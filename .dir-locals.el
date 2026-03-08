;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((lisp-mode . ((eval . (progn
                         (let ((keywords (list (rx symbol-start
                                                   (zero-or-one "asdf:")
                                                   "defsystem"
                                                   symbol-end))))
                           (font-lock-add-keywords nil (mapcar #'(lambda (kw)
                                                                   (unless (assoc kw font-lock-keywords)
                                                                     (cons kw 'font-lock-keyword-face)))
                                                               keywords)))
                         (put 'defpackage 'lisp-indent-function 1)
                         (put 'asdf:defsystem 'lisp-indent-function 1))))))
