"""
Example dataset tests for GTFS.jl

Tests all official GTFS example datasets to ensure they can be read correctly
and contain the expected data based on the official GTFS examples.
"""

@testset "Example Datasets" begin
    # Define all example datasets with their expected characteristics
    examples = [
        (
            name = "basic-example",
            description = "Complete GTFS feed with all core files",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "shapes.txt", "feed_info.txt"],
            expected_agencies = 1,
            expected_stops = 6,
            expected_routes = 3,
            expected_trips = 5,
            expected_stop_times = 12,
            expected_shapes = 7,
            has_feed_info = true,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "continuous-stops-example",
            description = "Demonstrates continuous pickup/drop-off functionality",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt"],
            expected_agencies = 1,
            expected_stops = 7,
            expected_routes = 4,
            expected_trips = 4,
            expected_stop_times = 7,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false,
            continuous_pickup_routes = true,
            continuous_dropoff_routes = true
        ),
        (
            name = "attributions-example",
            description = "Dataset attribution examples",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "attributions.txt"],
            expected_agencies = 1,
            expected_stops = 2,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 2,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = true,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "frequencies-example",
            description = "Frequency-based service examples",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "frequencies.txt"],
            expected_agencies = 1,
            expected_stops = 3,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 3,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = true,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "pathways-example",
            description = "Station pathway information",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "pathways.txt", "levels.txt"],
            expected_agencies = 1,
            expected_stops = 5,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 2,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = true,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "text-to-speech-example",
            description = "Accessibility features with TTS-friendly names",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt"],
            expected_agencies = 1,
            expected_stops = 3,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 3,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "transfers-example",
            description = "Transfer information between stops and routes",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "transfers.txt"],
            expected_agencies = 1,
            expected_stops = 4,
            expected_routes = 3,
            expected_trips = 3,
            expected_stop_times = 6,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = true,
            has_translations = false,
            has_fares = false
        ),
        (
            name = "translations-example",
            description = "Multilingual support with translations",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "translations.txt"],
            expected_agencies = 1,
            expected_stops = 2,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 2,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = true,
            has_fares = false
        ),
        (
            name = "fares-v1-example",
            description = "Legacy fare structure with zones and transfer rules",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "fare_attributes.txt", "fare_rules.txt"],
            expected_agencies = 1,
            expected_stops = 3,
            expected_routes = 2,
            expected_trips = 2,
            expected_stop_times = 4,
            expected_shapes = 0,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = true
        ),
        (
            name = "shapes-example",
            description = "Detailed route geometry with shape points",
            expected_files = ["agency.txt", "stops.txt", "routes.txt", "trips.txt", "stop_times.txt", "calendar.txt", "shapes.txt"],
            expected_agencies = 1,
            expected_stops = 3,
            expected_routes = 1,
            expected_trips = 1,
            expected_stop_times = 3,
            expected_shapes = 7,
            has_feed_info = false,
            has_attributions = false,
            has_frequencies = false,
            has_pathways = false,
            has_transfers = false,
            has_translations = false,
            has_fares = false
        )
    ]

    # Test each example dataset
    for example in examples
        @testset "$(example.name): $(example.description)" begin
            feed_path = joinpath(@__DIR__, "fixtures", "$(example.name).zip")

            if isfile(feed_path)
                # Test reading the feed
                gtfs = read_gtfs(feed_path)
                @test gtfs !== nothing

                # Test basic structure
                @test gtfs.agency !== nothing
                @test gtfs.stops !== nothing
                @test gtfs.routes !== nothing
                @test gtfs.trips !== nothing
                @test gtfs.stop_times !== nothing

                # Test expected counts
                @test nrow(gtfs.agency) == example.expected_agencies
                @test nrow(gtfs.stops) == example.expected_stops
                @test nrow(gtfs.routes) == example.expected_routes
                @test nrow(gtfs.trips) == example.expected_trips
                @test nrow(gtfs.stop_times) == example.expected_stop_times

                # Test optional files
                if example.has_feed_info
                    @test gtfs.feed_info !== nothing
                end
                if example.has_attributions
                    @test gtfs.attributions !== nothing
                end
                if example.has_frequencies
                    @test gtfs.frequencies !== nothing
                end
                if example.has_pathways
                    @test gtfs.pathways !== nothing
                end
                if example.has_transfers
                    @test gtfs.transfers !== nothing
                end
                if example.has_translations
                    @test gtfs.translations !== nothing
                end
                if example.has_fares
                    @test gtfs.fare_attributes !== nothing
                    @test gtfs.fare_rules !== nothing
                end

                # Test shapes if expected
                if example.expected_shapes > 0
                    @test gtfs.shapes !== nothing
                    @test nrow(gtfs.shapes) == example.expected_shapes
                end

                # Test validation
                result = validate(gtfs)
                @test result !== nothing
                @test isa(result.errors, Vector{ValidationError})

                # Print summary
                println("✓ $(example.name): $(example.description)")
                println("  Agencies: $(nrow(gtfs.agency)), Stops: $(nrow(gtfs.stops))")
                println("  Routes: $(nrow(gtfs.routes)), Trips: $(nrow(gtfs.trips))")
                println("  Stop Times: $(nrow(gtfs.stop_times))")
                if gtfs.shapes !== nothing
                    println("  Shapes: $(nrow(gtfs.shapes))")
                end

                # Print warnings if any (for debugging)
                warnings = filter(e -> e.severity == :warning, result.errors)
                if !isempty(warnings)
                    println("Warnings in $(example.name):")
                    for warning in warnings
                        println("  - $(warning.message)")
                    end
                end
            else
                @warn "Example dataset $(example.name) not found at $feed_path"
            end
        end
    end
end
