#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(define z3-lib (ffi-lib "libz3" '("2" #f)))

(require "z3-definitions.rkt")

(define z3-ast-to-string
  (get-ffi-obj "Z3_ast_to_string" z3-lib (_fun _Z3_context _Z3_ast -> _Z3_string)))

(define z3-benchmark-to-smtlib-string ;; unused
  (get-ffi-obj "Z3_benchmark_to_smtlib_string"
               z3-lib
               (_fun _Z3_context
                     _Z3_string
                     _Z3_string
                     _Z3_string
                     _Z3_string
                     _int
                     (_list i _Z3_ast_const)
                     _Z3_ast
                     ->
                     _Z3_string)))

(define z3-del-config (get-ffi-obj "Z3_del_config" z3-lib (_fun _Z3_config -> _void)))

(define z3-set-error-handler (get-ffi-obj "Z3_set_error_handler" z3-lib (_fun _Z3_context _Z3_error_handler -> _void)))

(define z3-mk-and
  (get-ffi-obj "Z3_mk_and" z3-lib (_fun _Z3_context _int (_list i _Z3_ast) -> _Z3_ast)))

(define z3-mk-bool-sort (get-ffi-obj "Z3_mk_bool_sort" z3-lib (_fun _Z3_context -> _Z3_sort)))

(define z3-mk-config (get-ffi-obj "Z3_mk_config" z3-lib (_fun -> _Z3_config)))

(define z3-mk-context (get-ffi-obj "Z3_mk_context" z3-lib (_fun _Z3_config -> _Z3_context)))

(define z3-mk-const
  (get-ffi-obj "Z3_mk_const" z3-lib (_fun _Z3_context _Z3_symbol _Z3_sort -> _Z3_ast)))

(define z3-mk-iff (get-ffi-obj "Z3_mk_iff" z3-lib (_fun _Z3_context _Z3_ast _Z3_ast -> _Z3_ast)))

(define z3-mk-int-symbol
  (get-ffi-obj "Z3_mk_int_symbol" z3-lib (_fun _Z3_context _int -> _Z3_symbol)))

(define z3-mk-string-symbol
  (get-ffi-obj "Z3_mk_string_symbol" z3-lib (_fun _Z3_context _string -> _Z3_symbol)))

(define z3-mk-not (get-ffi-obj "Z3_mk_not" z3-lib (_fun _Z3_context _Z3_ast -> _Z3_ast)))

(define z3-mk-or (get-ffi-obj "Z3_mk_or" z3-lib (_fun _Z3_context _int (_list i _Z3_ast) -> _Z3_ast)))

(define z3-mk-solver ;; just mk_solver
  (get-ffi-obj "Z3_mk_solver" z3-lib (_fun _Z3_context -> _Z3_solver)))

(define z3-set-param-value
  (get-ffi-obj "Z3_set_param_value" z3-lib (_fun _Z3_config _Z3_string _Z3_string -> _void)))

(define z3-solver-assert
  (get-ffi-obj "Z3_mk_solver" z3-lib (_fun _Z3_context _Z3_solver _Z3_ast -> _void)))

(define z3-solver-check
  (get-ffi-obj "Z3_solver_check" z3-lib (_fun _Z3_context _Z3_solver -> _Z3_lbool)))

(define z3-solver-get-proof
  (get-ffi-obj "Z3_solver_get_proof" z3-lib (_fun _Z3_context _Z3_solver -> _Z3_ast)))

(define z3-solver-get-unsat-core
  (get-ffi-obj "Z3_solver_get_unsat_core" z3-lib (_fun _Z3_context _Z3_solver -> _Z3_ast_vector)))

(define z3-solver-inc-ref
  (get-ffi-obj "Z3_solver_inc_ref" z3-lib (_fun _Z3_context _Z3_solver -> _void)))

(define z3-solver-check-assumptions
  (get-ffi-obj "Z3_solver_check_assumptions" z3-lib (_fun _Z3_context _Z3_solver _int (_list i _Z3_ast) -> _Z3_lbool)))

(define z3-solver-to-string
  (get-ffi-obj "Z3_solver_to_string" z3-lib (_fun _Z3_context _Z3_solver -> _Z3_string)))


(provide (all-defined-out))
