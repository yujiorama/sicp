(laad "./chapter4.scm")

;;
;; 純正 (scheme に依存した評価順)
;;
;; (define (list-of-values exps env)
;;   (if (no-operands? exps)
;;       '()
;;       (cons (eval (first-operand exps) env)
;;             (list-of-values (rest-operands exps) env))))

;;
;; 左から右へ評価
;;
(define (list-of-values exps env)
  (define first-operand car)
  (define rest-operands cdr)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

;;
;; 右から左へ評価
;;
(define (list-of-values exps env)
  (define first-operand car)
  (define rest-operands cdr)
  (let ((rexps (reverse exps)))
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand rexps) env)
              (list-of-values (rest-operands rexps) env)))))

