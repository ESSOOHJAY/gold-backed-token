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

;; ------------------------
;; Utility Functions
;; ------------------------

(define-private (is-owner (caller principal))
  (is-eq caller owner))

(define-private (valid-amount (amount uint))
  (> amount u0))

(define-private (valid-recipient (recipient principal))
  (and 
    (is-ok (principal-destruct? recipient))
    (not (is-eq recipient (as-contract tx-sender)))))

;; ------------------------
;; Public Functions
;; ------------------------

(define-public (mint (recipient principal) (amount uint))
  (begin
    (asserts! (is-owner tx-sender) (err ERR_NOT_OWNER))
    (asserts! (valid-amount amount) (err ERR_INVALID_AMOUNT))
    (asserts! (valid-recipient recipient) (err ERR_INVALID_RECIPIENT))
    (let ((new-total-supply (+ (var-get total-supply) amount)))
      (asserts! (> new-total-supply (var-get total-supply)) (err ERR_INVALID_AMOUNT))
      (var-set total-supply new-total-supply)
      (match (map-get? balances recipient)
        balance-some (map-set balances recipient (+ balance-some amount))
        (map-set balances recipient amount))
      (ok amount))))

(define-public (transfer (recipient principal) (amount uint))
  (begin
    (asserts! (valid-amount amount) (err ERR_INVALID_AMOUNT))
    (asserts! (valid-recipient recipient) (err ERR_INVALID_RECIPIENT))
    (let ((current-balance (default-to u0 (map-get? balances tx-sender))))
      (asserts! (>= current-balance amount) (err ERR_INSUFFICIENT_BALANCE))
      (let ((new-sender-balance (- current-balance amount)))
        (map-set balances tx-sender new-sender-balance)
        (match (map-get? balances recipient)
          recipient-balance (map-set balances recipient (+ recipient-balance amount))
          (map-set balances recipient amount))
        (ok amount)))))

(define-public (redeem (amount uint))
  (begin
    (asserts! (valid-amount amount) (err ERR_INVALID_AMOUNT))
    (let ((current-balance (default-to u0 (map-get? balances tx-sender))))
      (asserts! (>= current-balance amount) (err ERR_INSUFFICIENT_BALANCE))
      (let ((new-balance (- current-balance amount))
            (new-total-supply (- (var-get total-supply) amount)))
        (asserts! (<= new-total-supply (var-get total-supply)) (err ERR_INVALID_AMOUNT))
        (map-set balances tx-sender new-balance)
        (var-set total-supply new-total-supply)
        (ok amount)))))

(define-read-only (get-balance (user principal))
  (default-to u0 (map-get? balances user)))

(define-read-only (get-total-supply)
  (var-get total-supply))

