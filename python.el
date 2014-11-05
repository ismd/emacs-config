(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (add-hook 'python-mode-hook 'autopair-mode)

;-----------------------------------------------------------------
; Jedi
;-----------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/elpa/epc-20140609.2234")
(add-to-list 'load-path "~/.emacs.d/elpa/concurrent-20140609.1940")
(add-to-list 'load-path "~/.emacs.d/elpa/deferred-20140816.2205")
(add-to-list 'load-path "~/.emacs.d/elpa/ctable-20140304.1659")
(add-to-list 'load-path "~/.emacs.d/elpa/python-environment-20140321.1116")

(add-to-list 'load-path "~/.emacs.d/elpa/jedi-20140321.1323")
(require 'jedi)

;; (setq jedi:server-command
;;       '("python" "~/.emacs.d/elpa/jedi-20140321.1323/jediepcserver.py"))

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            ;; (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            ;; (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))
