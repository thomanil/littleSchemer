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