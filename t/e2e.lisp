;;;; t/e2e.lisp -- find-dapla-deploy/e2e

(defpackage :find-dapla-deploy/e2e
  (:use :cl :fiveam)
  (:import-from :find-dapla-deploy/deploy :*haproxy-fqdn*)
  (:export :run-e2e))

(in-package :find-dapla-deploy/e2e)

(def-suite :find-dapla-deploy-e2e
  :description "Smoke tests for find.dapla.net.")

(in-suite :find-dapla-deploy-e2e)

(test http-redirect
  "Plain HTTP requests redirect to HTTPS."
  (multiple-value-bind (body status)
      (dex:get (format nil "http://~A/" *haproxy-fqdn*)
               :force-string t :want-stream nil :redirect nil)
    (declare (ignore body))
    (is (member status '(301 302)))))

(test frontend-responds
  "The service frontend returns HTTP 200."
  (multiple-value-bind (body status)
      (dex:get (format nil "https://~A" *haproxy-fqdn*)
               :force-string t :want-stream nil)
    (declare (ignore body))
    (is (= 200 status))))

(defun run-e2e ()
  "Run the post-deploy e2e suite and signal an error if any test fails."
  (let ((results (run :find-dapla-deploy-e2e)))
    (unless (every #'fiveam::test-passed-p results)
      (error "find-dapla-deploy e2e suite: one or more tests failed."))))
