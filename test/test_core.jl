"""
Core functionality tests for GTFS.jl

Tests the fundamental reading, validation, and data structure functionality.
"""

@testset "Core Functionality" begin
    # Test data structures
    @testset "Data Structures" begin
        @testset "ValidationMessage" begin
            error = ValidationMessage("test.txt", "field1", "Test message", :error)
            @test error.file == "test.txt"
            @test error.field == "field1"
            @test error.message == "Test message"
            @test error.severity == :error

            # Test with no field
            error2 = ValidationMessage("test.txt", nothing, "Test message", :warning)
            @test error2.field === nothing
        end

        @testset "ValidationResult" begin
            errors = [
                ValidationMessage("test.txt", "field1", "Test error", :error),
                ValidationMessage("test.txt", "field2", "Test warning", :warning)
            ]
            result = ValidationResult(errors)

            @test !result.is_valid
            @test length(result.messages) == 2
            @test result.summary !== nothing

            # Test filtering
            error_list = filter(e -> e.severity == :error, result.messages)
            warning_list = filter(e -> e.severity == :warning, result.messages)
            @test length(error_list) == 1
            @test length(warning_list) == 1
        end

        @testset "GTFSSchedule" begin
            # Test that GTFSSchedule can be constructed with minimal data
            temp_dir = mktempdir()
            try
                # Create minimal valid GTFS files
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, "stop_id,stop_name,stop_lat,stop_lon\nstop1,Test Stop,40.7128,-74.0060\n")
                end
                open(joinpath(temp_dir, "routes.txt"), "w") do f
                    write(f, "route_id,agency_id,route_short_name,route_type\nroute1,1,1,3\n")
                end
                open(joinpath(temp_dir, "trips.txt"), "w") do f
                    write(f, "route_id,service_id,trip_id\nroute1,service1,trip1\n")
                end
                open(joinpath(temp_dir, "stop_times.txt"), "w") do f
                    write(f, "trip_id,arrival_time,departure_time,stop_id,stop_sequence\ntrip1,08:00:00,08:00:00,stop1,1\n")
                end
                open(joinpath(temp_dir, "calendar.txt"), "w") do f
                    write(f, "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n")
                end

                gtfs = read_gtfs(temp_dir)
                @test gtfs !== nothing
                @test gtfs.agency !== nothing
                @test gtfs.stops !== nothing
                @test gtfs.routes !== nothing
                @test gtfs.trips !== nothing
                @test gtfs.stop_times !== nothing
                @test gtfs.calendar !== nothing
            finally
                rm(temp_dir, recursive=true)
            end
        end
    end

    # Test file operations
    @testset "File Operations" begin
        @testset "Error Handling" begin
            # Test reading non-existent file
            @test_throws ArgumentError read_gtfs("nonexistent.zip")
            @test_throws ArgumentError read_gtfs("nonexistent_dir/")

            # Test reading non-ZIP file
            temp_file = tempname() * ".txt"
            write(temp_file, "test content")
            @test_throws ArgumentError read_gtfs(temp_file)
            rm(temp_file)

            # Test file listing with invalid files
            @test_throws ArgumentError list_gtfs_files("nonexistent.zip")
            @test_throws ArgumentError list_gtfs_files("nonexistent_dir/")

            # Test structure validation with invalid files
            @test !validate_gtfs_structure("nonexistent.zip")
            @test !validate_gtfs_structure("nonexistent_dir/")
        end

        @testset "Valid Operations" begin
            # Test with basic example if available
            basic_feed_path = joinpath(@__DIR__, "fixtures", "basic-example.zip")
            if isfile(basic_feed_path)
                # Test structure validation
                @test validate_gtfs_structure(basic_feed_path)

                # Test file listing
                files = list_gtfs_files(basic_feed_path)
                @test "agency.txt" in files
                @test "stops.txt" in files
                @test "routes.txt" in files
                @test "trips.txt" in files
                @test "stop_times.txt" in files

                # Test reading
                gtfs = read_gtfs(basic_feed_path)
                @test gtfs !== nothing
                @test gtfs.agency !== nothing
                @test gtfs.stops !== nothing
                @test gtfs.routes !== nothing
                @test gtfs.trips !== nothing
                @test gtfs.stop_times !== nothing
            end
        end
    end

    # Test input format support
    @testset "Input Format Support" begin
        basic_feed_path = joinpath(@__DIR__, "fixtures", "basic-example.zip")
        if isfile(basic_feed_path)
            # Test ZIP file reading
            gtfs_zip = read_gtfs(basic_feed_path)
            @test gtfs_zip !== nothing

            # Test unzipped directory reading
            temp_dir = mktempdir()
            try
                run(`unzip -q $basic_feed_path -d $temp_dir`)

                # Handle subdirectory if present
                files = readdir(temp_dir)
                if length(files) == 1 && isdir(joinpath(temp_dir, files[1]))
                    temp_dir = joinpath(temp_dir, files[1])
                end

                gtfs_dir = read_gtfs(temp_dir)
                @test gtfs_dir !== nothing

                # Compare basic structure
                @test nrow(gtfs_zip.agency) == nrow(gtfs_dir.agency)
                @test nrow(gtfs_zip.stops) == nrow(gtfs_dir.stops)
                @test nrow(gtfs_zip.routes) == nrow(gtfs_dir.routes)
                @test nrow(gtfs_zip.trips) == nrow(gtfs_dir.trips)
                @test nrow(gtfs_zip.stop_times) == nrow(gtfs_dir.stop_times)
            finally
                rm(temp_dir, recursive=true)
            end
        end
    end

    # Test edge cases
    @testset "Edge Cases" begin
        @testset "Empty Files" begin
            temp_dir = mktempdir()
            try
                # Create empty required files
                for file in ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt"]
                    open(joinpath(temp_dir, file), "w") do f
                        write(f, "")  # Empty file
                    end
                end

                # Should fail validation but not crash
                @test_throws ArgumentError read_gtfs(temp_dir)
            finally
                rm(temp_dir, recursive=true)
            end
        end

        @testset "Missing Required Files" begin
            temp_dir = mktempdir()
            try
                # Create only some required files
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, "stop_id,stop_name,stop_lat,stop_lon\nstop1,Test Stop,40.7128,-74.0060\n")
                end
                # Missing routes.txt, trips.txt, stop_times.txt

                @test_throws ArgumentError read_gtfs(temp_dir)
            finally
                rm(temp_dir, recursive=true)
            end
        end

        @testset "Malformed CSV" begin
            temp_dir = mktempdir()
            try
                # Create files with malformed CSV
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, "stop_id,stop_name,stop_lat,stop_lon\nstop1,Test Stop,40.7128,-74.0060\n")
                end
                open(joinpath(temp_dir, "routes.txt"), "w") do f
                    write(f, "route_id,agency_id,route_short_name,route_type\nroute1,1,1,3\n")
                end
                open(joinpath(temp_dir, "trips.txt"), "w") do f
                    write(f, "route_id,service_id,trip_id\nroute1,service1,trip1\n")
                end
                open(joinpath(temp_dir, "stop_times.txt"), "w") do f
                    write(f, "trip_id,arrival_time,departure_time,stop_id,stop_sequence\ntrip1,08:00:00,08:00:00,stop1,1\n")
                end
                open(joinpath(temp_dir, "calendar.txt"), "w") do f
                    write(f, "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n")
                end

                # Add a malformed file
                open(joinpath(temp_dir, "malformed.txt"), "w") do f
                    write(f, "This is not CSV content\nwith multiple lines\nand no proper structure")
                end

                # Should still read successfully (malformed.txt is ignored)
                gtfs = read_gtfs(temp_dir)
                @test gtfs !== nothing
            finally
                rm(temp_dir, recursive=true)
            end
        end
    end
end
