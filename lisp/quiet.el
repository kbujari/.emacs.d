(deftheme quiet "Simple white-on-black theme"
          :background-mode 'dark
          :kind 'color-scheme)

(let ((quiet-bg "#181616")
      (quiet-fg "#c5c9c5")
      (quiet-fg-dim "#707070")
      (quiet-const "#999999")
      (quiet-error "#ff003f"))

  ;; M-x list-faces-display for face identifiers
  ;; C-h f set-face-attribute for face modifications
  (custom-theme-set-faces
   'quiet
   `(default ((t (:background ,quiet-bg :foreground ,quiet-fg))))
   `(fringe ((t (:background ,quiet-bg :foreground ,quiet-fg))))
   `(cursor ((t (:background ,quiet-fg :inverse-video t))))
   `(vertical-border ((t (:foreground ,quiet-fg-dim))))
   `(minibuffer-prompt ((t (:foreground ,quiet-fg :weight bold))))
   `(mode-line ((t (:background ,quiet-fg :foreground ,quiet-bg :box ,quiet-fg))))
   `(mode-line-inactive ((t (:background ,quiet-fg-dim :foreground ,quiet-bg :box ,quiet-fg-dim))))

   `(envrc-mode-line-none-face ((t (:foreground ,quiet-bg))))
   `(envrc-mode-line-on-face ((t (:foreground ,quiet-bg))))
   `(envrc-mode-line-error-face ((t (:foreground ,quiet-bg))))

   `(font-lock-builtin-face ((t (:foreground ,quiet-fg))))
   `(font-lock-comment-face ((t (:foreground ,quiet-fg-dim :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,quiet-const))))
   `(font-lock-function-call-face ((t (:foreground ,quiet-fg))))
   `(font-lock-function-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-keyword-face ((t (:foreground ,quiet-fg :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,quiet-fg))))
   `(font-lock-property-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-property-use-face ((t (:foreground ,quiet-fg))))
   `(font-lock-string-face ((t (:foreground ,quiet-const))))
   `(font-lock-type-face ((t (:foreground ,quiet-fg))))
   `(Font-lock-variable-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-variable-use-face ((t (:foreground ,quiet-fg))))

   `(tuareg-font-lock-governing-face ((t (:foreground ,quiet-fg :weight bold))))

   `(line-number ((t (:foreground "#585858"))))
   `(show-paren-match ((t (:foreground "#ff00af" :weight bold))))
   `(show-paren-mismatch ((t (:background ,quiet-error))))
   `(highlight ((t (:background "#303030"))))
   `(fill-column-indicator ((t (:height 1 :background ,quiet-fg-dim :foreground ,quiet-fg-dim))))
   `(region ((t (:background "#ffaf00" :foreground ,quiet-bg))))))
