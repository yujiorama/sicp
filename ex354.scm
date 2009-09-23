(load "./chapter3.scm")

(define (mul-streams s1 s2)
  (define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream
         (apply proc (map stream-car argstreams))
         (apply stream-map
                (cons proc (map stream-cdr argstreams))))))
  (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams integers factorials)))