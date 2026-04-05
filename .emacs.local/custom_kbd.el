(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-F") 'clone-indirect-buffer-other-window)

(global-set-key (kbd "M-a") 'backward-sentence)
(global-set-key (kbd "M-e") 'forward-sentence)
(global-set-key (kbd "M-b") 'list-buffers)

(global-set-key (kbd "M-s") 'save-buffer)


;; copy
(global-set-key (kbd "C-c C-c") 'kill-ring-save)
(global-set-key (kbd "M-w") 'switch-to-next-buffer)
(global-set-key (kbd "M-W") 'switch-to-prev-buffer)

(global-set-key (kbd "M-<tab>") 'other-window)

(defun my/kill-buffer-ask ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "M-k") 'kill-buffer)



(defun my/scroll-half-page (direction)
  "scroll half page, cursor stays the same"
  (let* ((scroll-lines (/ (window-body-height) 2))
         (current-line (count-lines (window-start) (point)))
         (can-scroll (if (eq direction 'up)
                         (not (bobp))
                       (not (eobp)))))
    
    (when can-scroll
      (if (eq direction 'up)
          (scroll-down scroll-lines)
        (scroll-up scroll-lines))      
      (move-to-window-line (min current-line
                                (1- (window-body-height)))))))

(defun my/scroll-half-page-up ()
  (interactive)
  (my/scroll-half-page 'up))

(defun my/scroll-half-page-down ()
  (interactive)
  (my/scroll-half-page 'down))

(global-set-key (kbd "<prior>") 'my/scroll-half-page-up)
(global-set-key (kbd "<next>")  'my/scroll-half-page-down)


