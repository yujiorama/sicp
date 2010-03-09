(load "./chapter3.scm")
(load "./ex371.scm")

(define (power n)
  (* n n))

(define (power-sum pair)
  (+ (power (car pair)) (power (cadr pair))))

(define (weight-power-number x y)
  (< (power-sum x) (power-sum y)))

(define power-order-pairs (weighted-pairs integers integers weight-power-number))

(define (pattern1 s)
  (cons-stream
   (power-sum (stream-car s))
   (pattern1 (stream-cdr s))))

(define (pattern2 s)
  (stream-map
   (lambda (x) (power-sum x))
   s))

(define (pattern3 s t)
  (add-stream + s t))


;; (map (lambda (n) (let ((x (stream-ref (pattern1 power-order-pairs) n))) (print x))) (seq 0 1 10))
