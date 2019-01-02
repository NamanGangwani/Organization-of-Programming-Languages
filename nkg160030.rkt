#lang racket

(provide (all-defined-out))

; Checks to see if a given x is divisble by 7
(define divisible-by-7?
  (λ (x)
    ; Sees if the division of it by seven results in an integer or not
    ; If it does, it's divisible by seven; if not, it is not divisible by 7
    (integer? (/ x 7))))

; Applies the number 3 to a given function and returns its value
(define function-3
  (λ (funct)
    (funct 3)))

; Takes in a function and a list and applies the function to every element of the list
(define my-map
  (λ (funct lst)
    (if (null? lst) ; If it has reached null, return an empty list
        '()
        ; Recursively goes through all elements and performs funct on them individually
        (cons (funct (car lst)) (my-map funct (cdr lst))))))

; Takes two lists as arguments and returns a single lists of pairs
(define zipper
  (λ (lst1 lst2)
    (if (or (null? lst1) (null? lst2)) ; If either one of them is null, return an empty list
        '()
        ; Pairs an element of lst1 with the corresponding element of lst2 and adds it to the single list recursively
        (cons (cons (car lst1) (cons (car lst2) '())) (zipper (cdr lst1) (cdr lst2))))))

; Takes a list of integers and returns two sublists of even and odd integers
(define segregate
  (λ (lstnums)
    ; Helper function that creates a sublist of even numbers
    (define segregate-even
      (λ (lst)
        (if (null? lst)
            '()
            (if (integer? (/ (car lst) 2)) ; If an element is divisible by two
                (cons (car lst) (segregate-even (cdr lst))) ; Add it to the sublist recursively
                (segregate-even (cdr lst)))))) ; Move on if it is odd
    ; Helper function that creates a sublist of odd numbers
    (define segregate-odd
      (λ (lst)
        (if (null? lst)
            '()
            (if (integer? (/ (car lst) 2)) ; If an element is divisible by two
                (segregate-odd (cdr lst)) ; Move on if it is even
                (cons (car lst) (segregate-odd (cdr lst))))))) ; Otherwise, it to the sublist recursively
    (cons (segregate-even lstnums) (list (segregate-odd lstnums))))) ; Combines both sublists into one list

; Determines if a given element is a member of a given list
(define is-member?
  (λ (const lst)
    (if (null? lst) ; If the list is empty or null, it doesn't contain the element
        #f
        (if (equal? const (car lst)) ; If the current element is equal to the given one
            #t ; It is a member of the list
            (is-member? const (cdr lst)))))) ; Continue searching through the list

; Determines if a given list is sorted or not
(define my-sorted?
  (λ (lst)
    (if (null? lst) ; If it is an empty list, it is sorted by default
        #t
        (if (null? (cdr lst)) ; If it has reached the end of the list successfully, it is sorted
            #t
            ; If it contains uncomparable types within the list, error
            (if (or (and (integer? (car lst)) (not (integer? (car (cdr lst))))) (and (string? (car lst)) (not (string? (car (cdr lst))))))
                (error "ERROR: List contains heterogenous data types")
                ; If the next element is less than or equal to the current element, it is not sorted
                (if (or (and (integer? (car lst)) (<= (car (cdr lst)) (car lst))) (and (string? (car lst)) (string<=? (car (cdr lst)) (car lst))))
                    #f
                    (my-sorted? (cdr lst)))))))) ; Continue checking the list

; Flattens all nested lists in a given list to be all part of a single list
(define my-flatten
  (λ (lst)           
    (if (null? lst)
        '()
        (if (list? (car lst)) ; If there is a nested list to go through
            (append (my-flatten (car lst)) (my-flatten (cdr lst))) ; Add its elements to the flattened list
            (cons (car lst) (my-flatten (cdr lst))))))) ; Otherwise, just add the element and continue searching

; Removes any numbers in a list greater than the given threshold
(define upper-threshold
  (λ (lst threshold)
    (if (null? lst)
        '()
        (if (< (car lst) threshold) ; If an element is within the threshold
            (cons (car lst) (upper-threshold (cdr lst) threshold)) ; Include in the list
            (upper-threshold (cdr lst) threshold))))) ; Otherwise, don't include it and move on

; Returns the element of a list at a given index; errors if index is out of bounds
(define my-list-ref
  (λ (lst index)
    (if (< index 0) ; If it is less than 0, it is out of bounds
        (error "ERROR: Index out of bounds")
        (printf ""))
    ; Helper function to recursively iterate through the list and find the elemnent at the given index
    (define my-list-ref-helper
      (λ (lst index cur)
            (if (null? lst) ; If it has reached the end of the list without finding it, it is out of bounds
                (error "ERROR: Index out of bounds")
                (if (= index cur) ; If it found an element at the given index
                    (car lst) ; Return the element
                    (my-list-ref-helper (cdr lst) index (add1 cur)))))) ; Otherwise, continue searching
    (my-list-ref-helper lst index 0))) ; Search through the list starting at index position 0

; Reverses a list and the order of its elements (including its nested sublists)
(define deep-reverse
  (λ (x)
    (if (null? x) ; If it has reached the end of the list, return an empty list
        x
        (if (not (list? x)) ; If the passed variable is not a list, just return it back
            x
            (if (null? (cdr x)) ; If the rest of the list does not exist
                (list (deep-reverse (car x))) ; Reverse it
                ; Otherwise, go through its nested sublist and reverse it and its order of elements
                (append (deep-reverse (cdr x)) (list (deep-reverse (car x)))))))))
