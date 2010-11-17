;;; eval-and と eval-or を作る

(define (and? exp)
  (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (iter exp)
    (let ((result (eval (car exp) env)))
      (if result
          (if (null? (cdr exp))
              result
              (iter (cdr exp)))
          #f)))
  (iter (cdr exp)))
