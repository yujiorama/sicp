;; 問題 3.78
;; 同次二階線形微分方程式とか

(load "./chapter3.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-stream (scale-stream integrand dt)
                               int))))
  int)

(define (solve-2nd a b dt y0 dy0)
  (define y
    (integral (delay dy) y0 dt))
  (define dy
    (integral (delay ddy) dy0 dt))
  (define ddy
    (add-stream (scale-stream dy a)
              (scale-stream y b)))
  y)

;; 例はうまいものが見つからない。
;; ググると、単振動の式が一番簡単そうだけど、いいかんじの練習問題見あたらななかった
