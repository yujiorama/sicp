(define (pairs3 s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs3 (stream-cdr s) (stream-cdr t))))

この定義が評価されると起こることを考える。

s と t には integers (1 2 3 ...)が与えられる。
smap でストリームが生成される。
(1 1)
(1 2)
(1 3)
(1 4)
...
pairs で (2 3 4 ...) なストリームが渡される
smap でストリームが生成される
(2 2)
(2 3)
(2 4)
...
interleave されるたびに pairs が呼ばれるからそのたびに n+1 の smap が発生していく。
まさに 1 行づつ sn t1..n を生成してるように見えるんだけど。
実行してみよう。

駄目だ。無限ループった。

理由は ... 元の pairs の定義だと pairs の評価は cons-stream の cdr になっ
ていたため遅延評価されるけど、上記の定義だと遅延評価にならないから無限
ループになる、ということで終わり。
