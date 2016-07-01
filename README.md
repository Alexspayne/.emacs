# My Emacs configuration.

I keep most of my settings in settings.org which is loaded using the following code from my `.init.el`.

    ;; Load configuration from ~/.emacs.d/settings.org
    (require 'org)
    (org-babel-load-file
    (expand-file-name "settings.org"
                       user-emacs-directory))

