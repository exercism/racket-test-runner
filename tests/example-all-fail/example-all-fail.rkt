#lang racket

(provide leap-year?)

(define (leap-year? year)
  (and (= (modulo year 2) 1)))
