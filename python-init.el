(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (add-hook 'python-mode-hook 'autopair-mode)

;-----------------------------------------------------------------
; Jedi
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/epc")
(add-to-list 'load-path "~/.emacs.d/packages/concurrent")
(add-to-list 'load-path "~/.emacs.d/packages/deferred")
(add-to-list 'load-path "~/.emacs.d/packages/ctable")
(add-to-list 'load-path "~/.emacs.d/packages/python-environment")

(add-to-list 'load-path "~/.emacs.d/packages/jedi")
(require 'jedi)

;; (setq jedi:server-command
;;       '("python" "~/.emacs.d/packages/jedi/jediepcserver.py"))

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            ;; (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            ;; (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))

;; (add-to-list 'load-path "~/.emacs.d/packages/flymake-python-pyflakes")
;; (require 'flymake-python-pyflakes)
;; (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
