;; Make startup faster by reducing the frequency of garbage  -*- lexical-binding: t; -*-
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

;; 在配置文件最开始，手动导入代理环境变量
(when (memq window-system '(mac ns x))
  (let ((shell-proxy (shell-command-to-string "echo -n $EMACS_HTTP_PROXY")))
    (when (and shell-proxy (not (string-empty-p shell-proxy)))
      (setenv "EMACS_HTTP_PROXY" shell-proxy)
      (setq url-proxy-services
            `(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\|127\\..*\\)")
              ("http" . ,shell-proxy)
              ("https" . ,shell-proxy)))
      (message "Early proxy set: %s" shell-proxy))))

(require 'package)
(package-initialize)

(require 'org)
(let ((config-org (expand-file-name "config.org" user-emacs-directory))
      (config-el (expand-file-name "config.el" user-emacs-directory)))
  (if (and (file-exists-p config-el)
           (file-newer-than-file-p config-el config-org))
      ;; 如果 .el 文件存在且比 .org 文件新，直接加载 .el
      (load-file config-el)
    ;; 否则从 .org 文件生成并加载
    (org-babel-load-file config-org)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))
