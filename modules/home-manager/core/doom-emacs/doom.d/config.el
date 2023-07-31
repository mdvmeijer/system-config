(setq user-full-name "mdvmeijer"
      user-mail-address "mdvmeijer@protonmail.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16))

(setq display-line-numbers-type 'relative)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;;Org configuration
(after! org
  ;(setq org-hide-emphasis-markers t)
  (setq org-link-descriptive t)
  (setq org-pretty-entities t)
  (setq org-hidden-keywords t))

;;Set org-mode to mixed-pitch to enable Sans-font
(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;;(add-hook! 'org-mode-hook #'solaire-mode) ;;Might not be required

;;Required for setting font-size of mixed-pitch
(after! mixed-pitch
  (setq mixed-pitch-set-height t)
  (setq mixed-pitch-variable-pitch-cursor nil))
;;Would be good to set font-size inside org src-blocks.
