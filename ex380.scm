;; RLC circuit

(load "./chapter3.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-stream (scale-stream integrand dt)
                               int))))
  int)

(define (RLC r l c dt)
  (define (fn vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dvc (scale-stream il (/ 1 c)))
    (define dil (add-stream (scale-stream vc (/ 1 l))
                            (scale-stream il (/ (- r) l))))
    (define (iter a b)
      (cons-stream (cons (stream-car a) (stream-car b))
                   (iter (stream-cdr a) (stream-cdr b))))
    (iter vc il))
  fn)
