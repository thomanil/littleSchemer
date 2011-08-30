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


(define insertL
  (lambda (new old lat)
    (cond 
     ((null? lat)(quote ()))
     (else 
      (cond 
        ((eq? old (car lat)) (cons new (cons old (cdr lat))))
        (else (cons (car lat) (insertL new old (cdr lat)))))))))

(insertL 'd 'e '(a b c e)) ;(a b c d e)

(define subst
  (lambda (new old lat)
    (cond 
      ((null? lat)(quote ()))
      (else 
       (cond
         ((eq? old (car lat))(cons new (cdr lat)))
         (else (cons (car lat)(subst new old (cdr lat)))))))))
         
(subst 'x 'b '(a b c)) ; (a x c)

(define subst2
  (lambda (new o1 o2 lat)
    (cond 
      ((null? lat)(quote ()))
      (else 
       (cond
         ((or (eq? o1 (car lat))(eq? o2 (car lat)))(cons new (cdr lat)))
         (else (cons (car lat)(subst2 new old (cdr lat)))))))))

(subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping)) ;#(vanilla ice cream with chocolate topping)
      
(define multirember
  (lambda (a lat)
    (cond 
      ((null? lat)(quote ()))
      (else 
       (cond
         ((eq? a (car lat))(multirember a (cdr lat)))
         (else (cons (car lat)(multirember a (cdr lat)))))))))
    
(multirember 'cup '(coffee cup tea cup and hick cup)) ;(coffee tea and hick)

(define multiinsertR
  (lambda (new old lat)
    (cond 
      ((null? lat)(quote ()))
      (else 
       (cond
         ((eq? old (car lat))(cons old (cons new (multiinsertR new old (cdr lat)))))
         (else (cons (car lat)(multiinsertR new old (cdr lat)))))))))
    
(multiinsertR 'x 'a '(a a a)) ;(a x a x a x)

(define multisubst
  (lambda (new old lat)
    (cond 
      ((null? lat)(quote ()))
      (else 
       (cond
         ((eq? old (car lat))(cons new (multisubst new old (cdr lat))))
         (else (cons (car lat)(multisubst new old (cdr lat)))))))))

(multisubst 'x 'a '(a a a)) ;(x x x)


;;; Chapter 4

(atom? 14) ;#t

(define add1
  (lambda (n)
    (+ n 1)))

(add1 67) ;68

(define sub1
  (lambda (n)
    (- n 1)))

(sub1 67) ;66

(zero? 0) ;#t
(zero? 3) ;#f

(define add
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1 (add n (sub1 m)))))))

(add 46 12) ;58

(define subtract
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (subtract (sub1 n)(sub1 m))))))

(subtract 14 3) ;11
(subtract 17 9) ;8

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (add (car tup)(addtup (cdr tup)))))))

(addtup '(1 2 3)) ;6
(addtup '(15 6 7 12 3)) ;43

(define multiply
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (add n (multiply n (sub1 m)))))))

(multiply 5 2) ;10
(multiply 13 4) ;52

(define tup+
  (lambda (tup1 tup2)
    (cond
     ((and (null? tup1)(null? tup2))(quote()))
     (else
      (cons (add (car tup1)(car tup2))(tup+ (cdr tup1)(cdr tup2)))))))

(tup+ '(3 6 9 11 4) '(8 5 2 0 7)) ;(11 11 11 11 11)

(define tup+
  (lambda (tup1 tup2)
    (cond
     ((null? tup1)tup2)
     ((null? tup2)tup1)
     (else
      (cons (add (car tup1)(car tup2))(tup+ (cdr tup1)(cdr tup2)))))))

(tup+ '(3 7) '(4 6 8 1)) ; (7 13 8 1)

(define greater
  (lambda (n m)
    (cond
     ((zero? n) #f)
     ((zero? m) #t)
     (else
      (greater (sub1 n) (sub1 m))))))

(greater 12 133) ;#f
(greater 120 11) ;#t
(greater 3 3) ;#f

(define lesser
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
     (else
      (lesser (sub1 n) (sub1 m))))))

(lesser 4 6) ;#t
(lesser 8 3) ;#f
(lesser 6 6) ;#f

(define equal
  (lambda (n m)
    (cond 
      ((greater n m) #f)
      ((lesser n m) #f)
      (else #t))))
      
(equal 0 0) ;#t
(equal 0 1) ;#f

(define exponential
  (lambda (n m)
    (cond 
      ((zero? m) 1)
      (else (multiply n (exponential n (sub1 m)))))))
      
(exponential 1 1) ;1
(exponential 2 3) ;8
(exponential 5 3) ;125

(define divide
  (lambda (n m)
    (cond 
      ((lesser n m) 0)
      (else (add1 (divide (subtract n m) m))))))


(divide 6 2) ;3
(divide 10 5) ;2
(divide 11 5) ;2

(define len
  (lambda (lat)
    (cond 
      ((null? lat) 0)
      (else (add1 (len (cdr lat)))))))

(length '(coffee sugar tea)) ;3
(length '(hotdogs with mustard sauerkraut and pickles)) ;6

(define pick
  (lambda (n lat)
    (cond 
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(pick 2 '(coffee sugar tea)) ;sugar
(pick 4 '(hotdogs with mustard sauerkraut and pickles)) ;sauerkraut

(define rempick
  (lambda (n lat)
    (cond 
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(rempick 2 '(coffee sugar tea)) ;coffee tea
(rempick 4 '(hotdogs with mustard sauerkraut and pickles)) ;hotdogs with mustard and pickles

(number? 'a) ;#f
(number? 3) ;#t

(define no-nums
  (lambda (lat)
    (cond 
      ((null? lat) '())
      ((number? (car lat))(no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))

(no-nums '(one two 3 four 5 six)) ;(one two four six)

(define all-nums
  (lambda (lat)
    (cond 
      ((null? lat) '())
      ((number? (car lat))(cons (car lat)(all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

(all-nums '(one two 3 four 5 six)) ;(3 5)

(define equan?
  (lambda (a b)
    (cond
      ((and (number? a)(number? b))(= a b))
      ((or (number? a)(number? b)) #f)
      (else (eq? a b)))))

(equan? 3 3) ;#t
(equan? 3 5) ;#f
(equan? 'a 'a) ;#t
(equan? 'a 'b) ;#f

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((equan? a (car lat))(add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

(occur 'a '(a x a x a)) ;3
(occur 3 '(a 3 a 3 a 2)) ;2

(define one?
  (lambda (a)
      (equan? a 1)))

(one? 1) ;#t
(one? 0) ;#f
(one? 'one) ;#f

(define rempick
  (lambda (n lat)
    (cond
      ((one? n)(cdr lat))
      (else (cons (car lat)(rempick (sub1 n) (cdr lat)))))))

(rempick 3 '(lemon meringue salty pie)) ;(lemon meringue pie)

;;; Chapter 5









