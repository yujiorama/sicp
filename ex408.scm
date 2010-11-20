;; 名前付き let は let でシンボルに手続きを束縛できるもの
;; let->combination を修正する

(define (let->combination exp)
  (make-lambda (map (lambda (x) (car x)) (cadr exp))
               (cddr exp)))

(define (let->combination exp)
  (if (list? (cadr exp))                ; 普通の let
      (make-lambda (map (lambda (x) (car x)) (cadr exp))
                   (cddr exp))
      (let ((name (cadr exp))
            (procbody (caddr exp))
            (letbody (cdddr exp)))
        (let ((newproc (cons 'define (cons name procbody))))
          (let->combination (cons '() letbody))))))

