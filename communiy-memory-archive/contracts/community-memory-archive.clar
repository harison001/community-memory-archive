;; Community Memory Archive Smart Contract
;; A decentralized platform for storing and sharing community memories and stories

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))
(define-constant err-invalid-input (err u104))
(define-constant err-memory-limit (err u105))

;; Data Variables
(define-data-var contract-paused bool false)
(define-data-var memory-counter uint u0)
(define-data-var total-memories uint u0)
(define-data-var max-memories-per-user uint u50)

;; Data Maps
(define-map memories
  { memory-id: uint }
  {
    title: (string-ascii 100),
    content: (string-ascii 500),
    author: principal,
    timestamp: uint,
    category: (string-ascii 50),
    tags: (list 5 (string-ascii 20)),
    likes: uint,
    verified: bool,
    public: bool
  }
)

(define-map user-memories
  { user: principal }
  { 
    memory-count: uint,
    memory-ids: (list 50 uint),
    reputation: uint,
    joined-at: uint
  }
)

(define-map memory-likes
  { memory-id: uint, user: principal }
  { liked: bool, timestamp: uint }
)

(define-map memory-comments
  { memory-id: uint, comment-id: uint }
  {
    author: principal,
    content: (string-ascii 200),
    timestamp: uint
  }
)

(define-map memory-comment-counter
  { memory-id: uint }
  { count: uint }
)

(define-map curators
  { curator: principal }
  { 
    active: bool,
    appointed-at: uint,
    verified-count: uint
  }
)

;; Private Functions
(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

(define-private (is-curator (user principal))
  (default-to false 
    (get active (map-get? curators { curator: user }))
  )
)

(define-private (get-next-memory-id)
  (let ((current-id (var-get memory-counter)))
    (var-set memory-counter (+ current-id u1))
    current-id
  )
)

(define-private (validate-memory-input (title (string-ascii 100)) (content (string-ascii 500)))
  (and 
    (> (len title) u0)
    (> (len content) u0)
    (<= (len title) u100)
    (<= (len content) u500)
  )
)

(define-private (update-user-memory-count (user principal) (memory-id uint))
  (let (
    (current-data (default-to 
      { memory-count: u0, memory-ids: (list), reputation: u0, joined-at