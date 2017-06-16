#lang br/quicklang

(define (read-syntax path port)
  (define args (port->lines port))
  
  ;when it passes in args to eg: we want eg: ,@arg-datums[1:] 
  (define arg-datums (format-datums '~a args))
  (define module-datum ``(module seed-mod "seed.rkt"
                            (eg ,@arg-datums)))
                          ;(eg: arg-datums(1) last(arg-datums) ,@arg-datums(:: 2 -2) )))
  (datum->syntax #f module-datum))
(provide read-syntax)

(define-macro (seed-module-begin HANDLE-ARGS-EXPR)
  #'(#%module-begin
     (display (first HANDLE-ARGS-EXPR))))
(provide (rename-out [seed-module-begin #%module-begin]))

; want a function where we read "eg add 1 2 = 3" and it executes it and checks for equal
(define (eg . args )
  (if (equal? args(1)( array-slice-ref args(list(:: 2 #f #f)) ) last(args))
    (print "success")(error "failed")
  )
)
(provide eg +)


;(define (handle-args . args)
;  (for/fold ([stack-acc empty])
;            ([arg (filter-not void? args)])
;    (cond
;      [(number? arg) (cons arg stack-acc)]
;      [(or (equal? * arg) (equal? + arg))
;       (define op-result
;         (arg (first stack-acc) (second stack-acc)))
;       (cons op-result (drop stack-acc 2))])))
;(provide handle-args)
;
;(provide + *)