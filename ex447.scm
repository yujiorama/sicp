;; let* がどうやって let にできるのかを説明

(let* ((a 1) (b a) (c b))
  (print a))

;; これはこうなるから。つまりは入れ子になる。

(let ((a 1))
  (let ((b a))
    (let ((c b))
      (print a))))


;; let*->nested-lets を書く
(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (define (make-let vars body)
    (cons 'let
          (cons
           (car vars)
           (if (null? (cdr vars))
               body
               (make-let (cdr vars) body)))))
  (let ((vars (cadr exp))
        (body (cddr exp)))
    (make-let vars body)))