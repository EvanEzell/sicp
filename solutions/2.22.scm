; Exercise 2.22
; Author: Evan Ezell

; The first one produces the results in reverse order
; because it cons a single item from "things" onto
; "answer". "things" can only be traversed forward thus
; "answer" is produced in the reverse order of "things".

; Switching the arguments to cons will not work because
; the first cons will cons a nil and a value. There will
; be no nil terminating the last pair in the list.
