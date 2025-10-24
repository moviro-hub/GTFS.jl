"""
File Conditions Validation Test Suite

This module contains tests for the GTFS file presence validation functionality.
"""

using Test
using GTFS
using DataFrames
using CSV

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    create_basic_gtfs() -> GTFSSchedule

Create a basic GTFS dataset with all required files.
"""
function create_basic_gtfs()
    gtfs = GTFSSchedule()

    # Required files
    gtfs["agency.txt"] = DataFrame(
        agency_id = ["DTA"],
        agency_name = ["Demo Transit Authority"],
        agency_url = ["http://example.com"],
        agency_timezone = ["America/New_York"]
    )

    gtfs["routes.txt"] = DataFrame(
        route_id = ["R1"],
        route_short_name = ["1"],
        route_long_name = ["Route 1"],
        route_type = [3]
    )

    gtfs["trips.txt"] = DataFrame(
        route_id = ["R1"],
        service_id = ["S1"],
        trip_id = ["T1"]
    )

    gtfs["stop_times.txt"] = DataFrame(
        trip_id = ["T1"],
        arrival_time = ["08:00:00"],
        departure_time = ["08:00:00"],
        stop_id = ["S1"],
        stop_sequence = [1]
    )

    gtfs["stops.txt"] = DataFrame(
        stop_id = ["S1"],
        stop_name = ["Stop 1"],
        stop_lat = [40.0],
        stop_lon = [-74.0]
    )

    gtfs["calendar.txt"] = DataFrame(
        service_id = ["S1"],
        monday = [1],
        tuesday = [1],
        wednesday = [1],
        thursday = [1],
        friday = [1],
        saturday = [0],
        sunday = [0],
        start_date = ["20240101"],
        end_date = ["20241231"]
    )

    return gtfs
end

"""
    create_gtfs_without_file(gtfs::GTFSSchedule, file::String) -> GTFSSchedule

Create a copy of GTFS without the specified file.
"""
function create_gtfs_without_file(gtfs::GTFSSchedule, file::String)
    new_gtfs = GTFSSchedule()
    for (key, value) in gtfs
        if key != file
            new_gtfs[key] = value
        end
    end
    return new_gtfs
end

"""
    create_gtfs_with_network_id() -> GTFSSchedule

Create a GTFS dataset with routes.txt containing network_id field.
"""
function create_gtfs_with_network_id()
    gtfs = create_basic_gtfs()
    # Add network_id field to routes.txt
    df = gtfs["routes.txt"]
    df[!, :network_id] = ["N1"]
    return gtfs
end

"""
    create_gtfs_with_pathway_mode(mode::Int) -> GTFSSchedule

