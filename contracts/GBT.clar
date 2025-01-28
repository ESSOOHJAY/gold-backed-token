;; contracts/gold-backed-token.clar

(define-constant ERR_NOT_OWNER u100)
(define-constant ERR_INSUFFICIENT_BALANCE u101)
(define-constant ERR_INVALID_AMOUNT u102)
(define-constant ERR_INVALID_RECIPIENT u103)

;; State variables
(define-data-var total-supply uint u0)
(define-map balances principal uint)

;; Contract owner
(define-constant owner tx-sender)



