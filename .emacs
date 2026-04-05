;; .Emacs --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; When installing new packages, please manually refresh the package contents.
;; Put lang-mode & personal plugins in "~/.emacs.local" and require them in the config will just be fine.
;; IMPORTANT: Whenever you struggle to modify configuration and you find that it just doesn't work, pay
;;            attention to .elc files as it is loaded before .emacs. Delete this and finally when you are
;;            done with your config, "byte-compile-file" and theorically your config will load faster. 

;; Get much reference from Steve Purcell, Alexey Kutepov, ...
;; https://github.com/purcell/emacs.d
;; https://github.com/rexim/dotfiles

;;; Code:

(add-to-list 'load-path "~/.emacs.local/")
(require 'init-benchmarking)

(setq custom-file "~/.emacs.custom.el")

(require 'package)

(add-to-list 'load-path "~/.emacs.snippets/")

;; Uncomment when needed. 
(load-file "~/.emacs.rc/rc.el")
;;(load-file "~/.emacs.rc/misc-rc.el")
;;(load-file "~/.emacs.rc/org-mode-rc.el")
;;(load-file "~/.emacs.rc/autocommit-rc.el")


(setq package-check-signature nil)
(unless (bound-and-true-p package--initialized)
  (package-initialize))
(unless (file-directory-p "~/.emacs.d/elpa/archives/")
  (package-refresh-contents))
(defvar rc/package-contents-refreshed t)


;;; Appearance
(add-to-list 'default-frame-alist '(font . "YaHei Consolas Hybrid-14"))
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(electric-pair-mode t)
(global-display-line-numbers-mode)
(add-hook 'prog-mode-hook #'show-paren-mode)
(column-number-mode t)
(global-auto-revert-mode t)
(delete-selection-mode t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(when (display-graphic-p) (toggle-scroll-bar -1))
(setq display-line-numbers-type 'relative)
(setq gc-cons-threshold most-positive-fixnum)
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)
(setq custom-safe-themes t)


;;; Major Mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))


;;; rc/require
(rc/require 'restart-emacs)
(rc/require-theme 'gruber-darker)

(rc/require 'swiper)
(global-set-key (kbd "C-s") 'swiper)

(rc/require 'vterm)
(setq vterm-shell "/bin/zsh")
(setq vterm-max-scrollback 10000)
(global-set-key (kbd "C-c v") 'vterm)
(global-set-key (kbd "C-c V") 'vterm-other-window)

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

(rc/require 'company)
(global-company-mode 1)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(set-face-attribute 'company-preview nil
                    :background "#484848"
                    :foreground "white")

(add-to-list 'load-path
	      "~/.emacs.snippets/")
(rc/require 'yasnippet)
(yas-global-mode 1)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-,")         'rc/duplicate-line)

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs"))

(global-set-key (kbd "<f2>") 'open-init-file)

;;; key sets
(global-set-key (kbd "C-c c") 'compile)
(setq compilation-scroll-output t)
(setq compilation-auto-jump-to-first-error nil)


;;; kbd-related
(load-file "~/.emacs.local/custom_kbd.el")


;;; Others
(split-window-horizontally)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-auto-revert-buffer t)

;; ido should be after company
(ido-mode 1)
(ido-everywhere 1)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "+" 'dired-create-directory)))

(require 'hello)
;;; .emacs ends here
