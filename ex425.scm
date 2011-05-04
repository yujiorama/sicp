;; applicative order の Scheme で unless を定義した場合、
;; それを使った factorial を評価しようとするとどうなるか。

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= #?=n 1)
          (* n (factorial (- n 1)))
          1))

;;
;; unless の引数として factorial が評価されてしまう
;; factorial の評価は再帰的なので、これは無限再帰する
;;
;; 正規順序だとどうなる ?
;; factorial の評価は遅延するので、無限再帰はしない
;; 