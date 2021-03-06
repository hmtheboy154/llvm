# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -iterations=1500 -timeline -timeline-max-iterations=3 < %s | FileCheck %s

# Each lzcnt has a false dependency on %ecx; the first lzcnt has to wait on the
# imul. However, the folded load can start immediately.
# The last lzcnt has a false dependency on %cx. However, even in this case, the
# folded load can start immediately.

imul %edx, %ecx
lzcnt (%rsp), %cx
lzcnt 2(%rsp), %cx

# CHECK:      Iterations:        1500
# CHECK-NEXT: Instructions:      4500
# CHECK-NEXT: Total Cycles:      4510
# CHECK-NEXT: Total uOps:        7500

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    1.66
# CHECK-NEXT: IPC:               1.00
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%edx, %ecx
# CHECK-NEXT:  2      8     1.00    *                   lzcntw	(%rsp), %cx
# CHECK-NEXT:  2      8     1.00    *                   lzcntw	2(%rsp), %cx

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -     3.00    -      -     1.00   1.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     imull	%edx, %ecx
# CHECK-NEXT:  -      -      -     1.00    -      -      -     1.00   lzcntw	(%rsp), %cx
# CHECK-NEXT:  -      -      -     1.00    -      -     1.00    -     lzcntw	2(%rsp), %cx

# CHECK:      Timeline view:
# CHECK-NEXT:                     012345678
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeER    .    .  .   imull	%edx, %ecx
# CHECK-NEXT: [0,1]     D=eeeeeeeeER   .  .   lzcntw	(%rsp), %cx
# CHECK-NEXT: [0,2]     .D=eeeeeeeeER  .  .   lzcntw	2(%rsp), %cx
# CHECK-NEXT: [1,0]     .D=========eeeER  .   imull	%edx, %ecx
# CHECK-NEXT: [1,1]     . D=eeeeeeeeE--R  .   lzcntw	(%rsp), %cx
# CHECK-NEXT: [1,2]     . D==eeeeeeeeE-R  .   lzcntw	2(%rsp), %cx
# CHECK-NEXT: [2,0]     .  D==========eeeER   imull	%edx, %ecx
# CHECK-NEXT: [2,1]     .  D==eeeeeeeeE---R   lzcntw	(%rsp), %cx
# CHECK-NEXT: [2,2]     .   D==eeeeeeeeE--R   lzcntw	2(%rsp), %cx

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     7.3    0.3    0.0       imull	%edx, %ecx
# CHECK-NEXT: 1.     3     2.3    2.3    1.7       lzcntw	(%rsp), %cx
# CHECK-NEXT: 2.     3     2.7    2.7    1.0       lzcntw	2(%rsp), %cx