Create a GTFS dataset with pathways.txt containing a specific pathway_mode.
"""
function create_gtfs_with_pathway_mode(mode::Int)
    gtfs = create_basic_gtfs()
    gtfs["pathways.txt"] = DataFrame(
        pathway_id = ["P1"],
        from_stop_id = ["S1"],
        to_stop_id = ["S2"],
        pathway_mode = [mode],
        is_bidirectional = [1]
    )
    return gtfs
end

# =============================================================================
# TEST SUITES
# =============================================================================

@testset "File Conditions Validation" begin

    @testset "Required Files" begin
        @testset "All Required Files Present" begin
            gtfs = create_basic_gtfs()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test result isa GTFS.Validations.ValidationResult
            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Missing Required Files" begin
            required_files = ["agency.txt", "routes.txt", "trips.txt", "stop_times.txt"]

            for missing_file in required_files
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_without_file(gtfs, missing_file)
                result = GTFS.Validations.validate_file_conditions(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Optional Files" begin
        @testset "Optional Files Present" begin
            gtfs = create_basic_gtfs()
            gtfs["shapes.txt"] = DataFrame(
                shape_id = ["S1"],
                shape_pt_lat = [40.0],
                shape_pt_lon = [-74.0],
                shape_pt_sequence = [1]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Optional Files Absent" begin
            gtfs = create_basic_gtfs()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Required: stops.txt" begin
        @testset "stops.txt present, locations.geojson absent" begin
            gtfs = create_basic_gtfs()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "stops.txt absent, locations.geojson present" begin
            # Create a temporary directory with GTFS files
            temp_dir = mktempdir()
            try
                # Create required files
                CSV.write(joinpath(temp_dir, "agency.txt"), DataFrame(
                    agency_id = ["DTA"],
                    agency_name = ["Demo Transit Authority"],
                    agency_url = ["http://example.com"],
                    agency_timezone = ["America/New_York"]
                ))
                CSV.write(joinpath(temp_dir, "routes.txt"), DataFrame(
                    route_id = ["R1"],
                    route_short_name = ["1"],
                    route_long_name = ["Route 1"],
                    route_type = [3]
                ))
                CSV.write(joinpath(temp_dir, "trips.txt"), DataFrame(
                    route_id = ["R1"],
                    service_id = ["S1"],
                    trip_id = ["T1"]
                ))
                CSV.write(joinpath(temp_dir, "stop_times.txt"), DataFrame(
                    trip_id = ["T1"],
                    arrival_time = ["08:00:00"],
                    departure_time = ["08:00:00"],
                    stop_id = ["S1"],
                    stop_sequence = [1]
                ))
                CSV.write(joinpath(temp_dir, "calendar.txt"), DataFrame(
                    service_id = ["S1"], monday = [1], tuesday = [1], wednesday = [1],
                    thursday = [1], friday = [1], saturday = [0], sunday = [0],
                    start_date = ["20240101"], end_date = ["20241231"]
                ))

                # Create locations.geojson file
                geojson_content = """{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "properties": {
                "location_id": "L1",
                "location_name": "Location 1"
            },
            "geometry": {
                "type": "Point",
                "coordinates": [-74.0, 40.0]
            }
        }
    ]
}"""
                write(joinpath(temp_dir, "locations.geojson"), geojson_content)

                # Read GTFS using the proper reader
                gtfs = GTFS.read_gtfs(temp_dir)
                result = GTFS.Validations.validate_file_conditions(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            finally
                rm(temp_dir, recursive=true)
            end
        end

        @testset "Both stops.txt and locations.geojson absent" begin
            gtfs = create_basic_gtfs()
            gtfs = create_gtfs_without_file(gtfs, "stops.txt")
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Required: calendar.txt/calendar_dates.txt" begin
        @testset "calendar.txt present, calendar_dates.txt absent" begin
            gtfs = create_basic_gtfs()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "calendar.txt absent, calendar_dates.txt present" begin
            gtfs = create_basic_gtfs()
            gtfs = create_gtfs_without_file(gtfs, "calendar.txt")
            gtfs["calendar_dates.txt"] = DataFrame(
                service_id = ["S1"],
                date = ["20240101"],
                exception_type = [1]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Both calendar.txt and calendar_dates.txt absent" begin
            gtfs = create_basic_gtfs()
            gtfs = create_gtfs_without_file(gtfs, "calendar.txt")
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Required: levels.txt" begin
        @testset "levels.txt present when pathways.txt has pathway_mode=5" begin
            gtfs = create_gtfs_with_pathway_mode(5)
            gtfs["levels.txt"] = DataFrame(
                level_id = ["L1"],
                level_index = [0.0],
                level_name = ["Ground"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "levels.txt absent when pathways.txt has pathway_mode=5" begin
            gtfs = create_gtfs_with_pathway_mode(5)
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "levels.txt absent when pathways.txt has no pathway_mode=5" begin
            gtfs = create_gtfs_with_pathway_mode(1)  # Walkway, not elevator
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Required: feed_info.txt" begin
        @testset "feed_info.txt present when translations.txt present" begin
            gtfs = create_basic_gtfs()
            gtfs["feed_info.txt"] = DataFrame(
                feed_publisher_name = ["Demo Publisher"],
                feed_publisher_url = ["http://example.com"],
                feed_lang = ["en"]
            )
            gtfs["translations.txt"] = DataFrame(
                table_name = ["stops"],
                field_name = ["stop_name"],
                language = ["es"],
                translation = ["Parada 1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "feed_info.txt absent when translations.txt present" begin
            gtfs = create_basic_gtfs()
            gtfs["translations.txt"] = DataFrame(
                table_name = ["stops"],
                field_name = ["stop_name"],
                language = ["es"],
                translation = ["Parada 1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "feed_info.txt absent when translations.txt absent" begin
            gtfs = create_basic_gtfs()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Forbidden: networks.txt" begin
        @testset "networks.txt absent when routes.txt has network_id field" begin
            gtfs = create_gtfs_with_network_id()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "networks.txt present when routes.txt has network_id field" begin
            gtfs = create_gtfs_with_network_id()
            gtfs["networks.txt"] = DataFrame(
                network_id = ["N1"],
                network_name = ["Network 1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "networks.txt present when routes.txt has no network_id field" begin
            gtfs = create_basic_gtfs()
            gtfs["networks.txt"] = DataFrame(
                network_id = ["N1"],
                network_name = ["Network 1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Conditionally Forbidden: route_networks.txt" begin
        @testset "route_networks.txt absent when routes.txt has network_id field" begin
            gtfs = create_gtfs_with_network_id()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "route_networks.txt present when routes.txt has network_id field" begin
            gtfs = create_gtfs_with_network_id()
            gtfs["route_networks.txt"] = DataFrame(
                network_id = ["N1"],
                route_id = ["R1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "route_networks.txt present when routes.txt has no network_id field" begin
            gtfs = create_basic_gtfs()
            gtfs["route_networks.txt"] = DataFrame(
                network_id = ["N1"],
                route_id = ["R1"]
            )
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end
    end

    @testset "Edge Cases" begin
        @testset "Empty GTFS Dataset" begin
            gtfs = GTFSSchedule()
            result = GTFS.Validations.validate_file_conditions(gtfs)

            @test result isa GTFS.Validations.ValidationResult
            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "Invalid Field Values" begin
            # Test with invalid pathway_mode value
            gtfs = create_gtfs_with_pathway_mode(99)  # Invalid pathway mode
            result = GTFS.Validations.validate_file_conditions(gtfs)

            # Should not require levels.txt for invalid pathway_mode
            @test !GTFS.Validations.has_validation_errors(result)
        end
    end
end
