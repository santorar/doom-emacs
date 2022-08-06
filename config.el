;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "santorar"
      user-mail-address "santorar@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; Fonts
(setq doom-font (font-spec :family "FantasqueSansMono Nerd Font" :size 14 )
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16)
     doom-big-font (font-spec :family "FantasqueSansMono Nerd Font" :size 18))
;; Themes
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

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
;; beacon to hightlight on scroll
(beacon-mode 1)
;; ;; list of bookmarks and save bookmarks
(map! :leader
      (:prefix ("b". "buffer")
      :desc "List bookmarks" "L" #'list-bookmarks
      :desc "Save current bookmarks file" "w" #'bookmark-save))
;; scroll offset
(setq scroll-margin 5)
;; personal keybindings
(map! :leader :desc "Open a terminal" "\\" #'+vterm/toggle )
;; buffer and window movement
(map! :n "C-h" #'evil-window-left )
(map! :n "C-j" #'evil-window-down )
(map! :n "C-k" #'evil-window-up )
(map! :n "C-l" #'evil-window-right )
(map!  :after libvterm "C-S-v" #'evil-paste-after )
(map! "C-s" #'save-buffer)
(map!  (:after evil
        :m "H" #'centaur-tabs-backward ))
(map! (:after evil
       :m "L" #'centaur-tabs-forward))

;; global autorevert for files modified by other programms
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
;; Tabs
(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 20
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs globally" "t t" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t T" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map (kbd "S-l") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                               (kbd "S-h")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                               (kbd "g t j")  'centaur-tabs-forward-group
                                               (kbd "g t k")    'centaur-tabs-backward-group)

;; clippy describe
(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
       :desc "Clippy describes function under point" "f" #'clippy-describe-function
       :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

;; dired configuration
(map! :leader
      (:prefix ("f")
      :desc "Jump to current directory in dired" "j" #'dired-jump))
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
;; modeline config
(set-face-attribute 'mode-line nil :font "UbuntuMono Nerd Font-13")
(setq doom-modeline-height 20     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

;; treemacs config
(map! "C-n" #'+treemacs/toggle )
(setq treemacs-width 25
      treemacs-text-scale -2)

(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))

;; modline

(setq doom-modeline-height 8)
(setq doom-modeline-bar-width 2)
(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)
(setq doom-modeline-buffer-modification-icon t)
(setq doom-modeline-unicode-fallback nil)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-enable-word-count nil)

;; LSP

(setq lsp-enable-symbol-highlighting t)
(setq lsp-lens-enable t)
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-modeline-code-actions-enable t)
(setq lsp-eldoc-enable-hover t)
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-signature-auto-activate t) ;; you could manually request them via `lsp-signature-activate`
(setq lsp-signature-render-documentation t)
(setq lsp-completion-show-detail t)
(setq lsp-completion-show-kind t)
(setq quickrun-focus-p nil)


