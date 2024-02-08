(setq user-full-name "mdvmeijer"
      user-mail-address "mdvmeijer@protonmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "PT Serif" :size 20))

(setq display-line-numbers-type 'relative)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; Org configuration
;; Must be set before org loads!
(setq org-directory "~/06-org/")

(after! org
  ;(setq org-hide-emphasis-markers t)
  (setq org-link-descriptive t)
  (setq org-pretty-entities t)
  (setq org-hidden-keywords t))
  (setq org-log-done 'time)
  (setq org-ellipsis " ▼ ")

(with-eval-after-load 'org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆"))
  (setq org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦))) ; changes +/- symbols in item lists
)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/01-personal/01-MAIN")

(after! org
  (setq org-agenda-files '("~/06-org/agenda"))
  (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "BDAY(y)"
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(setq org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

;;Set org-mode to mixed-pitch to enable Sans-font
(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;;(add-hook! 'org-mode-hook #'solaire-mode) ;;Might not be required

;;Required for setting font-size of mixed-pitch
(after! mixed-pitch
  (setq mixed-pitch-set-height t)
  (setq mixed-pitch-variable-pitch-cursor nil))
;;Would be good to set font-size inside org src-blocks.

;;By default, rapidly typing 'jk' while in insert mode exits insert mode.
;;I don't want that lol
(after! evil
  (setq evil-escape-key-sequence nil))
