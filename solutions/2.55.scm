; Exercise 2.55
; Author: Evan Ezell

; (car ''abracadabra) -> quote

; We can think of ' being replaced
; by the longer form quote which yields
; (car (quote (quote abacadabra))). The quote
; expression yields a list where each of its
; items are symbols. So we can think of the
; full expression as the following:
; (car (list 'quote 'abacadabra))
; Applying car to the list yields -> quote
