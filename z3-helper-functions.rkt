#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(define z3-lib (ffi-lib "libz3" '("2" #f)))

(require "z3-functions.rkt")

(define (mk-context-custom cfg)
  (z3-set-param-value cfg "model" "true")
  (define ctx (z3-mk-context cfg))
  ctx)

(define (mk-proof-context)
  (define cfg (z3-mk-config))
  (z3-set-param-value cfg "proof" "true")
  (define ctx (mk-context-custom cfg))
  (z3-del-config cfg)
  ctx
  )

(define (mk-var ctx name ty)
  (define s (z3-mk-string-symbol ctx name))
  (z3-mk-const ctx s ty))

(define (mk-bool-var ctx name)
  (define ty (z3-mk-bool-sort ctx))
  (mk-var ctx name ty))

(provide (all-defined-out))
