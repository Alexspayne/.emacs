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
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(exec-path
   (quote
    ("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9" "/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin" "/Library/Frameworks/Python.framework/Versions/3.6/bin/")))
 '(fci-rule-color "#3C3D37")
 '(flycheck-python-pylint-executable
   "/Library/Frameworks/Python.framework/Versions/2.7/bin/pylint")
 '(flymake-google-cpplint-command "cpplint")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(mode-line-format
   (quote
    ("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
     (vc-mode vc-mode)
     "  " mode-line-modes mode-line-misc-info mode-line-end-spaces)))
 '(org-agenda-files
   (quote
    ("~/Dropbox/WebDev/DailyGoalSetting.org" "~/Dropbox/Org/Work.org" "c:/Users/apayne/My Documents/emacs/bin/Dropbox/WebDev/Work.org" "~/Dropbox/org_files/da_guai.org")))
 '(org-journal-dir "~/Dropbox/journal")
 '(package-selected-packages
   (quote
    (groovy-mode smart-mode-line blacken vdm-mode vmd-mode code-library org-mobile-sync markdown-mode google-c-style flymake-google-cpplint iedit org xah-math-input wrap-region web-mode volatile-highlights visual-regexp-steroids virtualenvwrapper use-package transpose-frame tagedit syntax-subword sx smex smartscan shell-current-directory scss-mode sane-term rainbow-mode rainbow-delimiters python-mode py-autopep8 popup-complete peep-dired ox-twbs ox-qmd ox-jira ox-gfm org-present org-journal org-bullets org-babel-eval-in-repl multiple-cursors monokai-theme magit key-chord js2-mode jquery-doc jedi ido-ubiquitous hydra helm-projectile helm-flyspell helm-flycheck helm-ag git-timemachine git-commit-mode fullframe flycheck-pyflakes fixmee fill-column-indicator expand-region exec-path-from-shell elpy ein dired-subtree dired-narrow define-word cpputils-cmake company-jedi clojure-mode-extra-font-locking cider arduino-mode anaconda-mode ac-html-angular)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(show-paren-mode t)
 '(user-emacs-directory-warning nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
