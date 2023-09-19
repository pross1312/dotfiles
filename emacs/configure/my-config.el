(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'ido)
(ido-mode t)
(load-theme 'gruvbox t)

(setq inhibit-startup-message t
      visible-bell nil)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(set-frame-font "Iosevka Term 18" nil t)

(setq backup-directory-alist '(("." . "~/dotfiles/emacs/.emacs_saves")))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(ffap-bindings)
(global-set-key (kbd "M-/") 'company-complete)
(setq company-idle-delay nil)
(add-hook 'after-init-hook 'global-company-mode)
