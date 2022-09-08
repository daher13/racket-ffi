#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(define z3-lib (ffi-lib "libz3" '("2" #f)))

(define-cpointer-type _Z3_ast)
(define-cpointer-type _Z3_ast_const)
(define-cpointer-type _Z3_ast_vector)
(define-cpointer-type _Z3_config)
(define-cpointer-type _Z3_context)
(define-cpointer-type _Z3_error_code)
(define-cpointer-type _Z3_error_handler)
(define-cpointer-type _Z3_lbool)
(define-cpointer-type _Z3_model)
(define-cpointer-type _Z3_solver)
(define-cpointer-type _Z3_sort)
(define-cpointer-type _Z3_string)
(define-cpointer-type _Z3_symbol)
(define-cpointer-type _jmp_buf)

(provide (all-defined-out))
