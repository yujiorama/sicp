
(define integer-pairs
  (pairs integers integers))


(1 . n) が登場するのはどういうときか。
具体例で調べる。
(1 . 1) 1
(1 . 2) 2
(1 . 3) 4
(1 . 4) 6
(1 . 5) 8
(1 . 6) 10

これより、次のような条件が得られる。
f(1) = 1
f(n) = 2(n - 1) ... (n > 1)

これより、(1 . 100) が現れる順番 f(100) は次のとおり。
f(100) = 2(100 - 1) = 198


(n-1 . n) が登場するのはどういうときか。
具体例で調べる。
(0 . 1) -
(1 . 2) 2
(2 . 3) 5
(3 . 4) 10
(4 . 5) 22
(5 . 6) 46
(6 . 7) 94

これより、次のような条件が得られる。
f(1) = 解なし
f(2) = 2
f(3) = 5
f(4) = 10
f(n) = f(n-1) * 2 + 2 ... (n > 4)

これより、(99 . 100) が現れる順番 f(100) は次のとおり。
f(100) = f(99) * 2 + 2
       = (f(98) * 2 + 2) * 2 + 2
       = ((f(97) * 2 + 2) * 2 + 2) * 2 + 2
       ...
計算する。
(define (calc-n n)
  (cond ((= n 1) 0)
        ((= n 2) 2)
        ((= n 3) 5)
        ((= n 4) 10)
        (else
         (+ 2 (* 2 (calc-n (- n 1)))))))

gosh> (calc-n 100)
950737950171172051122527404030
本当かどうかは分かりませんが、こういうことでした。


(n . n) が登場するのはどういうときか。
具体例で調べる。
(1 . 1) 1
(2 . 2) 3
(3 . 3) 7
(4 . 4) 14
(5 . 5) 30
(6 . 6) 62

(define (seq from step to)
  (if (< from to)
      (cons from (seq (+ from step) step to))
      to))

これより、次のような条件が得られる。
f(1) = 1
f(2) = 3 = f(1) * 2 + 1
f(3) = 7 = f(2) * 2 + 1
f(4) = 14 = f(3) * 2
f(n) = f(n - 1) * 2 + 2  ... (n > 4)

これより、(100 . 100) が現れる順番 f(100) は次のとおり。
f(100) = f(99) * 2 + 2
       = (f(98) * 2 + 2) * 2 + 2
       ...
計算する。
(define (calc-n2 n)
  (cond ((= n 1) 1)
        ((= n 2) 3)
        ((= n 3) 7)
        ((= n 4) 14)
        (else
         (+ 2 (* 2 (calc-n2 (- n 1)))))))

また素敵な結果が得られた。
gosh> (calc-n2 100)
1267650600228229401496703205374
