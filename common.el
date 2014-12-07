(add-to-list 'load-path "~/.emacs.d/lisp")

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 '(ac-auto-show-menu 0.4)
 '(ac-quick-help-delay 0.5)
 '(company-dabbrev-downcase nil)
 '(create-lockfiles nil)
 '(ecb-display-default-dir-after-start nil)
 '(ecb-excluded-directories-regexps (quote ("^\\(CVS\\|\\.\\|\\.\\.\\)$")))
 '(ecb-kill-buffer-clears-history (quote auto))
 '(ecb-layout-name "leftright2")
 '(ecb-layout-window-sizes
   (quote
    (("leftright2"
      (ecb-directories-buffer-name 0.09101694915254236 . 0.6440677966101694)
      (ecb-sources-buffer-name 0.09101694915254236 . 0.3559322033898305)
      (ecb-methods-buffer-name 0.17101694915254236 . 0.423728813559322)
      (ecb-history-buffer-name 0.17101694915254236 . 0.576271186440678)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-file-regexps (quote ((".*" ("\\(^#\\|^.flycheck_\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)") ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-tip-of-the-day nil)
 '(flycheck-temp-prefix ".flycheck")
 '(less-css-lessc-options (quote ("--no-color -x")))
 '(menu-bar-mode nil)
 '(package-archive '(("gnu" . "http://elpa.gnu.org/packages/")
                     ("melpa" . "http://melpa.milkbox.net/packages/")))
 '(scroll-conservatively 10000)
 '(scroll-step 1)
 '(svn-program "svn")
 '(tool-bar-mode nil)
 '(web-mode-code-indent-offset 4)
 '(web-mode-css-indent-offset 4)
 '(web-mode-markup-indent-offset 4))
(custom-set-faces
 '(tabbar-button-highlight ((t (:inherit tabbar-button))))
 '(tabbar-default ((t (:inherit variable-pitch :background "gray82" :foreground "gray50" :height 0.8))))
 '(tabbar-highlight ((t nil)))
 '(tabbar-selected ((t (:inherit tabbar-default :background "white" :foreground "blue" :box (:line-width 1 :color "black")))))
 '(tabbar-separator ((t (:inherit tabbar-default :height 0.2))))
 '(tabbar-unselected ((t (:inherit tabbar-default :background "gray72" :foreground "black" :box (:line-width 1 :color "black"))))))

;-----------------------------------------------------------------
; Inhibit startup screen
;-----------------------------------------------------------------
(setq inhibit-startup-screen t)

;-----------------------------------------------------------------
; Default font
;-----------------------------------------------------------------
(set-frame-font "Dejavu Sans Mono-10")
;(set-frame-font "Consolas-11")

;-----------------------------------------------------------------
; Y or N instead of YES or NO
;-----------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;-----------------------------------------------------------------
; Color theme
;-----------------------------------------------------------------
;(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-20080305.834")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-gtk-ide)

;-----------------------------------------------------------------
; Sublime theme
;-----------------------------------------------------------------
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/sublime-themes-20140920.500")
(load-theme 'junio t)

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
;; (global-hl-line-mode)
;; (set-face-background 'hl-line "#EEEEEE")

;-----------------------------------------------------------------
; Cursor type
;-----------------------------------------------------------------
(setq-default cursor-type 'bar)

;-----------------------------------------------------------------
; Icomplete mode
;-----------------------------------------------------------------
(icomplete-mode)

;-----------------------------------------------------------------
; ido
;-----------------------------------------------------------------
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(ido-mode)

;-----------------------------------------------------------------
; Vertical completions
;-----------------------------------------------------------------
(setq completions-format 'vertical)

;-----------------------------------------------------------------
; Linum mode
;-----------------------------------------------------------------
(global-linum-mode)
(setq linum-format " %3i ")

;-----------------------------------------------------------------
; Which function
;-----------------------------------------------------------------
(which-function-mode)

;-----------------------------------------------------------------
; Show paren mode
;-----------------------------------------------------------------
(show-paren-mode)

;-----------------------------------------------------------------
; Yasnippet
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-global-mode 1)

;-----------------------------------------------------------------
; Tabbar
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/tabbar-20140316.600")
(require 'tabbar)
(tabbar-mode)

(global-set-key [C-next] 'tabbar-backward)
(global-set-key [C-prior]  'tabbar-forward)

;-----------------------------------------------------------------
; Size indication mode
;-----------------------------------------------------------------
(size-indication-mode)

;-----------------------------------------------------------------
; Column number mode
;-----------------------------------------------------------------
(column-number-mode)

;-----------------------------------------------------------------
; Org mode
;-----------------------------------------------------------------
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/Документы/org")
(setq org-agenda-files (list org-directory))

(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "DONE")))

(setq org-todo-keyword-faces
      '(("WAIT". (:foreground "orange" :weight bold))))

;-----------------------------------------------------------------
; Switching between windows
;-----------------------------------------------------------------
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;-----------------------------------------------------------------
; Auto complete
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/popup-20140815.629")
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20140824.1658")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-modes 'php+-mode)
(add-to-list 'ac-modes 'web-mode)

(global-set-key (kbd "C-<tab>") 'auto-complete)

;-----------------------------------------------------------------
; Inserting Brackets by Pairs
;-----------------------------------------------------------------
(electric-pair-mode 1)

;-----------------------------------------------------------------
; Dired+
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/dired+-20140922.2220")
(require 'dired+)
(toggle-diredp-find-file-reuse-dir 1)

;-----------------------------------------------------------------
; Dsvn
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/dsvn-20130120.1257")
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'vc-svn)

;-----------------------------------------------------------------
; Delete selection mode
;-----------------------------------------------------------------
(delete-selection-mode 1)

;-----------------------------------------------------------------
; ECB
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/ecb-20140215.114")
(require 'ecb)
(ecb-activate)

;-----------------------------------------------------------------
; epl
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/epl-20140823.609")
(require 'epl)

;-----------------------------------------------------------------
; Dash
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/dash-20140811.523")
(require 'dash)

;-----------------------------------------------------------------
; S
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/s-20140910.334")
(require 's)

(eval-after-load "sgml-mode"
  '(define-key html-mode-map (kbd "C-c C-d") 'ng-snip-show-docs-at-point))

;-----------------------------------------------------------------
; pkg-info
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/pkg-info-20140610.630")
(require 'pkg-info)

;-----------------------------------------------------------------
; Projectile
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/projectile-20140906.1456")
(require 'projectile)
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
; Company mode
;-----------------------------------------------------------------
;(autoload 'company-mode "company" nil t)
;(add-hook 'after-init-hook 'global-company-mode)

(helm :repo "emacs-helm/helm" :fetcher github :files ("*.el" "emacs-helm.sh"))
