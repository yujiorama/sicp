
(define (ln2-summand n)
  (cons-stream
   (/ 1.0 n)
   (stream-map - (ln2-summand (+ n 1)))))

;;; 150 回くらいで 0.6901076949618198 くらいに収束
(define ln2-stream
  (partial-sums (ln2-summand 1)))

;;; 80 回くらいで 0.6931470062295334 くらいに収束、前のやつと違う!
(define (ln2-stream-2)
  (euler-transform (ln2-stream)))

(define (ln2-stream-3)
  (stream-limit ln2-stream 0.01))
;; なんかエラーになるけど数字は伺い知れる
;; gosh> (display-stream (ln2-stream-3))
;; *** ERROR: pair required, but got 0.6980731694092049
;; Stack Trace:
;; _______________________________________
;;   0  (stream-car s)
;;         At line 26 of "./stream.scm"
;;   1  proc
