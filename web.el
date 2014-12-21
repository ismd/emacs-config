(add-to-list 'load-path "~/.emacs.d/elpa/web-mode-20140924.1330")
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'"))
)

(add-hook 'web-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'php-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'js2-mode-hook 'turn-on-diff-hl-mode)

(global-set-key (kbd "M-q") 'web-mode)

;-----------------------------------------------------------------
; php-mode
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/php-mode-20140923.1250")
(require 'php-mode)

;-----------------------------------------------------------------
; js2-mode
;-----------------------------------------------------------------
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;-----------------------------------------------------------------
; ac-js2
;-----------------------------------------------------------------
;; (add-hook 'js2-mode-hook 'ac-js2-mode)
;; (setq ac-js2-evaluate-calls t)

;-----------------------------------------------------------------
; Skewer mode
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/skewer-mode-20140702.647")
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;-----------------------------------------------------------------
; Less
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/less-css-mode-20140919.524")
(require 'less-css-mode)

;-----------------------------------------------------------------
; ac-html
;-----------------------------------------------------------------
;; (add-to-list 'load-path "~/.emacs.d/packages/ac-html")
;; (require 'ac-html)

;; (add-to-list 'ac-sources 'ac-source-html-tag)
;; (add-to-list 'ac-sources 'ac-source-html-attribute)

;; (add-to-list 'web-mode-ac-sources-alist
;;              '("html" . (ac-source-html-tag
;;                          ac-source-html-attribute)))
