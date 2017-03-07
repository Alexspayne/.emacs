;; Load configuration from ~/.emacs.d/settings.org

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(setq load-prefer-newer t)
(setq user-emacs-directory-warning nil)
(require 'org)
(org-babel-load-file
    (expand-file-name "settings.org"
        user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-google-cpplint-command "cpplint")
 '(org-agenda-files
   (quote
    ("c:/Users/apayne/My Documents/emacs/bin/Dropbox/WebDev/Work.org" "~/Dropbox/org_files/da_guai.org")))
 '(org-journal-dir "~/Dropbox/journal")
 '(package-selected-packages
   (quote
    (google-c-style flymake-google-cpplint iedit org xah-math-input wrap-region web-mode volatile-highlights visual-regexp-steroids virtualenvwrapper use-package transpose-frame tagedit syntax-subword sx smex smartscan shell-current-directory scss-mode sane-term rainbow-mode rainbow-delimiters python-mode py-autopep8 popup-complete peep-dired ox-twbs ox-qmd ox-jira ox-gfm org-present org-journal org-bullets org-babel-eval-in-repl multiple-cursors monokai-theme magit key-chord js2-mode jquery-doc jedi ido-ubiquitous hydra helm-projectile helm-flyspell helm-flycheck helm-ag git-timemachine git-commit-mode fullframe flycheck-pyflakes fixmee fill-column-indicator expand-region exec-path-from-shell elpy ein dired-subtree dired-narrow define-word cpputils-cmake company-jedi clojure-mode-extra-font-locking cider arduino-mode anaconda-mode ac-html-angular)))
 '(user-emacs-directory-warning nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
