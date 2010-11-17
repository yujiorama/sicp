(load "./chapter4.scm")

;; 基盤の lisp が cons を右から評価するか左から評価するかを問わず演算子を左から評価する list-of-values
(define (list-of-values-l exps env)
  (if (no-operands? exps)
      '()
      (let ((lhs (eval (first-operand exps) env)))
        (cons lhs 
              (list-of-values-l (rest-operands exps) env)))))

;;右から左へ評価する list-of-values
(define (list-of-values-r exps env)
  (if (no-operands? exps)
      '()
      (let ((rhs (list-of-values-r (rest-operands exps) env)))
        (cons (eval (first-operand exps) env)
              rhs))))

