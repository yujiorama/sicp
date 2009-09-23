;; http://www.csus4.net/hiki/SICPReading/?TadashiHirata
;; (define-syntax stream-cons
;;   (syntax-rules ()
;;     ((_ hd tl) (cons hd (delay tl)))))
(define-syntax cons-stream
  (syntax-rules ()
    ((_ hd tl) (cons hd (delay tl)))))
(define (stream-car dl)
  (car dl))
(define (stream-cdr dl)
  (force (cdr dl)))
(define the-empty-stream '())
(define stream-null? null?)
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
                   (stream-for-each proc (stream-cdr s)))))
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))

