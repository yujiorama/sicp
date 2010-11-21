;; チューリングの停止問題。本文の try は多分誤植

(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p)
      (run-forever)
      'halted))

;; (try try) は停止するか ?
停止しない。
halts?  が正しいと仮定する。
halts? が引数の try が停止すると判定したなら、run-forever が無限に再帰して停止しないので、
try は停止すると判定されるが無限に実行されることになる。
halts? が引数の try が停止しないと判定したなら、try は 'halted で停止するので、
try は停止しないと判定されるが停止することになる。
以上より、halts? が正しいという仮定は誤り。


