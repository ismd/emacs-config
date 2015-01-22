;;; Package --- Summary
;;; Commentary:
;;; Code:

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 '(ac-auto-show-menu 0.4)
 '(ac-quick-help-delay 0.5)
 '(create-lockfiles nil)
 '(flycheck-temp-prefix ".flycheck")
 ;; '(menu-bar-mode nil)
 '(require-final-newline t)
 '(scroll-conservatively 10000)
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil))

;-----------------------------------------------------------------
; Faces
;-----------------------------------------------------------------
(custom-set-faces
 '(show-paren-match ((t (:background "#483D8B" :foreground "#343434" :weight normal)))))

;-----------------------------------------------------------------
; Common
;-----------------------------------------------------------------
(xterm-mouse-mode t)
(setq inhibit-startup-screen t)
(set-frame-font "Dejavu Sans Mono-10")
;; (set-frame-font "Consolas-10")
(fset 'yes-or-no-p 'y-or-n-p)

;-----------------------------------------------------------------
; Package initialize
;-----------------------------------------------------------------
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-list '(ac-emmet
                     ac-js2
                     auto-complete
                     flycheck
                     dired+
                     dsvn
                     emmet-mode
                     ggtags
                     helm
                     helm-gtags
                     jedi
                     js2-mode
                     less-css-mode
                     php-mode
                     projectile
                     skewer-mode
                     sr-speedbar
                     sublime-themes
                     web-mode
                     yasnippet
                     ))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;-----------------------------------------------------------------
; Ede
;-----------------------------------------------------------------
(global-ede-mode t)
(ede-enable-generic-projects)

;-----------------------------------------------------------------
; Sublime theme
;-----------------------------------------------------------------
(load-theme 'ritchie t)

;-----------------------------------------------------------------
; Indentation
;-----------------------------------------------------------------
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq sgml-basic-offset 4)
(setq css-indent-offset 4)
(setq nxml-child-indent 4)

;-----------------------------------------------------------------
; Scroll one line at a time
;-----------------------------------------------------------------
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

;-----------------------------------------------------------------
; Russian computer
;-----------------------------------------------------------------
(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(defadvice read-passwd (around my-read-passwd act)
  (let ((local-function-key-map nil))
    ad-do-it))

(reverse-input-method 'russian-computer)

;-----------------------------------------------------------------
; Coding systems
;-----------------------------------------------------------------
(prefer-coding-system 'cp1251)
(prefer-coding-system 'utf-8)

;-----------------------------------------------------------------
; Browser
;-----------------------------------------------------------------
(setq browse-url-default-browser "chromium")
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

;-----------------------------------------------------------------
; Highlighting line
;-----------------------------------------------------------------
(global-hl-line-mode)
;; (set-face-background 'hl-line "#EEEEEE")

;-----------------------------------------------------------------
; Cursor type
;-----------------------------------------------------------------
(setq-default cursor-type 'bar)

;-----------------------------------------------------------------
; Linum mode
;-----------------------------------------------------------------
(global-linum-mode)
(setq linum-format " %3i ")

;-----------------------------------------------------------------
; Which function
;-----------------------------------------------------------------
(which-function-mode 1)

;-----------------------------------------------------------------
; Show paren mode
;-----------------------------------------------------------------
(show-paren-mode)

;-----------------------------------------------------------------
; Directories first
;-----------------------------------------------------------------
(setq dired-listing-switches "-al --group-directories-first")

;-----------------------------------------------------------------
; Yasnippet
;-----------------------------------------------------------------
(yas-global-mode 1)

;-----------------------------------------------------------------
; Size indication mode
;-----------------------------------------------------------------
;; (size-indication-mode)

;-----------------------------------------------------------------
; Column number mode
;-----------------------------------------------------------------
;; (column-number-mode)

;-----------------------------------------------------------------
; Org mode
;-----------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/ownCloud/Documents/org")
(setq org-default-notes-file "~/ownCloud/Documents/org/my.org")
(setq org-agenda-files (list org-directory))

(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "DONE")))

(setq org-todo-keyword-faces
      '(("WAIT". (:foreground "orange" :weight bold))))

;-----------------------------------------------------------------
; Switching between windows
;-----------------------------------------------------------------
;; (global-set-key [M-left] 'windmove-left)
;; (global-set-key [M-right] 'windmove-right)
;; (global-set-key [M-up] 'windmove-up)
;; (global-set-key [M-down] 'windmove-down)

;-----------------------------------------------------------------
; Auto complete
;-----------------------------------------------------------------
(ac-config-default)

(defalias 'yas/current-snippet-table 'yas--get-snippet-tables)
(setq ac-ignore-case 'smart)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

(global-auto-complete-mode t)

;-----------------------------------------------------------------
; Inserting Brackets by Pairs
;-----------------------------------------------------------------
(electric-pair-mode 1)

;-----------------------------------------------------------------
; Dired+
;-----------------------------------------------------------------
(toggle-diredp-find-file-reuse-dir 1)

;-----------------------------------------------------------------
; Dsvn
;-----------------------------------------------------------------
(require 'vc-svn)
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;-----------------------------------------------------------------
; Delete selection mode
;-----------------------------------------------------------------
(delete-selection-mode 1)

;-----------------------------------------------------------------
; Projectile
;-----------------------------------------------------------------
(projectile-global-mode)
(setq projectile-enable-caching t)

;-----------------------------------------------------------------
; Flycheck
;-----------------------------------------------------------------
(add-hook 'after-init-hook #'global-flycheck-mode)

;-----------------------------------------------------------------
; Subword mode
;-----------------------------------------------------------------
(subword-mode 1)

;-----------------------------------------------------------------
; Remove trailing whitespace
;-----------------------------------------------------------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;-----------------------------------------------------------------
; ggtags
;-----------------------------------------------------------------
(add-hook 'c-mode-common-hook
          (lambda ()
            (ggtags-mode 1)))

;-----------------------------------------------------------------
; Helm
;-----------------------------------------------------------------
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "/tmp/helm-cfg.el") (delete-file "/tmp/helm-cfg.el"))))

;; For find-file etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

;-----------------------------------------------------------------
; Helm gtags
;-----------------------------------------------------------------
(add-hook 'c-mode-common-hook
          (lambda ()
            (helm-gtags-mode 1)))

(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;-----------------------------------------------------------------
; sr-speedbar
;-----------------------------------------------------------------
;; (sr-speedbar-open)

;-----------------------------------------------------------------
; Copy filename
;-----------------------------------------------------------------
(defun copy-buffer-file-name (event &optional bufName)
  "Copy buffer file name to kill ring. If no file is associated with buffer just get buffer name."
  (interactive "eP")
  (save-selected-window
    (message "bufName: %S" bufName)
    (select-window (posn-window (event-start event)))
    (let ((name (or (unless bufName (buffer-file-name)) (buffer-name))))
      (message "Saved file name \"%s\" in killring." name)
      (kill-new name)
      name)))

(define-key mode-line-buffer-identification-keymap [mode-line mouse-2] 'copy-buffer-file-name)
(define-key mode-line-buffer-identification-keymap [mode-line S-mouse-2] '(lambda (e) (interactive "e") (copy-buffer-file-name e 't)))

;-----------------------------------------------------------------
; Display time
;-----------------------------------------------------------------
(display-time-mode)

;-----------------------------------------------------------------
; Open default file
;-----------------------------------------------------------------
(find-file "~/ownCloud/Documents/org/my.org")

(provide 'common)
;;; common.el ends here
