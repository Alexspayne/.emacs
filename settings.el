
;; Open this config file
(global-set-key (kbd "C-c s")
                (lambda () (interactive) (find-file "~/.emacs.d/settings.org")))

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (add-hook 'window-setup-hook 'toggle-frame-maximized t))

;; Emacs lisp files
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(setq use-package-verbose t)

(require 'use-package)

(use-package atom-one-dark-theme
  :disabled t
  :init
  (load-theme 'atom-one-dark t)
  )

(use-package aurora-theme
  :disabled t
  :init
  (load-theme 'aurora t)
  )

(use-package monokai-theme
  :init
  (load-theme 'monokai t)
  )

(use-package base16-theme
  :init
  :disabled t
  (load-theme 'base16-oceanicnext-dark t)
  )

(defun es/enable-misterioso ()
  "Load misterioso theme, but fix annoying highlighting"
  (load-theme 'misterioso t)
  (set-face-attribute 'hl-line nil
              :inherit nil
              :background "gray13"))

;; (es/enable-misterioso)

;; THEME switching stuff from Daniel Mai
(defun switch-theme (theme)
  "Disables any currently active themes and loads THEME."
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapc 'symbol-name
                                   (custom-available-themes))))))
  (let ((enabled-themes custom-enabled-themes))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)))

