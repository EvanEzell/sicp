; Exercise 2.76
; Author: Evan Ezell

; generic operations with explicit dispatch
; New types: Each operation must be updated to contain the new dispatch 
; predicate for that type. Also, new constructors and selectors 
; must be written.
; New operations: New operations can be defined, but must include support
; for all types using each of their individual constructors and selectors.

; data-directed-style
; New types: New constructors and selectors must be written. 
; New operations: New operation can be defined directly using abstract
; constructors and selectors.

; message-passing-style
; New types: A new data object must be created which handles all
; procedures.
; New operations: Support for operation must be added to each data object 
; individually.

; If new types must be added often, it would likely be best to choose a
; data-directed-style system or a message-passing-style system. 

; If new operations must be added often, it would likely be best to choose
; a data-directed-style system or a generic operations with explicit
; dispatch style system.
; would likely be best to 
