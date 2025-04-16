# racket-ffi

This repository contains Racket Foreign Function Interface (FFI) bindings for integrating with C and C++ libraries. It demonstrates how to interface Racket with external code to leverage existing functionalities or optimize performance-critical sections.

## Features

- **C Bindings**: Provides bindings to C functions for direct interoperability.
- **C++ Bindings**: Includes bindings to C++ functions, utilizing Racket's FFI capabilities.
- **Z3 Solver Integration**: Interfaces with the Z3 theorem prover for logical reasoning tasks.

## Files

- `cairo.rkt`: Racket bindings for the Cairo graphics library.
- `demorgan.rkt`: Implements Demorgan's laws using Racket's FFI.
- `z3-racket.rkt`: Interfaces with the Z3 solver, providing functions for logical operations.
- `proof-example.rkt`: Demonstrates the use of Z3 for proof generation.
- `z3-test.c`: A C program for testing Z3 functionalities.

## Installation

To get started, clone this repository:

```bash
git clone https://github.com/daher13/racket-ffi.git
```

## Usage
After cloning, you can load the Racket files in your environment:
```racket
(require "z3-racket.rkt")
```
This will provide access to the Z3 solver functions defined in the repository.
