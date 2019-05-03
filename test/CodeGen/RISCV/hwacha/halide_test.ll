; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+x -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IFDX %s

define dso_local i64 @kernel_output_s0_x___block_id_x(i64 "noelim" %vl, i64 %consumed, i32 %t2, i8* noalias %input, i8* noalias %output) local_unnamed_addr #0 {
; RV64IFDX-LABEL: kernel_output_s0_x___block_id_x:
; RV64IFDX:       # %bb.0: # %body
; RV64IFDX-NEXT:    vpset vp0
; RV64IFDX-NEXT:    @vp0 vlw vv0, va1
; RV64IFDX-NEXT:    vaddi vs1, vs0, 1
; RV64IFDX-NEXT:    @vp0 vsll vv0, vv0, vs1
; RV64IFDX-NEXT:    @vp0 vsw vv0, va2
; RV64IFDX-NEXT:    vstop
body:
  %0 = call i64 @llvm.hwacha.veidx() #12
  %output.s0.x.__block_id_x = add nsw i64 %0, %consumed
  %1 = sext i32 %t2 to i64
  %2 = add nsw i64 %output.s0.x.__block_id_x, %1
  %3 = bitcast i8* %input to i32*
  %4 = getelementptr inbounds i32, i32* %3, i64 %2
  %5 = load i32, i32* %4, align 4
  %6 = mul i32 %5, 2
  %7 = bitcast i8* %output to i32*
  %8 = getelementptr inbounds i32, i32* %7, i64 %output.s0.x.__block_id_x
  store i32 %6, i32* %8, align 4
  %vlret = call i64 @llvm.hwacha.vretvl()
  ret i64 %vlret
}

define dso_local i64 @kernel_output.s0.x.__block_id_x_trunc(i64 "noelim" %vl, i32 %t2, i8* noalias %input, i8* noalias %output) #11 {
body:
  %0 = call i64 @llvm.hwacha.veidx() #14
  %output.s0.x.__block_id_x = trunc i64 %0 to i32
  %1 = add nsw i32 %output.s0.x.__block_id_x, %t2
  %2 = bitcast i8* %input to i32*
  %3 = sext i32 %1 to i64
  %4 = getelementptr inbounds i32, i32* %2, i64 %3
  %5 = load i32, i32* %4, align 4
  %6 = bitcast i8* %output to i32*
  %7 = sext i32 %output.s0.x.__block_id_x to i64
  %8 = getelementptr inbounds i32, i32* %6, i64 %7
  store i32 %5, i32* %8, align 4

  %vlret = call i64 @llvm.hwacha.vretvl()
  ret i64 %vlret
}

define dso_local void @nonstripmine(i32 %t2, i8* noalias %input, i8* noalias %output) #10 {
; RV64IFDX-LABEL: nonstripmine:
; RV64IFDX:       # %bb.0:
; RV64IFDX-NEXT:    addi a3, zero, 5
; RV64IFDX-NEXT:    vmcs vs1,a3
; RV64IFDX-NEXT:    vmcs vs2,a0
; RV64IFDX-NEXT:    vmcs vs3,a1
; RV64IFDX-NEXT:    vmcs vs4,a2
; RV64IFDX-NEXT:    vsetcfg a0,2,1,0,1
; RV64IFDX-NEXT:    vsetvl a0,a3
; RV64IFDX-NEXT:    la a0, kernel_output.s0.x.__block_id_x_trunc
; RV64IFDX-NEXT:    vf 0(a0)
; RV64IFDX-NEXT:    ret
  %vlret = call i64 @kernel_output.s0.x.__block_id_x_trunc(i64 5, i32 %t2, i8* %input, i8* %output)
  ret void
}

