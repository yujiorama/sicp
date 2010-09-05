(load "./chapter3.scm")

(define (stream-rand s . m)
  (cond ((null? m) s)
        ((eq? 'generate (car m))
         (cons-stream random-init
                      (stream-cdr s)))
        ((eq? 'reset (car m))
         (cons-stream (stream-ref s 0)
                      (stream-cdr s)))
        (else
         s)))

