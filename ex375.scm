(load "./chapter3.scm")
(load "./ex374.scm")

;; (define (make-zero-crossings input-stream last-value)
;;   (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
;;     (cons-stream (sign-change-detector avpt last-value)
;;                  (make-zero-crossings (stream-cdr input-stream)
;;                                       avpt))))

;; ずらしたストリームを引数に加えるということなんだろうか
;; (define (make-zero-crossings input-stream input-stream2 last-value)
;;   (let ((avpt (/ (+ (stream-car input-stream) (stream-car input-stream2)) 2)))
;;     (cons-stream (sign-change-detector avpt last-value)
;;                  (make-zero-crossings (stream-cdr input-stream)
;;                                       (stream-cdr input-stream2)
;;                                       avpt))))

;; 違ったらしい
;; http://d.hatena.ne.jp/tmurata/20100304/1267705937
(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream (sign-change-detector avpt last-avpt)
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream)
                                      avpt))))

(define zero-crossings (make-zero-crossings sense-data 0 0))
