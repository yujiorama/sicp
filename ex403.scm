;; データ駆動になるよう eval を書き直す

(define install
  (begin
    (put self-evaluating? (lambda (exp env) exp)
    (put variable? lookup-variable-value)
    (put quoted? (lambda (exp env) (text-of-quotation exp)))
    (put assignment? eval-assignment)
    (put definition? eval-definition)
    (put if? eval-if)
    (put lambda? (lambda (exp env) (make-procedure (lambda-parameters exp) (lambda-body exp) env)))
    (put begin? (lambda (exp env) (eval-sequence (begin-actions exp) env)))
    (put cond? (lambda (exp env) (cond->if exp) env))
    (put appliction? (lambda (exp env) (my-apply (eval (operator exp) env)
                                              (list-of-values (operands exp) env))))
    )
(define (eval exp env)
  (let ((proc (get exp)))
    (if proc
        (proc exp env)
        (error "Unknown expression type -- EVAL" exp))))
