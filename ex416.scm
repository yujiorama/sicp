;; 内部定義を let に変換して、逐次定義による問題を回避する

(load "./chapter4.scm")

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

;; 内部定義の名前と手続きの対からなるリストを返す
(define (inner-defines exp)
  (cond ((null? exp) '())
        ((not (pair? exp)) '())
        ((definition? (car exp))
         (cons
          (cons (definition-variable (car exp))
                (define-body (car exp)))
          (inner-defines (cdr exp))))
        (else '())))

(define (define-body exp)
  (cddr exp))

;; 内部定義を除いた手続きを返す
(define (only-body exp)
  (cond ((null? exp) '())
        ((definition? (car exp))
         (only-body (cdr exp)))
        (else exp)))

;; 内部手続きを let で名前に束縛する
(define (scan-out-defines exp)
  (let ((body (define-body exp)))
    (let ((defines (inner-defines body)))
      (if (null? defines)
          exp
          (cons 'let
            (cons
             (map (lambda (x)
                    (cons (car x) '*unassigned*))
                  defines)
             (cons
              (map (lambda (x)
                     (cons 'set! (cons (car x) (cdr x))))
                   defines)
              (only-body body))))))))