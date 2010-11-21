;; 超循環評価器の上で map を定義して実行

gosh> (driver-loop)


;;; M-Eval input:
(define (map proc lst) (cond ((null? lst) '()) ((null? (cdr lst)) (proc (car lst))) (else (cons (proc (car lst)) (map proc (cdr lst))))))

;;; M-Eval value:
ok

;;; M-Eval input:
(map (lambda (x) (+ 1 x)) (list 1 2 3))

;;; M-Eval value:
(2 3 . 4)

;;; M-Eval input:

;; 基本手続きで実行
gosh> (driver-loop)


;;; M-Eval input:
(map (lambda (x) (+ 1 x)) (list 1 2 3))
*** ERROR: invalid application: ((procedure (x) ((+ 1 x)) (((false true car cdr cons null? list + - * / display newline map) #f #t (primitive #<subr car>) (primitive #<subr cdr>) (primitive #<subr cons>) (primitive #<subr null?>) (primitive #<subr list>) (primitive #<subr +>) (primitive #<subr ->) (primitive #<subr *>) (primitive #<subr />) (primitive #<subr display>) (primitive #<subr newline>) (primitive #<subr map>)))) 1)
Stack Trace:
_______________________________________
  0  (eval input the-global-environment)
        At line 358 of "/home/yuji/work/sicp/chapter4.scm"

map が primitive になっていると、map の引数として lambda とリストを評価してしまうから。

