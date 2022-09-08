#lang racket

(require ffi/unsafe)
(require ffi/unsafe/define)

(define z3-lib (ffi-lib "libz3" '("2" #f)))

(require "z3-helper-functions.rkt")

(provide (all-defined-out))
