(add-to-list 'load-path "~/.emacs.d")

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("leftright-analyse" (ecb-directories-buffer-name 0.21693121693121692 . 0.37735849056603776) (ecb-sources-buffer-name 0.21693121693121692 . 0.3018867924528302) (ecb-history-buffer-name 0.21693121693121692 . 0.3018867924528302) (ecb-methods-buffer-name 0.20105820105820105 . 0.49056603773584906) (ecb-analyse-buffer-name 0.20105820105820105 . 0.49056603773584906)) ("left8" (ecb-directories-buffer-name 0.21084337349397592 . 0.2826086956521739) (ecb-sources-buffer-name 0.21084337349397592 . 0.2391304347826087) (ecb-methods-buffer-name 0.21084337349397592 . 0.2826086956521739) (ecb-history-buffer-name 0.21084337349397592 . 0.17391304347826086)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(scroll-conservatively 10000)
 '(scroll-step 1)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
(set-default-font "Dejavu Sans Mono-8")

;-----------------------------------------------------------------
; Y or N instead of YES or NO
;-----------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;-----------------------------------------------------------------
; ELPA
;-----------------------------------------------------------------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

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
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-20080305.834")
(require 'color-theme)
(color-theme-initialize)
(color-theme-gtk-ide)

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
; Coding systems
;-----------------------------------------------------------------
(prefer-coding-system 'cp1251)
(prefer-coding-system 'utf-8)

;-----------------------------------------------------------------
; Browser
;-----------------------------------------------------------------
(setq browse-url-default-browser "firefox")

;-----------------------------------------------------------------
; Highlighting line
;-----------------------------------------------------------------
(global-hl-line-mode)
(set-face-background 'hl-line "#EEEEEE")

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

;-----------------------------------------------------------------
; Which function
;-----------------------------------------------------------------
(which-function-mode)

;-----------------------------------------------------------------
; nXhtml
;-----------------------------------------------------------------
(load "~/.emacs.d/nxhtml/autostart")

;-----------------------------------------------------------------
; Show paren mode
;-----------------------------------------------------------------
(show-paren-mode)

;-----------------------------------------------------------------
; Dash
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/dash-20130712.2307")
(require 'dash)

;-----------------------------------------------------------------
; S
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/s-20130617.1851")
(require 's)

;-----------------------------------------------------------------
; Yasnippet
;-----------------------------------------------------------------
(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
(require 'yasnippet)
(yas/global-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/angular-snippets-20130505.1446")
(require 'angular-snippets)

(eval-after-load "sgml-mode"
  '(define-key html-mode-map (kbd "C-c C-d") 'ng-snip-show-docs-at-point))

;-----------------------------------------------------------------
; php+-mode
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/php+-mode-20121129.1452")
(require 'php+-mode)
(php+-mode-setup)

;-----------------------------------------------------------------
; Tabbar
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/tabbar-20110824.1439")
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
; Ide Skel
;-----------------------------------------------------------------
(require 'ide-skel)
(partial-completion-mode)

(global-set-key [f4] 'ide-skel-proj-find-files-by-regexp)
(global-set-key [f5] 'ide-skel-proj-grep-files-by-regexp)
(global-set-key [f10] 'ide-skel-toggle-left-view-window)
(global-set-key [f11] 'ide-skel-toggle-bottom-view-window)
(global-set-key [f12] 'ide-skel-toggle-right-view-window)

;-----------------------------------------------------------------
; SqlPlus
;-----------------------------------------------------------------
(require 'sqlplus)

;-----------------------------------------------------------------
; js2-mode
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/js2-mode-20130725.125")
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;-----------------------------------------------------------------
; Switching between windows
;-----------------------------------------------------------------
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
