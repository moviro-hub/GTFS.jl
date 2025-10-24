"""
Field Enum Values Validation Test Suite

This module contains tests for the GTFS enum field validation functionality.
Tests are derived from the GTFS specification and ENUM_RULES.
"""

using Test
using GTFSSchedules
using DataFrames
using CSV

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

"""
    create_basic_gtfs() -> GTFSSchedule

Create a basic GTFS dataset with all required files and valid enum values.
"""
function create_basic_gtfs()
    gtfs = GTFSSchedule()

    # Required files with valid enum values
    gtfs["agency.txt"] = DataFrame(
        agency_id = ["DTA"],
        agency_name = ["Demo Transit Authority"],
        agency_url = ["http://example.com"],
        agency_timezone = ["America/New_York"],
        cemv_support = [0]  # Valid enum value
    )

    gtfs["routes.txt"] = DataFrame(
        route_id = ["R1"],
        route_short_name = ["1"],
        route_long_name = ["Route 1"],
        route_type = [3],  # Valid enum value (Bus)
        continuous_pickup = [1],  # Valid enum value
        continuous_drop_off = [1],  # Valid enum value
        cemv_support = [0]  # Valid enum value
    )

    gtfs["trips.txt"] = DataFrame(
        route_id = ["R1"],
        service_id = ["S1"],
        trip_id = ["T1"],
        direction_id = [0],  # Valid enum value
        wheelchair_accessible = [0],  # Valid enum value
        bikes_allowed = [0],  # Valid enum value
        cars_allowed = [0]  # Valid enum value
    )

    gtfs["stop_times.txt"] = DataFrame(
        trip_id = ["T1"],
        arrival_time = ["08:00:00"],
        departure_time = ["08:00:00"],
        stop_id = ["S1"],
        stop_sequence = [1],
        pickup_type = [0],  # Valid enum value
        drop_off_type = [0],  # Valid enum value
        continuous_pickup = [1],  # Valid enum value
        continuous_drop_off = [1],  # Valid enum value
        timepoint = [1]  # Valid enum value
    )

    gtfs["stops.txt"] = DataFrame(
        stop_id = ["S1"],
        stop_name = ["Stop 1"],
        stop_lat = [40.0],
        stop_lon = [-74.0],
        location_type = [0],  # Valid enum value
        wheelchair_boarding = [0],  # Valid enum value
        stop_access = [0]  # Valid enum value
    )

    gtfs["calendar.txt"] = DataFrame(
        service_id = ["S1"],
        monday = [1],  # Valid enum value
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
    create_gtfs_with_enum_field(filename::String, field_name::String, value) -> GTFSSchedule

Create a GTFS dataset with a specific enum field set to a specific value.
"""
function create_gtfs_with_enum_field(filename::String, field_name::String, value)
    gtfs = create_basic_gtfs()

    if haskey(gtfs, filename)
        df = gtfs[filename]
        if hasproperty(df, Symbol(field_name))
            df[!, Symbol(field_name)] .= [value]
        else
            df[!, Symbol(field_name)] = [value]
        end
    else
        # Create a minimal file with the enum field
        if filename == "agency.txt"
            gtfs[filename] = DataFrame(
                agency_id = ["DTA"],
                agency_name = ["Demo Transit Authority"],
                agency_url = ["http://example.com"],
                agency_timezone = ["America/New_York"]
            )
        elseif filename == "routes.txt"
            gtfs[filename] = DataFrame(
                route_id = ["R1"],
                route_short_name = ["1"],
                route_long_name = ["Route 1"]
            )
        elseif filename == "trips.txt"
            gtfs[filename] = DataFrame(
                route_id = ["R1"],
                service_id = ["S1"],
                trip_id = ["T1"]
            )
        elseif filename == "stop_times.txt"
            gtfs[filename] = DataFrame(
                trip_id = ["T1"],
                arrival_time = ["08:00:00"],
                departure_time = ["08:00:00"],
                stop_id = ["S1"],
                stop_sequence = [1]
            )
        elseif filename == "stops.txt"
            gtfs[filename] = DataFrame(
                stop_id = ["S1"],
                stop_name = ["Stop 1"],
                stop_lat = [40.0],
                stop_lon = [-74.0]
            )
        elseif filename == "calendar.txt"
            gtfs[filename] = DataFrame(
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
        elseif filename == "calendar_dates.txt"
            gtfs[filename] = DataFrame(
                service_id = ["S1"],
                date = ["20240101"]
            )
        elseif filename == "fare_attributes.txt"
            gtfs[filename] = DataFrame(
                fare_id = ["F1"],
                price = [2.50],
                currency_type = ["USD"]
            )
        elseif filename == "rider_categories.txt"
            gtfs[filename] = DataFrame(
                rider_category_id = ["RC1"],
                rider_category_name = ["Adult"]
            )
        elseif filename == "fare_media.txt"
            gtfs[filename] = DataFrame(
                fare_media_id = ["FM1"],
                fare_media_name = ["Card"]
            )
        elseif filename == "fare_transfer_rules.txt"
            gtfs[filename] = DataFrame(
                from_leg_group_id = ["LG1"],
                to_leg_group_id = ["LG2"],
                fare_product_id = ["FP1"]
            )
        elseif filename == "frequencies.txt"
            gtfs[filename] = DataFrame(
                trip_id = ["T1"],
                start_time = ["08:00:00"],
                end_time = ["18:00:00"],
                headway_secs = [1800]
            )
        elseif filename == "transfers.txt"
            gtfs[filename] = DataFrame(
                from_stop_id = ["S1"],
                to_stop_id = ["S2"]
            )
        elseif filename == "pathways.txt"
            gtfs[filename] = DataFrame(
                pathway_id = ["P1"],
                from_stop_id = ["S1"],
                to_stop_id = ["S2"],
                is_bidirectional = [1]
            )
        elseif filename == "booking_rules.txt"
            gtfs[filename] = DataFrame(
                booking_rule_id = ["BR1"]
            )
        elseif filename == "attributions.txt"
            gtfs[filename] = DataFrame(
                attribution_id = ["A1"],
                organization_name = ["Demo Org"]
            )
        end

        df = gtfs[filename]
        df[!, Symbol(field_name)] = [value]
    end

    return gtfs
end

"""
    create_gtfs_with_missing_field(filename::String, field_name::String) -> GTFSSchedule

Create a GTFS dataset with a specific enum field missing/empty.
"""
function create_gtfs_with_missing_field(filename::String, field_name::String)
    gtfs = create_basic_gtfs()

    if haskey(gtfs, filename)
        df = gtfs[filename]
        if hasproperty(df, Symbol(field_name))
            # Set to missing/empty
            df[!, Symbol(field_name)] .= [missing]
        end
    else
        # Create the file with the field but set to missing
        if filename == "calendar_dates.txt"
            gtfs[filename] = DataFrame(
                service_id = ["S1"],
                date = ["20240101"],
                exception_type = [missing]
            )
        elseif filename == "fare_attributes.txt"
            gtfs[filename] = DataFrame(
                fare_id = ["F1"],
                price = [2.50],
                currency_type = ["USD"],
                payment_method = [0]
            )
            if field_name == "transfers"
                # For transfers field, don't add it (allow_empty=true)
            else
                gtfs[filename][!, Symbol(field_name)] = [missing]
            end
        elseif filename == "fare_media.txt"
            gtfs[filename] = DataFrame(
                fare_media_id = ["FM1"],
                fare_media_name = ["Card"],
                fare_media_type = [missing]
            )
        elseif filename == "fare_transfer_rules.txt"
            gtfs[filename] = DataFrame(
                from_leg_group_id = ["LG1"],
                to_leg_group_id = ["LG2"],
                fare_product_id = ["FP1"],
                fare_transfer_type = [missing]
            )
        elseif filename == "pathways.txt"
            gtfs[filename] = DataFrame(
                pathway_id = ["P1"],
                from_stop_id = ["S1"],
                to_stop_id = ["S2"],
                is_bidirectional = [1],
                pathway_mode = [missing]
            )
        elseif filename == "booking_rules.txt"
            gtfs[filename] = DataFrame(
                booking_rule_id = ["BR1"],
                booking_type = [missing]
            )
        end
    end

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

# =============================================================================
# TEST SUITES
# =============================================================================

@testset "Field Enum Values Validation" begin

    @testset "agency.txt" begin
        @testset "cemv_support" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("agency.txt", "cemv_support", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("agency.txt", "cemv_support", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("agency.txt", "cemv_support")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "stops.txt" begin
        @testset "location_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3, 4]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "location_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 5, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "location_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stops.txt", "location_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "wheelchair_boarding" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "wheelchair_boarding", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "wheelchair_boarding", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stops.txt", "wheelchair_boarding")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "stop_access" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "stop_access", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stops.txt", "stop_access", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stops.txt", "stop_access")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "routes.txt" begin
        @testset "route_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3, 4, 5, 6, 7, 11, 12]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "route_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 8, 9, 10, 13, 20]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "route_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("routes.txt", "route_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "continuous_pickup" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "continuous_pickup", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "continuous_pickup", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("routes.txt", "continuous_pickup")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "continuous_drop_off" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "continuous_drop_off", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "continuous_drop_off", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("routes.txt", "continuous_drop_off")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "cemv_support" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "cemv_support", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("routes.txt", "cemv_support", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("routes.txt", "cemv_support")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "trips.txt" begin
        @testset "direction_id" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "direction_id", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "direction_id", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("trips.txt", "direction_id")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "wheelchair_accessible" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "wheelchair_accessible", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "wheelchair_accessible", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("trips.txt", "wheelchair_accessible")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "bikes_allowed" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "bikes_allowed", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "bikes_allowed", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("trips.txt", "bikes_allowed")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "cars_allowed" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "cars_allowed", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("trips.txt", "cars_allowed", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("trips.txt", "cars_allowed")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "stop_times.txt" begin
        @testset "pickup_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "pickup_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "pickup_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stop_times.txt", "pickup_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "drop_off_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "drop_off_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "drop_off_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stop_times.txt", "drop_off_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "continuous_pickup" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "continuous_pickup", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "continuous_pickup", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stop_times.txt", "continuous_pickup")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "continuous_drop_off" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "continuous_drop_off", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "continuous_drop_off", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stop_times.txt", "continuous_drop_off")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "timepoint" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "timepoint", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("stop_times.txt", "timepoint", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid
                gtfs = create_gtfs_with_missing_field("stop_times.txt", "timepoint")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "calendar.txt" begin
        @testset "monday" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("calendar.txt", "monday", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("calendar.txt", "monday", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("calendar.txt", "monday")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "calendar_dates.txt" begin
        @testset "exception_type" begin
            @testset "Valid Values" begin
                valid_values = [1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("calendar_dates.txt", "exception_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 0, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("calendar_dates.txt", "exception_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("calendar_dates.txt", "exception_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_attributes.txt" begin
        @testset "payment_method" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("fare_attributes.txt", "payment_method", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("fare_attributes.txt", "payment_method", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("fare_attributes.txt", "payment_method")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "transfers" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("fare_attributes.txt", "transfers", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("fare_attributes.txt", "transfers", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add transfers field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "rider_categories.txt" begin
        @testset "is_default_fare_category" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("rider_categories.txt", "is_default_fare_category", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("rider_categories.txt", "is_default_fare_category", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add is_default_fare_category field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_media.txt" begin
        @testset "fare_media_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3, 4]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("fare_media.txt", "fare_media_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 5, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("fare_media.txt", "fare_media_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("fare_media.txt", "fare_media_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "fare_transfer_rules.txt" begin
        @testset "duration_limit_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("fare_transfer_rules.txt", "duration_limit_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 4, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("fare_transfer_rules.txt", "duration_limit_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add duration_limit_type field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end

        @testset "fare_transfer_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("fare_transfer_rules.txt", "fare_transfer_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("fare_transfer_rules.txt", "fare_transfer_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("fare_transfer_rules.txt", "fare_transfer_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "frequencies.txt" begin
        @testset "exact_times" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("frequencies.txt", "exact_times", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("frequencies.txt", "exact_times", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add exact_times field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "transfers.txt" begin
        @testset "transfer_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2, 3, 4, 5]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("transfers.txt", "transfer_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 6, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("transfers.txt", "transfer_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add transfer_type field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "pathways.txt" begin
        @testset "pathway_mode" begin
            @testset "Valid Values" begin
                valid_values = [1, 2, 3, 4, 5, 6, 7]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("pathways.txt", "pathway_mode", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 0, 8, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("pathways.txt", "pathway_mode", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("pathways.txt", "pathway_mode")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "booking_rules.txt" begin
        @testset "booking_type" begin
            @testset "Valid Values" begin
                valid_values = [0, 1, 2]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("booking_rules.txt", "booking_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 3, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("booking_rules.txt", "booking_type", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=false (REQUIRED), so missing should produce error
                gtfs = create_gtfs_with_missing_field("booking_rules.txt", "booking_type")
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "attributions.txt" begin
        @testset "is_producer" begin
            @testset "Valid Values" begin
                valid_values = [0, 1]
                for value in valid_values
                    gtfs = create_gtfs_with_enum_field("attributions.txt", "is_producer", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test !GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Invalid Values" begin
                invalid_values = [99, -1, 2, 10]
                for value in invalid_values
                    gtfs = create_gtfs_with_enum_field("attributions.txt", "is_producer", value)
                    result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                    @test GTFSSchedules.Validations.has_validation_errors(result)
                end
            end

            @testset "Empty/Missing Values" begin
                # allow_empty=true, so missing should be valid (field doesn't exist)
                gtfs = create_basic_gtfs()
                # Don't add is_producer field at all
                result = GTFSSchedules.Validations.validate_enum_values(gtfs)
                @test !GTFSSchedules.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Edge Cases" begin
        @testset "Empty GTFS Dataset" begin
            gtfs = GTFSSchedule()
            result = GTFSSchedules.Validations.validate_enum_values(gtfs)
            @test result isa GTFSSchedules.Validations.ValidationResult
            @test !GTFSSchedules.Validations.has_validation_errors(result)  # No enum fields to validate
        end

        @testset "String Values in Integer Enum Fields" begin
            # Test that string values are properly rejected for integer enum fields
            gtfs = create_basic_gtfs()
            df = gtfs["routes.txt"]
            df[!, :route_type] .= ["invalid"]  # String instead of integer
            result = GTFSSchedules.Validations.validate_enum_values(gtfs)
            @test GTFSSchedules.Validations.has_validation_errors(result)
        end

        @testset "Float Values in Integer Enum Fields" begin
            # Test that float values are properly rejected for integer enum fields
            gtfs = create_basic_gtfs()
            df = gtfs["routes.txt"]
            df[!, :route_type] .= [3.5]  # Float instead of integer
            result = GTFSSchedules.Validations.validate_enum_values(gtfs)
            @test GTFSSchedules.Validations.has_validation_errors(result)
        end

        @testset "Multiple Invalid Values in Same Field" begin
            # Test multiple rows with invalid enum values
            gtfs = create_basic_gtfs()
            df = gtfs["routes.txt"]
            # Add more rows to the DataFrame first
            new_df = DataFrame(
                route_id = ["R1", "R2", "R3"],
                route_short_name = ["1", "2", "3"],
                route_long_name = ["Route 1", "Route 2", "Route 3"],
                route_type = [99, 100, -1],  # Multiple invalid values
                continuous_pickup = [1, 1, 1],
                continuous_drop_off = [1, 1, 1],
                cemv_support = [0, 0, 0]
            )
            gtfs["routes.txt"] = new_df
            result = GTFSSchedules.Validations.validate_enum_values(gtfs)
            @test GTFSSchedules.Validations.has_validation_errors(result)
            # Should have multiple error messages
            @test length(result.messages) >= 3
        end
    end
end
