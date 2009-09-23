(load "./chpater3.scm")

;; (define (partial-sums s)
;;   (cond ((stream-null? #?=s) null)
;;         ((stream-null? (stream-cdr s)) (stream-car s))
;;         (else
;;          (add-stream (stream-car s)
;;                      (partial-sums (stream-cdr s))))))
(define (partial-sums s)
  (cons-stream
   (stream-car s)
   (add-stream (stream-cdr s) (partial-sums s))))
