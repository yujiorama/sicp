(load "./chapter4.scm")

;;
;; a. Louis の計画では何が悪かったか。 (define x 3 に対して、Louis の評価器は何をするか.)
;;

;; (define (eval exp env)
;;   (cond ((self-evaluating? exp) exp)
;;         ((variable? exp) (lookup-variable-value exp env))
;;         ((quoted? exp) (text-of-quotation exp))
;;         ((assignment? exp) (eval-assignment exp env))
;;         ((definition? exp) (eval-definition exp env))
;;         ((if? exp) (eval-if exp env))
;;         ((lambda? exp)
;;          (make-procedure (lambda-parameters exp)
;;                          (lambda-body exp)
;;                          env))
;;         ((begin? exp)
;;          (eval-sequence (begin-actions exp) env))
;;         ((cond? exp) (eval (cond->if exp) env))
;;         ((application? exp)
;;          (apply (eval (operator exp) env)
;;                 (list-of-values (operands exp) env)))
;;         (else
;;          (error "Unkown expression type -- EVAL" exp))))

application? が definition? の前に置かれたとする。
この場合、次のような評価がされる。
(apply (eval 'define env)
       (list-of-values '(x 3) env))
'define は基本構文ではないので、評価結果はエラーになってしまう。
application? の実装が、pair? ではなく、cond 節に現れないものを対象とするようになれば問題ないと思う。


;;
;; b. 評価される言語の構文を変更し、手続き作用が call で始まるようにして彼を助けよ。
;;
(define (application? exp)
  (tagged-list? exp 'call))
