; do for while until のような反復構造の設計と使用例

(for <vars> <loop-condition> <inc> <proc>)

vars は反復の最初に 1 度だけ初期化される変数と式の対からなるリスト。
loop-condition は反復ごとに評価される引数を取らない手続き。真または偽を返す。
inc は反復ごとに評価される引数を取らない手続き。
proc は反復ごとに評価される引数を取らない手続き。

<loop-condition> が偽になったら反復を止める。式の値はない。

(while <loop-condition> <proc>)
loop-condition は引数を取らない真または偽を返す手続き。
proc は反復ごとに評価される引数を取らない手続き。

<loop-condition> が偽になったら反復を止める。式の値はない。

(until <loop-condition> <proc>)
(while (not (<loop-condition>) <proc>)) と同じ。

(define (for vars loop-condition inc proc)
  (let vars
      (define (iter)
        (cond ((loop-condition) (eval proc env) (inc) (iter))
              (else #f)))
    (iter)))

(define (while loop-condition proc)
  (define (iter)
    (cond ((loop-condition) (eval proc env) (iter)))
    (else #f)))
