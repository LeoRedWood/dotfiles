;;; hello -- Echo "Hello, world!"
;;; Commentary;
;;; Code;

(defun hello-world ()
  (interactive)
  (message "Hello, world!"))

(provide 'hello) ; so that (require 'hello) is possible
;;; hello.el ends here
