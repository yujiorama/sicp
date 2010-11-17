;;
;; a. ルイスは eval の cond 節の順序を変えて、手続き作用の節が代入の前にくるようにした。
;;
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
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
        (else
         (error "Unkown expression type -- EVAL" exp))))

;;; (define x 3) を評価するとどうなるか
;;; (appliction? exp) が #t となり、手続きが評価されてしまう。
;;; タグ付きリストとして定義される exp の評価の中で、唯一タグなし、pair? を評価するのが application? だからだ。

;;; b. 手続き作用が call で始まるようにして彼を助ける。
(define (application? exp)
  (tagged-list? exp 'call))
