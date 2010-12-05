(load "./chapter4.scm")
;; let は lambda で等価な式が書けるから、let は導出式
;; let を lambda にする let->combination を実装して、eval に組み込む

(define (let? exp)
  (tagged-list? exp 'let))

(define (let->combination exp)
  (make-lambda (map car (cadr exp))
               (cddr exp)))

(define (let-values exp)
  (map cadr (cadr exp)))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((let? exp) (eval (cons (let->combination exp) (let-values exp)) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unkown expression type -- EVAL" exp))))