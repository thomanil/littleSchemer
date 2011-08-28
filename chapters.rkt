;;; Chapter 1

;predefine atom? as instructed in book preface
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

'atom ;atom
'(atom) ;(atom)
'(atom turkey) ;(atom turkey)
'() ;<null list, not an atom>
(car '(a b c)) ;a
(car '((a) b c)) ;(a)
;(car 'atom) ;Won't work, need list for car
;(car '()) ;Wont't work, need non-empty list
(car (car '((hotdogs)))) ;hotdogs
(cdr '(a b c)) ; (b c)
(cdr '(b c)) ; (c)
(cdr '(hamburger)) ;()
;(cdr 'hotdog) ;Won't work, need a list
;(cdr '()) ;Wont't work, need non-empty list
(car (cdr '((b)(x y)((c))))) ;(x y)
(cdr (cdr '((b)(x y)((c))))) ;(((c)))
;(cdr (car '(a (b (c)) d) )) ;Won't work, first car gives atom, unable to cdr that
;car and cdr both take any non-empty list as arg
(cons 'peanut '(butter and jelly)) ; (peanut butter and jelly)
(cons '(banana and) '(peanut butter and jelly)) ; ((banana and) peanut butter and jelly)
(cons '((help) this) '(is very ((hard)to learn))) ;(((help) this) is very ((hard) to learn))
;cons take two args, first is any s-exp, second is any list
(cons '(a b) '()) ;((a b))
(cons 'a '()) ;(a)
(cons '(a b) 'b) ;((a b) . b) 
(cons 'a (car '((b) c d))) ; (a b)
(cons 'a (cdr '((b) c d))) ; (a c d)
(null? '()) ;#t
(null? '(a c d)) ;#f
(null? 'a) ;#f
;primitive null? only true for empty lists
(atom? 'a) ;#t
(atom? '()) ;#f
;atom? takes one arg, any s-expr
(atom? (car '(a b c))) ;#t
(atom? (cdr '(a b c))) ;#f
(atom? (cdr '(c))) ;#f
(atom? (car (cdr '(swing low cherry oat)))) ;#t
(atom? (car (cdr '(swing (low sweet) cherry oat)))) ;#f
(eq? 'harry 'harry) ;#t
(eq? 'harry 'frank) ;#f
(eq? '(harry) '()) ;#f
(eq? '(harry) '(harry)) ;#f (same content but different lists)
(define dummy 
  '(a b c))
(eq? dummy dummy) ;#t (same list)
(eq? 12 12) ;#t
(eq? 10 12) ;#f
(eq? 'a (car '(a b c))) ;#t
(eq? 'a (cdr '(a b c))) ;#f
(define l
  '(beans beans we need jelly beans))
(eq? (car l) (car (cdr l))) ;#t


;;; Chapter 2

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


;;; Chapter 3

;(Wrong version first)
(define rember
  (lambda (a lat)
  (cond
    ((null? lat)(quote ()))
    (else (cond
             ((eq? (car lat) a)(cdr lat))
             (else (rember a
                           (cdr lat))))))))

(rember 'bacon '(bacon lettuce tomato)) ; (lettuce tomato)
(rember 'bacon '(bacon lettuce bacon bread)) ; (lettuce bacon bread)
(rember 'and '(bacon lettuce and tomato)) ; (bacon)

; (Use cons to fix it)
(define rember
  (lambda (a lat)
  (cond
    ((null? lat)(quote ()))
    (else (cond
             ((eq? (car lat) a)(cdr lat))
             (else (cons (car lat)
                         (rember a (cdr lat)))))))))

(rember 'and '(bacon lettuce and tomato)) ; (bacon lettuce tomato)

; (Simplified version, since cond can have more than one sexpr before else)
(define rember
  (lambda (a lat)
  (cond
    ((null? lat)(quote ()))
    ((eq? (car lat) a)(cdr lat))
    (else (cons (car lat)
                (rember a (cdr lat)))))))

(rember 'and '(bacon lettuce and tomato)) ; (bacon lettuce tomato)
(rember 'sauce '(soy sauce and tomate sauce)) ;(soy and tomate sauce)

(define firsts
  (lambda (l)
    (cond 
      ((null? l)(quote ()))
      (else (cons (car (car l)) 
                  (firsts (cdr l)))))))
                  
(firsts '((a b)(c d)(e f))) ;(a c e)


(define insertR
  (lambda (new old lat)
    (cond 
     ((null? lat)(quote ()))
     (else 
      (cond 
        ((eq? old (car lat)) (cons old (cons new (cdr lat))))
        (else (cons (car lat) (insertR new old (cdr lat)))))))))
         
         
      
(insertR 'jalapeno 'and '(tacos tamales and salsa)) ;(tacos tamales and jalapeno salsa)
(insertR 'e 'd '(a b c d f g d h)) ;(a b c d e f g d h)
(insertR 'topping 'fudge '(ice cream with fudge for dessert)) ;(ice cream with fudge topping for dessert)


