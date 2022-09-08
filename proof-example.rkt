#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(require "z3-racket.rkt")

(define cfg (z3-mk-config))
(define ctx (z3-mk-context cfg))

(define s (z3-mk-solver ctx))

(define pa (mk-bool-var ctx "PredA"))
(define pb (mk-bool-var ctx "PredB"))
(define pc (mk-bool-var ctx "PredC"))
(define pd (mk-bool-var ctx "PredD"))


(define p1 (mk-bool-var ctx "P1"))
(define p2 (mk-bool-var ctx "P2"))
(define p3 (mk-bool-var ctx "P3"))
(define p4 (mk-bool-var ctx "P4"))

(define a1 (z3-mk-not ctx p1))

(define assumptions (list (z3-mk-not ctx p1) (z3-mk-not ctx p2) (z3-mk-not ctx p3) (z3-mk-not ctx p4)))

(define args1 (list pa pb pc))

(define f1 (z3-mk-and ctx 3 args1))

(define args2 (list pa (z3-mk-not ctx pb) pc))

(define f2 (z3-mk-and ctx 3 args2))

(define args3 (list (z3-mk-not ctx pa) (z3-mk-not ctx pc)))

(define f3 (z3-mk-or ctx 2 args3))

(define f4 pd)

(define g1 (list f1 p1))
(define g2 (list f2 p2))
(define g3 (list f3 p3))
(define g4 (list f4 p4))

(define m 0)

(z3-solver-assert ctx s (z3-mk-or ctx 2 g1))
(z3-solver-assert ctx s (z3-mk-or ctx 2 g2))
(z3-solver-assert ctx s (z3-mk-or ctx 2 g3))
(z3-solver-assert ctx s (z3-mk-or ctx 2 g4))

(define result (z3-solver-check-assumptions ctx s 4 assumptions))

(z3-solver-get-unsat-core ctx s)

(z3-solver-get-proof ctx s)

;; proof

;; (z3-ast-to-string ctx proof)
