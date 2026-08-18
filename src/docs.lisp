;;;; src/docs.lisp -- find-dapla-deploy/docs

(defpackage :find-dapla-deploy/docs
  (:use :cl)
  (:import-from :40ants-doc :defsection))

(in-package :find-dapla-deploy/docs)

(defsection @find-dapla-deploy (:title "find-dapla-deploy")
  "Roswell/Consfigurator deploy for find.dapla.net."
  (@deploy-properties section))

(defsection @deploy-properties (:title "Consfigurator Properties")
  (find-dapla-deploy/deploy:deploy-app function))
