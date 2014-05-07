(add-to-list 'load-path "~/.emacs.d")

;-----------------------------------------------------------------
; Variables
;-----------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.4)
 '(ac-quick-help-delay 0.5)
 '(ecb-display-default-dir-after-start nil)
 '(ecb-excluded-directories-regexps (quote ("^\\(CVS\\|\\.\\|\\.\\.\\)$")))
 '(ecb-kill-buffer-clears-history (quote auto))
 '(ecb-layout-name "leftright2")
 '(ecb-layout-window-sizes (quote (("leftright2" (ecb-directories-buffer-name 0.0894915254237288 . 0.4925373134328358) (ecb-sources-buffer-name 0.0894915254237288 . 0.4925373134328358) (ecb-methods-buffer-name 0.17372881355932204 . 0.40298507462686567) (ecb-history-buffer-name 0.17372881355932204 . 0.582089552238806)) ("leftright-analyse" (ecb-directories-buffer-name 0.21693121693121692 . 0.37735849056603776) (ecb-sources-buffer-name 0.21693121693121692 . 0.3018867924528302) (ecb-history-buffer-name 0.21693121693121692 . 0.3018867924528302) (ecb-methods-buffer-name 0.20105820105820105 . 0.49056603773584906) (ecb-analyse-buffer-name 0.20105820105820105 . 0.49056603773584906)) ("left8" (ecb-directories-buffer-name 0.21084337349397592 . 0.2826086956521739) (ecb-sources-buffer-name 0.21084337349397592 . 0.2391304347826087) (ecb-methods-buffer-name 0.21084337349397592 . 0.2826086956521739) (ecb-history-buffer-name 0.21084337349397592 . 0.17391304347826086)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-file-regexps (quote ((".*" ("\\(^#\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)") ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-tip-of-the-day nil)
 '(scroll-conservatively 10000)
 '(scroll-step 1)
 '(tool-bar-mode nil)
 '(web-mode-code-indent-offset 4)
 '(web-mode-css-indent-offset 4)
 '(web-mode-markup-indent-offset 4)) 
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
(set-default-font "Dejavu Sans Mono-10")

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
; e2wm
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/window-layout")
(require 'window-layout)
(add-to-list 'load-path "~/.emacs.d/packages/e2wm")
(require 'e2wm)

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
(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/sublime-themes")
(load-theme 'spolsky t)

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
;(global-hl-line-mode)
;(set-face-background 'hl-line "#EEEEEE")

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
; nXhtml
;-----------------------------------------------------------------
;(load "~/.emacs.d/nxhtml/autostart")

;-----------------------------------------------------------------
; Show paren mode
;-----------------------------------------------------------------
(show-paren-mode)

;-----------------------------------------------------------------
; Yasnippet
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)

;-----------------------------------------------------------------
; Tabbar
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/tabbar")
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
;(require 'ide-skel)
;(partial-completion-mode)

;(global-set-key [f4] 'ide-skel-proj-find-files-by-regexp)
;(global-set-key [f5] 'ide-skel-proj-grep-files-by-regexp)
;(global-set-key [f10] 'ide-skel-toggle-left-view-window)
;(global-set-key [f11] 'ide-skel-toggle-bottom-view-window)
;(global-set-key [f12] 'ide-skel-toggle-right-view-window)

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
(add-to-list 'load-path "~/.emacs.d/packages/popup")
(add-to-list 'load-path "~/.emacs.d/packages/auto-complete")
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
(add-to-list 'load-path "~/.emacs.d/packages/dired+")
(require 'dired+)

;-----------------------------------------------------------------
; Dsvn
;-----------------------------------------------------------------
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'vc-svn)

;-----------------------------------------------------------------
; Delete selection mode
;-----------------------------------------------------------------
(delete-selection-mode 1)

;-----------------------------------------------------------------
; Prevents from throwing errors
;-----------------------------------------------------------------
;(setq stack-trace-on-error t)

;-----------------------------------------------------------------
; ECB
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/ecb")
(require 'ecb)
(ecb-activate)

;-----------------------------------------------------------------
; epl
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/epl")
(require 'epl)

;-----------------------------------------------------------------
; Dash
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/dash")
(require 'dash)

;-----------------------------------------------------------------
; S
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/s")
(require 's)

(eval-after-load "sgml-mode"
  '(define-key html-mode-map (kbd "C-c C-d") 'ng-snip-show-docs-at-point))

;-----------------------------------------------------------------
; pkg-info
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/pkg-info")
(require 'pkg-info)

;-----------------------------------------------------------------
; Projectile
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/projectile")
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

;-----------------------------------------------------------------
; Flymake
;-----------------------------------------------------------------
(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)

(add-to-list 'load-path "~/.emacs.d/packages/flymake-easy")
(add-to-list 'load-path "~/.emacs.d/packages/flymake-css")
(add-to-list 'load-path "~/.emacs.d/packages/flymake-php")
(add-to-list 'load-path "~/.emacs.d/packages/flymake-python-pyflakes")
(require 'flymake-easy)
(require 'flymake-css)
(require 'flymake-php)
(require 'flymake-python-pyflakes)
(add-hook 'css-mode-hook 'flymake-css-load)
(add-hook 'php-mode-hook 'flymake-php-load)
(add-hook 'php+-mode-hook 'flymake-php-load)
(add-hook 'web-mode-hook 'flymake-php-load)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;-----------------------------------------------------------------
; Semantic
;-----------------------------------------------------------------
(global-semantic-idle-completions-mode t)
(global-semantic-decoration-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-show-unmatched-syntax-mode t)

(global-ede-mode 1)
(semantic-mode 1)

(defun newline-and-indent-as-above ()
  (interactive)
  (let* ((cline (thing-at-point 'line))
         (start (string-match "\\`[ \t]+" cline))
         (end (match-end 0))
         (indent (substring cline start end )))
    (newline)
    (insert indent)))
 
(global-set-key (kbd "<C-return>") 'newline-and-indent-as-above)

;-----------------------------------------------------------------
; Subword mode
;-----------------------------------------------------------------
(subword-mode 1)
