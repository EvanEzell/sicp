; Exercise 2.71
; Author: Evan Ezell

; Tree for n=5
;       T31
;      /   \
;     T15  L16
;     /  \
;    T7  L8
;   /  \
;  T3  L4
;  / \
; L1 L2

; Tree for n=10
;                     T1023
;                     /   \
;                   T511  L512
;                  /   \
;                T255  L256
;               /   \
;             T127   L128
;            /   \
;           T63  L64
;          /   \
;        T31   L32
;        /  \
;      T15  L16
;      /  \
;     T7  L8
;    /  \
;   T3  L4
;  / \
; L1 L2

; It takes one bit to encode the most frequent symbol.
; It takes n-1 bits to encode the least frequent symbol.
