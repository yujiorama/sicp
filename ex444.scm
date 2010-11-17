;;; eval-and と eval-or を作る

(define (and? exp)
  (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (iter result rest)
    (if (false? result)
        #f
        (if (null? rest)
            #f
            (iter (eval (car rest) env) (cdr rest)))))
  (if (null? (cdr exp))
      #t
      (iter (eval (cadr exp) env) (cddr exp))))

(define (or? exp)
  (tagged-list? exp 'or))

(define (eval-or exp env)
  (define (iter result rest)
    (if result
        result
        (if (null? rest)
            #f
            (iter (eval (car rest) env) (cdr rest)))))
  (if (null? (cdr exp))
      #f
      (iter (eval (cadr exp) env) (cddr exp))))
