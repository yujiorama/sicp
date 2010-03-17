(load "./chapter3.scm")
(load "./ex350.scm")

(define sense-data (list 1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define (sign-change-detector cur next)
  (cond ((and (> 0 cur) (<= 0 next)) -1)
        ((and (<= 0 cur) (> 0 next)) 1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

;; エヴァ・ル・エイターが言うことも分かる。1 つずらせばいいんではないか
;; (define zero-crossings
;;   (stream-map sign-change-detector sense-data <expression>))

(define zero-crossings
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))

