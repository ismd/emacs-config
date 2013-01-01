(add-to-list 'load-path "~/.emacs.d")

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.14232209737827714 . 0.2777777777777778) (ecb-sources-buffer-name 0.14232209737827714 . 0.2361111111111111) (ecb-methods-buffer-name 0.14232209737827714 . 0.2916666666666667) (ecb-history-buffer-name 0.14232209737827714 . 0.18055555555555555)))))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/home/ismd/coding/game/ismd-game" "game"))))
 '(indent-tabs-mode nil)
 '(scroll-conservatively 10000)
 '(scroll-step 1)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;-----------------------------------------------------------------
; Inhibit startup screen
;-----------------------------------------------------------------
(setq inhibit-startup-screen t)

;-----------------------------------------------------------------
; Default font
;-----------------------------------------------------------------
(set-default-font "Droid Sans Mono-9")

;-----------------------------------------------------------------
; Y or N instead of YES or NO
;-----------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;-----------------------------------------------------------------
; cedet
;-----------------------------------------------------------------
(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

;-----------------------------------------------------------------
; ECB
;-----------------------------------------------------------------
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ecb")
(require 'ecb)

;-----------------------------------------------------------------
; Color theme
;-----------------------------------------------------------------
;(color-theme-initialize)
;(color-theme-arjen)

;-----------------------------------------------------------------
; Indentation
;-----------------------------------------------------------------
(setq c-basic-offset 4)
(setq sgml-basic-offset 4)
(setq css-indent-offset 1)

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
; iPython
;-----------------------------------------------------------------
;(setq ipython-command "/usr/bin/ipython2")
;(setq py-shell-name "/usr/bin/ipython2")
;(setq py-python-command-args '( "--colors" "Linux"))

;-----------------------------------------------------------------
; python-mode
;-----------------------------------------------------------------
;(autoload 'python-mode "python-mode.el" "Python mode." t)
;(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

;-----------------------------------------------------------------
; pymacs, ropemacs
;-----------------------------------------------------------------
;(require 'pymacs)
;(setenv "PYMACS_PYTHON" "python2")
;(pymacs-load "ropemacs" "rope-")

;-----------------------------------------------------------------
; pylookup
;-----------------------------------------------------------------
;(setq pylookup-dir "~/.emacs.d/pylookup")
;(add-to-list 'load-path pylookup-dir)
;; load pylookup when compile time
;(eval-when-compile (require 'pylookup))

;; set executable file and db file
;(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
;(autoload 'pylookup-lookup "pylookup"
;  "Lookup SEARCH-TERM in the Python HTML indexes." t)
;(autoload 'pylookup-update "pylookup"
;  "Run pylookup-update and create the database at `pylookup-db-file'." t)

;(global-set-key "\C-ch" 'pylookup-lookup)

;-----------------------------------------------------------------
; Browser
;-----------------------------------------------------------------
;(setq browse-url-browser-function 'w3m-browse-url)
(setq browse-url-default-browser "firefox")

;-----------------------------------------------------------------
; Using flymake with pylint
;-----------------------------------------------------------------
;(when (load "flymake" t)
;  (defun flymake-pylint-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;       (local-file (file-relative-name
;                    temp-file
;                    (file-name-directory buffer-file-name))))
;      (list "epylint" (list local-file))))

;  (add-to-list 'flymake-allowed-file-name-masks
;           '("\\.py\\'" flymake-pylint-init)))

;(add-hook 'python-mode-hook 'flymake-mode)

;-----------------------------------------------------------------
; php-mode
;-----------------------------------------------------------------
(autoload 'php-mode "php-mode.el" "Php mode." t)
(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;-----------------------------------------------------------------
; emhacks
;-----------------------------------------------------------------
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emhacks")
