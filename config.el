;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; keybind to go to splash screen
(map! "C-c d" #'+doom-dashboard/open)

;; tabs in the top
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

;; autosearch projectile path
projectile-project-search-path '("~/Projects/")

;; LSP mode
(use-package! lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; LSP ui
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

;; company mode
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1))

;; LSP for python
(after! lsp-python-ms
  (set-lsp-priority! 'pyright 1))

(use-package! lsp-pyright
  :defer t
  :init
  (when (executable-find "pyright")
    (setq lsp-pyright-multi-root nil
          lsp-pyright-auto-import-completions t
          lsp-pyright-use-library-code-for-types t
          lsp-pyright-venv-path "~/.virtualenvs")
    (add-hook 'python-mode-hook #'lsp)))


;; LSP for C/C++
(use-package! lsp-clangd
  :defer t
  :init
  (when (executable-find "clangd")
    (setq lsp-clients-clangd-args '("--header-insertion=never"))
    (add-hook 'c-mode-hook #'lsp)
    (add-hook 'c++-mode-hook #'lsp)))

;; LSP for web
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
