(load "./chapter3.scm")

(define (RC r c dt)
  (define (v i v0)
    (add-stream (scale-stream i r)
                (integral (scale-stream i (/ 1 c)) v0 dt)))
  v)

