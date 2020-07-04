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



(use-package! lsp-julia
  :config
  (add-hook 'julia-mode-hook #'lsp)
  ; (setq lsp-julia-default-environment "~/.julia/environments/v1.3")
  (setq lsp-folding-range-limit 100)
  (setq lsp-julia-package-dir nil)
  ; (setq lsp-julia-flags '("--project=/Users/gtrun/.julia/packages/languageserver"  "--startup-file=no" "--history-file=no"))
  )


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


(defun roots-theme ()
  (interactive)
  (set-frame-font (font-spec :family "CozetteVector" :size 20))
  (load-theme 'doom-nord-light)
  (setq fancy-splash-image "~/Drive/Org/logos/gnuvm.png" )
  (+doom-dashboard-reload t))


(defun slick-theme ()
  (interactive)
  (set-frame-font  (font-spec :family "Cascadia Code" :size 18))
  (load-theme 'doom-gruvbox-light)
  (setq fancy-splash-image (random-choice
                          '("~/Drive/Org/logos/gnu2.png"
                            "~/Drive/Org/logos/ggnu.png")))
  (+doom-dashboard-reload t))





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


(defun query-google-scholar (query)
"Google scholar the QUERY.
Based on doi-utils-google-scholar."
  (interactive "sQUERY: ")
  (let ((q (string-join (split-string query) "+")))
  (browse-url
   (format
    "http://scholar.google.com/scholar?q=%s" q))))


(map! "C-c b h" #'helm-bibtex
      "C-c b o" #'orb-note-actions
      "C-c b l" #'crossref-lookup
      "C-c b g" #'query-google-scholar
      "C-c e c" #'comment-region
      "C-c e u" #'uncomment-region
      "C-c e a" #'org-fc-hydra-type/body
      "C-c o o" #'olivetti-mode
      "C-c d d" #'+doom-dashboard/open
      "C-c D"  #'er-delete-file-and-buffer
      "C-c s p" #'+ivy/project-search
      "C-c s o" #'+lookup/online
      "C-c r e t" #'+eshell/toggle
      "C-c r e h" #'+eshell/here
      "C-c r h"  #'helm-run-external-command
      "C-c t r" #'roots-theme
      "C-c t s" #'slick-theme
      )


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
;;  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
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



(use-package! org-fc
  :load-path "~/Drive/org-fc"
  :custom
  (org-fc-directories '("~/Drive/Org/org-roam"))
  :config
  (require 'org-fc-hydra))



(use-package! outshine
  :hook (julia-mode . outshine-mode)
  )
