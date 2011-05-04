;;
;; applicative order での unless 実装の議論
;;
;; Ben:
;;     unless は作用的順序では特殊形式で実装できる
;;
;; Alyssa:
;;     誰かがそうすると、unless は高水準手続きと一緒に使える手続きではなく、
;;     単なる構文だと反論する。
;;
;; 
;; Ben の主張は評価器で if と同じように扱えってことでしかない。
;; Alyssa の主張は、構文 (=特殊形式) になると、高階関数として使えなくなることを指してる。
;;

;; unless を導出された式として実装
;; 評価器で対応するってことでいいのかな

(define (unless? exp)
  (tagged-list? exp 'unless))

(define (unless->if exp)
  (make-if (not (if-predicate exp)) (if-alternative exp) (if-consequent exp)))

;; unless が手続きとして使えると有用である状況の例を述べる

