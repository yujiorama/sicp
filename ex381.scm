(load "./chapter3.scm")

(define random-stream
  (let ((seed (sys-time))
        (x 0))
    (define (inner . m)
      (cond ((or (null? m) (= (car m) 'reset))
             (set! seed (cadr m)))
            ((= (car m) 'generate)
             (set! seed (sys-time))))
      (set! x (cons-stream seed
                           (stream-map rand-update x))))
    inner))
