(asdf:defsystem #:cl-coreutils
  :description "GNU Coreutils in Common Lisp"
  :version "1.0"
  :author "MinmusxMinmus <git.1khdc@simplelogin.com>"
  :license "GPL-3"
  :components ((:module "src"
                :components ((:file "cl-coreutils")))))
