
(define (stream-limit s tolerance)
  (if (< (abs (- (car (stream-cdr s)) (stream-car s))) tolerance)
      (car (stream-cdr s))
      (stream-limit (stream-cdr s) tolerance)))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))