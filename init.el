;; Make startup faster by reducing the frequency of garbage
;; collection.
;; (setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(package-initialize)

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

;; (if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
;;     (load-file (expand-file-name "config.el" user-emacs-directory))
;;   (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
;; (setq gc-cons-threshold (* 2 1000 1000))
