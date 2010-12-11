;; 内部定義を let に変換して、逐次定義による問題を回避する

(load "./chapter4.scm")
(load "./ex406.scm")
(load "./ex407.scm")

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
;; yad-EL さんのカンニングした。だいたい同じだったけどちょっと進歩
;; http://sicp.g.hatena.ne.jp/yad-EL/20080507/1210174173
;;
(define (scan lst body defs)
  (cond ((null? lst)
         (cons (reverse body) (reverse defs)))
        ((null? (cdr lst))
         (scan '() (cons (car lst) body) defs))
        ((definition? (car lst))
         (scan (cdr lst)
               body
               (cons (cons (definition-variable (car lst))
                           (definition-value (car lst)))
                     defs)))
        (else
         (scan (cdr lst)
               (cons (car lst) body)
               defs))))

(define (scan-out-defines exp)
  (let ((lst (scan exp '() '())))
    (let ((body (car lst))
          (def-names (map car (cdr lst)))
          (def-bodies (map cdr (cdr lst))))
      (if (null? def-names)
          body
          (append
           (list 'let
                 (map (lambda (name) (list name '*unassigned*)) def-names))
           (append
            (map (lambda (name body) (list 'set! name body)) def-names def-bodies)
            body))))))

;; c. scan-out-defines を make-procedure かまたは procedure-body かに組み込む
;; make-procedure は lambda 式にだけ適用されるみたい。
;; define は値としての lambda 式を持つようになるから、define された式の内部 define だけが対象になる
;; procedure-body は eval-sequence の全てに適用される。
;; なので、効率という意味では make-procedure に組み込むのがよい。

;; (define (make-procedure parameters body env)
;;   (list 'procedure parameters body env))
;; (define (make-procedure parameters body env)
;;  (list 'procedure parameters (scan-out-defines body) env))

;; (define (procedure-body p) (caddr p))
;;(define (procedure-body p)
;;  (scan-out-defines p))
