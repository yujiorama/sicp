(load "./prime.scm")
(load "./stream.scm")

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred s)
  (cond ((stream-null? s) the-empty-stream)
        ((pred (stream-car s))
         (cons-stream (stream-car s)
                      (stream-filter pred
                                     (stream-cdr s))))
        (else (stream-filter pred (stream-cdr s)))))

(define (memo-proc proc)
  (let ((already-run? #f) (result #f))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (ste! already-run? #t)
                 result)
          result))))


(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))


(define (sieve s)
  (cons-stream
   (stream-car s)
   (sieve (stream-filter
           (lambda (x) (not (divisivle? x (stream-car s))))
           (stream-cdr s)))))
(define prime (sieve (integers-starting-from 2)))

(define (add-stream s1 s2)
  (define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))
  (stream-map + s1 s2))


(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor)) s))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s1) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(define (sqrt-improve guess x)
  (define (average a b)
    (/ (+ a b) 2))
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                              (sqrt-improve guess x))
                            guesses)))
  guesses)

;; (load "./ex355.scm")
(define (partial-sums s)
  (cons-stream
   (stream-car s)
   (add-stream (stream-cdr s) (partial-sums s))))
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))
