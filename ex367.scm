
;; i <= j の条件を抜きにして、すべての整数について (i . j) のストリームを生じさせる
;; (list (car s) (car t)) が対を作る
;; smap はひとつ違いと list するから (n . (+ n 1)) の対を作る
;; interleave しなくてもいいんじゃないか ?
;; うーん、
;; ヒント： もう一つのストリームを混ぜる必要がある
;; カンニングした
;; http://www.serendip.ws/archives/1675
;; この図は分かりやすい ...
;; (S0 . T0) を左上、対角線上に (Sn . Tn) を並べた表より、それぞれの区画を生成する S 式を割り当てるのか。
;; pp.201 の表で抜けている部分を生成するということか。
;; あれ、これだと (S2 T1) は生成しないんじゃなかろうか。
;;
(define (pairs2 s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (interleave
     (stream-map (lambda (x) (list (stream-car s) x))
                 (stream-cdr t))
     (stream-map (lambda (x) (list (stream-car t) x))
                 (stream-cdr s)))
    (pairs2 (stream-cdr s) (stream-cdr t)))))

