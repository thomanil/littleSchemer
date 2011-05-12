;predefine atom? as instructed in book preface
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l))(lat? (cdr l)))
      (else #f))))

(lat? '(Jack Sprat could eat no chicken fat)) ;#t
(lat? '((Jack) Sprat could eat no chicken fat)) ;#f
(lat? '(Jack (Sprat could) eat no chicken fat)) ;#f
(lat? '()) ;#t

(or (null? '()) (atom? '(a b c))) ;#t
(or (null? '(a b c)) (null? '())) ;#t
(or (null? '(a b c)) (null? 'atom)) ;#f

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (member? a (cdr lat)))))))

(member? 'a '(a b c)) ;#t
(member? 'x '(a b c)) ;#f

