;;; Package --- Summary
;;; Commentary:
;;; Code:

(custom-set-variables
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include"))))

;-----------------------------------------------------------------
; c++-mode for .h files
;-----------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;-----------------------------------------------------------------
; Semantic
;-----------------------------------------------------------------
(defun my/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;;  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;;  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)

  ;; (add-to-list 'ac-sources 'ac-source-semantic)
  )

(add-hook 'c-mode-common-hook 'my/cedet-hook)

(provide 'cpp)
;;; cpp.el ends here
