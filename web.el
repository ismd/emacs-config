;;; Package --- Summary
;;; Commentary:
;;; Code:

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
      '(("php"    . "\\.phtml\\'")))

(global-set-key (kbd "M-q") 'web-mode)

(setq web-mode-code-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-markup-indent-offset 4)

;-----------------------------------------------------------------
; js2-mode
;-----------------------------------------------------------------
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;-----------------------------------------------------------------
; ac-js2
;-----------------------------------------------------------------
(add-hook 'js2-mode-hook 'ac-js2-mode)

;-----------------------------------------------------------------
; Skewer mode
;-----------------------------------------------------------------
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;-----------------------------------------------------------------
; ac-html
;-----------------------------------------------------------------
;; (add-to-list 'web-mode-ac-sources-alist
;;              '("html" . (
;;                          ;; attribute-value better to be first
;;                          ac-source-html-attribute-value
;;                          ac-source-html-tag
;;                          ac-source-html-attribute)))

;-----------------------------------------------------------------
; ac-html-csswatcher
;-----------------------------------------------------------------
;; (ac-html-csswatcher-setup)

;-----------------------------------------------------------------
; Emmet
;-----------------------------------------------------------------
(add-hook 'sgml-mode-hook     'emmet-mode)
(add-hook 'html-mode-hook     'emmet-mode)
(add-hook 'css-mode-hook      'emmet-mode)
(add-hook 'web-mode-hook      'emmet-mode)
(add-hook 'less-css-mode-hook 'emmet-mode)

;-----------------------------------------------------------------
; ac-emmet
;-----------------------------------------------------------------
(add-hook 'sgml-mode-hook 'ac-emmet-html-setup)
(add-hook 'html-mode-hook 'ac-emmet-css-setup)
(add-hook 'css-mode-hook 'ac-emmet-css-setup)
(add-hook 'web-mode-hook 'ac-emmet-css-setup)
(add-hook 'less-css-mode-hook 'ac-emmet-css-setup)

(provide 'web)
;;; web.el ends here
