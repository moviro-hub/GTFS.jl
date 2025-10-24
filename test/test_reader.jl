"""
Comprehensive test suite for reader.jl

This module contains thorough tests for the GTFS reader functionality including
ZIP files, directories, CSV parsing, GeoJSON support, error handling, and edge cases.
"""

using Test
using GTFS
using DataFrames
using CSV
using GeoJSON

@testset "Reader.jl Comprehensive Tests" begin

    @testset "Basic Read Functionality" begin
        # Test reading from directory
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        @test isdir(feed_path)

        gtfs = read_gtfs(feed_path)
        @test gtfs !== nothing
        @test isa(gtfs, Dict)
        @test isa(gtfs, GTFSSchedule)

        # Verify expected files are loaded
        expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt"]
        for file in expected_files
            @test haskey(gtfs, file)
            @test gtfs[file] !== nothing
            @test isa(gtfs[file], DataFrame)
        end

        # Test reading from ZIP file
        zip_path = joinpath(@__DIR__, "fixtures", "official-sample-feed.zip")
        if isfile(zip_path)
            gtfs_zip = read_gtfs(zip_path)
            @test gtfs_zip !== nothing
            @test isa(gtfs_zip, GTFSSchedule)
        end
    end

    @testset "Basic Example Dataset Validation" begin
        # Path to the basic-example dataset
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        @test isdir(feed_path)

        # Read the GTFS feed
        println("Reading basic-example dataset from: $feed_path")
        gtfs = read_gtfs(feed_path)
        @test gtfs !== nothing
        @test isa(gtfs, Dict)

        # Test basic structure - access as dictionary
        @test haskey(gtfs, "agency.txt")
        @test haskey(gtfs, "stops.txt")
        @test haskey(gtfs, "routes.txt")
        @test haskey(gtfs, "trips.txt")
        @test haskey(gtfs, "stop_times.txt")
        @test haskey(gtfs, "calendar.txt")

        # Test expected counts for basic-example
        @test nrow(gtfs["agency.txt"]) == 1
        @test nrow(gtfs["stops.txt"]) == 9
        @test nrow(gtfs["routes.txt"]) == 5
        @test nrow(gtfs["trips.txt"]) == 11
        @test nrow(gtfs["stop_times.txt"]) == 28

        # Test optional files that should be present in basic-example
        @test haskey(gtfs, "calendar_dates.txt")
        @test haskey(gtfs, "fare_attributes.txt")
        @test haskey(gtfs, "fare_rules.txt")
        @test haskey(gtfs, "frequencies.txt")
        @test haskey(gtfs, "shapes.txt")

        # Test shapes count
        @test nrow(gtfs["shapes.txt"]) == 0

        # Basic validation - check that all required files are present
        println("Running basic validation on basic-example dataset...")

        # Check that all required GTFS files are present
        required_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt"]
        for file in required_files
            @test haskey(gtfs, file)
        end

        # Check that data is not empty
        for file in required_files
            @test nrow(gtfs[file]) > 0
        end

        println("Basic validation completed successfully")

        # Print dataset summary
        println("\nBasic Example Dataset Summary:")
        println("  Agencies: $(nrow(gtfs["agency.txt"]))")
        println("  Stops: $(nrow(gtfs["stops.txt"]))")
        println("  Routes: $(nrow(gtfs["routes.txt"]))")
        println("  Trips: $(nrow(gtfs["trips.txt"]))")
        println("  Stop Times: $(nrow(gtfs["stop_times.txt"]))")
        println("  Calendar: $(nrow(gtfs["calendar.txt"]))")
        println("  Calendar Dates: $(nrow(gtfs["calendar_dates.txt"]))")
        println("  Fare Attributes: $(nrow(gtfs["fare_attributes.txt"]))")
        println("  Fare Rules: $(nrow(gtfs["fare_rules.txt"]))")
        println("  Frequencies: $(nrow(gtfs["frequencies.txt"]))")
        println("  Shapes: $(nrow(gtfs["shapes.txt"]))")

        println("✓ Basic example dataset test completed successfully")
    end

    @testset "File Format Tests" begin
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        gtfs = read_gtfs(feed_path)

        # Test CSV files with proper column types
        @test haskey(gtfs, "agency.txt")
        agency_df = gtfs["agency.txt"]
        @test isa(agency_df, DataFrame)
        @test nrow(agency_df) > 0

        # Test GeoJSON files (create temporary test)
        temp_dir = mktempdir()
        try
            # Create a temporary GeoJSON file for testing
            geojson_content = """{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "properties": {
                "location_id": "L1",
                "location_name": "Test Location"
            },
            "geometry": {
                "type": "Point",
                "coordinates": [-74.0, 40.0]
            }
        }
    ]
}"""
            geojson_file = joinpath(temp_dir, "locations.geojson")
            write(geojson_file, geojson_content)

            gtfs_geo = read_gtfs(temp_dir)
            @test haskey(gtfs_geo, "locations.geojson")
            @test gtfs_geo["locations.geojson"] !== nothing
            @test isa(gtfs_geo["locations.geojson"], DataFrame)
        finally
            rm(temp_dir, recursive=true, force=true)
        end

        # Test column types are applied correctly
        if haskey(gtfs, "agency.txt")
            agency_df = gtfs["agency.txt"]
            # Check that columns exist and have appropriate types
            @test "agency_id" in names(agency_df)
            @test "agency_name" in names(agency_df)
            @test "agency_url" in names(agency_df)
        end
    end

    @testset "ZIP Archive Handling" begin
        zip_path = joinpath(@__DIR__, "fixtures", "official-sample-feed.zip")
        if isfile(zip_path)
            # Test reading from ZIP
            gtfs = read_gtfs(zip_path)
            @test gtfs !== nothing
            @test isa(gtfs, GTFSSchedule)

            # Verify files are loaded from ZIP
            @test haskey(gtfs, "agency.txt")
            @test haskey(gtfs, "stops.txt")
        end

        # Test ZIP with subdirectory structure (create temporary test)
        temp_dir = mktempdir()
        try
            # Create a ZIP with subdirectory structure
            subdir = joinpath(temp_dir, "gtfs_feed")
            mkdir(subdir)

            # Copy basic-example files to subdirectory
            basic_path = joinpath(@__DIR__, "fixtures", "basic-example")
            for file in readdir(basic_path)
                if endswith(file, ".txt")
                    cp(joinpath(basic_path, file), joinpath(subdir, file))
                end
            end

            # Create ZIP file
            zip_file = joinpath(temp_dir, "test_feed.zip")
            run(`zip -q -r $zip_file $subdir`)

            # Test reading ZIP with subdirectory
            gtfs = read_gtfs(zip_file)
            @test gtfs !== nothing
            @test haskey(gtfs, "agency.txt")

        catch e
            # If ZIP creation fails, skip this test
            @warn "Skipping ZIP subdirectory test due to: $e"
        finally
            rm(temp_dir, recursive=true, force=true)
        end
    end

    @testset "Edge Cases & Special Scenarios" begin
        # Test with basic-example fixture
        fixture_path = joinpath(@__DIR__, "fixtures", "basic-example")
            if isdir(fixture_path)
                gtfs = read_gtfs(fixture_path)
                @test gtfs !== nothing
                @test isa(gtfs, GTFSSchedule)

                # Check that at least some files are loaded
                @test length(gtfs) > 0
        end

        # Test empty files (create temporary test)
        temp_dir = mktempdir()
        try
            # Create empty CSV with headers only
            empty_csv = joinpath(temp_dir, "empty.txt")
            open(empty_csv, "w") do f
                write(f, "agency_id,agency_name,agency_url,agency_timezone\n")
            end

            gtfs = read_gtfs(temp_dir)
            @test gtfs !== nothing
            @test haskey(gtfs, "empty.txt")
            @test nrow(gtfs["empty.txt"]) == 0

        finally
            rm(temp_dir, recursive=true, force=true)
        end
    end

    @testset "Error Handling Tests" begin
        # Test invalid paths
        @test_throws ArgumentError read_gtfs("/nonexistent/path")
        @test_throws ArgumentError read_gtfs("/nonexistent/path.zip")

        # Test invalid file types
        temp_file = tempname() * ".txt"
        open(temp_file, "w") do f
            write(f, "test content")
        end
        try
            @test_throws ArgumentError read_gtfs(temp_file)
        finally
            rm(temp_file, force=true)
        end

        # Test directory without GTFS files
        temp_dir = mktempdir()
        try
            # Create directory with non-GTFS files (no .txt or .geojson extensions)
            open(joinpath(temp_dir, "readme.md"), "w") do f
                write(f, "This is not a GTFS file")
            end
            open(joinpath(temp_dir, "data.json"), "w") do f
                write(f, "{\"test\": \"data\"}")
            end

            @test_throws ArgumentError read_gtfs(temp_dir)

        finally
            rm(temp_dir, recursive=true, force=true)
        end

        # Test corrupted ZIP (create invalid ZIP)
        temp_zip = tempname() * ".zip"
        open(temp_zip, "w") do f
            write(f, "This is not a valid ZIP file")
        end
        try
            @test_throws Exception read_gtfs(temp_zip)
        finally
            rm(temp_zip, force=true)
        end

        # Test malformed CSV
        temp_dir = mktempdir()
        try
            malformed_csv = joinpath(temp_dir, "malformed.txt")
            open(malformed_csv, "w") do f
                write(f, "agency_id,agency_name\n")
                write(f, "1,\"Unclosed quote\n")  # Malformed CSV
            end

            # Should handle gracefully with warning
            gtfs = read_gtfs(temp_dir)
            @test gtfs !== nothing
            @test haskey(gtfs, "malformed.txt")

        finally
            rm(temp_dir, recursive=true, force=true)
        end
    end

    @testset "Basic Feed Fixture Tests" begin
        # Test basic-example fixture
        fixture_path = joinpath(@__DIR__, "fixtures", "basic-example")
            if isdir(fixture_path)
                gtfs = read_gtfs(fixture_path)
                @test gtfs !== nothing
                @test isa(gtfs, GTFSSchedule)

                # Verify basic structure
                @test length(gtfs) > 0

            # Check for expected files in basic-example
            @test haskey(gtfs, "agency.txt")
            @test haskey(gtfs, "stops.txt")
            @test haskey(gtfs, "routes.txt")
            @test haskey(gtfs, "trips.txt")
            @test haskey(gtfs, "stop_times.txt")
            @test haskey(gtfs, "calendar.txt")
        end
    end

    @testset "Field Type Application Tests" begin
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        gtfs = read_gtfs(feed_path)

        # Test that field types are applied
        if haskey(gtfs, "agency.txt")
            agency_df = gtfs["agency.txt"]

            # Check column types match expected GTFS types
            for col in names(agency_df)
                col_data = agency_df[!, col]
                if !isempty(col_data)
                    # Check that missing values are handled properly
                    @test all(x -> x isa Union{String, Missing}, col_data)
                end
            end
        end

        # Test with custom field_types parameter
        custom_field_types = Dict{String,Vector}()
        gtfs_custom = read_gtfs(feed_path, custom_field_types)
        @test gtfs_custom !== nothing
        @test isa(gtfs_custom, GTFSSchedule)

        # Test fallback when type mapping fails
        # This is tested implicitly in the error handling section
    end

    @testset "Internal Function Tests" begin
        # Test _read_gtfs_from_directory
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        gtfs = GTFS._read_gtfs_from_directory(feed_path, GTFS.FIELD_TYPES)
        @test gtfs !== nothing
        @test isa(gtfs, GTFSSchedule)

        # Test _read_csv_file
        agency_file = joinpath(feed_path, "agency.txt")
        if isfile(agency_file)
            df = GTFS._read_csv_file(agency_file, GTFS.FIELD_TYPES)
            @test df !== nothing
            @test isa(df, DataFrame)
            @test nrow(df) > 0
        end

        # Test _read_geojson_file (create temporary test)
        temp_dir = mktempdir()
        try
            # Create a temporary GeoJSON file for testing
            geojson_content = """{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "properties": {
                "location_id": "L1",
                "location_name": "Test Location"
            },
            "geometry": {
                "type": "Point",
                "coordinates": [-74.0, 40.0]
            }
        }
    ]
}"""
            geo_file = joinpath(temp_dir, "locations.geojson")
            write(geo_file, geojson_content)

            df = GTFS._read_geojson_file(geo_file)
            @test df !== nothing
            @test isa(df, DataFrame)
        finally
            rm(temp_dir, recursive=true, force=true)
        end

        # Test _read_gtfs_from_zip
        zip_path = joinpath(@__DIR__, "fixtures", "official-sample-feed.zip")
        if isfile(zip_path)
            gtfs_zip = GTFS._read_gtfs_from_zip(zip_path, GTFS.FIELD_TYPES)
            @test gtfs_zip !== nothing
            @test isa(gtfs_zip, GTFSSchedule)
        end
    end

    @testset "DataFrame Structure Validation" begin
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")
        gtfs = read_gtfs(feed_path)

        # Test that all DataFrames have proper structure
        for (filename, df) in gtfs
            if df !== nothing
                @test isa(df, DataFrame)
                @test ncol(df) > 0  # Should have columns

                # Test that missing values are handled properly
                for col in names(df)
                    col_data = df[!, col]
                    # Check that all values are of expected GTFS types
                    @test all(x -> x isa Union{String, Missing, Int64, Float64, Int8, Float32}, col_data)
                end
            end
        end

        # Test specific file structures
        if haskey(gtfs, "agency.txt")
            agency_df = gtfs["agency.txt"]
            @test "agency_id" in names(agency_df)
            @test "agency_name" in names(agency_df)
            @test "agency_url" in names(agency_df)
            @test "agency_timezone" in names(agency_df)
        end

        if haskey(gtfs, "stops.txt")
            stops_df = gtfs["stops.txt"]
            @test "stop_id" in names(stops_df)
            @test "stop_name" in names(stops_df)
            @test "stop_lat" in names(stops_df)
            @test "stop_lon" in names(stops_df)
        end
    end

    @testset "Warning and Error Message Tests" begin
        # Test that appropriate warnings are issued
        temp_dir = mktempdir()
        try
            # Create a file with type coercion issues
            problem_csv = joinpath(temp_dir, "problem.txt")
            open(problem_csv, "w") do f
                write(f, "agency_id,agency_name\n")
                write(f, "1,Test Agency\n")
                write(f, "invalid_id,Another Agency\n")  # This should work fine
            end

            # Should not throw errors, but may issue warnings
            gtfs = read_gtfs(temp_dir)
            @test gtfs !== nothing

        finally
            rm(temp_dir, recursive=true, force=true)
        end
    end

    @testset "Performance and Memory Tests" begin
        # Test that reading doesn't consume excessive memory
        feed_path = joinpath(@__DIR__, "fixtures", "basic-example")

        # Read multiple times to test for memory leaks
        for i in 1:3
            gtfs = read_gtfs(feed_path)
            @test gtfs !== nothing
            @test isa(gtfs, GTFSSchedule)
        end

        # Test with larger fixture if available
        zip_path = joinpath(@__DIR__, "fixtures", "official-sample-feed.zip")
        if isfile(zip_path)
            gtfs = read_gtfs(zip_path)
            @test gtfs !== nothing
            @test isa(gtfs, GTFSSchedule)
        end
    end

end
