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


(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unkown expression type -- EVAL" exp))))