(load "./chapter3.scm")

(define (random-in-range a b)
  (lambda (x)
    (let ((xx (remainder x b)))
      (if (< xx a) (+ a xx) xx))))

(define (estimate-integral p x1 x2 y1 y2)
  (define x-stream
    (stream-map (random-in-range x1 x2) random-numbers))
  (define y-stream
    (stream-map (random-in-range y1 y2) random-numbers))
  (define area
    (* (- x2 x1) (- y2 y1)))
  (stream-map
   (lambda (x) (* area x))
   (monte-carlo
    (stream-map
     (lambda (x) (p (car x) (cadr x)))
     (pairs x-stream y-stream)) 0 0))
  )

;;
;; 中心が (5,5) で半径が 5 を想定
;; 
(define (estimate-pi index)
  (define radius 5)
  (define x-center 5)
  (define y-center 5)
  (define (P x y)
    (<= (+ (square (- x x-center)) (square (- y y-center))) (square radius)))
  (define estimate
    (estimate-integral
     P
     (- x-center radius) (+ x-center radius)
     (- y-center radius) (+ y-center radius)
     )
    )
  (for-each
   (lambda (x)
     (display (/ (stream-ref estimate x) (square radius)))
     (newline)
     )
   index))
