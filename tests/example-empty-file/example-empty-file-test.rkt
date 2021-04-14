#lang racket/base

(require "example-empty-file.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  (define suite
    (test-suite
     "leap tests"

     (test-eqv? "vanilla-leap-year" (leap-year? 1996) #t)
     (test-eqv? "any-old-year" (leap-year? 2015)#f)))

  (run-tests suite))
