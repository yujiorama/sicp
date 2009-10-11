
(load "./chapter3.scm")
(define (triples s t u)
  (cons-stream
   (list (stream-car s) (stream-car t) (stream-car u))
   (interleave
    (stream-map (lambda (x) (append (list (stream-car s)) x))
                (pairs t u))
    (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define triples-integers (triples integers integers integers))

(define pythagoras-stream
  (stream-filter
   (lambda (x)
     (let ((i (car x))
           (j (cadr x))
           (k (caddr x)))
       (and (<= i j) (= (* k k) (+ (* i i) (* j j))))))
   triples-integers))

