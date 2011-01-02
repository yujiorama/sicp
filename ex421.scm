;; letrec も define も無しに 10 の階乗を計算する
((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1)))))))
 10)

;; gosh> 3628800


;; a. 式を評価して、これが実際に過剰を計算することを調べる。
;;    Fibonacci 数を計算する類似の式を考える。

;; 最初の lambda は 1 つの引数を取る。(引数には 10 が渡される)
;; 最初の lambda は次のように評価される。
;;   2 番目の lambda は 1 つの引数を取る。 (引数には 3 番目の lambda が渡される)
;;   2 番目の lambda は次のように評価される。
;;     fact を、fact と n を引数として評価する。
;;   3 番目の lambda は 2 つの引数を取る。 (引数は渡されない)
;      ft は自分自身なので、再帰するために ft を、ft と (- k 1) を引数として評価する。


;; b. 相互に再帰的な内部定義を持つ次の定義を考える。欠けた式を補い、内部定義も letrec も使わない f の別の定義を完成せよ。

;; (define (f x)
;;   (define (even? n)
;;     (if (= n 0)
;;         #t
;;         (odd? (- n 1))))
;;   (define (odd? n)
;;     (if (= n 0)
;;         #f
;;         (even? (- n 1))))
;;   (even? x))

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) #t (od? <??> <??> <??>)))
   (lambda (ev? od? n)
     (if (= n 0) #f (ev? <??> <??> <??>)))))
