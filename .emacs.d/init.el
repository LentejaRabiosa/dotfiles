;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    CUSTOM SET VARIABLES    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(projectile smex paredit use-package gruvbox-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;
;;    PACKAGES    ;;
;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-install 'use-package)
(package-refresh-contents)
(use-package evil :ensure t)
(use-package paredit :ensure t)
(use-package general
  :ensure t
  :after evil
  :config
  (general-create-definer tyrant-def
    :states '(normal insert motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC")
  (tyrant-def "" nil)

  (general-def universal-argument-map
    "SPC u" 'universal-argument-more)

  (tyrant-def
	"b" 'previous-buffer
	"n" 'next-buffer
    "ff" 'find-file
    ;; "fs" 'save-buffer
	"fd" 'dired
	"mb" 'buffer-menu
	"kb" 'kill-buffer
    "kt" 'kill-this-buffer
	"ks" 'kill-some-buffers
	"kw" 'kill-buffer-and-window
	"dt" 'delete-window
	"do" 'delete-other-windows
	"o"  'other-window
    "sb" 'switch-to-buffer
	"gs" 'magit-status
	"gb" 'magit-branch
	"sr" 'magit-show-refs
	"ws" 'whitespace-mode
	"lp" (lambda () (interactive) (shell-command (concat "pdflatex " buffer-file-name " ; open " (file-name-sans-extension buffer-file-name) ".pdf")))))

(use-package smex
             :ensure t
             :config
             (smex-initialize)
             (global-set-key (kbd "M-x") 'smex)
             (global-set-key (kbd "M-X") 'smex-major-mode-commands))
(use-package magit :ensure t)
(use-package projectile :ensure t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(use-package which-key
  :ensure t
  :config
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-side-window-location 'bottom)
  (which-key-mode))
(use-package gruvbox-theme :ensure t)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  (load-theme 'doom-one t))

;;;;;;;;;;;;;;;;;;;;;
;;    EVIL MODE    ;;
;;;;;;;;;;;;;;;;;;;;;
(evil-mode 1)

;;;;;;;;;;;;;;;;;;
;;    THEMES    ;;
;;;;;;;;;;;;;;;;;;
;; (load-theme 'gruvbox t)

;;;;;;;;;;;;;;;;
;;    TABS    ;;
;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(add-hook 'html-mode-hook
		  (lambda()
			(setq sgml-basic-offset 4)
			(setq indent-tabs-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;
;;    BASIC STUFF    ;;
;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)
(setq history-lenght 25)
(tool-bar-mode -1)
(scroll-bar-mode 1)
(global-display-line-numbers-mode)
(set-frame-font "Source Code Pro" nil t)
(set-face-attribute 'default nil :height 170)
(setq ns-right-alternate-modifier nil)
(setq user-full-name "Lenteja Rabiosa")
(setq make-backup-files nil)
(setq auto-save-default t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq ring-bell-function 'ignore)
(show-paren-mode t)
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;;;;;;;;;;;;;;;;;
;;    BUFFERS    ;;
;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    CUSTOM FUNCTIONS    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun open-file-right ()
  "Split window right and open file"
  (interactive)
  (split-window-right)
  (call-interactively 'find-file-other-window))

;;;;;;;;;;;;;;;;;;;;;
;;    DASHBOARD    ;;
;;;;;;;;;;;;;;;;;;;;;
(setq dashboard-banner-logo-title "Lenteja Rabiosa Martian Emacs.")
(setq dashboard-startup-banner "~/.emacs.d/baner.txt")
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts t)
(setq dashboard-items '((recents . 5)
						(bookmarks . 5)
						(projects . 5)
						(agenda . 5)))
(setq dashboard-footer-messages '("No puedes conectar los puntos mirando hacia adelante. Sólo puedes hacerlo mirando hacia atrás."))
(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)

;;;;;;;;;;;;;;;;
;;    KEYS    ;;
;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "\C-x_n") 'global-display-line-numbers-mode)
;; (global-set-key (kbd "\C-x_w") 'whitespace-mode)
;; (global-set-key (kbd "\C-x_e") 'evil-mode)
;; (global-set-key (kbd "C-M-w") 'whitespace-mode)
;; (global-set-key (kbd "C-M-n") 'global-display-line-numbers-mode)
;; (global-set-key (kbd "C-M-e") 'evil-mode)
;; (global-set-key (kbd "C-x v s") 'open-file-right)

;; (evil-define-key 'normal 'global (kbd "SPC f")  'find-file)
;; (evil-define-key 'normal 'global (kbd "SPC kb") 'kill-buffer)
;; (evil-define-key 'normal 'global (kbd "SPC ks") 'kill-some-buffers)
;; (evil-define-key 'normal 'global (kbd "SPC o")  'other-window)
;; (evil-define-key 'normal 'global (kbd "SPC g")  'magit-status)

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file
  (kbd "+") 'dired-create-directory
  (kbd "D") 'dired-do-delete
  (kbd "M") 'dired-do-chmod
  (kbd "T") 'dired-do-touch
  (kbd "R") 'dired-do-rename
  (kbd "C") 'dired-do-copy
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark)

(global-set-key (kbd "C-, l p") (lambda () (interactive) (shell-command (concat "pdflatex " buffer-file-name " ; open " (file-name-sans-extension buffer-file-name) ".pdf"))))

(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

;; (add-to-list 'org-latex-classes
;; 			 '("article"
;; 			   "\\documentclass{article}"
;; 			   ("\\section{%s}" . "\\section*{%s}")
;; 			   ("\\subsection{%s}" . "\\subsection*{%s}")
;; 			   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; 			   ("\\paragraph{%s}" . "\\paragraph*{%s}")
;; 			   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
