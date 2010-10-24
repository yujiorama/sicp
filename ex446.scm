(load "./chapter4.scm")


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
        ((let? exp) (let->combination exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unkown expression type -- EVAL" exp))))

(define (let? exp)
  (tagged-list? exp 'let))

(define (let->combination exp env)
  (apply
   (cons
    (make-procedure
          (let-parameters (cadr exp))
          (cddr exp)
          env)
    (let-arguments (cadr exp) env))))

;;
(define (let-parameters seq)
  (if (last-exp? seq)
      (first-exp seq)
      (cons (car (first-exp seq))
            (let-parameters (rest-exps seq)))))

(define (let-arguments seq env)
  (if (last-exp? seq)
      (eval (first-exp seq) env)
      (cons (eval (first-exp seq) env)
            (let-arguments (rest-exps seq) env))))