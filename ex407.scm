;; let* がどうやって let にできるのかを説明

(let* ((a 1) (b a) (c b))
  (print a))

;; これはこうなるから。つまりは入れ子になる。

(let ((a 1))
  (let ((b a))
    (let ((c b))
      (print a))))


;; let*->nested-lets を書く
(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (define (make-let vars body)
    (cons 'let
          (cons
           (car vars)
           (if (null? (cdr vars))
               body
               (make-let (cdr vars) body)))))
  (let ((vars (cadr exp))
        (body (cddr exp)))
    (make-let vars body)))

;; eval を拡張する
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((let? exp) (eval (cons (let->combination exp) (let-values exp)) env))
        ((let*? exp) (eval (let*->nested-lets exp) env)
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