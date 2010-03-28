(load "./chapter3.scm")
(load "./ex378.scm")

;; (define (solve-2nd a b dt y0 dy0)
;;   (define y
;;     (integral (delay dy) y0 dt))
;;   (define dy
;;     (integral (delay ddy) dy0 dt))
;;   (define ddy
;;     (add-stream (scale-stream dy a)
;;               (scale-stream y b)))
;;   y)

;; 右辺を関数として一般化する
;; \frac{d^2y}{dt-2} = a\frac{dy}{dt} + by
;; dy 自体は ddy の不定積分として定義される
;; y 自体は dy の不定積分として定義される
;; ddy を (define (ddy dy y dt) ...) として定義するか
;; 戦略が定まらないなー
