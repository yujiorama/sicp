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


;;
;; 右から左へ評価
;;
