(add-to-list 'load-path "~/.emacs.d/packages/web-mode")
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'"))
)

;(add-hook 'after-init-hook #'global-flycheck-mode)

;(add-to-list 'load-path "~/.emacs.d/packages/web-mode")
(add-hook 'web-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

;-----------------------------------------------------------------
; php-mode
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/php-mode")
(require 'php-mode)

;-----------------------------------------------------------------
; js2-mode
;-----------------------------------------------------------------
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;-----------------------------------------------------------------
; ac-js2
;-----------------------------------------------------------------
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;-----------------------------------------------------------------
; Skewer mode
;-----------------------------------------------------------------
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
