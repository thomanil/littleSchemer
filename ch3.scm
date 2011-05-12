;predefine atom? as instructed in book preface
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

