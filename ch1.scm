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
(cdr (car '(a (b (c)) d) )) ;Won't work, first car gives atom, unable to cdr that

