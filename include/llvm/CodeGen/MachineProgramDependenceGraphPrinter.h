//===-- RegionPrinter.h - Region printer external interface -----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines external functions that can be called to explicitly
// instantiate the region printer.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_PROGRAMDEPENDENCEGRAPHPRINTER_H
#define LLVM_ANALYSIS_PROGRAMDEPENDENCEGRAPHPRINTER_H

namespace llvm {
  class MachineFunctionPass;
  MachineFunctionPass *createMachineProgramDependenceGraphPrinterPass();
} // End llvm namespace

#endif
