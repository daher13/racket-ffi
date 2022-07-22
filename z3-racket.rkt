#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(define z3-lib (ffi-lib "libz3" '("2" #f)))

(define-cpointer-type _Z3_ast)
(define-cpointer-type _Z3_ast_const)
(define-cpointer-type _Z3_config)
(define-cpointer-type _Z3_context)
(define-cpointer-type _Z3_lbool)
(define-cpointer-type _Z3_solver)
(define-cpointer-type _Z3_sort)
(define-cpointer-type _Z3_string)
(define-cpointer-type _Z3_symbol)

(define z3-benchmark-to-smtlib-string ;; unused
  (get-ffi-obj "Z3_benchmark_to_smtlib_string" z3-lib
               (_fun _Z3_context _Z3_string _Z3_string _Z3_string _Z3_string _int (_list i _Z3_ast_const) _Z3_ast -> _Z3_string)))

(define z3-del-config
  (get-ffi-obj "Z3_del_config" z3-lib
               (_fun _Z3_config -> _void)))

(define z3-mk-and
  (get-ffi-obj "Z3_mk_and" z3-lib
               (_fun _Z3_context _int (_list i _Z3_ast) -> _Z3_ast)))

(define z3-mk-bool-sort
  (get-ffi-obj "Z3_mk_bool_sort" z3-lib
               (_fun _Z3_context -> _Z3_sort)))

(define z3-mk-config
  (get-ffi-obj "Z3_mk_config" z3-lib
               (_fun -> _Z3_config)))

(define z3-mk-context
  (get-ffi-obj "Z3_mk_context" z3-lib
               (_fun _Z3_config -> _Z3_context)))

(define z3-mk-const
  (get-ffi-obj "Z3_mk_const" z3-lib
               (_fun _Z3_context _Z3_symbol _Z3_sort -> _Z3_ast)))

(define z3-mk-iff
  (get-ffi-obj "Z3_mk_not" z3-lib
               (_fun _Z3_context _Z3_ast _Z3_ast -> _Z3_ast)))

(define z3-mk-int-symbol
  (get-ffi-obj "Z3_mk_int_symbol" z3-lib
               (_fun _Z3_context _int -> _Z3_symbol)))

(define z3-mk-not
  (get-ffi-obj "Z3_mk_not" z3-lib
               (_fun _Z3_context _Z3_ast -> _Z3_ast)))

(define z3-mk-or
  (get-ffi-obj "Z3_mk_or" z3-lib
               (_fun _Z3_context _int (_list i _Z3_ast) -> _Z3_ast)))

(define z3-mk-solver ;; just mk_solver
  (get-ffi-obj "Z3_mk_solver" z3-lib
               (_fun _Z3_context -> _Z3_solver)))

(define z3-solver-assert
  (get-ffi-obj "Z3_mk_solver" z3-lib
               (_fun _Z3_context _Z3_solver _Z3_ast -> _void)))

(define z3-solver-check
  (get-ffi-obj "Z3_solver_check" z3-lib
               (_fun _Z3_context _Z3_solver -> _Z3_lbool)))

(define z3-solver-inc-ref
  (get-ffi-obj "Z3_solver_inc_ref" z3-lib
               (_fun _Z3_context _Z3_solver  -> _void)))

(define z3-solver-to-string
  (get-ffi-obj "Z3_solver_to_string" z3-lib
               (_fun _Z3_context _Z3_solver  -> _Z3_string)))

(provide (all-defined-out))

