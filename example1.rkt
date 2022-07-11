#lang racket

(require racket/draw)
(require ffi/unsafe)

(define bt (make-bitmap 256 256))
(define bt-surface (send bt get-handle))

(define cairo-lib (ffi-lib "libcairo" '("2" #f)))

(define-cpointer-type _cairo_t)
(define-cpointer-type _cairo_surface_t)

(define cairo-create
  (get-ffi-obj "cairo_create" cairo-lib
               (_fun _pointer -> _pointer)))

(define ctx (cairo-create bt-surface))
; ctx

(cpointer-push-tag! ctx 'cairo_t)
; (cpointer-has-tag? ctx 'cairo_t)

(require ffi/unsafe/define)
(define-ffi-definer define-cairo cairo-lib)

(define-cairo cairo-set-font-size
  (_fun _cairo_t _double -> _void)
  #:c-id cairo_set_font_size)

(define-cairo cairo-set-source-rgb
  (_fun _cairo_t _double _double _double -> _void)
  #:c-id cairo_set_source_rgb)

(define-cairo cairo-move-to
  (_fun _cairo_t _double _double -> _void)
  #:c-id cairo_move_to)

(define-cairo cairo-show-text
  (_fun _cairo_t _string -> _void)
  #:c-id cairo_show_text)

(define-cairo cairo-surface-write-to-png
  (_fun _cairo_surface_t _string -> _void)
  #:c-id cairo_surface_write_to_png)

(cairo-set-font-size ctx 32.0)
(cairo-set-source-rgb ctx 0.0 0.0 1.0)
(cairo-move-to ctx 10.0 50.0)
(cairo-show-text ctx "HelloWorld")
(cairo-surface-write-to-png bt-surface "hello.png")