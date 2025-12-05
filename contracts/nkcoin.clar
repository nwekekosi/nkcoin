;; nkcoin - A SIP-010 Fungible Token
;; 
;; This contract implements a fungible token following the SIP-010 standard.
;; Features include:
;; - Token transfers
;; - Balance queries
;; - Total supply tracking
;; - Token name, symbol, and decimals
;; - URI for token metadata

;; -------------------------
;; Constants
;; -------------------------

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; -------------------------
;; Variables
;; -------------------------

(define-fungible-token nkcoin)

(define-data-var token-uri (optional (string-utf8 256)) none)

;; -------------------------
;; SIP-010 Functions
;; -------------------------

;; Transfer tokens from one account to another
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    (begin
        (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (asserts! (> amount u0) err-invalid-amount)
        (try! (ft-transfer? nkcoin amount sender recipient))
        (match memo to-print (print to-print) 0x)
        (ok true)
    )
)

;; Get token name
(define-read-only (get-name)
    (ok "NK Coin")
)

;; Get token symbol
(define-read-only (get-symbol)
    (ok "NK")
)

;; Get number of decimals
(define-read-only (get-decimals)
    (ok u6)
)

;; Get balance of an account
(define-read-only (get-balance (account principal))
    (ok (ft-get-balance nkcoin account))
)

;; Get total supply of tokens
(define-read-only (get-total-supply)
    (ok (ft-get-supply nkcoin))
)

;; Get token URI
(define-read-only (get-token-uri)
    (ok (var-get token-uri))
)

;; -------------------------
;; Additional Functions
;; -------------------------

;; Mint new tokens (owner only)
(define-public (mint (amount uint) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (asserts! (> amount u0) err-invalid-amount)
        (ft-mint? nkcoin amount recipient)
    )
)

;; Burn tokens
(define-public (burn (amount uint) (owner principal))
    (begin
        (asserts! (is-eq tx-sender owner) err-not-token-owner)
        (asserts! (> amount u0) err-invalid-amount)
        (ft-burn? nkcoin amount owner)
    )
)

;; Set token URI (owner only)
(define-public (set-token-uri (uri (string-utf8 256)))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (ok (var-set token-uri (some uri)))
    )
)

;; -------------------------
;; Initialization
;; -------------------------

;; Mint initial supply to contract owner
(begin
    (try! (ft-mint? nkcoin u1000000000000 contract-owner))
)
