"""
Test suite for GTFS.jl package

This module contains comprehensive tests for the GTFS package functionality.
"""

using Test
using GTFS
using DataFrames

@testset "GTFS.jl Tests" begin
    include("test_core.jl")
    include("test_validation.jl")
    include("test_examples.jl")
    include("test_specialized.jl")
end
