;; 内部定義を let に変換して、逐次定義による問題を回避する

(load "chapter4.scm")
(load "./ex406.scm")

;; a. lookup-variable-value を変更して *unassigned* を見つけたらエラーにする
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? '*unassigned* (car vals))
                 (error "unassigned variable" var)
                 (car vals)))
            (else
             (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-enviromnent)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env))


;; b. 内部定義のある手続きを let に変換する scan-out-defines を書く
;;; 内部定義は上から書いてあると仮定しておく
(define (scan-out-defines exp)
  (define (extract-inner-define-names exp)
    )
  (let ((inner-defines
         (extract-inner-defines
          (cond ((definition? exp)
                 (if (symbol? (cadr exp))
                     (caddr exp)
                     (cddr exp)))
                ((lambda? exp)
                 (lambda-body exp)))))
        (
        ))
