function test_symcliff()
    @testset "Small symbolic operators" begin
        for n in test_sizes
            for i in 1:6
                op = enumerate_single_qubit_gates(i, qubit=n, phases=rand(Bool,2))
                op0 = enumerate_single_qubit_gates(i, qubit=n) 
                op_cc = CliffordOperator(op, 1, compact=true)
                op_c = CliffordOperator(op, n)
                @test SingleQubitOperator(op)==SingleQubitOperator(op_cc, n)
                op0_c = CliffordOperator(op0, n)
                s = random_stabilizer(n)
                @test apply!(copy(s),op)==apply!(copy(s),SingleQubitOperator(op))==apply!(copy(s),op_cc,[n])==apply!(copy(s),op_c)
                @test ==(apply!(copy(s),op,phases=false),apply!(copy(s),op_cc,[n],phases=false), phases=false)
                @test apply!(copy(s),op0)==apply!(copy(s),op0_c)
            end
            i = n÷2+1
            @test apply!(copy(s),sX(i)) == apply_single_x!(copy(s),i)
            @test apply!(copy(s),sY(i)) == apply_single_y!(copy(s),i)
            @test apply!(copy(s),sZ(i)) == apply_single_z!(copy(s),i)
            n==1 && continue
            s = random_stabilizer(n)
            i1,i2 = randperm(n)[1:2]
            @test apply!(copy(s),CNOT,[i1,i2]) == apply!(copy(s),sCNOT(i1,i2))
            @test apply!(copy(s),SWAP,[i1,i2]) == apply!(copy(s),sSWAP(i1,i2))
        end
        @test_throws DimensionMismatch SingleQubitOperator(CNOT,1)
        @test_throws DimensionMismatch CliffordOperator(sHadamard(5),2)
        @test_throws ArgumentError CliffordOperator(sHadamard(5),6,compact=true)    
    end
end

test_symcliff()