(add-to-list 'load-path "~/.emacs.d")

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("left8" (ecb-directories-buffer-name 0.1927710843373494 . 0.2826086956521739) (ecb-sources-buffer-name 0.1927710843373494 . 0.2391304347826087) (ecb-methods-buffer-name 0.1927710843373494 . 0.2826086956521739) (ecb-history-buffer-name 0.1927710843373494 . 0.17391304347826086)))))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/home/ismd/coding/game/ismd-game" "game"))))
 '(py-shell-name "ipython2" t)
 '(scroll-conservatively 10000)
 '(scroll-step 1)
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
; CEDET
;-----------------------------------------------------------------
(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")
(global-ede-mode 1)
(semantic-load-enable-gaudy-code-helpers)

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
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq sgml-basic-offset 4)
(setq css-indent-offset 1)
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
; iPython
;-----------------------------------------------------------------
(setq ipython-command "/usr/bin/ipython2")
(setq py-shell-name "/usr/bin/ipython2")
(setq py-python-command-args '( "--colors" "Linux"))
;(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

;-----------------------------------------------------------------
; python-mode
;-----------------------------------------------------------------
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

;-----------------------------------------------------------------
; pymacs, ropemacs
;-----------------------------------------------------------------
(require 'pymacs)
(setenv "PYMACS_PYTHON" "python2")
(pymacs-load "ropemacs" "rope-")

;-----------------------------------------------------------------
; pylookup
;-----------------------------------------------------------------
(setq pylookup-dir "~/.emacs.d/pylookup")
(add-to-list 'load-path pylookup-dir)
;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(global-set-key "\C-ch" 'pylookup-lookup)

;-----------------------------------------------------------------
; Browser
;-----------------------------------------------------------------
;(setq browse-url-browser-function 'w3m-browse-url)
(setq browse-url-default-browser "firefox")

;-----------------------------------------------------------------
; Using flymake with pylint
;-----------------------------------------------------------------
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
       (local-file (file-relative-name
                    temp-file
                    (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
           '("\\.py\\'" flymake-pylint-init)))

;-----------------------------------------------------------------
; Flymake
;-----------------------------------------------------------------
(add-hook 'python-mode-hook 'flymake-mode)
(add-hook 'php-mode-hook 'flymake-mode)

;-----------------------------------------------------------------
; php-mode
;-----------------------------------------------------------------
;(autoload 'php-mode "php-mode.el" "Php mode." t)
;(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;-----------------------------------------------------------------
; Highlighting line
;-----------------------------------------------------------------
(global-hl-line-mode t)

;-----------------------------------------------------------------
; Cursor type
;-----------------------------------------------------------------
(setq-default cursor-type 'bar)

;-----------------------------------------------------------------
; Icomplete mode
;-----------------------------------------------------------------
(icomplete-mode t)

;-----------------------------------------------------------------
; ido
;-----------------------------------------------------------------
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(ido-mode t)

;-----------------------------------------------------------------
; Vertical completions
;-----------------------------------------------------------------
(setq completions-format 'vertical)

;-----------------------------------------------------------------
; Linum mode
;-----------------------------------------------------------------
(global-linum-mode t)

;-----------------------------------------------------------------
; Which function
;-----------------------------------------------------------------
(which-function-mode t)

;-----------------------------------------------------------------
; nXhtml
;-----------------------------------------------------------------
(load "~/.emacs.d/nxhtml/autostart")

;-----------------------------------------------------------------
; Show paren mode
;-----------------------------------------------------------------
(show-paren-mode t)

;-----------------------------------------------------------------
; ELPA
;-----------------------------------------------------------------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;-----------------------------------------------------------------
; Yasnippet
;-----------------------------------------------------------------
(add-to-list 'load-path
             "~/.emacs.d/elpa/yasnippet-20121225.430")
(require 'yasnippet)

(yas--initialize)
(yas/load-directory "~/.emacs.d/elpa/yasnippet-20121225.430/snippets")

(yas-global-mode 1)

;-----------------------------------------------------------------
; php+-mode
;-----------------------------------------------------------------
(add-to-list 'load-path
             "~/.emacs.d/elpa/php+-mode-20121129.1452")
(require 'php+-mode)
(php+-mode-setup)

;-----------------------------------------------------------------
; Tabbar
;-----------------------------------------------------------------
(add-to-list 'load-path
             "~/.emacs.d/elpa/tabbar-20110824.1439")
(require 'tabbar)
(tabbar-mode)