(defun disable-active-themes ()
  "Disables any currently active themes listed in `custom-enabled-themes'."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(bind-key "C-`" 'switch-theme)

(use-package fill-column-indicator
  :config
  (add-hook 'python-mode-hook 'fci-mode)
  (setq-default fill-column 80)
  (setq-default fci-rule-color "#546D7A"))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package fixmee
  :config
  (add-hook 'python-mode-hook 'fixmee-mode)
  )

(use-package org-bullets
:init
(setq org-bullets-bullet-list
'("◉" "◎" "⚫" "○" "►" "◇"))
:config
(setcdr org-bullets-bullet-map nil)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(use-package hydra
  :defer t
  )

(defhydra hydra-vc ()
  "vc hydra"
  ("n" git-gutter+-next-hunk  "next hunk")
  ("p" git-gutter+-previous-hunk "previous hunk")
  ("d" git-gutter+-show-hunk "show diff")
  ("r" git-gutter+-revert-hunk "revert hunk")
  ("b" magit-blame "blame")
  ("a" vc-annotate "annotate")
  ("t" git-timemachine "timemachine" :exit t)
  )

(global-set-key (kbd "<f8>") 'hydra-vc/body)

(use-package transpose-frame)

(defhydra hydra-transpose ()
  "transposing hydra"
  ("l" transpose-lines "lines")
  ("w" transpose-words "words")
  ("s" transpose-sexps "sexps")
  ("p" transpose-paragraphs "paragraphs")
  ("c" transpose-chars "characters")
  ("W" transpose-frame "windows")
  )

(global-set-key (kbd "C-t") 'hydra-transpose/body)

(defhydra hydra-modes ()
  "settings hydra"
  ("l" lisp-interaction-mode "lisp interaction" :exit t)
  ("p" python-mode "python" :exit t)
  ("o" org-mode "org" :exit t)
  ("s" sql-mysql "MySQL interaction" :exit t)
  ("x" sx-compose-mode "Stack Exhange compose" :exit t)
  ("m" gfm-mode "Markdown" :exit t)
  ("j" js2-mode "JavaScript" :exit t)
  ("w" web-mode "Web" :exit t)
  )

(global-set-key (kbd "s-M") 'hydra-modes/body)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
(setq org-hide-leading-stars t)
(add-hook 'org-mode-hook 'org-indent-mode)

;; Open .org and .txt files in org-mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

(add-hook 'org-agenda-finalize-hook
      (lambda () (remove-text-properties
         (point-min) (point-max) '(mouse-face t))))

(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'corgi-org-agenda)

(define-key org-agenda-mode-map "d" 'org-agenda-deadline)
(define-key org-agenda-mode-map "s" 'org-agenda-schedule)

;; Open this config file
(global-set-key (kbd "C-c s")
        (lambda () (interactive) (find-file "~/.emacs.d/settings.org")))

;; bindings for capture templates
(define-key global-map "\C-ci" ;inbox
  (lambda () (interactive) (org-capture nil "i")))
(define-key global-map "\C-cnn" ;new note
  (lambda () (interactive) (org-capture nil "n")))

;; allow comment region in the code edit buffer (according to language)
(defun my-org-comment-dwim (&optional arg)
  (interactive "P")
  (or (org-babel-do-key-sequence-in-edit-buffer (kbd "M-;"))
      (comment-dwim arg)))

(define-key org-mode-map
  (kbd "M-;") 'my-org-comment-dwim)

(setq org-enforce-todo-dependencies t)

;; Set to 'invisible and blocked tasks wont show up in agenda, t and they will be dimmed
(setq org-agenda-dim-blocked-tasks 'invisible)

;; Don't keep track of completed repeating tasks
(setq org-log-repeat nil)

;; Enable highlight line only for org-agenda-mode (it is annoying in other modes)
(add-hook 'org-agenda-mode-hook 'hl-line-mode)

;; Make agenda full screen without typing 'o'
(add-hook 'org-agenda-finalize-hook (lambda () (delete-other-windows)))

(defun es/skip-unless-work ()
  "Skip trees that are not waiting"
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (re-search-forward ":work:" subtree-end t)
    nil ; tag found, do not skip
      subtree-end))) ; tag not found, continue after end of subtree

;; Block agenda view for agenda and unscheduled tasks
(setq org-agenda-custom-commands
      '(("j" "Agenda and unscheduled tasks"
     ((tags-todo
       "-DEADLINE={.+}-SCHEDULED={.+}-dad-mom-beilei-someday-emacs-projects-work")
      (agenda ""))
     ((org-agenda-start-on-weekday nil)
      (org-agenda-ndays 2)
      (org-deadline-warning-days 0)))
    ("w" "Work tasks"
     ((tags-todo
       "-DEADLINE={.+}-SCHEDULED={.+}-dad-mom-beilei-someday-emacs-projects")
      (agenda ""))
     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'regexp ":home:"))
      (org-agenda-start-on-weekday nil)
      (org-agenda-ndays 1)
      (org-deadline-warning-days 0)))
    ("f" "Talking points"
         ((tags-todo "+beilei")
          (tags-todo "+mom")
          (tags-todo "+dad"))
     ((org-agenda-prefix-format "- ")
      (org-show-context-detail 'minimal)
      (org-agenda-todo-keyword-format "")))
    (";" "Someday and projects"
     ((tags-todo "+someday"))
     ((org-agenda-prefix-format "- ")
      (org-show-context-detail 'minimal)
      (org-agenda-remove-tags t)
      (org-agenda-todo-keyword-format "")))
    ("l" "Emacs"
     ((tags-todo "+emacs"))
     ((org-agenda-prefix-format "- ")
      (org-show-context-detail 'minimal)
      (org-agenda-remove-tags t)
      (org-agenda-todo-keyword-format "")))
    ("2" "Mobile tasks"
     ((tags "-DEADLINE={.+}-SCHEDULED={.+}/+TODO")
      (agenda ""))
     ((org-agenda-prefix-format "- ")
      (org-agenda-todo-keyword-format "")
      (org-agenda-start-on-weekday nil)
      (org-agenda-ndays 3)
      (org-deadline-warning-days 0))
         ("~/Dropbox/org_files/taskpaper_files/da_guai.taskpaper"))))

  (setq org-agenda-files '("~/Dropbox/org_files/da_guai.org"))

  ;; Only ask for confirmation of kills within agenda
  ;; only if TODO spans more than 2 lines
  (setq org-agenda-confirm-kill 2)

  (setq org-deadline-warning-days 3)

(setq org-capture-templates
  '(("i" "New TODO to Uncategorized TODOs" entry (file+headline
    "~/Dropbox/org_files/da_guai.org" "Uncategorized TODOs")
    "* TODO %?" :kill-buffer t)

  ("n" "New note to xnotes.org" entry (file
   "~/Dropbox/org_files/xnotes.org")
   "* %T\n\n%i%?" :prepend t :empty-lines 1)

  ("w" "New work note" entry (file
    "~/Dropbox/org_files/worknotes.org")
    "* %T\n\n%i%?" :kill-buffer t :prepend t :empty-lines 1)

  ("d" "New daydayup entry" entry (file
    "~/Dropbox/org_files/daydayup.org")
    "* %T\n\n%?" :kill-buffer t :prepend t :empty-lines 1)))

(setq org-src-fontify-natively t
      org-src-window-setup 'current-window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t
      org-src-tab-acts-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (sh . t)))

(use-package deft
    :defer t
    :commands deft-new-file-named
    :config
    (setq deft-directory "~/Dropbox/org_files")
    (setq deft-default-extension "org")
    (setq deft-text-mode 'org-mode)
    (setq deft-use-filename-as-title t)
    (setq deft-recursive t)
    (setq deft-use-filter-string-for-filename t)
    :bind (("C-c d" . deft)))
  ;;(setq deft-auto-save-interval 0)

(defun es/make-scratches-in-deft ()
  "save a new file to deft with a unique name based on current time
The file will be uniquely named with xscratch + yeardatehourminutesecond"
  (interactive)
  (let ((today-string (concat (substring (current-time-string) 20)
                  (substring (current-time-string) 4 7)
                  (substring (current-time-string) 8 10)
                  (substring (current-time-string) 11 13)
                  (substring (current-time-string) 14 16)
                  (substring (current-time-string) 17 19))))
    (deft-new-file-named (concat "xscratch" today-string))))

(global-set-key (kbd "<f9>") 'es/make-scratches-in-deft)

(use-package projectile
  :defer t
  :diminish projectile-mode
  :config
  (progn
    (setq projectile-enable-caching t)
    (setq projectile-indexing-method 'alien)
    (setq projectile-completion-system 'default)
    (setq projectile-switch-project-action 'helm-projectile)
    (projectile-global-mode)))

(use-package helm-projectile
  :defer t
  :commands helm-projectile-find-file
  :init
  (helm-projectile-on))

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)

(defun my/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(use-package helm
    :init
    ;;(require 'helm-config)
    (helm-mode 1)
    (setq helm-recentf-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-completion-in-region-fuzzy-match t
      helm-mode-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-M-x-fuzzy-match t)
    (add-to-list 'helm-completing-read-handlers-alist '(find-file . helm-completing-read-symbols))
    (setq helm-source-recentf
      (helm-make-source "Recentf" 'helm-recentf-source
        :fuzzy-match t))
    :bind (("C-x b" . helm-mini)
           ("C-x f" . helm-recentf)
       ("C-s" . helm-occur)
       ("M-x" .  helm-M-x)
           ("M-y" . helm-show-kill-ring)))

(define-key helm-map
  (kbd "<down-mouse-2>") 'mouse-yank-primary)

(define-key helm-map
  (kbd "<drag-mouse-2>") 'ignore)

(defun es/helm-mini-or-projectile-find-file ()
  (interactive)
  (if (helm-alive-p)
      (helm-run-after-exit #'helm-projectile-find-file)
    (helm-mini)))

(use-package helm-ag
  :defer t
  :config
  (setq helm-ag-insert-at-point 'symbol)
  )

;;
;; ace jump mode major function
;;
(add-to-list 'load-path "/home/ethan/.emacs.d/elisp/ace-jump-mode/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

;; you can select the key you prefer to
(global-set-key (kbd "M-s") 'ace-jump-mode)

;;
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(setq ace-jump-mode-submode-list '(ace-jump-char-mode ace-jump-line-mode ace-jump-word-mode))

(use-package smartscan
  :init
  (global-smartscan-mode 1)
  )

(defhydra hydra-register (global-map "<f1>")
  "register hydra"
  ("r" point-to-register "point")
  ("j" jump-to-register "jump")
  ("t" copy-to-register "copy text")
  ("i" insert-register "insert text")
  ("a" append-to-register "append text")
  ("p" prepend-to-register "prepend text")
  )

(defun my/quick-save-bookmark ()
  "Save bookmark with name as 'buffer:row:col'"
  (interactive)
  (bookmark-set (format "%s:%s:line %s:column %s"
                        (thing-at-point 'symbol)
                        (buffer-name)
                        (line-number-at-pos)
                        (current-column)))
  (message "Bookmarked saved at current position"))

(global-set-key (kbd "C-S-b") 'my/quick-save-bookmark)
(bind-key "<menu>" 'helm-bookmarks)

(global-set-key (kbd "C-c o") 'browse-url-of-file)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-\-") 'text-scale-decrease)
(global-set-key "\C-xp" 'pop-to-mark-command)
(global-set-key (kbd "s-n") 'new-frame)
(define-key dired-mode-map "b" 'dired-up-directory)
;; Don't suspended when I accidently hit C-z
(global-unset-key (kbd "C-z"))

(defun es/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(use-package key-chord
  :init
  (progn
    (key-chord-mode 1)
    (key-chord-define-global ";f" 'flip-frame)
    (key-chord-define-global ";t" 'elpy-test-pytest-runner)
    (key-chord-define-global "jj" 'helm-projectile-find-file)
    (key-chord-define-global "JJ" 'helm-projectile-find-file-in-known-projects)
    (key-chord-define-global "BB" 'my/switch-to-previous-buffer)
    (key-chord-define-global "\\\\" 'es/helm-mini-or-projectile-find-file)
    (key-chord-define-global "MM" 'hydra-modes/body)
    (key-chord-define-global "FF" 'delete-other-windows)
    (key-chord-define-global "GG" 'magit-status)
    (key-chord-define-global "SS" 'helm-swoop-back-to-last-point)
    (key-chord-define-global "DD" 'dired-jump)
    )
  )

(setq inferior-lisp-program "/usr/bin/sbcl")

(use-package "eldoc"
  :diminish eldoc-mode
  :commands turn-on-eldoc-mode
  :defer t
  :init
  (progn
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(defun replace-alist-mode (alist oldmode newmode)
  (dolist (aitem alist)
    (if (eq (cdr aitem) oldmode)
    (setcdr aitem newmode))))

;; not sure what mode you want here. You could default to 'fundamental-mode
(replace-alist-mode auto-mode-alist 'javascript-mode 'js2-mode)

(use-package js2-mode
  :defer t
  :config
  (setq js2-indent-switch-body t)
  ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

(use-package yasnippet
  :diminish yas-minor-mode
  :init (yas-global-mode 1)
  :config
  (progn
    (yas-global-mode)
    (add-hook 'term-mode-hook (lambda()
                                (setq yas-dont-activate t)))
    (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (define-key yas-minor-mode-map (kbd "SPC") #'yas-expand)
    (yas-global-mode 1)))

(use-package magit
  :init
  (setq magit-push-current-set-remote-if-missing nil)
  :config
  (setq magit-push-always-verify nil)
  :bind ("C-c g" . magit-status))

(use-package expand-region
  :defer t
  :bind ("M-SPC" . er/expand-region))

(use-package syntax-subword
  :init
  (setq syntax-subword-skip-spaces t)
  :config
  (global-syntax-subword-mode))

(use-package wrap-region
  :config
  (wrap-region-add-wrappers
   '(("(" ")" nil (python-mode org-mode lisp-mode))
     ("'" "'" nil python-mode)
     ("`" "`" nil (org-mode sql-mode sql-interactive-mode gfm-mode))
     ("\"" "\"" nil (org-mode python-mode lisp-mode sql-mode))))
  (add-hook 'org-mode-hook 'wrap-region-mode)
  (add-hook 'python-mode-hook 'wrap-region-mode)
  (add-hook 'lisp-mode-hook 'wrap-region-mode))

(use-package multiple-cursors
  :bind (("M-N" . mc/mark-next-like-this)
         ("M-P". mc/mark-previous-like-this)
         ("C-S-<mouse-1> " . mc/add-cursor-on-click)))

(use-package flycheck
  :init
  :disabled t
  (global-flycheck-mode)
  )

(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0)
  (setq company-tooltip-limit 15)
  (setq company-minimum-prefix-length 2)
  ;; (setq company-tooltip-flip-when-above t)
  ;; (setq company-dabbrev-ignore-case 'keep-prefix)
  )

(use-package auto-complete
    :ensure t
    :init
    (require 'auto-complete-config)
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/es-ac-dict")
    (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
    (add-to-list 'ac-modes 'sql-interactive-mode)
    (add-hook 'sql-interactive-mode-hook (lambda () (auto-complete-mode 1) (company-mode)))
)

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t))
  :bind ("C-/" . undo-tree-undo)
  )

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
    Ease of use features:
    - Move to start of next line.
    - Appends the copy on sequential calls.
    - Use newline as last char even on the last line of the buffer.
    - If region is active, copy its lines."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(global-set-key (kbd "C-S-l") 'copy-line)

(use-package sane-term
  :ensure t
  :bind (("<f10>" . sane-term-create)))

(global-set-key (kbd "<f12>") (kbd "M-& terminator"))
(add-to-list 'display-buffer-alist (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

(windmove-default-keybindings)

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(defun vsplit-other-window ()
  "Splits the window vertically and switches to that window."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil))
(defun hsplit-other-window ()
  "Splits the window horizontally and switches to that window."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil))

(bind-key "C-x 2" 'vsplit-other-window)
(bind-key "C-x 3" 'hsplit-other-window)

(defhydra hydra-resize (global-map "<f2>")
  "resizing hydra"
  ("<left>" shrink-window-horizontally "shrink horizontal")
  ("<right>" enlarge-window-horizontally "enlarge horizontal")
  ("<down>" shrink-window "shrink")
  ("<up>" enlarge-window "shrink")
  )

(winner-mode 1)

(use-package fullframe
  :init
  (fullframe magit-status magit-mode-quit-window)
  (fullframe projectile-vc magit-mode-quit-window)
  (fullframe magit-diff magit-quit-window)
  (fullframe magit-diff-unstaged magit-quit-window)
  (fullframe magit-diff magit-mode-quit-window))

(use-package sx
  :defer t
  :config
  (require 'sx-load))

(use-package markdown-mode
  :defer t
)

(use-package web-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
    '(("django"    . "\\.html\\'"))
    )
  )

;;narrow dired to match filter
(use-package dired-narrow
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))


;;preview files in dired
(use-package peep-dired
  :ensure t
  :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
  :bind (:map dired-mode-map
              ("P" . peep-dired)))

(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files
              (seq "~" eol)                 ;; backup-files
              (seq ".pyc" eol)
              )))

(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))

(use-package define-word
  :bind
  ("C-x d" . define-word-at-point)
  )

(use-package git-timemachine
  :defer t
  )

(setq org-use-speed-commands t)
;; volatile highlights - temporarily highlight changes from pasting etc
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))
