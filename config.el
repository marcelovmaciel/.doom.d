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
(defun roots-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 18")
;;   (set-frame-font (font-spec :family "CozetteVector" :size 20))
  (load-theme 'acme)
  (setq fancy-splash-image "~/Drive/Org/logos/automata4.png" )
  (doom-modeline-mode 1)
  ;; (doom-enable-line-numbers-h)
  (+doom-dashboard-reload t))


(defun mypoet-theme ()
  (interactive)
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130)
  (set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono")
  (set-face-attribute 'variable-pitch nil :family "IBM Plex Serif")
  (set-frame-font  (font-spec :family "DejaVu Sans Mono" :size 18))
  (load-theme 'poet)
  (setq fancy-splash-image (random-choice
                          '("~/Drive/Org/logos/gnu2.png"
                            "~/Drive/Org/logos/ggnu.png")))
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (doom/reload-theme)
  (+doom-dashboard-reload t))

(defun mypoet-mono-theme ()
  (interactive)
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130)
  (set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono")
  (set-face-attribute 'variable-pitch nil :family "IBM Plex Serif")
  (set-frame-font  (font-spec :family "DejaVu Sans Mono" :size 18))
  (load-theme 'poet-monochrome)
  (setq fancy-splash-image (random-choice
                          '("~/Drive/Org/logos/gnu2.png"
                            "~/Drive/Org/logos/ggnu.png")))
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (doom/reload-theme)
  (+doom-dashboard-reload t))

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



(defun prog-theme ()
  (interactive)
  (set-face-font 'default "JuliaMono Bold 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-challenger-deep)
  (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
  (doom-modeline-mode 1)
  ;;(doom-enable-line-numbers-h)
  (+doom-dashboard-reload t) )


(defun nord-theme ()
  (interactive)
  (set-face-font 'default "Cascadia Code 18" )
  ;; (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-nord)
  (setq fancy-splash-image  "~/Drive/Org/logos/dreamcast.png")
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
  (shell-command "nautilus .")
)

(defun black-theme ()
  (interactive)
  (load-theme 'less-black)
  (set-face-font 'default "Roboto Mono Medium 17")
 ;; (random-choice
 ;;                          '("~/Drive/Org/logos/gnu2.png"
 ;;                            "~/Drive/Org/logos/ggnu.png"))
  (setq fancy-splash-image '"~/Drive/Org/logos/quenya-2.png" )
  (doom-modeline-mode -1)
  (doom-disable-line-numbers-h)
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
"Google scholar the QUERY.
Based on doi-utils-google-scholar."
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
      "C-c o o" #'olivetti-mode
      "C-c d d" #'+doom-dashboard/open
      "C-c D"  #'er-delete-file-and-buffer
      "C-c s p" #'+ivy/project-search
      "C-c s o" #'+lookup/online
      "C-c s d" #'+lookup/dictionary-definition
      "C-c r e t" #'+eshell/toggle
      "C-c r e h" #'+eshell/here
      "C-c r h"  #'helm-run-external-command
      "C-c t r" #'roots-theme
      "C-c t s" #'slick-theme
      "C-c t e" #'elegant-theme
      "C-c t p" #'prog-theme
      "C-c t b" #'black-theme
      "C-c t z" #'snazzy-theme
      "C-c t n" #'nord-theme
      "C-c t l" #'mypoet-theme
      "C-c t m" #'mypoet-mono-theme
      "C-c f b g" #'ispell-buffer
      "C-c f d" #'ispell-change-dictionary
      "C-c f b s" #'langtool-check
      "C-c f b d" #'langtool-check-done
      "C-c f p" #'proselint
      "C-c s a p" #'academic-phrases
      "C-c s a s" #'academic-phrases-by-section
      "C-c s s s" #'swiper
      "C-c s s m" #'swiper-multi
      "C-c s s i" #'swiper-isearch
      "C-c s s a" #'swiper-all
      "C-c g g" #'magit-status
      "C-c e l" #'mc/edit-lines
      "C-c e m" #'mc/mark-all-in-region
      "C-c C-<mouse-1>" #'mc/add-cursor-on-click
      "C-c o h" #'outline-hide-body
      "C-c o a d" #'org-day
      "C-c o a w" #'org-week
      "C-c o T" #'display-time-mode
 )


(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g w") 'avy-goto-char-2)

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

(use-package! magit-org-todos
  :config
  (magit-org-todos-autoinsert))


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

;; (use-package mathpix.el
;;   :custom ((mathpix-app-id "marcelovmaciel@gmail.com")
;;            (mathpix-app-key "76Xrgm2HKGTZxbj"))
;;   :bind
;;   ("C-x m" . mathpix-screenshot))


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

;; fixing annoying snippet behavior
;; https://stackoverflow.com/questions/7619640/emacs-latex-yasnippet-why-are-newlines-inserted-after-a-snippet
;; (setq mode-require-final-newline nil)
;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :custom-face
;;   (org-super-agenda-header ((default (:inherit propositum-agenda-heading))))

;;   :init
;;   (setq org-agenda-skip-scheduled-if-done t
;;       org-agenda-skip-deadline-if-done t
;;       org-agenda-include-deadlines t
;;       org-agenda-block-separator nil
;;       org-agenda-compact-blocks t
;;       org-agenda-start-day nil ;; i.e. today
;;       org-agenda-span 1
;;       org-agenda-start-on-weekday nil)
;;   (setq org-agenda-custom-commands
;;         '(("c" "Super view"
;;            ((agenda "" ((org-agenda-overriding-header "")
;;                         (org-super-agenda-groups
;;                          '((:name "Today"
;;                                   :time-grid t
;;                                   :date today
;;                                   :order 1)))))
;;             (alltodo "" ((org-agenda-overriding-header "")
;;                          (org-super-agenda-groups
;;                           '((:log t)
;;                             (:name #(" due this week\n" 0 1 (rear-nonsticky t display (raise -0.24) font-lock-face (:family "Material Icons" :height 1.2) face (:family "Material Icons" :height 1.2)))
;;                                    :deadline past)
;;                             (:name "Important"
;;                                    :priority "A"
;;                                    :order 6)
;;                             (:name "Due soon"
;;                                    :deadline future)
;;                             (:name "Due Today"
;;                                    :deadline today
;;                                    :order 2)
;;                             (:name "Scheduled Soon"
;;                                    :scheduled future
;;                                    :order 8)
;;                             (:name "Overdue"
;;                                    :deadline past
;;                                    :order 7)
;;                             (:name "Meetings"
;;                                    :and (:todo "MEET" :scheduled future)
;;                                    :order 10)
;;                             (:discard (:not (:todo "TODO")))))))))))
;;   :config
;;   (org-super-agenda-mode))

; (setq lsp-haskell-process-path-hie  "haskell-language-server-wrapper")
;; (setq lsp-haskell-server-path "~/.ghcup/bin/haskell-language-server-wrapper-1.0.0")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#f2e5bc" "#99324B" "#4F894C" "#9A7500" "#3B6EA8" "#97365B" "#398EAC" "#3B4252"])
 '(custom-safe-themes
   (quote
    ("ed4913967eddeccb37cfff93ea99fa4aa1401dfc578929ad49855fedaaf2bc7d" "d4028cb4bef9868c69332d37cfbbed72bfd039e9f478f15207c8e85ac7b0869a" "9b272154fb77a926f52f2756ed5872877ad8d73d018a426d44c6083d1ed972b1" "1623aa627fecd5877246f48199b8e2856647c99c6acdab506173f9bb8b0a41ac" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "893eb2887d8e59f6dde92c217801d310f8dacaefa3bf071b27f7bbb1deaa70b2" "0cb1b0ea66b145ad9b9e34c850ea8e842c4c4c83abe04e37455a1ef4cc5b8791" "6177ecbffb8f37756012c9ee9fd73fc043520836d254397566e37c6204118852" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "93ed23c504b202cf96ee591138b0012c295338f38046a1f3c14522d4a64d7308" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" default)))
 '(fci-rule-color "#AEBACF")
 '(jdee-db-active-breakpoint-face-colors (cons "#F0F4FC" "#5d86b6"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#F0F4FC" "#4F894C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#F0F4FC" "#B8C5DB"))
 '(objed-cursor-color "#99324B")
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
 '(vc-annotate-background "#E5E9F0")
 '(vc-annotate-color-map
   (list
    (cons 20 "#4F894C")
    (cons 40 "#688232")
    (cons 60 "#817b19")
    (cons 80 "#9A7500")
    (cons 100 "#a0640c")
    (cons 120 "#a65419")
    (cons 140 "#AC4426")
    (cons 160 "#a53f37")
    (cons 180 "#9e3a49")
    (cons 200 "#97365B")
    (cons 220 "#973455")
    (cons 240 "#983350")
    (cons 260 "#99324B")
    (cons 280 "#a0566f")
    (cons 300 "#a87b93")
    (cons 320 "#b0a0b6")
    (cons 340 "#AEBACF")
p    (cons 360 "#AEBACF")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
