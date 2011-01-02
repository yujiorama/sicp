;; letrec

;; (define (f x)
;;   (letrec ((even?
;;             (lambda (n)
;;               (if (= n 0)
;;                   #t
;;                   (odd? (- n 1)))))
;;            (odd?
;;             (lambda (n)
;;               (if (= n 0)
;;                   #f
;;                   (even? (- n 1)))))))
;;   <f の本体の残り>)

;; (letrec ((<var1> <exp1>) ... (<varn> <expn>))
;;   <body>)

;; (letrec ((fact
;;           (lambda (n)
;;             (if (= n 1)
;;                 1
;;                 (* n (fact (- n 1)))))))
;;   (fact 10))

;; a. letrec を let 式に変換する実装

(define (letrec->let exp)
  (let ((vars (map car (cadr exp)))
        (exps (map cdr (cadr exp)))
        (body (cddr exp)))
    (if (null? vars)
        body
        (append
         (list 'let
               (map (lambda (name) (list name '*unassigned*)) vars))
         (append
          (map (lambda (name body) (list 'set! name body)) vars exps)
          body)))))

;; b. Louis の理解(手続きの内部で define が使いたくなければ let を使うことができる) は足りない。
;;    f について、 (f 5) の評価の途中で <fの本体の残り> が評価される環境を示す環境ダイアグラムを描いて示せ。
;;    同じ評価で f の定義の letrec が let になった場合の環境ダイアグラムを描け。
