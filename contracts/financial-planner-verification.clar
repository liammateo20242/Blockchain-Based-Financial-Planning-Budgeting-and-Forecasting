;; Financial Planner Verification Contract
;; Validates and manages financial planning professionals

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_CREDENTIALS (err u103))

;; Data structures
(define-map verified-planners
  { planner: principal }
  {
    verified: bool,
    certification-level: uint,
    verification-date: uint,
    expiry-date: uint
  }
)

(define-map planner-credentials
  { planner: principal }
  {
    license-number: (string-ascii 50),
    institution: (string-ascii 100),
    specialization: (string-ascii 50)
  }
)

;; Public functions
(define-public (verify-planner (planner principal) (cert-level uint) (license (string-ascii 50)) (institution (string-ascii 100)))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-none (map-get? verified-planners { planner: planner })) ERR_ALREADY_VERIFIED)
    (asserts! (> cert-level u0) ERR_INVALID_CREDENTIALS)

    (map-set verified-planners
      { planner: planner }
      {
        verified: true,
        certification-level: cert-level,
        verification-date: block-height,
        expiry-date: (+ block-height u52560) ;; ~1 year in blocks
      }
    )

    (map-set planner-credentials
      { planner: planner }
      {
        license-number: license,
        institution: institution,
        specialization: "General"
      }
    )

    (ok true)
  )
)

(define-public (revoke-verification (planner principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-some (map-get? verified-planners { planner: planner })) ERR_NOT_FOUND)

    (map-delete verified-planners { planner: planner })
    (map-delete planner-credentials { planner: planner })

    (ok true)
  )
)

;; Read-only functions
(define-read-only (is-verified-planner (planner principal))
  (match (map-get? verified-planners { planner: planner })
    verification (and
      (get verified verification)
      (< block-height (get expiry-date verification))
    )
    false
  )
)

(define-read-only (get-planner-info (planner principal))
  (map-get? verified-planners { planner: planner })
)

(define-read-only (get-planner-credentials (planner principal))
  (map-get? planner-credentials { planner: planner })
)
