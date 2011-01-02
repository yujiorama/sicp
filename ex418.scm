;; 元の式
(lambda <vars>
  (define u <e1>)
  (define v <e2>)
  <e3>)

;; 解釈系が内部で束縛を作り出した式
(lambda <vars>
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (let ((a <e1>)
          (b <e2>))
      (set! u a)
      (set! v b))
    <e3>))

;; 3.5.4 の solve
(define (solv f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)


;; solve は、内部で束縛を作り出すやつで動くか
e1 である y について、束縛 dy は内部の let された束縛 b に相当する。
また、e2 である dy について、束縛 y は内部 let の束縛 a に相当する。

e3 が評価されるのは内部の let の外になるので、うまく動かないかもしれない。

;; solve は、let の中で評価されるやつで動くか
e3 は、束縛 u と v が存在する let で評価されるので動くと思う。