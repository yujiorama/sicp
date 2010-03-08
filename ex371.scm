(load "./chapter3.scm")
(load "./ex370.scm")

;;; 立方数
(define (cubic n)
  (* n n n))

(define (cubic-sum pair)
  (+ (cubic (car pair)) (cubic (cadr pair))))

;;; 立方数の和で重み関数
(define (weight-cubic-number x y)
  (< (cubic-sum x)
     (cubic-sum y)))

;;; 立方数の重み関数でペア
(define cubic-order-pairs (weighted-pairs integers integers weight-cubic-number))

;;; 確認 60 番目と 61 番目が最初のラマヌジャン数 1729
;; (map (lambda (n) (let ((x (stream-ref cubic-order-pairs n))) (print  x " " (+ (cubic (car x)) (cubic (cadr x)))))) (seq 60 1 70))

;; なるべく愚直に書いてみた
(define (ramanujan-stream c)
  (if (= (cubic-sum (stream-car c)) (cubic-sum (stream-car (stream-cdr c))))
      (cons-stream
       (list (stream-car c) (stream-car (stream-cdr c)))
       (ramanujan-stream (stream-cdr (stream-cdr c))))
      (ramanujan-stream (stream-cdr c))))

;;; 確認 0 番目から 10 番目までを出してみる
;; (map (lambda (n) (let ((x (stream-ref (ramanujan-stream cubic-order-pairs) n))) (print x " " (cubic-sum (car x))))) (seq 0 1 10))