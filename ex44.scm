(load "./chapter4.scm")

;; and: 式を左から右へ評価する。ある式が偽に評価されたら偽を返す; 残りの式は評価しない。すべての式が真に評価されたら、最後の式の値を返す。式が一つもなければ真を返す。
;; or: 式を左から右へ評価する。ある式が真の値に評価されたらその値を返す; 残りの式は評価しない。すべての式が偽に評価されるか、式が一つもなければ偽を返す。


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



(define (and? exp)
  (tagged-list? exp 'and))

(define (eval-and exp env)
  (cond ((null? exp) #t)
        ((last-exp? exp) (eval (first-exp exp) env))
        (else (if (eval (first-exp exp) env)
                  (eval-and (rest-exps exp) env)
                  #f))))

(define (or? exp)
  (tagged-list? exp 'or))

(define (eval-or exp env)
  (cond ((null? exp) #f)
        ((last-exp? exp) (eval (first-exp exp) env))
        (else (if (eval (first-exp exp) env)
                  #t
                  (eval-or (rest-exps exp) env)))))
