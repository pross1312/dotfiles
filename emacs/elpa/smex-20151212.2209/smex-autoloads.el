;;; smex-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "smex" "smex.el" (0 0 0 0))
;;; Generated autoloads from smex.el

(autoload 'smex "smex" nil t nil)

(autoload 'smex-major-mode-commands "smex" "\
Like `smex', but limited to commands that are relevant to the active major mode." t nil)

(autoload 'smex-initialize "smex" nil t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "smex" '("smex-")))

;;;***

;;;### (autoloads nil nil ("smex-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; smex-autoloads.el ends here
