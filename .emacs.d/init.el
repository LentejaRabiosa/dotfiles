(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-install 'use-package)
(package-refresh-contents)
(use-package evil :ensure t)
(use-package paredit :ensure t)
(use-package smex
             :ensure t
             :config
             (smex-initialize)
             (global-set-key (kbd "M-x") 'smex)
             (global-set-key (kbd "M-X") 'smex-major-mode-commands))
(use-package magit :ensure t)

(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(smex paredit use-package gruvbox-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-message t)
(setq history-lenght 25)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (global-display-line-number-mode 1)
(load-theme 'gruvbox t)
(set-frame-font "Source Code Pro" nil t)
(set-face-attribute 'default nil :height 160)
(setq ns-right-alternate-modifier nil)
(setq user-full-name "Lenteja Rabiosa")
(setq make-backup-files nil)
(setq auto-save-default t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq ring-bell-function 'ignore)
(show-paren-mode t)
(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-x e") 'evil-mode)

(defun open-file-right ()
  "Split window right and open file"
  (interactive)
  (split-window-right)
  (call-interactively 'find-file-other-window))

(global-set-key (kbd "C-x v s") 'open-file-right)

;; Makes *scratch* empty.
(setq initial-scratch-message "")
;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))
;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)
;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
