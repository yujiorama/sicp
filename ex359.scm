(load "./chapter3.scm")

;;; a
(define (integrate-series a)
  (define (merge-series a s)
    (cons-stream (/ (stream-car a)
                    (stream-car s))
                 (merge-series (stream-cdr a)
                               (stream-cdr s))))
  (merge-series a (integers-starting-from 1)))

;;; b
(define exp-series
  (cons-stream 1
               (integrate-series exp-series)))


(define cosine-series
  (cons-stream 1
               (integrate-series
                (stream-map (lambda (x) (- 0 x)) sine-series))))

(define sine-series
  (cons-stream 0
               (integrate-series
                cosine-series)))
