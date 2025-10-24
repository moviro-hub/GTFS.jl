"""
Field Constraints Validation Test Suite

This module contains tests for the GTFS field constraints validation functionality.
Tests are derived from the GTFS specification and FIELD_CONSTRAINTS.
"""

using Test
using GTFSSchedule
using DataFrames

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    create_basic_gtfs() -> GTFSSchedule

Create a basic GTFS dataset with all required files and valid constraint values.
"""
function create_basic_gtfs()
    gtfs = GTFSSchedule()

    # Required files with valid constraint values
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
        route_sort_order = [0]  # Non-negative
    )

    gtfs["stops.txt"] = DataFrame(
        stop_id = ["S1"],
        stop_name = ["Stop 1"],
        stop_lat = [40.0],
        stop_lon = [-74.0]
    )

    gtfs["trips.txt"] = DataFrame(
        route_id = ["R1"],
        service_id = ["SERVICE1"],
        trip_id = ["T1"]
    )

    gtfs["stop_times.txt"] = DataFrame(
        trip_id = ["T1"],
        arrival_time = ["08:00:00"],
        departure_time = ["08:00:00"],
        stop_id = ["S1"],
        stop_sequence = [1],  # Non-negative
        shape_dist_traveled = [0.0]  # Non-negative
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

    return gtfs
end

# =============================================================================
# TEST SUITES
# =============================================================================

@testset "Field Constraints Validation" begin

    @testset "agency.txt" begin
        @testset "agency_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["agency.txt"] = DataFrame(
                    agency_id = ["DTA", "MTA", "CTA"],
                    agency_name = ["Demo", "Metro", "Chicago"],
                    agency_url = ["http://demo.com", "http://metro.com", "http://cta.com"],
                    agency_timezone = ["America/New_York", "America/Chicago", "America/Chicago"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["agency.txt"] = DataFrame(
                    agency_id = ["DTA", "DTA", "CTA"],
                    agency_name = ["Demo", "Demo2", "Chicago"],
                    agency_url = ["http://demo.com", "http://demo2.com", "http://cta.com"],
                    agency_timezone = ["America/New_York", "America/New_York", "America/Chicago"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["agency.txt"] = DataFrame(
                    agency_id = ["DTA", missing, "CTA"],
                    agency_name = ["Demo", "Missing", "Chicago"],
                    agency_url = ["http://demo.com", "http://missing.com", "http://cta.com"],
                    agency_timezone = ["America/New_York", "America/New_York", "America/Chicago"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "stops.txt" begin
        @testset "stop_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1", "S2", "S3"],
                    stop_name = ["Stop 1", "Stop 2", "Stop 3"],
                    stop_lat = [40.0, 40.1, 40.2],
                    stop_lon = [-74.0, -74.1, -74.2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1", "S1", "S3"],
                    stop_name = ["Stop 1", "Stop 1 Duplicate", "Stop 3"],
                    stop_lat = [40.0, 40.0, 40.2],
                    stop_lon = [-74.0, -74.0, -74.2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["stops.txt"] = DataFrame(
                    stop_id = ["S1", missing, "S3"],
                    stop_name = ["Stop 1", "Missing", "Stop 3"],
                    stop_lat = [40.0, 40.0, 40.2],
                    stop_lon = [-74.0, -74.0, -74.2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "routes.txt" begin
        @testset "route_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1", "R2", "R3"],
                    route_short_name = ["1", "2", "3"],
                    route_long_name = ["Route 1", "Route 2", "Route 3"],
                    route_type = [3, 3, 3]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1", "R1", "R3"],
                    route_short_name = ["1", "1 Duplicate", "3"],
                    route_long_name = ["Route 1", "Route 1 Duplicate", "Route 3"],
                    route_type = [3, 3, 3]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "route_sort_order (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1", "R2", "R3"],
                    route_short_name = ["1", "2", "3"],
                    route_long_name = ["Route 1", "Route 2", "Route 3"],
                    route_type = [3, 3, 3],
                    route_sort_order = [0, 1, 100]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1", "R2", "R3"],
                    route_short_name = ["1", "2", "3"],
                    route_long_name = ["Route 1", "Route 2", "Route 3"],
                    route_type = [3, 3, 3],
                    route_sort_order = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["routes.txt"] = DataFrame(
                    route_id = ["R1", "R2", "R3"],
                    route_short_name = ["1", "2", "3"],
                    route_long_name = ["Route 1", "Route 2", "Route 3"],
                    route_type = [3, 3, 3],
                    route_sort_order = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "trips.txt" begin
        @testset "trip_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1", "R1", "R1"],
                    service_id = ["S1", "S1", "S1"],
                    trip_id = ["T1", "T2", "T3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["trips.txt"] = DataFrame(
                    route_id = ["R1", "R1", "R1"],
                    service_id = ["S1", "S1", "S1"],
                    trip_id = ["T1", "T1", "T3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "stop_times.txt" begin
        @testset "stop_sequence (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [0, 1, 100]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "shape_dist_traveled (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [1, 2, 3],
                    shape_dist_traveled = [0.0, 1.5, 100.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [1, 2, 3],
                    shape_dist_traveled = [-1.0, 0.0, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["stop_times.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    arrival_time = ["08:00:00", "08:05:00", "08:10:00"],
                    departure_time = ["08:00:00", "08:05:00", "08:10:00"],
                    stop_id = ["S1", "S2", "S3"],
                    stop_sequence = [1, 2, 3],
                    shape_dist_traveled = [0.0, missing, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "calendar.txt" begin
        @testset "service_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["S1", "S2", "S3"],
                    monday = [1, 1, 0],
                    tuesday = [1, 1, 0],
                    wednesday = [1, 1, 0],
                    thursday = [1, 1, 0],
                    friday = [1, 1, 0],
                    saturday = [0, 0, 1],
                    sunday = [0, 0, 1],
                    start_date = ["20240101", "20240101", "20240101"],
                    end_date = ["20241231", "20241231", "20241231"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["calendar.txt"] = DataFrame(
                    service_id = ["S1", "S1", "S3"],
                    monday = [1, 1, 0],
                    tuesday = [1, 1, 0],
                    wednesday = [1, 1, 0],
                    thursday = [1, 1, 0],
                    friday = [1, 1, 0],
                    saturday = [0, 0, 1],
                    sunday = [0, 0, 1],
                    start_date = ["20240101", "20240101", "20240101"],
                    end_date = ["20241231", "20241231", "20241231"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_attributes.txt" begin
        @testset "fare_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [2.50, 3.00, 1.50],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F1", "F3"],
                    price = [2.50, 2.50, 1.50],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "price (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [0.0, 2.50, 100.0],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [-1.0, 0.0, 1.0],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [0.0, missing, 1.0],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "transfer_duration (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [2.50, 3.00, 1.50],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0],
                    transfer_duration = [0, 1800, 3600]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [2.50, 3.00, 1.50],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0],
                    transfer_duration = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1", "F2", "F3"],
                    price = [2.50, 3.00, 1.50],
                    currency_type = ["USD", "USD", "USD"],
                    payment_method = [0, 0, 0],
                    transfer_duration = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "rider_categories.txt" begin
        @testset "rider_category_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["rider_categories.txt"] = DataFrame(
                    rider_category_id = ["RC1", "RC2", "RC3"],
                    rider_category_name = ["Adult", "Child", "Senior"],
                    is_default_fare_category = [1, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["rider_categories.txt"] = DataFrame(
                    rider_category_id = ["RC1", "RC1", "RC3"],
                    rider_category_name = ["Adult", "Adult Duplicate", "Senior"],
                    is_default_fare_category = [1, 0, 0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_media.txt" begin
        @testset "fare_media_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["fare_media.txt"] = DataFrame(
                    fare_media_id = ["FM1", "FM2", "FM3"],
                    fare_media_name = ["Card", "Mobile", "Cash"],
                    fare_media_type = [2, 2, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["fare_media.txt"] = DataFrame(
                    fare_media_id = ["FM1", "FM1", "FM3"],
                    fare_media_name = ["Card", "Card Duplicate", "Cash"],
                    fare_media_type = [2, 2, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_leg_rules.txt" begin
        @testset "rule_priority (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_leg_rules.txt"] = DataFrame(
                    leg_group_id = ["LG1", "LG2", "LG3"],
                    rule_priority = [0, 1, 100]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_leg_rules.txt"] = DataFrame(
                    leg_group_id = ["LG1", "LG2", "LG3"],
                    rule_priority = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_leg_rules.txt"] = DataFrame(
                    leg_group_id = ["LG1", "LG2", "LG3"],
                    rule_priority = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_transfer_rules.txt" begin
        @testset "transfer_count (Non-zero)" begin
            @testset "Valid - Non-zero Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [1, 2, 3]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Zero Value" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [0, 1, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [1, missing, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "duration_limit (Positive)" begin
            @testset "Valid - Positive Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [1, 2, 3],
                    duration_limit = [1, 1800, 3600]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Zero or Negative" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [1, 2, 3],
                    duration_limit = [0, 1, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["fare_transfer_rules.txt"] = DataFrame(
                    from_leg_group_id = ["LG1", "LG2", "LG3"],
                    to_leg_group_id = ["LG2", "LG3", "LG1"],
                    transfer_count = [1, 2, 3],
                    duration_limit = [1, missing, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "areas.txt" begin
        @testset "area_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["areas.txt"] = DataFrame(
                    area_id = ["A1", "A2", "A3"],
                    area_name = ["Area 1", "Area 2", "Area 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["areas.txt"] = DataFrame(
                    area_id = ["A1", "A1", "A3"],
                    area_name = ["Area 1", "Area 1 Duplicate", "Area 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "networks.txt" begin
        @testset "network_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["networks.txt"] = DataFrame(
                    network_id = ["N1", "N2", "N3"],
                    network_name = ["Network 1", "Network 2", "Network 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["networks.txt"] = DataFrame(
                    network_id = ["N1", "N1", "N3"],
                    network_name = ["Network 1", "Network 1 Duplicate", "Network 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "shapes.txt" begin
        @testset "shape_pt_sequence (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [0, 1, 100]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "shape_dist_traveled (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [1, 2, 3],
                    shape_dist_traveled = [0.0, 1.5, 100.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [1, 2, 3],
                    shape_dist_traveled = [-1.0, 0.0, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["SHAPE1", "SHAPE1", "SHAPE1"],
                    shape_pt_lat = [40.0, 40.1, 40.2],
                    shape_pt_lon = [-74.0, -74.1, -74.2],
                    shape_pt_sequence = [1, 2, 3],
                    shape_dist_traveled = [0.0, missing, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "frequencies.txt" begin
        @testset "headway_secs (Positive)" begin
            @testset "Valid - Positive Values" begin
                gtfs = GTFSSchedule()
                gtfs["frequencies.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    start_time = ["08:00:00", "12:00:00", "18:00:00"],
                    end_time = ["10:00:00", "14:00:00", "20:00:00"],
                    headway_secs = [1, 1800, 3600]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Zero or Negative" begin
                gtfs = GTFSSchedule()
                gtfs["frequencies.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    start_time = ["08:00:00", "12:00:00", "18:00:00"],
                    end_time = ["10:00:00", "14:00:00", "20:00:00"],
                    headway_secs = [0, 1, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["frequencies.txt"] = DataFrame(
                    trip_id = ["T1", "T1", "T1"],
                    start_time = ["08:00:00", "12:00:00", "18:00:00"],
                    end_time = ["10:00:00", "14:00:00", "20:00:00"],
                    headway_secs = [1, missing, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "transfers.txt" begin
        @testset "min_transfer_time (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["transfers.txt"] = DataFrame(
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    transfer_type = [0, 0, 0],
                    min_transfer_time = [0, 60, 300]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["transfers.txt"] = DataFrame(
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    transfer_type = [0, 0, 0],
                    min_transfer_time = [-1, 0, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["transfers.txt"] = DataFrame(
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    transfer_type = [0, 0, 0],
                    min_transfer_time = [0, missing, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "pathways.txt" begin
        @testset "pathway_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P1", "P3"],
                    from_stop_id = ["S1", "S1", "S3"],
                    to_stop_id = ["S2", "S2", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "length (Non-negative)" begin
            @testset "Valid - Non-negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    length = [0.0, 10.5, 100.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Negative Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    length = [-1.0, 0.0, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    length = [0.0, missing, 1.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "traversal_time (Positive)" begin
            @testset "Valid - Positive Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    traversal_time = [1, 30, 300]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Zero or Negative" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    traversal_time = [0, 1, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    traversal_time = [1, missing, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "min_width (Positive)" begin
            @testset "Valid - Positive Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    min_width = [1.0, 2.5, 10.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Zero or Negative" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    min_width = [0.0, 1.0, 2.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Valid - With Missing Values" begin
                gtfs = GTFSSchedule()
                gtfs["pathways.txt"] = DataFrame(
                    pathway_id = ["P1", "P2", "P3"],
                    from_stop_id = ["S1", "S2", "S3"],
                    to_stop_id = ["S2", "S3", "S1"],
                    pathway_mode = [1, 1, 1],
                    is_bidirectional = [1, 1, 1],
                    min_width = [1.0, missing, 2.0]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "levels.txt" begin
        @testset "level_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["levels.txt"] = DataFrame(
                    level_id = ["L1", "L2", "L3"],
                    level_index = [0.0, 1.0, 2.0],
                    level_name = ["Ground", "Level 1", "Level 2"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["levels.txt"] = DataFrame(
                    level_id = ["L1", "L1", "L3"],
                    level_index = [0.0, 0.0, 2.0],
                    level_name = ["Ground", "Ground Duplicate", "Level 2"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "location_groups.txt" begin
        @testset "location_group_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["location_groups.txt"] = DataFrame(
                    location_group_id = ["LG1", "LG2", "LG3"],
                    location_group_name = ["Group 1", "Group 2", "Group 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["location_groups.txt"] = DataFrame(
                    location_group_id = ["LG1", "LG1", "LG3"],
                    location_group_name = ["Group 1", "Group 1 Duplicate", "Group 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "booking_rules.txt" begin
        @testset "booking_rule_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["booking_rules.txt"] = DataFrame(
                    booking_rule_id = ["BR1", "BR2", "BR3"],
                    booking_type = [0, 1, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["booking_rules.txt"] = DataFrame(
                    booking_rule_id = ["BR1", "BR1", "BR3"],
                    booking_type = [0, 0, 2]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "attributions.txt" begin
        @testset "attribution_id (Unique)" begin
            @testset "Valid - All Unique" begin
                gtfs = GTFSSchedule()
                gtfs["attributions.txt"] = DataFrame(
                    attribution_id = ["A1", "A2", "A3"],
                    organization_name = ["Org 1", "Org 2", "Org 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid - Duplicates" begin
                gtfs = GTFSSchedule()
                gtfs["attributions.txt"] = DataFrame(
                    attribution_id = ["A1", "A1", "A3"],
                    organization_name = ["Org 1", "Org 1 Duplicate", "Org 3"]
                )
                result = GTFS.Validations.validate_field_constraints(gtfs)
                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Edge Cases" begin
        @testset "Empty GTFS Dataset" begin
            gtfs = GTFSSchedule()
            result = GTFS.Validations.validate_field_constraints(gtfs)
            @test result isa GTFS.Validations.ValidationResult
            @test !GTFS.Validations.has_validation_errors(result)  # No fields to validate
        end

        @testset "Missing Field" begin
            # Field doesn't exist in DataFrame - should be skipped
            gtfs = GTFSSchedule()
            gtfs["agency.txt"] = DataFrame(
                agency_name = ["Demo Transit Authority"],
                agency_url = ["http://example.com"],
                agency_timezone = ["America/New_York"]
            )
            result = GTFS.Validations.validate_field_constraints(gtfs)
            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Multiple Violations" begin
            # Multiple rows with constraint violations
            gtfs = GTFSSchedule()
            gtfs["routes.txt"] = DataFrame(
                route_id = ["R1", "R2", "R3"],
                route_short_name = ["1", "2", "3"],
                route_long_name = ["Route 1", "Route 2", "Route 3"],
                route_type = [3, 3, 3],
                route_sort_order = [-1, -2, -3]  # Multiple negative values
            )
            result = GTFS.Validations.validate_field_constraints(gtfs)
            @test GTFS.Validations.has_validation_errors(result)
            @test length(result.messages) >= 3
        end

        @testset "Float vs Integer Values" begin
            # Test that numeric constraints work with both float and integer values
            gtfs = GTFSSchedule()
            gtfs["routes.txt"] = DataFrame(
                route_id = ["R1", "R2", "R3"],
                route_short_name = ["1", "2", "3"],
                route_long_name = ["Route 1", "Route 2", "Route 3"],
                route_type = [3, 3, 3],
                route_sort_order = [0.0, 1, 2.5]  # Mix of float and integer
            )
            result = GTFS.Validations.validate_field_constraints(gtfs)
            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Boundary Values" begin
            # Test boundary values for constraints
            gtfs = GTFSSchedule()
            gtfs["routes.txt"] = DataFrame(
                route_id = ["R1", "R2", "R3"],
                route_short_name = ["1", "2", "3"],
                route_long_name = ["Route 1", "Route 2", "Route 3"],
                route_type = [3, 3, 3],
                route_sort_order = [0, 0, 0]  # Boundary value for non-negative
            )
            result = GTFS.Validations.validate_field_constraints(gtfs)
            @test !GTFS.Validations.has_validation_errors(result)
        end
    end
end
