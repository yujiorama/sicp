(load "./chapter3.scm")

(define (merge-weighted s1 s2 weight-fn)
  (cond ((stream-null? s1) s2)
        ((stream-null? s1) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (if (weight-fn s1car s2car)
               (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight-fn))
               (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight-fn)))
           ))))


(define (weighted-pairs s t w)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) w)
    w)))

;; a. 和 i + j に従って順序づけられた、i <= j なる正の整数の対 (i,j) のすべてのストリーム
;;
;; 上のようなストリームを生成する pairs-a 関数があるとして
;; weight 計算するときは、(stream-car pairs-a) と (stream-cdr pairs-a) の大小を比較して、
;; car か cddr へ進むようなことをするのか
;;
(define (weight-a x y)
  (< (+ (car x) (cadr x))
     (+ (car y) (cadr y))))

(define sum-order-pairs (weighted-pairs integers integers weight-a))

;; b. 和 2i + 3j + 5ij に従って順序づけられた、i <= j で、i も j も 2, 3, 5 で割り切れない正の整数の対 (i,j) のすべてのストリーム
;; filter すればいいですね
;;
(define (weight-b x y)
  (< (+ (* 2 (car x)) (* 3 (cadr x)) (* 5 (car x) (cadr x)))
     (+ (* 2 (car y)) (* 3 (cadr y)) (* 5 (car y) (cadr y)))))

(define 235order-pairs
  (stream-filter
   (lambda (x)
     (let ((i (car x))
           (j (cadr x)))
       (and (<= i j)
            (not
             (or
              (= 0 (modulo i 2)) (= 0 (modulo i 3)) (= 0 (modulo i 5))
              (= 0 (modulo j 2)) (= 0 (modulo j 3)) (= 0 (modulo j 5)))))))
   (weighted-pairs integers integers weight-b)))


;; 確認用。次の計算結果を表示します
;; (i,j) 2i + 3j + 5ij
;; (map
;;  (lambda (i)
;;    (let ((x (stream-ref 235order-pairs i)))
;;      (print x
;;             " "
;;             (+ (* 2 (car x)) (* 3 (cadr x)) (* 5 (car x) (cadr x))))))
;;  (seq 1 1 50))