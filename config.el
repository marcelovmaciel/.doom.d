;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcelo Veloso Maciel"
      user-mail-address "marcelovmaciel@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Cascadia Code" :size 18))
;; (setq doom-font (font-spec :family "CozetteVector" :size 19))
;; (setq doom-font (font-spec :family "Source Code Pro" :size 19))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Drive/Org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(use-package! org-roam
  :init
  (setq org-roam-directory "~/Drive/Org/org-roam-mvm")

  (require 'org-roam-protocol))

(use-package! org-roam-protocol
  :after org-protocol)



; (setq org-roam-db-location "~/Drive/Org/org-roam")
; (require 'org-roam-protocol)

; (require 'company-org-roam)

;; (use-package! company-org-roam
;;   :when (featurep! :completion company)
;;   :after org-roam
;;   :config
;;   (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))


(use-package!  eglot-jl
  :config
   ; (add-hook 'julia-mode-hook . #'eglot)
  ; (eglot-jl-init)
  (with-eval-after-load 'eglot
  (eglot-jl-init))
  )

(load "~/.doom.d/scihub.el" )
(load  "~/.doom.d/latex-wrap.el")
;; (use-package! lsp-julia
;;   :config
;;   (add-hook 'julia-mode-hook #'lsp)
;;   ; (setq lsp-julia-default-environment "~/.julia/environments/v1.3")
;;   (setq lsp-folding-range-limit 100)
;;   (setq lsp-julia-package-dir nil)
;;   ; (setq lsp-julia-flags '("--project=/Users/gtrun/.julia/packages/languageserver"  "--startup-file=no" "--history-file=no"))
;;   )


(use-package! company-lsp
    :after company-mode
    :config
    (push 'company-lsp company-backends)
    (setq company-lsp-async t
          company-lsp-cache-candidates 'auto
          company-lsp-enable-recompletion t)
    )


 ;; (use-package! company-quickhelp
 ;;    :defines company-quickhelp-delay
 ;;    :bind (:map company-active-map
 ;;                ([remap company-show-doc-buffer] . company-quickhelp-manual-begin))
 ;;    :hook (global-company-mode . company-quickhelp-mode)
 ;;    :init (setq company-quickhelp-delay 0.5))


;; (use-package company-box
;;   :after company
;;   :diminish
;;   :hook (company-mode . company-box-mode))


;; (after! company
;;   (setq company-idle-delay 0.5
;;         company-minimum-prefix-length 2
;;         company-transformers nil)
;;   (setq company-show-numbers t)
;;   (define-key company-active-map (kbd "C-p") 'company-select-previous)
;;   (define-key company-active-map (kbd "C-n") 'company-select-next))


(setq org-journal-dir "~/Drive/Org/journal")
(global-page-break-lines-mode 1 )

(setq julia-url "https://docs.julialang.org")


(grep-apply-setting
   'grep-find-command
   '("rg -n -H --no-heading -e '' $(git rev-parse --show-toplevel || pwd)" . 27)
 )


(defun docs-julia ()
  "open julia docs on browser"
  (interactive)
  (browse-url-firefox julia-url))

(org-babel-do-load-languages 'org-babel-load-languages
                             (append org-babel-load-languages
                              '((julia     . t)
                                )))
(font-lock-add-keywords 'org-mode
                    '(("\\(src_\\)\\([^[{]+\\)\\(\\[:.*\\]\\){\\([^}]*\\)}"
                       (1 '(:foreground "black" :weight 'normal :height 10)) ; src_ part
                       (2 '(:foreground "cyan" :weight 'bold :height 75 :underline "red")) ; "lang" part.
                       (3 '(:foreground "#555555" :height 70)) ; [:header arguments] part.
                       (4 'org-code) ; "code..." part.
                       )))

(defun org-day ()
  (interactive)
  (progn (org-agenda)
         (org-agenda-day-view)))

(defun slick-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-gruvbox-light)
  (setq fancy-splash-image (random-choice
                          '("~/Drive/Org/logos/gnu2.png"
                            "~/Drive/Org/logos/ggnu.png")))
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t))

(defun snazzy-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-snazzy)
  (setq fancy-splash-image "~/Drive/Org/logos/automata4.png")  
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )

(defhydra hydra-window (global-map "<f3>")
  "change window size"
  ("l" enlarge-window-horizontally "enlarge h")
  ("u" enlarge-window "enlarge v")
  ("r" shrink-window-horizontally "shrink h")
  ("s" shrink-window "shrink v") )


(defun prog-theme ()
  (interactive)
  (set-face-font 'default "JuliaMono 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))

  (load-theme 'doom-rouge)
  (setq fancy-splash-image  "~/Drive/Org/logos/redcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )



(defun one-theme ()
  (interactive)
  (set-face-font 'default "RobotoMono Medium 16" )

  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-one-light)
  (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )


(defun rebecca-theme ()
  (interactive)
  (set-face-font 'default "JuliaMono Bold 18" )
    ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))


  (load-theme 'rebecca)
   ; (add-hook 'minibuffer-setup-hook ')
  ;; (add-hook 'minibuffer-setup-hook
  ;;     (lambda ()
  ;;       (make-local-variable 'face-remapping-alist)
  ;;       (add-to-list 'face-remapping-alist '(default (:background "grey10")))))
(setq ivy-display-style 'fancy)
    (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  ;;
  (+doom-dashboard-reload t))


(defun cyberpunk-theme ()
  (interactive)
  (set-face-font 'default "JuliaMono Bold 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'cyberpunk-2019)
  (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t)
 '(mode-line ((t (:foreground "#fafafa" :background "DarkOrange" :box nil))))
 '(mode-line-inactive ((t (:foreground "#fafafa" :background "#666666" :box nil))))
  )

(setq bibtex-completion-find-additional-pdfs t)
(defun nord-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-nord-light)
  (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )

(defun chocolate-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 16" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'chocolate)
  (setq fancy-splash-image  "~/Drive/Org/logos/automata4.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )

(load "~/Drive/less-theme-master/less-theme.el")

(defun elegant-theme ()
  (interactive)
  (load-theme 'less)
  (set-face-font 'default "Roboto Mono Medium 17")
 ;; (random-choice
 ;;                          '("~/Drive/Org/logos/gnu2.png"
 ;;                            "~/Drive/Org/logos/ggnu.png"))
  (setq fancy-splash-image '"~/Drive/Org/logos/quenya.png" )
  (doom-modeline-mode -1)
  (doom-disable-line-numbers-h)
  (+doom-dashboard-reload t)
  )

(defun nautilus-here ()
  (interactive)
  (async-shell-command "nautilus .")
)

(defun vscode-here ()
  (interactive)
  (async-shell-command "code .")
)


(defun black-theme ()
  (interactive)
  (load-theme 'doom-plain-dark)
  ;; (set-face-font 'default "Roboto Mono Medium 17")
   (set-face-font 'default "Julia Mono 17")
 ;; (random-choice
 ;;                          '("~/Drive/Org/logos/gnu2.png"
 ;;                            "~/Drive/Org/logos/ggnu.png"))
  (setq fancy-splash-image '"~/Drive/Org/logos/logo.png" )
    (doom-modeline-mode -1)
    (doom-disable-line-numbers-h)
    (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
  (+doom-dashboard-reload t)
  )

;; (require 'disp-table)

;; (require 'nano-theme-light)
;; (require 'nano-modeline)
;; (require 'nano-help)
;; (require 'nano-layout)
;; (setq doom-theme 'nil)

(defun er-delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))


(defun get-alarm (query)

  (interactive "sDayWhitespaceHour: ")

  (let ((al (format "alarm -s %s  /home/mvmaciel/alarm/sounds/xylophone.mp3" query)))
    (kill-new al)
    (print al)))



(defun query-google-scholar (query)
"Google scholar the QUERY.
Based on doi-utils-google-scholar."
  (interactive "sQUERY: ")
  (let ((q (string-join (split-string query) "+")))
    (browse-url
   (format
    "http://scholar.google.com/scholar?q=%s" q))))

(defun query-wordnik (query)
  (interactive "sQUERY: ")
  (let ((q (string-join (split-string query) "+")))
    (browse-url
   (format
    "https://www.wordnik.com/words/%s" q))))



(flycheck-define-checker proselint
  "A linter for prose."
  :command ("proselint" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (id (one-or-more (not (any " "))))
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode latex-mode))
(add-to-list 'flycheck-checkers 'proselint)

(defun proselint ()
  (interactive)
  (flycheck-mode)
  (flycheck-select-checker 'proselint)
  (list-flycheck-errors))
(defun pdf-view--rotate (&optional counterclockwise-p page-p)
  "Rotate PDF 90 degrees.  Requires pdftk to work.\n
Clockwise rotation is the default; set COUNTERCLOCKWISE-P to
non-nil for the other direction.  Rotate the whole document by
default; set PAGE-P to non-nil to rotate only the current page.
\nWARNING: overwrites the original file, so be careful!"
  ;; error out when pdftk is not installed
  (if (null (executable-find "pdftk"))
      (error "Rotation requires pdftk")
    ;; only rotate in pdf-view-mode
    (when (eq major-mode 'pdf-view-mode)
      (let* ((rotate (if counterclockwise-p "left" "right"))
             (file   (format "\"%s\"" (pdf-view-buffer-file-name)))
             (page   (pdf-view-current-page))
             (pages  (cond ((not page-p)                        ; whole doc?
                            (format "1-end%s" rotate))
                           ((= page 1)                          ; first page?
                            (format "%d%s %d-end"
                                    page rotate (1+ page)))
                           ((= page (pdf-info-number-of-pages)) ; last page?
                            (format "1-%d %d%s"
                                    (1- page) page rotate))
                           (t                                   ; interior page?
                            (format "1-%d %d%s %d-end"
                                    (1- page) page rotate (1+ page))))))
        ;; empty string if it worked
        (if (string= "" (shell-command-to-string
                         (format (concat "pdftk %s cat %s "
                                         "output %s.NEW "
                                         "&& mv %s.NEW %s")
                                 file pages file file file)))
            (pdf-view-revert-buffer nil t)
          (error "Rotation error!"))))))

(defun pdf-view-rotate-clockwise (&optional arg)
  "Rotate PDF page 90 degrees clockwise.  With prefix ARG, rotate
entire document."
  (interactive "P")
  (pdf-view--rotate nil (not arg)))

(defun pdf-view-rotate-counterclockwise (&optional arg)
  "Rotate PDF page 90 degrees counterclockwise.  With prefix ARG,
rotate entire document."
  (interactive "P")
  (pdf-view--rotate :counterclockwise (not arg)))


(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%S" value))))



(map! "C-c b h" #'helm-bibtex
      "C-c b o" #'orb-note-actions
      "C-c l s" #'org-store-link
      "C-c l i" #'org-insert-link
      "C-c b l" #'crossref-lookup
      "C-c b w" #'query-wordnik
      "C-c b g" #'query-google-scholar
      "C-c n" #'nautilus-here
      "C-c e c" #'comment-region
      "C-c e u" #'uncomment-region
      "C-c e a" #'org-fc-hydra-type/body
      "C-c e s" #'org-edit-latex-fragment
      "C-c o o" #'olivetti-mode
      "C-c d d" #'+doom-dashboard/open
      "C-c D"  #'er-delete-file-and-buffer
      "C-c s p" #'counsel-rg
      "C-c s o" #'+lookup/online
      "C-c s d" #'+lookup/dictionary-definition
      "C-c r e t" #'+eshell/toggle
      "C-c r e h" #'+eshell/here
      "C-c r h"  #'helm-run-external-command
      "C-c t s" #'slick-theme
      "C-c t e" #'elegant-theme
      "C-c t p" #'prog-theme
      "C-c t c r" #'rebecca-theme
      "C-c t c y" #'cyberpunk-theme
      "C-c t c c" #'chocolate-theme
      "C-c t b" #'black-theme
      "C-c t z" #'snazzy-theme
      "C-c t n" #'nord-theme
      "C-c t o" #'one-theme
      "C-c f b g" #'ispell-buffer
      "C-c f d" #'ispell-change-dictionary
      "C-c f b s" #'langtool-check
      "C-c f b d" #'langtool-check-done
      "C-c f p" #'proselint
      "C-c s a p" #'academic-phrases
      "C-c s a s" #'academic-phrases-by-section
      "C-c s c u" #'company-math-symbols-unicode
      "C-c s c l" #'company-math-symbols-latex
      "C-c s s s" #'swiper
      "C-c s s m" #'swiper-multi
      "C-c s s i" #'swiper-isearch
      "C-c s s a" #'swiper-all
      "C-c g g" #'magit-status
      "C-c e l" #'mc/edit-lines
      "C-c g l" #'avy-goto-line
      "C-c g w 0" #'avy-goto-word-0
      "C-c g w 1 " #'avy-goto-word-1
      "C-c g c 1" #'avy-goto-char
      "C-c g c 2 " #'avy-goto-char-2
      "C-c e m" #'mc/mark-all-in-region
      "C-c C-<mouse-1>" #'mc/add-cursor-on-click
      "C-c o h" #'outline-hide-body
      "C-c o a d" #'org-day
      "C-c o a w" #'org-week
      "C-c o T" #'display-time-mode
      "C-c o r" #'evil-ex-resize
      "C-x x" #'eval-and-replace
      "C-c o s" #'org-roam-server-open
      "C-x C-g" #'grep-find
 )


(defvar rascunho-path "~/Drive/Org/other")
(setq flycheck-global-modes nil)


(set-register ?a (cons 'file "~/Drive/Org/agenda/week-agenda.org"))
(set-register ?f
              (cons 'file "~/Drive/Org/org-roam-mvm/20200520213408-my_project_ideas.org"))
(set-register ?g (cons 'file "~/Drive/Org/Projects/gtd-inbox.org"))

(set-register ?q (cons 'file "~/Drive/Org/org-roam-mvm/20200703013409-questions_for_reading.org"))
(set-register ?p (cons 'file "~/Drive/Org/Projects/focus.org"))

(set-register ?b (cons 'file "~/Drive/Org/bib/refs.bib"))


(setq langtool-language-tool-jar   "/snap/languagetool/24/usr/bin/languagetool-commandline.jar")

(use-package! org-cliplink
  :after org
    :bind (("C-c e p" . org-cliplink)))


(use-package! deft
    :commands deft
    :init

    (setq deft-directory "~/Drive/Org/org-roam-mvm"
          deft-default-extension "org"
          ;; de-couples filename and note title:
          deft-use-filename-as-title nil
          deft-use-filter-string-for-filename t
          ;; disable auto-save
          deft-auto-save-interval -1.0
          ;; converts the filter string into a readable file-name using kebab-case:
          deft-file-naming-rules
          '((noslash . "-")
            (nospace . "-")
            (case-fn . downcase)))
    :config
    (add-to-list 'deft-extensions "tex")
    )

(use-package! peep-dired
  :ensure t
  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired)))

;; (use-package! magit-org-todos
  ;;; n:config
  ;; (magit-org-todos-autoinsert))


 (use-package!  all-the-icons-dired
    :hook   (dired-mode .   all-the-icons-dired-mode)
    :config (all-the-icons-dired-mode 1)
    )

;; (use-package! lsp-haskell
;;  :ensure t
;;  :config
; ;  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
;;  (setq lsp-haskell-process-path-hie "~/Documents/Work/Projects/foobar/ghcide")
;;  (setq lsp-haskell-process-args-hie '())
;;  (setq lsp-haskell-process-path-hie "hie-wrapper")
;; Comment/uncomment this line to see interactions between lsp client/server.
;;  (setq lsp-log-io t)
;; )


(use-package! org-download
  :hook (dired-mode . org-download-enable)
  :init
  (setq-default org-download-image-dir "~/Drive/Org/imgs")
  )

(add-hook! text-mode (ispell-minor-mode))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "ROUTINE(r)" "WAITING(w)" "|" "CANCELLED(c)")
              (sequence "[ ]" "[-]" "[?]" "|" "[X]"))))
(setq org-agenda-prefix-format '((agenda . " %i %?-12t% s")
                                 (todo . " %i ")
                                 (tags . " %i ")
                                 (search . " %i ")))
(setq-default org-export-with-todo-keywords nil)
(setq-default org-enforce-todo-dependencies t)
(setq org-agenda-custom-commands
      '(("z" "Marcelo view"
         ((agenda "" ((org-super-agenda-groups
                       '((:auto-category t)))))))))

(add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

(add-hook! julia-mode (rainbow-delimiters-mode-enable))

(setq org-journal-enable-agenda-integration t)

(setq
 bibtex-completion-notes-path "~/Drive/Org/org-roam-mvm"
 bibtex-completion-bibliography "~/Drive/Org/bib/refs.bib"
 bibtex-completion-library-path "~/Drive/Org/pdfs"
  bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journal}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )


(use-package! org-ref
  :config
  (setq
 ; org-ref-completion-library 'org-ref-ivy-bibtex
 org-ref-default-bibliography (list "~/Drive/Org/bib/refs.bib")
 org-ref-pdf-directory "~/Drive/Org/pdfs"
 org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
 org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
 org-ref-notes-directory "~/Drive/Org/org-roam-mvm"
 org-ref-notes-function 'orb-edit-notes
 )
)


;; (use-package! nroam
;;   :after org-roam
;;   :config
;;   (add-hook 'org-mode-hook #'nroam-setup-maybe)

;;   )



(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq org-roam-bibtex-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

           :unnarrowed t))))

(setq bibtex-dialect 'BibTeX)
(setq bibtex-maintain-sorted-entries t)


; (use-package! org-transclusion
;   :load-path "~/Drive/Org/org-transclusion" )


(use-package! org-fc
  :load-path "~/Drive/org-fc"
  :custom
  (org-fc-directories '("~/Drive/Org/org-roam-mvm"))
  :config
  (require 'org-fc-hydra))

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :load-path "~/Drive/Org/org-mind-map/"
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )



(map! :after julia-mode
      :map julia-mode-map
      "C-c s l" #'julia-repl-send-line
      "C-c s r" #'julia-repl-send-region-or-line
      "C-c s b" #'julia-repl-send-buffer
      "C-c g d" #'xref-find-definitions
      "C-c g D" #'eglot-find-declaration
      "C-c e r" #'eglot-rename
      )

(use-package! org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(defun org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (smartparens-global-mode -1)
    (org-roam-server-mode 1)
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))
    (smartparens-global-mode 1))

(use-package! outshine
  :hook (julia-mode . outshine-mode)
  :hook (haskell-mode . outshine-mode)
  )

(use-package! psc-ide
  :hook (purescript-mode .
                         '((psc-ide-mode)
                           (company-mode)
                           (flycheck-mode)
                           (turn-on-purescript-indentation))))

(setq org-use-property-inheritance nil)


(setq org-tag-alist '((:startgroup . nil)
                      ("@task" . ?t)
                      ("@habit" . ?h)
                      ("@appt" . ?a)
                      ("@prjct" . ?p)
                      (:endgroup . nil)
                      ))

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
(setq lsp-enable-folding t)
(setq lsp-folding-range-limit 1000)

(defvar eshell-modules-list
  '(eshell-alias
    eshell-banner
    eshell-basic
    eshell-cmpl
    eshell-dirs
    eshell-glob
    eshell-hist
    eshell-ls
    eshell-pred
    eshell-prompt
    eshell-script
    eshell-term
    eshell-unix))
(setq lsp-enable-folding t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(org-agenda-files
   (quote
    ("~/Drive/Org/Projects/nature-computation/todo.org" "~/Drive/Org/Projects/focus.org" "~/Drive/Org/org-roam-mvm/20200520213408-my_project_ideas.org" "~/Drive/Org/agenda/week-agenda.org")))
 '(org-agenda-sorting-strategy
   (quote
    ((agenda habit-down time-up priority-down category-keep)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep))))
 '(org-fc-directories (quote ("~/Drive/Org/org-roam-mvm")))
 '(package-selected-packages (quote (org-mind-map)))
 '(pdf-view-midnight-colors (cons "#3B4252" "#E5E9F0"))
 '(rustic-ansi-faces
   ["#E5E9F0" "#99324B" "#4F894C" "#9A7500" "#3B6EA8" "#97365B" "#398EAC" "#3B4252"])
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
