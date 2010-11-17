;; cond 節の (<test> => <recipient>) の構文が使えるように cond 節を直す
;; expand-clause を修正します。

(define (expand-clause clauses)
  (if (null? clause)
      #f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF" clauses))
            (let* ((predicate (cond-predicate first))
                   (actions (cond-actions first))
                   (first-action (car actions)))
              (if (eq? '=> first-action)
                  (if (eval predicate env)
                      (eval (cons actions predicate) env))
                  (make-if predicate
                     (sequence->exp actions)
                     (expand-clause rest))))))))
