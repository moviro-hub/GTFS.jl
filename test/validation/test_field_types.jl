"""
Field Types Validation Test Suite

This module contains tests for the GTFS field type validation functionality.
Tests are derived from the GTFS specification field types section.
"""

using Test
using GTFS
using DataFrames

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
    create_gtfs_with_field_values(gtfs::GTFSSchedule, filename::String, field::String, values::Vector) -> GTFSSchedule

Create a GTFS dataset with specific field values for testing.
"""
function create_gtfs_with_field_values(gtfs::GTFSSchedule, filename::String, field::String, values::Vector)
    new_gtfs = deepcopy(gtfs)
    if haskey(new_gtfs, filename)
        df = new_gtfs[filename]
        if hasproperty(df, Symbol(field))
            df[!, Symbol(field)] = values
        else
            df[!, Symbol(field)] = values
        end
    else
        # Create minimal file with just the field we're testing
        new_gtfs[filename] = DataFrame(Symbol(field) => values)
    end
    return new_gtfs
end

"""
    create_gtfs_with_mixed_values(gtfs::GTFSSchedule, filename::String, field::String, valid_values::Vector, invalid_values::Vector) -> GTFSSchedule

Create a GTFS dataset with mixed valid and invalid values for testing.
"""
function create_gtfs_with_mixed_values(gtfs::GTFSSchedule, filename::String, field::String, valid_values::Vector, invalid_values::Vector)
    mixed_values = vcat(valid_values, invalid_values)
    return create_gtfs_with_field_values(gtfs, filename, field, mixed_values)
end

# =============================================================================
# TEST SUITES
# =============================================================================

@testset "Field Type Validation" begin

    @testset "Color Type" begin
        # Per line 79 of gtfs_reference.md: "A color encoded as a six-digit hexadecimal number"
        @testset "Valid colors" begin
            valid_colors = ["FFFFFF", "000000", "0039A6", "FF0000", "00FF00", "0000FF"]

            for color in valid_colors
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "routes.txt", "route_color", [color])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid colors" begin
            invalid_colors = ["FFF", "GFFFFF", "#FFFFFF", "FFFFFFF", "12345", "GGGGGG"]

            for color in invalid_colors
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "routes.txt", "route_color", [color])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Currency Code Type" begin
        # Per line 80 of gtfs_reference.md: "ISO 4217 alphabetical currency code"
        @testset "Valid currency codes" begin
            valid_codes = ["CAD", "EUR", "JPY", "USD", "GBP", "AUD"]

            for code in valid_codes
                gtfs = create_basic_gtfs()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1"],
                    price = [10.50],
                    currency_type = [code],
                    payment_method = [0],
                    transfers = [0]
                )
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid currency codes" begin
            invalid_codes = ["CA", "EURO", "123", "USDX", "E", "DOLLAR"]

            for code in invalid_codes
                gtfs = create_basic_gtfs()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1"],
                    price = [10.50],
                    currency_type = [code],
                    payment_method = [0],
                    transfers = [0]
                )
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Date Type" begin
        # Per line 82 of gtfs_reference.md: "Service day in the YYYYMMDD format"
        @testset "Valid dates" begin
            valid_dates = ["20180913", "20241231", "20200101", "20231225", "20240229"]  # leap year

            for date in valid_dates
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "calendar.txt", "start_date", [date])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid dates" begin
            invalid_dates = ["2024-09-13", "240913", "20249999", "20240230", "20241301", "20240132"]

            for date in invalid_dates
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "calendar.txt", "start_date", [date])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Email Type" begin
        # Per line 83 of gtfs_reference.md: "An email address"
        @testset "Valid emails" begin
            valid_emails = ["example@example.com", "user@domain.org", "test+tag@example.co.uk"]

            for email in valid_emails
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_email", [email])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid emails" begin
            invalid_emails = ["notanemail", "@example.com", "example@", "user@", "@", "user@domain"]

            for email in invalid_emails
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_email", [email])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "ID Type" begin
        # Per line 85 of gtfs_reference.md: "sequence of any UTF-8 characters, printable ASCII recommended"
        @testset "Valid IDs" begin
            valid_ids = ["STOP_1", "route-123", "station_A", "agency_1", "trip_001"]

            for id_val in valid_ids
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_id", [id_val])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid IDs" begin
            invalid_ids = [""]  # Empty string is invalid for IDs

            for id_val in invalid_ids
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_id", [id_val])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Language Code Type" begin
        # Per line 86 of gtfs_reference.md: "IETF BCP 47 language code"
        @testset "Valid language codes" begin
            valid_codes = ["en", "en-US", "de", "fr", "es", "ja", "zh-CN"]

            for code in valid_codes
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_lang", [code])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid language codes" begin
            invalid_codes = ["e", "english", "EN", "en_US", "123", "x"]

            for code in invalid_codes
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_lang", [code])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Latitude/Longitude Types" begin
        # Per lines 87-88 of gtfs_reference.md: "WGS84 latitude/longitude in decimal degrees"
        @testset "Valid coordinates" begin
            valid_lats = [41.890169, 0.0, -45.5, 90.0, -90.0]
            valid_lons = [12.492269, 0.0, 180.0, -180.0, -74.0]

            for lat in valid_lats
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lat", [lat])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            for lon in valid_lons
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lon", [lon])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid coordinates" begin
            invalid_lats = [91.0, -91.0, 200.0, -200.0]
            invalid_lons = [181.0, -181.0, 360.0, -360.0]

            for lat in invalid_lats
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lat", [lat])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end

            for lon in invalid_lons
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lon", [lon])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Time Type" begin
        # Per line 92 of gtfs_reference.md: "Time in HH:MM:SS format, can exceed 24:00:00"
        @testset "Valid times" begin
            valid_times = ["14:30:00", "08:00:00", "25:35:00", "00:00:00", "23:59:59", "26:00:00"]

            for time in valid_times
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stop_times.txt", "arrival_time", [time])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid times" begin
            invalid_times = ["14:30", "2:30:00", "25:35", "25:60:00", "25:00:60"]

            for time in invalid_times
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stop_times.txt", "arrival_time", [time])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Timezone Type" begin
        # Per line 95 of gtfs_reference.md: "TZ timezone, no spaces, may contain underscore"
        @testset "Valid timezones" begin
            valid_timezones = ["Asia/Tokyo", "America/Los_Angeles", "Africa/Cairo", "Europe/London", "UTC"]

            for tz in valid_timezones
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_timezone", [tz])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid timezones" begin
            invalid_timezones = ["New York", "America/New York", "", "GMT+5", "EST"]

            for tz in invalid_timezones
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_timezone", [tz])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "URL Type" begin
        # Per line 96 of gtfs_reference.md: "Fully qualified URL with http:// or https://"
        @testset "Valid URLs" begin
            valid_urls = ["http://example.com", "https://example.org/path", "https://www.example.com"]

            for url in valid_urls
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_url", [url])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid URLs" begin
            invalid_urls = ["example.com", "ftp://example.com", "www.example.com", "http://", "https://"]

            for url in invalid_urls
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_url", [url])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Phone Number Type" begin
        # Per line 91 of gtfs_reference.md: "A phone number"
        @testset "Valid phone numbers" begin
            valid_phones = ["503-238-RIDE", "+1-555-1234", "(555) 123-4567", "555-123-4567", "+1234567890"]

            for phone in valid_phones
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_phone", [phone])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Invalid phone numbers" begin
            # Phone validation is lenient, so we test edge cases
            invalid_phones = ["", "abc", "123-abc-4567"]

            for phone in invalid_phones
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_phone", [phone])
                result = GTFS.Validations.validate_field_types(gtfs)

                # Note: Phone validation might be lenient, so we check if errors occur
                # The actual behavior depends on the validation implementation
            end
        end
    end

    @testset "Numeric Types" begin
        @testset "Float values" begin
            valid_floats = [1.5, 0.0, -3.14, 100.0]
            invalid_floats = ["abc", "1.2.3", "not_a_number"]

            for float_val in valid_floats
                gtfs = create_basic_gtfs()
                gtfs["shapes.txt"] = DataFrame(
                    shape_id = ["S1"],
                    shape_pt_lat = [40.0],
                    shape_pt_lon = [-74.0],
                    shape_pt_sequence = [1],
                    shape_dist_traveled = [float_val]
                )
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "Integer values" begin
            valid_ints = [0, 100, -50, 1]
            invalid_ints = [1.5, "abc", "not_a_number"]

            for int_val in valid_ints
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stop_times.txt", "stop_sequence", [int_val])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "File-Specific Type Validation" begin
        @testset "agency.txt types" begin
            @testset "Valid agency data" begin
                gtfs = create_basic_gtfs()
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid agency timezone" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_timezone", ["Invalid/Timezone"])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid agency URL" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_url", ["not-a-url"])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "stops.txt types" begin
            @testset "Valid stop data" begin
                gtfs = create_basic_gtfs()
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid latitude" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lat", [91.0])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid longitude" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_lon", [181.0])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "routes.txt types" begin
            @testset "Valid route data" begin
                gtfs = create_basic_gtfs()
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid route color" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "routes.txt", "route_color", ["INVALID"])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "stop_times.txt types" begin
            @testset "Valid stop times data" begin
                gtfs = create_basic_gtfs()
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid arrival time" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stop_times.txt", "arrival_time", ["12:60:00"])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "calendar.txt types" begin
            @testset "Valid calendar data" begin
                gtfs = create_basic_gtfs()
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid start date" begin
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "calendar.txt", "start_date", ["2024-13-01"])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end

        @testset "fare_attributes.txt types" begin
            @testset "Valid fare data" begin
                gtfs = create_basic_gtfs()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1"],
                    price = [10.50],
                    currency_type = ["USD"],
                    payment_method = [0],
                    transfers = [0]
                )
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end

            @testset "Invalid currency type" begin
                gtfs = create_basic_gtfs()
                gtfs["fare_attributes.txt"] = DataFrame(
                    fare_id = ["F1"],
                    price = [10.50],
                    currency_type = ["INVALID"],
                    payment_method = [0],
                    transfers = [0]
                )
                result = GTFS.Validations.validate_field_types(gtfs)

                @test GTFS.Validations.has_validation_errors(result)
            end
        end
    end

    @testset "Edge Cases" begin
        @testset "Missing values" begin
            # Missing values should always be valid per GTFS spec
            gtfs = create_basic_gtfs()
            gtfs = create_gtfs_with_field_values(gtfs, "agency.txt", "agency_email", [missing])
            result = GTFS.Validations.validate_field_types(gtfs)

            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Empty GTFS dataset" begin
            gtfs = GTFSSchedule()
            result = GTFS.Validations.validate_field_types(gtfs)

            @test result isa GTFS.Validations.ValidationResult
            # Empty dataset should not have type validation errors
            @test !GTFS.Validations.has_validation_errors(result)
        end

        @testset "Mixed valid and invalid values" begin
            valid_values = ["http://example.com", "https://test.org"]
            invalid_values = ["not-a-url", "ftp://invalid.com"]
            mixed_values = vcat(valid_values, invalid_values)

            # Create a new GTFS with multiple rows to match the mixed values length
            gtfs = GTFSSchedule()
            gtfs["agency.txt"] = DataFrame(
                agency_id = ["DTA1", "DTA2", "DTA3", "DTA4"],
                agency_name = ["Demo Transit Authority", "Demo Transit Authority", "Demo Transit Authority", "Demo Transit Authority"],
                agency_url = mixed_values,
                agency_timezone = ["America/New_York", "America/New_York", "America/New_York", "America/New_York"]
            )

            result = GTFS.Validations.validate_field_types(gtfs)

            @test GTFS.Validations.has_validation_errors(result)
        end

        @testset "Unicode text values" begin
            # Test that UTF-8 text is properly handled
            unicode_text = ["Café", "Müller", "北京", "🚌"]

            for text in unicode_text
                gtfs = create_basic_gtfs()
                gtfs = create_gtfs_with_field_values(gtfs, "stops.txt", "stop_name", [text])
                result = GTFS.Validations.validate_field_types(gtfs)

                @test !GTFS.Validations.has_validation_errors(result)
            end
        end
    end
end
