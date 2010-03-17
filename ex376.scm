(load "./chapter3.scm")

(define sense-data (list 1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define (sign-change-detector cur next)
  (cond ((and (> 0 cur) (<= 0 next)) -1)
        ((and (<= 0 cur) (> 0 next)) 1)
        (else 0)))

(define (smooth s)
  s)
(define (smooth s)
  (let ((x (stream-car s))
        (y (stream-ref s 1)))
    (cons-stream
     (/ (+ x y) 2)
     (smooth (stream-cdr s)))))

(define (make-zero-crossings input-stream last-value)
  (cons-stream (sign-change-detector (stream-car input-stream) last-value)
               (make-zero-crossings (stream-cdr input-stream)
                                    (stream-car input-stream))))

;; 部品化というので関数適用してみる
(define zero-crossings (make-zero-crossings (smooth sense-data) 0))
