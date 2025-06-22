;; Cost Tracking Contract
;; Tracks maintenance costs and budgets

(define-constant err-unauthorized (err u500))
(define-constant err-insufficient-budget (err u501))
(define-constant err-invalid-amount (err u502))

;; Data variables
(define-data-var total-budget uint u0)
(define-data-var total-spent uint u0)
(define-data-var next-expense-id uint u1)

;; Data maps
(define-map expenses uint {
  description: (string-ascii 200),
  amount: uint,
  category: (string-ascii 50),
  work-order-id: (optional uint),
  recorded-by: principal,
  recorded-at: uint
})

(define-map department-budgets (string-ascii 30) uint)
(define-map department-spent (string-ascii 30) uint)

;; Public functions
(define-public (set-total-budget (amount uint))
  (begin
    (var-set total-budget amount)
    (ok true)))

(define-public (set-department-budget (department (string-ascii 30)) (amount uint))
  (begin
    (map-set department-budgets department amount)
    (ok true)))

(define-public (record-expense
  (description (string-ascii 200))
  (amount uint)
  (category (string-ascii 50))
  (work-order-id (optional uint)))
  (let ((expense-id (var-get next-expense-id))
        (current-spent (var-get total-spent)))
    (begin
      (asserts! (> amount u0) err-invalid-amount)
      (asserts! (<= (+ current-spent amount) (var-get total-budget)) err-insufficient-budget)
      (map-set expenses expense-id {
        description: description,
        amount: amount,
        category: category,
        work-order-id: work-order-id,
        recorded-by: tx-sender,
        recorded-at: block-height
      })
      (var-set total-spent (+ current-spent amount))
      (var-set next-expense-id (+ expense-id u1))
      (ok expense-id))))

;; Read-only functions
(define-read-only (get-expense (expense-id uint))
  (map-get? expenses expense-id))

(define-read-only (get-total-budget)
  (var-get total-budget))

(define-read-only (get-total-spent)
  (var-get total-spent))

(define-read-only (get-remaining-budget)
  (- (var-get total-budget) (var-get total-spent)))

(define-read-only (get-department-budget (department (string-ascii 30)))
  (default-to u0 (map-get? department-budgets department)))
