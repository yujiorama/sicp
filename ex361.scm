(load "./chapter3.scm")
(load "./ex360.scm")
(define (invert-unit-series s)
  (cons-stream
   1
   (mul-series
    (scale-stream (stream-cdr s) -1)
    (invert-unit-series s))))