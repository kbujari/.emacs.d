;; Pick up config from lisp/
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Always load newest byte code
(setopt load-prefer-newer t)

;; Reduce frequency of garbage collection
(setopt gc-cons-threshold (* 128 1024 1024))

;; Tune processes for better performance
(setopt read-process-output-max (* 4 1024 1024)
        process-adaptive-read-buffering nil)

;; Define file for all custom configuration
(setopt custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Remove extraneous UI elements
(setopt inhibit-startup-message t
        inhibit-splash-screen t
        use-file-dialog nil)

;; Insert tabs as spaces, render tabs as 2 spaces
(setopt indent-tabs-mode nil
        tab-width 2)

;; Disable emacs generated files (.#emacsa8932) (#file#) (file~)
(setopt create-lockfiles nil
        auto-save-default nil
        make-backup-files nil)

;; Conditionally enable HTTP proxy before package init
(when-let* ((proxy (getenv "FWDPROXY")))
  (setopt url-proxy-services
          `(("no_proxy" . "^localhost")
            ("http"     . ,proxy)
            ("https"    . ,proxy))))

(require 'package)

(add-to-list 'package-archives
             '("MELPA"  . "https://melpa.org/packages/")
             '("NONGNU" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)

(when (fboundp 'display-line-numbers-mode)
  (setopt display-line-numbers-width 3)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(when (boundp 'display-fill-column-indicator)
  (setopt indicate-buffer-boundaries 'left
          display-fill-column-indicator-character ?┊)
  (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))

(when (fboundp 'show-paren-mode)
  (setopt show-paren-delay 0)
  (add-hook 'prog-mode-hook 'show-paren-mode))

(when (fboundp 'repeat-mode)
  (add-hook 'after-init-hook 'repeat-mode))

;; General editor preferences
(setopt column-number-mode t
        case-fold-search t
        scroll-preserve-screen-position 'always
        truncate-lines nil
        truncate-partial-width-windows nil
        buffers-menu-max-size 30)

;; Deletes selection when typing
(add-hook 'after-init-hook 'delete-selection-mode)

;; Update buffers when they change from outside emacs
(when (fboundp 'global-auto-revert-mode)
  (setopt global-auto-revert-non-file-buffers t
          auto-revert-verbose nil)
  (add-hook 'after-init-hook 'global-auto-revert-mode))

(when (fboundp 'which-key-mode)
  (add-hook 'after-init-hook 'which-key-mode))

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'default nil :font "Iosevka" :height 124)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(use-package mu4e
  :ensure nil
  :custom
  (setq mu4e-get-mail-command "mbsync -a"
        message-kill-buffer-on-exit t ;; don't keep message buffers
        mu4e-confirm-quit nil         ;; don't ask to quit
        mu4e-change-filenames-when-moving t))

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(use-package meow
  :ensure t
  :config
  (require 'meow-binds)
  (setq meow-use-clipboard t)
  (meow-setup)
  (meow-global-mode 1))

(use-package vertico
  :ensure t
  :hook after-init
  :custom
  (vertico-cycle t))

(use-package marginalia
  :ensure t
  :hook after-init)

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :config
  (keymap-unset corfu-map "RET"))

(use-package dired
  :ensure nil
  :commands (dired)
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (delete-by-moving-to-trash t)
  (dired-dwim-target t))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")

(use-package tuareg
  :ensure t
  :mode ("\\.\\(ml[dipy]?\\)\\'" . tuareg-mode))

(use-package dune
  :ensure t
  :after tuareg)

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'")

(use-package erlang
  :ensure t
  :mode "\\.[eh]rl\\'")

(use-package typst-ts-mode
  :ensure t
  :mode "\\.typ\\'")

(use-package geiser
  :ensure t)

(use-package geiser-guile
  :ensure t)

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
          eval-expression-minibuffer-setup-mode
          lisp-mode
          lisp-interaction-mode
          ielm-mode
          scheme-mode)
         . enable-paredit-mode))

(use-package kdl-mode
  :ensure t
  :mode "\\.kdl\\'")

(use-package magit
  :ensure t)

(use-package eglot
  :hook ((rust-mode
          nix-mode
          tuareg-mode
          haskell-mode
          erlang-mode
          typst-ts-mode)
         . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(erlang-mode . ("elp" "server")))

  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
  :bind (:map eglot-mode-map
         ("C-c c a" . eglot-code-actions)
         ("C-c c r" . eglot-rename)
         ("C-c c f" . eglot-format)
         ("C-c c b" . eglot-format-buffer)
         ("C-c c i" . eglot-find-implementation)
         ("C-c c d" . eglot-find-declaration)
         ("C-c c t" . eglot-find-typeDefinition)
         ("C-c c z" . eglot-reconnect)))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
