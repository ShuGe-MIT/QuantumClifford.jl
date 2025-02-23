using Test, Random
using QuantumClifford
using QuantumClifford: stab_looks_good, mixed_stab_looks_good, destab_looks_good, mixed_destab_looks_good
using QuantumClifford: mul_left!
using LinearAlgebra: inv
#using Nemo

test_sizes = [1,2,10,63,64,65,127,128,129] # Including sizes that would test off-by-one errors in the bit encoding.

function doset(descr)
    if length(ARGS) == 0
        return true
    end
    for a in ARGS
        if occursin(lowercase(a), lowercase(descr))
            return true
        end
    end
    return false
end

println("Starting tests with $(Threads.nthreads()) threads out of `Sys.CPU_THREADS = $(Sys.CPU_THREADS)`...")

doset("paulis")             && include("./test_paulis.jl")
doset("stabilizers")        && include("./test_stabs.jl")
doset("canonicalization")   && include("./test_stabcanon.jl")
doset("gf2")                && include("./test_gf2.jl")
doset("projection")         && include("./test_projections.jl")
doset("trace")              && include("./test_trace.jl")
doset("cliffords")          && include("./test_cliff.jl")
doset("symbolic cliffords") && include("./test_symcliff.jl")
doset("random")             && include("./test_random.jl")
doset("noisy circuits")     && include("./test_noisycircuits.jl")
doset("allocations")        && include("./test_allocations.jl")
doset("bitpack")            && include("./test_bitpack.jl")
doset("doctests")           && include("./doctests.jl")