;;; Package --- Summary
;;; Commentary:
;;; Code:

(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;-----------------------------------------------------------------
; Jedi
;-----------------------------------------------------------------
;; (setq jedi:server-command
;;       '("python" "~/.emacs.d/elpa/jedi-20140321.1323/jediepcserver.py"))

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            ;; (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            ;; (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))

(provide 'python)
;;; python.el ends here
