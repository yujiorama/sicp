(load "./chapter3.scm")

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
