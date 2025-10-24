"""
Test suite for GTFSSchedule.jl package

This module contains comprehensive tests for the GTFS package functionality.
"""

using Test
using GTFSSchedule
using DataFrames

@testset "GTFSSchedule.jl Tests" begin
    include("test_reader.jl")
    include("validation/test_gtfs.jl")
    include("validation/test_file_conditions.jl")
    include("validation/test_field_conditions.jl")
    include("validation/test_field_types.jl")
end
