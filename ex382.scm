

(define (estimate-integral p x1 x2 y1 y2)
  (define (random-in-range a b)
    (lambda (x)
      (let ((xx (remainder x b)))
        (if (< a xx) (+ a xx) xx))))
  (stream-map
   (lambda (x) (* p (* (- x2 x1) (- y2 y1))))
   (monte-carlo
    (stream-map (random-in-range x1 x2) cesaro-stream)
    (stream-map (random-in-range y1 y2) cesaro-stream)
    0 0)
   )
  )

