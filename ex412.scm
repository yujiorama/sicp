;; set define lookup から共通パターンを括り出して手続きを再定義する

;; 元のやつを再定義する

(define (env-loop var val when-null when-eq env)
  (define (scan vars vals)
    (cond ((null? vars)
           (when-null (enclosing-environment env)))
          ((eq? var (car vars))
           (when-eq vals val)
           (else
            (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-enviromnent)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) (frame-values frame))))))

(define (lookup-variable-value var env)
  (env-loop var #f
            env-loop
            (lambda (vals val) (car vals))
            env))

(define (set-variable-value! var val env)
  (env-loop var val
            env-loop
            (lambda (vals val) (set-car! vals val))
            env))

(define (define-variable! var val env)
  (env-loop var val
            (lambda (frame) (add-binding-to-frame! var val frame))
            (lambda (vals val) (set-car! vals val))
            env))
