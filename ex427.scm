;;; ;;; L-Eval input:
;;; (define count 0)
;;; 
;;; ;;; L-Eval value:
;;; ok
;;; 
;;; ;;; L-Eval input:
;;; (define (id x) (set! count (+ count 1)) x)
;;; 
;;; ;;; L-Eval value:
;;; ok
;;; 
;;; ;;; L-Eval input:
;;; (define w (id (id 10)))
;;; 
;;; ;;; L-Eval value:
;;; ok
;;; 
;;; ;;; L-Eval input:
;;; count
;;; 
;;; ;;; L-Eval value:
;;; 1
;;; define w の時点で (id 10) が評価されてしまっている
;;; 
;;; ;;; L-Eval input:
;;; w
;;; 
;;; ;;; L-Eval value:
;;; 10
;;; 
;;; ;;; L-Eval input:
;;; count
;;; 
;;; ;;; L-Eval value:
;;; 2
;;; w を評価したとき、(id 10) はメモ化された値が使われ、 (id (id 10)) の外側で count が変更されている。
;;; 
;;; ;;; L-Eval input:

