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
