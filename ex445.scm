;; cond 節の (<test> => <recipient>) の構文が使えるように cond 節を直す
;; expand-clause を修正します。

(define (expand-clause clauses)
  (if (null? clauses)
      #f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF" clauses))
            (let ((predicate (cond-predicate first))
                   (actions (cond-actions first)))
              (if (eq? '=> (car actions))
                  (if (eval predicate env)
                      (eval (cons (cdr actions) predicate) env))
                  (make-if predicate
                     (sequence->exp actions)
                     (expand-clause rest))))))))
