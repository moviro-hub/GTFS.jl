"""
Field ID References Validation Test Suite (Simplified)

This module contains tests for the GTFS foreign key (ID reference) validation functionality.
Tests are derived from the GTFS specification and FIELD_ID_REFERENCES.
"""

using Test
using GTFSSchedules
using DataFrames

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    create_basic_gtfs() -> GTFSSchedule

Create a basic GTFS dataset with all required files and valid ID relationships.
"""
function create_basic_gtfs()
    gtfs = GTFSSchedule()

    # Required files with valid ID relationships
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
        route_type = [3],
        agency_id = ["DTA"]  # Valid reference to agency.agency_id
    )

    gtfs["stops.txt"] = DataFrame(
        stop_id = ["S1", "S2"],
        stop_name = ["Stop 1", "Stop 2"],
        stop_lat = [40.0, 40.1],
        stop_lon = [-74.0, -74.1],
        parent_station = [missing, "S1"]  # S2 references S1 (self-reference)
    )

    gtfs["trips.txt"] = DataFrame(
        route_id = ["R1"],  # Valid reference to routes.route_id
        service_id = ["SERVICE1"],  # Valid reference to calendar.service_id
        trip_id = ["T1"],
        shape_id = ["SHAPE1"]  # Valid reference to shapes.shape_id
    )

    gtfs["stop_times.txt"] = DataFrame(
        trip_id = ["T1"],  # Valid reference to trips.trip_id
        arrival_time = ["08:00:00"],
        departure_time = ["08:00:00"],
        stop_id = ["S1"],  # Valid reference to stops.stop_id
        stop_sequence = [1]
    )

    gtfs["calendar.txt"] = DataFrame(
        service_id = ["SERVICE1"],
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

    gtfs["shapes.txt"] = DataFrame(
        shape_id = ["SHAPE1"],
        shape_pt_lat = [40.0],
        shape_pt_lon = [-74.0],
        shape_pt_sequence = [1]
    )

    return gtfs
end

# =============================================================================
# TEST SUITES
# =============================================================================

@testset "Field ID References Validation (Simplified)" begin

    @testset "stops.txt" begin
        @testset "parent_station" begin
            @testset "Valid References" begin
                # Test self-reference: parent_station → stops.stop_id
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1", "S2"],
                    stop_name = ["Stop 1", "Stop 2"],
                    stop_lat = [40.0, 40.1],
                    stop_lon = [-74.0, -74.1],
                    parent_station = [missing, "S1"]  # S2 references S1 (self-reference)
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid self-reference
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1"],
                    stop_name = ["Stop 1"],
                    stop_lat = [40.0],
                    stop_lon = [-74.0],
                    parent_station = ["NONEXISTENT"]  # Invalid reference
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Empty Values" begin
                # Test that empty/missing values are allowed
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1"],
                    stop_name = ["Stop 1"],
                    stop_lat = [40.0],
                    stop_lon = [-74.0],
                    parent_station = [missing]  # Missing value
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "routes.txt" begin
        @testset "agency_id" begin
            @testset "Valid References" begin
                # Test valid agency_id reference
                gtfs = GTFSSchedule()
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
                    route_type = [3],
                    agency_id = ["DTA"]  # Valid reference
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid agency_id reference
                gtfs = GTFSSchedule()
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
                    route_type = [3],
                    agency_id = ["INVALID_AGENCY"]  # Invalid reference
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Missing Referenced Table" begin
                # Test behavior when agency.txt is missing
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1"],
                    route_short_name = ["1"],
                    route_long_name = ["Route 1"],
                    route_type = [3],
                    agency_id = ["DTA"]  # References missing agency.txt
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                # When referenced table is missing, validation is skipped (no errors)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "trips.txt" begin
        @testset "route_id" begin
            @testset "Valid References" begin
                # Test valid route_id reference
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1"],
                    route_short_name = ["1"],
                    route_long_name = ["Route 1"],
                    route_type = [3],
                    agency_id = ["DTA"]
                )
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],  # Valid reference
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid route_id reference
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1"],
                    route_short_name = ["1"],
                    route_long_name = ["Route 1"],
                    route_type = [3],
                    agency_id = ["DTA"]
                )
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["INVALID_ROUTE"],  # Invalid reference
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "service_id" begin
            @testset "Valid References to calendar" begin
                # Test valid service_id reference to calendar
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["SERVICE1"],
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
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],  # Valid reference to calendar
                    trip_id = ["T1"]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Valid References to calendar_dates" begin
                # Test valid service_id reference to calendar_dates
                gtfs = GTFSSchedule()
                gtfs["calendar_dates.txt"] = DataFrame(
                    service_id = ["SERVICE2"],
                    date = ["20240101"],
                    exception_type = [1]
                )
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE2"],  # Valid reference to calendar_dates
                    trip_id = ["T1"]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid service_id reference
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["SERVICE1"],
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
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["INVALID_SERVICE"],  # Invalid reference
                    trip_id = ["T1"]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "shape_id" begin
            @testset "Valid References" begin
                # Test valid shape_id reference
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1"],
                    shape_pt_lat = [40.0],
                    shape_pt_lon = [-74.0],
                    shape_pt_sequence = [1]
                )
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"],
                    shape_id = ["SHAPE1"]  # Valid reference
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid shape_id reference
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1"],
                    shape_pt_lat = [40.0],
                    shape_pt_lon = [-74.0],
                    shape_pt_sequence = [1]
                )
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"],
                    shape_id = ["INVALID_SHAPE"]  # Invalid reference
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Missing Referenced Table" begin
                # Test behavior when shapes.txt is missing
                gtfs = GTFSSchedule()
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"],
                    shape_id = ["SHAPE1"]  # References missing shapes.txt
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                # When referenced table is missing, validation is skipped (no errors)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "stop_times.txt" begin
        @testset "trip_id" begin
            @testset "Valid References" begin
                # Test valid trip_id reference
                gtfs = GTFSSchedule()
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"]
                )
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1"],  # Valid reference
                    arrival_time = ["08:00:00"],
                    departure_time = ["08:00:00"],
                    stop_id = ["S1"],
                    stop_sequence = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid trip_id reference
                gtfs = GTFSSchedule()
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1"],
                    service_id = ["SERVICE1"],
                    trip_id = ["T1"]
                )
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["INVALID_TRIP"],  # Invalid reference
                    arrival_time = ["08:00:00"],
                    departure_time = ["08:00:00"],
                    stop_id = ["S1"],
                    stop_sequence = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "stop_id" begin
            @testset "Valid References" begin
                # Test valid stop_id reference
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1"],
                    stop_name = ["Stop 1"],
                    stop_lat = [40.0],
                    stop_lon = [-74.0]
                )
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1"],
                    arrival_time = ["08:00:00"],
                    departure_time = ["08:00:00"],
                    stop_id = ["S1"],  # Valid reference
                    stop_sequence = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Invalid References" begin
                # Test invalid stop_id reference
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1"],
                    stop_name = ["Stop 1"],
                    stop_lat = [40.0],
                    stop_lon = [-74.0]
                )
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1"],
                    arrival_time = ["08:00:00"],
                    departure_time = ["08:00:00"],
                    stop_id = ["INVALID_STOP"],  # Invalid reference
                    stop_sequence = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "calendar_dates.txt" begin
        @testset "service_id" begin
            @testset "Valid References" begin
                # Test valid service_id reference (conditional reference)
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["SERVICE1"],
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
                gtfs["calendar_dates.txt"] = DataFrame(
                    service_id = ["SERVICE1"],  # Valid reference
                    date = ["20240101"],
                    exception_type = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Independent Service IDs" begin
                # Test that calendar_dates.service_id can be independent IDs (not referencing calendar.service_id)
                # This is valid according to GTFS spec: "Foreign ID referencing calendar.service_id or ID"
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["SERVICE1"],
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
                gtfs["calendar_dates.txt"] = DataFrame(
                    service_id = ["INDEPENDENT_SERVICE"],  # Independent ID, not in calendar.txt
                    date = ["20240101"],
                    exception_type = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Mixed References" begin
                # Test that calendar_dates.service_id can mix references and independent IDs
                # This is valid according to GTFS spec: "Foreign ID referencing calendar.service_id or ID"
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["SERVICE1"],
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
                gtfs["calendar_dates.txt"] = DataFrame(
                    service_id = ["SERVICE1", "INDEPENDENT_SERVICE"],  # Mix of reference and independent
                    date = ["20240101", "20240102"],
                    exception_type = [1, 1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end

            @testset "Missing Referenced Table" begin
                # Test behavior when calendar.txt is missing (conditional reference)
                gtfs = GTFSSchedule()
                gtfs["calendar_dates.txt"] = DataFrame(
                    service_id = ["SERVICE1"],  # References missing calendar.txt
                    date = ["20240101"],
                    exception_type = [1]
                )
                result = GTFSSchedules.Validations.validate_id_references(gtfs)
                # For conditional references, missing referenced table should be valid
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Edge Cases" begin
        @testset "Empty GTFS Dataset" begin
            gtfs = GTFSSchedule()
            result = GTFSSchedules.Validations.validate_id_references(gtfs)
            @test result isa GTFSSchedules.Validations.ValidationResult
            @test !GTFSSchedules.Validations.has_validation_errors(result)  # No foreign key fields to validate
        end

        @testset "Empty Values" begin
            # Test that empty values are allowed
            gtfs = GTFSSchedule()
            gtfs["stops.txt"] = DataFrame(
                stop_id = ["S1"],
                stop_name = ["Stop 1"],
                stop_lat = [40.0],
                stop_lon = [-74.0],
                parent_station = [""]  # Empty string
            )
            result = GTFSSchedules.Validations.validate_id_references(gtfs)
            @test !GTFSSchedules.Validations.has_validation_errors(result)
        end

        @testset "Zero Values" begin
            # Test that zero values are allowed
            gtfs = GTFSSchedule()
            gtfs["stops.txt"] = DataFrame(
                stop_id = ["S1"],
                stop_name = ["Stop 1"],
                stop_lat = [40.0],
                stop_lon = [-74.0],
                parent_station = ["0"]  # Zero string
            )
            result = GTFSSchedules.Validations.validate_id_references(gtfs)
            @test !GTFSSchedules.Validations.has_validation_errors(result)
        end

        @testset "Missing Values" begin
            # Test that missing values are allowed
            gtfs = GTFSSchedule()
            gtfs["stops.txt"] = DataFrame(
                stop_id = ["S1"],
                stop_name = ["Stop 1"],
                stop_lat = [40.0],
                stop_lon = [-74.0],
                parent_station = [missing]  # Missing value
            )
            result = GTFSSchedules.Validations.validate_id_references(gtfs)
            @test !GTFSSchedules.Validations.has_validation_errors(result)
        end

        @testset "Multiple Invalid References" begin
            # Test multiple rows with invalid foreign key references
            gtfs = GTFSSchedule()
            gtfs["agency.txt"] = DataFrame(
                agency_id = ["DTA"],
                agency_name = ["Demo Transit Authority"],
                agency_url = ["http://example.com"],
                agency_timezone = ["America/New_York"]
            )
            gtfs["routes.txt"] = DataFrame(
                route_id = ["R1", "R2", "R3"],
                route_short_name = ["1", "2", "3"],
                route_long_name = ["Route 1", "Route 2", "Route 3"],
                route_type = [3, 3, 3],
                agency_id = ["INVALID1", "INVALID2", "INVALID3"]  # Multiple invalid references
            )
            result = GTFSSchedules.Validations.validate_id_references(gtfs)
            @test GTFSSchedules.Validations.has_validation_errors(result)
            # Should have multiple error messages
            @test length(result.messages) >= 3
        end
    end
end
