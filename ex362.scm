(load "./chapter3.scm")
(load "./ex360.scm")
(load "./ex361.scm")

(define (div-series s1 s2)
  (if (= 0 (stream-car s2))
      (raise "constant term is 0")
      (mul-series s1
                  (invert-unit-series s2))))

(define tangent-series
  (div-series sine-series cosine-series))