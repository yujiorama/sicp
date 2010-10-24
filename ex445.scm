(load "./chapter4.scm")

;; (cond ((<test> => <recipient>))) をサポートする

(define (cond-recipient-clause? exp)
  (eq? (cadr exp) '=>))

(define (expand-clause clauses)
  (if (null? clause)
      #f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF" clauses))
            (if (cond-recipient-clause? first)
                (make-if (cond-predicate first)
                         ((cond-actions first) (eval (cond-predicate first) env))
                         (expand-clause rest))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clause rest)))))))
