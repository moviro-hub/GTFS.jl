"""
Specialized functionality tests for GTFS.jl

Tests GeoJSON reading, advanced validation, and other specialized features.
"""

@testset "Specialized Functionality" begin
    # Test GeoJSON reading
    @testset "GeoJSON Reading" begin
        temp_dir = mktempdir()
        try
            @testset "Valid GeoJSON File" begin
                geojson_file = joinpath(temp_dir, "locations.geojson")

                # Create a valid GeoJSON file with GTFS-Flex locations
                geojson_content = """
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": "location_1",
      "geometry": {
        "type": "Polygon",
        "coordinates": [[[-74.006, 40.7128], [-74.005, 40.7128], [-74.005, 40.7138], [-74.006, 40.7138], [-74.006, 40.7128]]]
      },
      "properties": {
        "name": "Downtown Area",
        "description": "Flexible pickup/dropoff zone"
      }
    },
    {
      "type": "Feature",
      "id": "location_2",
      "geometry": {
        "type": "Polygon",
        "coordinates": [[[-74.010, 40.7100], [-74.009, 40.7100], [-74.009, 40.7110], [-74.010, 40.7110], [-74.010, 40.7100]]]
      },
      "properties": {
        "name": "Uptown Area",
        "description": "Another flexible zone"
      }
    }
  ]
}
"""

                open(geojson_file, "w") do f
                    write(f, geojson_content)
                end

                # Test reading the GeoJSON file through GTFS reading
                # Create minimal GTFS files first
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
                df = gtfs.locations_geojson
                @test df !== nothing
                @test nrow(df) == 2
                @test "id" in names(df)
                @test "geometry_type" in names(df)
                @test "name" in names(df)
                @test "description" in names(df)
            end

            @testset "Empty GeoJSON File" begin
                geojson_file = joinpath(temp_dir, "empty.geojson")
                geojson_content = """
{
  "type": "FeatureCollection",
  "features": []
}
"""

                open(geojson_file, "w") do f
                    write(f, geojson_content)
                end

                # Test empty GeoJSON through GTFS reading
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

                # Add empty GeoJSON file
                geojson_file = joinpath(temp_dir, "locations.geojson")
                open(geojson_file, "w") do f
                    write(f, geojson_content)
                end

                gtfs = read_gtfs(temp_dir)
                df = gtfs.locations_geojson
                @test df !== nothing
                @test nrow(df) == 0
            end

            @testset "Invalid GeoJSON File" begin
                # Create minimal GTFS files
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

                # Add invalid GeoJSON file
                geojson_file = joinpath(temp_dir, "locations.geojson")
                open(geojson_file, "w") do f
                    write(f, "This is not valid JSON")
                end

                # Should still read successfully (invalid GeoJSON is ignored)
                gtfs = read_gtfs(temp_dir)
                @test gtfs !== nothing
                @test gtfs.locations_geojson === nothing
            end

            @testset "Non-FeatureCollection GeoJSON" begin
                # Create minimal GTFS files
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

                # Add non-FeatureCollection GeoJSON file
                geojson_file = joinpath(temp_dir, "locations.geojson")
                geojson_content = """
{
  "type": "Feature",
  "geometry": {
    "type": "Point",
    "coordinates": [-74.006, 40.7128]
  },
  "properties": {
    "name": "Test Point"
  }
}
"""
                open(geojson_file, "w") do f
                    write(f, geojson_content)
                end

                # Should still read successfully (non-FeatureCollection GeoJSON is ignored)
                gtfs = read_gtfs(temp_dir)
                @test gtfs !== nothing
                @test gtfs.locations_geojson === nothing
            end

            @testset "GeoJSON Integration with GTFS" begin
                # Create minimal GTFS files
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

                # Add GeoJSON file
                geojson_content = """
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": "location_1",
      "geometry": {
        "type": "Polygon",
        "coordinates": [[[-74.006, 40.7128], [-74.005, 40.7128], [-74.005, 40.7138], [-74.006, 40.7138], [-74.006, 40.7128]]]
      },
      "properties": {
        "name": "Test Location"
      }
    }
  ]
}
"""
                open(joinpath(temp_dir, "locations.geojson"), "w") do f
                    write(f, geojson_content)
                end

                # Test reading GTFS with GeoJSON
                gtfs = read_gtfs(temp_dir)
                @test gtfs !== nothing
                @test gtfs.locations_geojson !== nothing
                @test nrow(gtfs.locations_geojson) == 1
            end
        finally
            rm(temp_dir, recursive=true)
        end
    end

    # Test advanced validation scenarios
    @testset "Advanced Validation" begin
        temp_dir = mktempdir()
        try
            @testset "Complex Conditional Scenarios" begin
                # Create GTFS with multiple conditional violations
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Agency 1,https://agency1.com,America/New_York\n2,Agency 2,https://agency2.com,America/New_York\n")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, "stop_id,stop_name,stop_lat,stop_lon,location_type,parent_station\nstop1,Test Stop,,,0,parent1\nstop2,Test Station,40.7128,-74.0060,1,\n")
                end
                open(joinpath(temp_dir, "routes.txt"), "w") do f
                    write(f, "route_id,agency_id,route_short_name,route_long_name,route_type\nroute1,,,Test Route,3\n")
                end
                open(joinpath(temp_dir, "trips.txt"), "w") do f
                    write(f, "route_id,service_id,trip_id\nroute1,service1,trip1\n")
                end
                open(joinpath(temp_dir, "stop_times.txt"), "w") do f
                    write(f, "trip_id,arrival_time,departure_time,stop_id,stop_sequence\ntrip1,,,stop1,1\n")
                end
                open(joinpath(temp_dir, "calendar.txt"), "w") do f
                    write(f, "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n")
                end

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                warnings = filter(e -> e.severity == :warning, result.errors)
                @test length(warnings) > 0

                # Should have warnings for multiple issues
                warning_files = unique([w.file for w in warnings])
                @test length(warning_files) > 1
            end

            @testset "Fares v2 Conditional Rules" begin
                # Create GTFS with fare_products but missing fare_leg_rules
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
                open(joinpath(temp_dir, "fare_products.txt"), "w") do f
                    write(f, "fare_product_id,fare_product_name,amount,currency\nproduct1,Test Product,2.50,USD\n")
                end

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                warnings = filter(e -> e.severity == :warning, result.errors)
                @test any(w -> w.file == "fare_leg_rules.txt", warnings)
            end

            @testset "Pathways Conditional Rules" begin
                # Create GTFS with pathways but missing levels
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, "stop_id,stop_name,stop_lat,stop_lon,level_id\nstop1,Test Stop,40.7128,-74.0060,level1\n")
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
                open(joinpath(temp_dir, "pathways.txt"), "w") do f
                    write(f, "pathway_id,from_stop_id,to_stop_id,pathway_mode,is_bidirectional,length,traversal_time,stair_count,max_slope,min_width,signposted_as,reversed_signposted_as,level_id\npath1,stop1,stop2,1,1,10,30,0,0.1,1.5,Test Path,Test Path Reverse,level1\n")
                end

                gtfs = read_gtfs(temp_dir)
                result = validate(gtfs)

                warnings = filter(e -> e.severity == :warning, result.errors)
                @test any(w -> w.file == "levels.txt", warnings)
            end
        finally
            rm(temp_dir, recursive=true)
        end
    end

    # Test performance and edge cases
    @testset "Performance and Edge Cases" begin
        @testset "Large Dataset Performance" begin
            temp_dir = mktempdir()
            try
                # Create a large dataset
                open(joinpath(temp_dir, "agency.txt"), "w") do f
                    write(f, "agency_id,agency_name,agency_url,agency_timezone\n1,Test Agency,https://example.com,America/New_York\n")
                end

                # Create 5000 stops
                stop_lines = ["stop_id,stop_name,stop_lat,stop_lon"]
                for i in 1:5000
                    push!(stop_lines, "stop$i,Stop $i,40.7128,-74.0060")
                end
                open(joinpath(temp_dir, "stops.txt"), "w") do f
                    write(f, join(stop_lines, "\n"))
                end

                # Create 500 routes
                route_lines = ["route_id,agency_id,route_short_name,route_type"]
                for i in 1:500
                    push!(route_lines, "route$i,1,Route $i,3")
                end
                open(joinpath(temp_dir, "routes.txt"), "w") do f
                    write(f, join(route_lines, "\n"))
                end

                # Create 5000 trips
                trip_lines = ["route_id,service_id,trip_id"]
                for i in 1:5000
                    route_id = "route$((i-1) % 500 + 1)"
                    push!(trip_lines, "$route_id,service1,trip$i")
                end
                open(joinpath(temp_dir, "trips.txt"), "w") do f
                    write(f, join(trip_lines, "\n"))
                end

                # Create 10000 stop times
                stop_time_lines = ["trip_id,arrival_time,departure_time,stop_id,stop_sequence"]
                for i in 1:10000
                    trip_id = "trip$((i-1) % 5000 + 1)"
                    stop_id = "stop$((i-1) % 5000 + 1)"
                    push!(stop_time_lines, "$trip_id,08:00:00,08:00:00,$stop_id,1")
                end
                open(joinpath(temp_dir, "stop_times.txt"), "w") do f
                    write(f, join(stop_time_lines, "\n"))
                end

                open(joinpath(temp_dir, "calendar.txt"), "w") do f
                    write(f, "service_id,monday,tuesday,wednesday,thursday,friday,saturday,sunday,start_date,end_date\nservice1,1,1,1,1,1,0,0,20240101,20241231\n")
                end

                # Test reading performance
                start_time = time()
                gtfs = read_gtfs(temp_dir)
                read_time = time() - start_time

                @test gtfs !== nothing
                @test nrow(gtfs.stops) == 5000
                @test nrow(gtfs.routes) == 500
                @test nrow(gtfs.trips) == 5000
                @test nrow(gtfs.stop_times) == 10000

                # Test validation performance
                start_time = time()
                result = validate(gtfs)
                validation_time = time() - start_time

                @test result !== nothing
                @test isa(result.errors, Vector{ValidationError})

                # Performance should be reasonable (less than 10 seconds for this dataset)
                @test read_time < 10.0
                @test validation_time < 10.0
            finally
                rm(temp_dir, recursive=true)
            end
        end

        @testset "Memory Usage" begin
            # Test that we don't have memory leaks with large datasets
            temp_dir = mktempdir()
            try
                # Create a moderate dataset
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

                # Create other required files
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

                # Read multiple times to test for memory leaks
                for i in 1:10
                    gtfs = read_gtfs(temp_dir)
                    result = validate(gtfs)
                    @test gtfs !== nothing
                    @test result !== nothing
                end
            finally
                rm(temp_dir, recursive=true)
            end
        end
    end
end
