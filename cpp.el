;;; Package --- Summary
;;; Commentary:
;;; Code:

(custom-set-variables
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include"))))

;-----------------------------------------------------------------
; c++-mode for .h files
;-----------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(provide 'cpp)
;;; cpp.el ends here
