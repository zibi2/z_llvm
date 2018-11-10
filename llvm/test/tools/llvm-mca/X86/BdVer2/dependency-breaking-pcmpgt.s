# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=bdver2 -timeline -timeline-max-iterations=3 -iterations=1500 < %s | FileCheck %s

# perf stat reports an IPC of 2.00 for this block of code.

# All of the vector packed compares from this test are zero idioms.  These zero
# idioms are all detected and removed by the register renamer.  That means, no
# uOp is executed, and there is no RAW dependency for any of the packed
# compares.

vpcmpgtb %xmm0, %xmm0, %xmm1
vpcmpgtw %xmm1, %xmm1, %xmm2
vpcmpgtd %xmm2, %xmm2, %xmm3
vpcmpgtq %xmm3, %xmm3, %xmm0

# CHECK:      Iterations:        1500
# CHECK-NEXT: Instructions:      6000
# CHECK-NEXT: Total Cycles:      1504
# CHECK-NEXT: Total uOps:        6000

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    3.99
# CHECK-NEXT: IPC:               3.99
# CHECK-NEXT: Block RThroughput: 1.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      0     0.25                        vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT:  1      0     0.25                        vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT:  1      0     0.25                        vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT:  1      2     0.50                        vpcmpgtq	%xmm3, %xmm3, %xmm0

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - PdAGLU01
# CHECK-NEXT: [0.1] - PdAGLU01
# CHECK-NEXT: [1]   - PdBranch
# CHECK-NEXT: [2]   - PdCount
# CHECK-NEXT: [3]   - PdDiv
# CHECK-NEXT: [4]   - PdEX0
# CHECK-NEXT: [5]   - PdEX1
# CHECK-NEXT: [6]   - PdFPCVT
# CHECK-NEXT: [7.0] - PdFPFMA
# CHECK-NEXT: [7.1] - PdFPFMA
# CHECK-NEXT: [8.0] - PdFPMAL
# CHECK-NEXT: [8.1] - PdFPMAL
# CHECK-NEXT: [9]   - PdFPMMA
# CHECK-NEXT: [10]  - PdFPSTO
# CHECK-NEXT: [11]  - PdFPU0
# CHECK-NEXT: [12]  - PdFPU1
# CHECK-NEXT: [13]  - PdFPU2
# CHECK-NEXT: [14]  - PdFPU3
# CHECK-NEXT: [15]  - PdFPXBR
# CHECK-NEXT: [16.0] - PdLoad
# CHECK-NEXT: [16.1] - PdLoad
# CHECK-NEXT: [17]  - PdMul
# CHECK-NEXT: [18]  - PdStore

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3]    [4]    [5]    [6]    [7.0]  [7.1]  [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]   [15]   [16.0] [16.1] [17]   [18]
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -     0.50   0.50    -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3]    [4]    [5]    [6]    [7.0]  [7.1]  [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]   [15]   [16.0] [16.1] [17]   [18]   Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00    -      -     0.50   0.50    -      -      -      -      -      -      -     vpcmpgtq	%xmm3, %xmm3, %xmm0

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DR   ..   vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: [0,1]     DR   ..   vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT: [0,2]     DR   ..   vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT: [0,3]     DeeER..   vpcmpgtq	%xmm3, %xmm3, %xmm0
# CHECK-NEXT: [1,0]     .D--R..   vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: [1,1]     .D--R..   vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT: [1,2]     .D--R..   vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT: [1,3]     .DeeER.   vpcmpgtq	%xmm3, %xmm3, %xmm0
# CHECK-NEXT: [2,0]     . D--R.   vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: [2,1]     . D--R.   vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT: [2,2]     . D--R.   vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT: [2,3]     . DeeER   vpcmpgtq	%xmm3, %xmm3, %xmm0

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     0.0    0.0    1.3       vpcmpgtb	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: 1.     3     0.0    0.0    1.3       vpcmpgtw	%xmm1, %xmm1, %xmm2
# CHECK-NEXT: 2.     3     0.0    0.0    1.3       vpcmpgtd	%xmm2, %xmm2, %xmm3
# CHECK-NEXT: 3.     3     1.0    1.0    0.0       vpcmpgtq	%xmm3, %xmm3, %xmm0
