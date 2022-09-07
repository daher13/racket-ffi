#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(require "./z3-racket.rkt")

(define cfg (z3-mk-config))
(define ctx (z3-mk-context cfg))

(z3-del-config cfg)

(define bool-sort (z3-mk-bool-sort ctx))

(define symbol-x (z3-mk-int-symbol ctx 0))
(define symbol-y (z3-mk-int-symbol ctx 1))

(define x (z3-mk-const ctx symbol-x bool-sort))
(define y (z3-mk-const ctx symbol-y bool-sort))

(define not-x (z3-mk-not ctx x))
(define not-y (z3-mk-not ctx y))

(define args (list x y))

(define x-and-y (z3-mk-and ctx 2 args))
(define ls (z3-mk-not ctx x-and-y))

(set! args (list not-x not-y))

(define rs (z3-mk-or ctx 2 args))

(define conjecture (z3-mk-iff ctx ls rs))
(define negated-conjecture (z3-mk-not ctx conjecture))

(define s (z3-mk-solver ctx))

(define proof (z3-solver-get-proof ctx s))

(provide (all-defined-out))