define dso_local void @stripmine(i32 %t2, i8* noalias %input, i8* noalias %output) #10 {
; RV64IFDX-LABEL: stripmine:
; RV64IFDX:       # %bb.0: # %entry
; RV64IFDX-NEXT:    addi sp, sp, -48
; RV64IFDX-NEXT:    sd s0, 40(sp)
; RV64IFDX-NEXT:    sd s1, 32(sp)
; RV64IFDX-NEXT:    sd s2, 24(sp)
; RV64IFDX-NEXT:    sd s3, 16(sp)
; RV64IFDX-NEXT:    sd s4, 8(sp)
; RV64IFDX-NEXT:    sd s5, 0(sp)
; RV64IFDX-NEXT:    mv s3, a2
; RV64IFDX-NEXT:    mv s4, a1
; RV64IFDX-NEXT:    mv s2, a0
; RV64IFDX-NEXT:    addi a0, a1, 40
; RV64IFDX-NEXT:    addi a1, a2, 20
; RV64IFDX-NEXT:    addi a2, zero, 5
; RV64IFDX-NEXT:    vmcs vs1,a2
; RV64IFDX-NEXT:    vmca va1,a0
; RV64IFDX-NEXT:    vmca va2,a1
; RV64IFDX-NEXT:    vsetcfg a0,0,1,0,1
; RV64IFDX-NEXT:    vsetvl a0,a2
; RV64IFDX-NEXT:    la a0, kernel_output_s0_x___block_id_x
; RV64IFDX-NEXT:    vf 0(a0)
; RV64IFDX-NEXT:    addi s0, zero, 1
; RV64IFDX-NEXT:    sext.w s2, s2
; RV64IFDX-NEXT:    addi s5, zero, 100
; RV64IFDX-NEXT:  .LBB3_1: # %loop
; RV64IFDX-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64IFDX-NEXT:    slli a0, s0, 2
; RV64IFDX-NEXT:    add a0, s3, a0
; RV64IFDX-NEXT:    add a1, s0, s2
; RV64IFDX-NEXT:    slli a1, a1, 2
; RV64IFDX-NEXT:    add a1, s4, a1
; RV64IFDX-NEXT:    sub a2, s5, s0
; RV64IFDX-NEXT:    vmcs vs1,a2
; RV64IFDX-NEXT:    vmca va1,a1
; RV64IFDX-NEXT:    vmca va2,a0
; RV64IFDX-NEXT:    vsetcfg a0,0,1,0,1
; RV64IFDX-NEXT:    vsetvl s1,a2
; RV64IFDX-NEXT:    la a0, kernel_output_s0_x___block_id_x
; RV64IFDX-NEXT:    vf 0(a0)
; RV64IFDX-NEXT:    add s0, s0, s1
; RV64IFDX-NEXT:    beq s0, s5, .LBB3_1
; RV64IFDX-NEXT:  # %bb.2: # %afterloop
; RV64IFDX-NEXT:    ld s5, 0(sp)
; RV64IFDX-NEXT:    ld s4, 8(sp)
; RV64IFDX-NEXT:    ld s3, 16(sp)
; RV64IFDX-NEXT:    ld s2, 24(sp)
; RV64IFDX-NEXT:    ld s1, 32(sp)
; RV64IFDX-NEXT:    ld s0, 40(sp)
; RV64IFDX-NEXT:    addi sp, sp, 48
; RV64IFDX-NEXT:    ret
entry:
  %vlret0 = call i64 @kernel_output_s0_x___block_id_x(i64 5, i64 5, i32 5, i8* %input, i8* %output)
  br label %loop

loop:
  %counter = phi i64 [ 1, %entry ], [ %total, %loop ]
  %wantedvl = sub i64 100, %counter
  %vlret = call i64 @kernel_output_s0_x___block_id_x(i64 %wantedvl, i64 %counter, i32 %t2, i8* %input, i8* %output)
  %total = add i64 %counter, %vlret
  %exitcond = icmp eq i64 %total, 100
  br i1 %exitcond, label %loop, label %afterloop

afterloop:
  ret void
}


; Function Attrs: nounwind readnone
declare i64 @llvm.hwacha.veidx() #8
declare i64 @llvm.hwacha.vretvl()

!opencl.kernels = !{!3, !4}

!3 = !{i64 (i64, i64, i32, i8*, i8*)* @kernel_output_s0_x___block_id_x}
!4 = !{i64 (i64, i32, i8*, i8*)* @kernel_output.s0.x.__block_id_x_trunc}

