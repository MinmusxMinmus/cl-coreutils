(defpackage #:cl-coreutils/basename
  (:use #:cl #:cl-coreutils/util)
  (:export #:basename))
(in-package #:cl-coreutils/basename)

(defun path-separator ()
  (ecase *operating-system*
    (:linux #\/)
    (:windows #\\)))

(defun path-root ()
  (ecase *operating-system*
    (:linux "/")
    (:windows "C:")))

(defun not-empty (then else)
  (cond
    ((string/= then "") then)
    (t else)))

(defun remove-suffix (str suffix)
  (let* ((str-l (length str))
         (suffix-l (length suffix))
         (maybe-start (- str-l suffix-l)))
    (cond
      ((or (= 0 suffix-l) (= 0 str-l) (> suffix-l str-l)) str)
      ((string= str suffix :start1 maybe-start) (subseq str 0 maybe-start))
      (t str))))

(defutil basename (path suffix &key multiple zero)
  "Print PATH with any leading directory components and SUFFIX removed.

If MULTIPLE is non nil, PATH will be interpreted as a sequence of
paths instead.

If ZERO is non nil, end each output line with NUL."
  (let* ((paths (cond
                  (multiple path)
                  (t (cons path nil))))
         (paths-stripped (mapcar #'(lambda (p)
                                     (not-empty (string-right-trim (list (path-separator)) p)
                                                   (path-root)))
                                 paths))
         (base-names (mapcar #'(lambda (p)
                                 (or (pathname-name (pathname p)) p))
                             paths-stripped))
         (paths-no-suffix (when suffix
                            (mapcar #'(lambda (p)
                                        (not-empty (remove-suffix p suffix) p))
                                    base-names))))
    (format nil "~{~A~^ ~}~:[~;~C~]" (or paths-no-suffix base-names) zero (code-char 0))))
