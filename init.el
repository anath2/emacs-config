;;; packge -- summary

;;; Commentary:

;;; Code:

(server-start)

;; Package support

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-enable-imenu-support t)


(require 'use-package)
(require 'bind-key)
(require 'diminish)

;; Global keybindings
;; Define these early so the rest of the code can use them

;;; This key-map variable is an alias for `C-c`.
(defvaralias 'aj-custom-bindings-map 'mode-specific-map)

;;; `C-c h` is specifically for (most) hydra.
(bind-key "h" (define-prefix-command 'aj-hydra-map) aj-custom-bindings-map)

;;; `s-x` maps to individual commands, rarely modes or toggles.
(bind-key "s-x" (define-prefix-command 'aj-command-shortcut-map))

;;; `s-x s-w` is for packages which use web services.
(bind-key "s-w" (define-prefix-command 'aj-web-service-map) aj-command-shortcut-map)

;; LAYOUT UI

(menu-bar-mode -1)
(scroll-bar-mode -1)
(which-function-mode t)
(global-auto-revert-mode t)
(diminish 'auto-revert-mode)
(electric-indent-mode t)
(electric-pair-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(global-prettify-symbols-mode t)
(global-hl-line-mode t)
(pending-delete-mode t)
(blink-cursor-mode -1)

;; Global variables

(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq byte-compile-warnings nil)

;; no startup screen,
;; no scratch message and short
;; Yes/No questions.

(setq ring-bell-function #'ignore
      inhibit-startup-screen t
      initial-scratch-message "Hello there!\n")
(fset 'yes-or-no-p #'y-or-n-p)


;; Opt out from the startup message in the echo area

(fset 'display-startup-echo-area-message #'ignore)

;; Hydra

(use-package hydra
  :config
  (setq hydra-verbose nil))

;; Nyan cats

(use-package nyan-mode
  :init (nyan-mode))

;; THEME

(use-package flatland-black-theme
  :init
  (progn
    (load-theme 'flatland-black :no-confirm)
    (setf frame-background-mode 'dark)
    (custom-set-faces
     '(highlight               ((t :foreground nil  :background "#333333"))))

    (global-hl-line-mode 1)))

;; FONT

(set-face-attribute 'default nil
                    :family "hack"
		    :height 130)
(set-face-attribute 'variable-pitch nil)

;; Magit

(use-package magit)

;; Company

(use-package company
  :diminish 'company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-moden)))

;; Flycheck

(use-package flycheck
  :init (global-flycheck-mode))
  

(use-package flycheck-rust
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))
  
;; YaSnippet

(use-package yasnippet
  :diminish 'yas-minor-mode
  :config
  (yas-global-mode 1)
  (bind-key "C-?" #'yas-expand yas-minor-mode-map)
  (use-package auto-yasnippet
    :config
    (bind-key "s-x a c" #'aya-create yas-minor-mode-map)
    (bind-key "s-x a e" #'aya-expand yas-minor-mode-map)))

;; Indentation

(use-package aggressive-indent
  :commands (aggressive-indent-mode)
  :config
  (global-aggressive-indent-mode t))


;; EDITING UTIILITIES

;; Whitespace

(use-package shrink-whitespace
  :commands (shrink-whitespace)
  :bind ("M-SPC" . shrink-whitespace))

(use-package whitespace-cleanup-mode
  :diminish whitespace-cleanup-mode)
  :init (global-whitespace-cleanup-mode)

;; PROGRAMMING LANGUAGES

;;; Rust

(use-package rust-mode
  :config
  (use-package cargo :diminish cargo-mode))

;; Python

(use-package python-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (flatland-black)))
 '(custom-safe-themes
   (quote
    ("54449a089fc2f95f99ebc9b9b6067c802532fd50097cf44c46a53b4437d5c6cc" default)))
 '(package-selected-packages
   (quote
    (hydra magit racer auto-yasnippet yasnippet aggressive-indent use-package shrink-whitespace python-mode nyan-mode flycheck-rust flycheck-package flycheck-mypy flycheck-inline flycheck-clangcheck flatland-black-theme diminish company-quickhelp company-emoji cargo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t :foreground nil :background "#333333"))))
