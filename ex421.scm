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


;; 最初の lambda は 1 つの引数を取る。(引数には 10 が渡される)
;; 最初の lambda は次のように評価される。
;;   2 番目の lambda は 1 つの引数を取る。 (引数には 3 番目の lambda が渡される)
;;   2 番目の lambda は次のように評価される。
;;     fact を、fact と n を引数として評価する。
;;   3 番目の lambda は 2 つの引数を取る。 (引数は渡されない)
;      ft は自分自身なので、再帰するために ft を、ft と (- k 1) を引数として評価する。