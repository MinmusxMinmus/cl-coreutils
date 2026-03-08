(defpackage #:cl-coreutils/util
  (:use #:cl)
  (:export #:*operating-system*
           #:defutil))
(in-package #:cl-coreutils/util)

(defparameter *operating-system* (uiop:operating-system))

(defmacro defutil (name args docstring &rest body)
  "Create a coreutils utility called NAME with ARGS and BODY, with
included :help pointing to DOCSTRING."
  (let* ((extra (append (unless (some #'(lambda (arg) (equal '&key arg)) args)
                          '(&key))
                        '(help)))
         (full-args (concatenate 'list args extra))
         (full-help (concatenate 'string docstring "

If HELP is non nil, display this help and exit.")))
    `(progn
       (defparameter %help ,full-help)
       (defun ,name ,full-args
         %help
         (cond
           (help (format t %help))
           (t ,@body))))))
