;; 基盤の lisp が cons を右から評価するか左から評価するかを問わず演算子を左から評価する list-of-values
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((lhs (eval (first-operand exps) env)))
        (cons lhs 
              (list-of-values (rest-operands exps) env)))))

;;右から左へ評価する list-of-values
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((rhs (list-of-values (rest-operand exps) env)))
        (cons (eval (first-operand exps) env)
              rhs))))
