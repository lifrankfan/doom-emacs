;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal Information
(setq user-full-name "Frank Li Fan"
      user-mail-address "lifrankfan@gmail.com")

;; Font Configuration
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

;; Theme Configuration
(setq doom-theme 'doom-one)

;; Line Numbers Configuration
(setq display-line-numbers-type t)

;; Org Directory
(setq org-directory "~/org/")

;; Keybindings
(map! "C-c d" #'+doom-dashboard/open)

;; Projectile Configuration
(setq projectile-project-search-path '("~/Projects/"))

;; Package Configurations
(use-package! centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<" . centaur-tabs-backward)
  ("C->" . centaur-tabs-forward))
(setq centaur-tabs-style "bar")

(use-package! lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package! lsp-ui
  :after lsp
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t))

(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1))

(use-package! lsp-pyright
  :defer t
  :init
  (when (executable-find "pyright")
    (setq lsp-pyright-multi-root nil
          lsp-pyright-auto-import-completions t
          lsp-pyright-use-library-code-for-types t
          lsp-pyright-venv-path "~/.virtualenvs")
    (add-hook 'python-mode-hook #'lsp)))

(use-package! lsp-clangd
  :defer t
  :init
  (when (executable-find "clangd")
    (setq lsp-clients-clangd-args '("--header-insertion=never"))
    (add-hook 'c-mode-hook #'lsp)
    (add-hook 'c++-mode-hook #'lsp)))

(use-package! lsp-html
  :defer t
  :init
  (when (executable-find "vscode-html-language-server")
    (add-hook 'html-mode-hook #'lsp)))

(use-package! lsp-css
  :defer t
  :init
  (when (executable-find "vscode-css-language-server")
    (add-hook 'css-mode-hook #'lsp)))

(use-package! lsp-javascript
  :defer t
  :init
  (when (executable-find "vscode-json-language-server")
    (add-hook 'js-mode-hook #'lsp)
    (add-hook 'js2-mode-hook #'lsp)
    (add-hook 'rjsx-mode-hook #'lsp)))
