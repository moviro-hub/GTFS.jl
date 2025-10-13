"""
Test suite for GTFS.jl package

This module contains comprehensive tests for the GTFS package functionality.
"""

using Test
using GTFS
using DataFrames

@testset "GTFS.jl Tests" begin
    include("test_examples.jl")
end
