"""
Validation functionality tests for GTFS.jl

Tests validation logic, conditional requirements, and error reporting.
"""

@testset "Validation Functionality" begin
    # Test basic validation
    @testset "Basic Validation" begin
        basic_feed_path = joinpath(@__DIR__, "fixtures", "basic-example.zip")
        if isfile(basic_feed_path)
            gtfs = read_gtfs(basic_feed_path)
            result = validate(gtfs)

            # Basic example should be valid
            @test result.is_valid
            @test isa(result.errors, Vector{ValidationError})
            @test isa(result.summary, String)
        end
    end

    # Test conditional validation
    @testset "Conditional Validation" begin
        temp_dir = mktempdir()
        try
            # Helper function to create minimal GTFS files
            function create_minimal_gtfs_files(dir_path, custom_files=Dict())
                default_files = Dict(
                    "agency.txt" => "agency_id,agency_name,agency_url,agency_timezone,agency_lang,agency_phone,agency_fare_url,agency_email\n1,Test Agency,https://example.com,America/New_York,en,555-1234,,\n",
                    "stops.txt" => "stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station,stop_timezone,wheelchair_boarding,level_id,platform_code\nstop1,1,Test Stop,Test stop description,40.7128,-74.0060,1,,0,,,0,,\n",
                    "routes.txt" => "route_id,agency_id,route_short_name,route_long_name,route_desc,route_type,route_url,route_color,route_text_color,route_sort_order,continuous_pickup,continuous_drop_off,network_id\nroute1,1,1,Test Route,Test route description,3,,,0,0,0,0,\n",
                    "trips.txt" => "route_id,service_id,trip_id,trip_headsign,trip_short_name,direction_id,block_id,shape_id,wheelchair_accessible,bikes_allowed\ntrip1,service1,trip1,Test Trip,,0,,,0,0\n",
                    "stop_times.txt" => "trip_id,arrival_time,departure_time,stop_id,stop_sequence,stop_headsign,pickup_type,drop_off_type,continuous_pickup,continuous_drop_off,shape_dist_traveled,timepoint\ntrip1,08:00:00,08:00:00,stop1,1,,0,0,0,0,0,1\n",
                    "calendar.txt" => "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n"
                )
                all_files = merge(default_files, custom_files)
                for (filename, content) in all_files
                    open(joinpath(dir_path, filename), "w") do f
                        write(f, content)
                    end
                end
            end

            @testset "Field-level Conditional Requirements" begin
                # Test stops.txt: stop_lat/stop_lon required when location_type is 0 or empty
                custom_stops = "stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station,stop_timezone,wheelchair_boarding,level_id,platform_code\nstop1,1,Test Stop,Test stop description,,,1,,0,,,0,,\n"
                create_minimal_gtfs_files(temp_dir, Dict("stops.txt" => custom_stops))

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                warnings = filter(e -> e.severity == :warning, result.errors)
                @test length(warnings) > 0
                @test any(w -> w.file == "stops.txt" && w.field == "stop_lat", warnings)
            end

            @testset "Cross-file Conditional Requirements" begin
                # Test routes.txt: agency_id required when multiple agencies exist
                custom_agency = "agency_id,agency_name,agency_url,agency_timezone,agency_lang,agency_phone,agency_fare_url,agency_email\n1,Agency 1,https://agency1.com,America/New_York,en,555-1111,,\n2,Agency 2,https://agency2.com,America/New_York,en,555-2222,,\n"
                custom_routes = "route_id,agency_id,route_short_name,route_long_name,route_desc,route_type,route_url,route_color,route_text_color,route_sort_order,continuous_pickup,continuous_drop_off,network_id\nroute1,,1,Test Route,Test route description,3,,,0,0,0,0,\n"
                create_minimal_gtfs_files(temp_dir, Dict("agency.txt" => custom_agency, "routes.txt" => custom_routes))

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                warnings = filter(e -> e.severity == :warning, result.errors)
                @test any(w -> w.file == "routes.txt" && w.field == "agency_id", warnings)
            end

            @testset "Warning Limiting" begin
                # Create multiple stops with missing stop_lat/stop_lon
                stop_lines = ["stop_id,stop_code,stop_name,stop_desc,stop_lat,stop_lon,zone_id,stop_url,location_type,parent_station,stop_timezone,wheelchair_boarding,level_id,platform_code"]
                for i in 1:150  # Create 150 stops with missing coordinates
                    push!(stop_lines, "stop$i,$i,Test Stop $i,Test stop description,,,1,,0,,,0,,")
                end
                custom_stops = join(stop_lines, "\n")

                create_minimal_gtfs_files(temp_dir, Dict("stops.txt" => custom_stops))

                gtfs = read_gtfs(temp_dir)

                # Test with default limit (100)
                result_default = validate(gtfs)
                warnings_default = filter(e -> e.severity == :warning && e.file == "stops.txt", result_default.errors)
                @test length(warnings_default) <= 100

                # Test with custom limit (50)
                result_custom = validate(gtfs; max_warnings_per_file=50)
                warnings_custom = filter(e -> e.severity == :warning && e.file == "stops.txt", result_custom.errors)
                @test length(warnings_custom) <= 50
            end

            @testset "Valid Data" begin
                create_minimal_gtfs_files(temp_dir)

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                # Should have no warnings for valid data
                warnings = filter(e -> e.severity == :warning, result.errors)
                @test length(warnings) == 0
            end
        finally
            rm(temp_dir, recursive=true)
        end
    end

    # Test validation edge cases
    @testset "Validation Edge Cases" begin
        @testset "Empty ValidationResult" begin
            result = ValidationResult(ValidationError[])
            @test result.is_valid
            @test isempty(result.errors)
            @test result.summary !== nothing
        end

        @testset "Mixed Severity Validation" begin
            errors = [
                ValidationError("file1.txt", "field1", "Error message", :error),
                ValidationError("file2.txt", "field2", "Warning message", :warning),
                ValidationError("file3.txt", "field3", "Another error", :error)
            ]
            result = ValidationResult(errors)

            @test !result.is_valid
            @test length(result.errors) == 3

            error_count = count(e -> e.severity == :error, result.errors)
            warning_count = count(e -> e.severity == :warning, result.errors)
            @test error_count == 2
            @test warning_count == 1
        end

        @testset "Large Dataset Validation" begin
            # Test validation performance with larger dataset
            temp_dir = mktempdir()
            try
                # Create a larger dataset
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end

                # Create 1000 stops
                stop_lines = ["stop_id,stop_name,stop_lat,stop_lon"]
                for i in 1:1000
                    push!(stop_lines, "stop$i,Stop $i,40.7128,-74.0060")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, join(stop_lines, "\n"))
                end

                # Create 100 routes
                route_lines = ["route_id,agency_id,route_short_name,route_type"]
                for i in 1:100
                    push!(route_lines, "route$i,1,Route $i,3")
                end
                open(joinpath(temp_dir, "routes.txt"), "w") do f
                    write(f, join(route_lines, "\n"))
                end

                # Create 1000 trips
                trip_lines = ["route_id,service_id,trip_id"]
                for i in 1:1000
                    route_id = "route$((i-1) % 100 + 1)"
                    push!(trip_lines, "$route_id,service1,trip$i")
                end
                open(joinpath(temp_dir, "trips.txt"), "w") do f
                    write(f, join(trip_lines, "\n"))
                end

                # Create 2000 stop times
                stop_time_lines = ["trip_id,arrival_time,departure_time,stop_id,stop_sequence"]
                for i in 1:2000
                    trip_id = "trip$((i-1) % 1000 + 1)"
                    stop_id = "stop$((i-1) % 1000 + 1)"
                    push!(stop_time_lines, "$trip_id,08:00:00,08:00:00,$stop_id,1")
                end
                open(joinpath(temp_dir, "stop_times.txt"), "w") do f
                    write(f, join(stop_time_lines, "\n"))
                end

                open(joinpath(temp_dir, "calendar.txt"), "w") do f
                    write(f, "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n")
                end

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                # Should complete without errors
                @test result !== nothing
                @test isa(result.errors, Vector{ValidationError})
            finally
                rm(temp_dir, recursive=true)
            end
        end
    end
end
