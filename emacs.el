;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.
;;


;;
;; MS-Windows Emacs runemacs.bat
;;
;; @echo off
;; call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
;; %USERPROFILE%\emacs-26.3-x86_64\bin\runemacs.exe
;;
;; Make a desktop shortcut running %USERPROFILE%\bin\runemacs.bat
;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;
;; Use MELP package repository.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 ;; '(cmake-tab-width 4)
 ;; '(tab-width 4)
 '(gdb-many-windows t)
 '(global-hl-line-mode t)
 ; '(global-linenum-mode t) ; obsolete
 ; '(global-linum-mode t) ; obsolete
 '(global-display-line-numbers-mode t)
 ;; Home
 '(package-selected-packages (quote (plantuml-mode yaml-mode cmake-font-lock elgrep cmake-mode)))
 ;; Work
 ;; '(package-selected-packages
 ;;   (quote
 ;;    (groovy-mode yaml-mode tabbar session pod-mode muttrc-mode mutt-alias markdown-mode initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode browse-kill-ring boxquote bm bar-cursor apache-mode)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(speedbar-use-images nil)
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "wheat" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "misc" :family "fixed"))))
 '(hl-line ((t (:inherit highlight :background "grey15"))))
 '(region ((t (:background "DodgerBlue4")))))

;; Remove trailing whitespaces when saving.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; OS specific settings.
(cond
 ;;
 ;; MS-Windows
 ((eq system-type 'windows-nt)
  (setq prefer-coding-system 'utf-8)
  (custom-set-faces '(default ((t (:foundry "outline" :family "Consolas")))))
  ;; https://emacs.stackexchange.com/questions/22049/git-bash-in-emacs-on-windows
  (defun git-bash () (interactive)
	 (let ((explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
	       (explicit-bash.exe-args '("--login" "-i"))
	       (shell-command-switch "-m"))
	   (call-interactively 'shell)))
  ;; (setenv "PATH"
  ;; 	  (concat (getenv "PATH")
  ;; 		  ";<DIR>"
  ;; 		  )
  ;; 	  )
  )
 ;;
 ;; GNU/Linux
 ((eq system-type 'gnu/linux)
  ;;
  ;; 2020-05-05: https://www.emacswiki.org/emacs/GnuGlobal
  (defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))
  ;;
  (defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u")
    )
  ;;
  (defun gtags-update-single(filename)
    "Update Gtags database for changes in a single file"
    (interactive)
    (start-process "update-gtags"
		   "update-gtags"
		   "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))
  ;;
  (defun gtags-update-current-file()
    (interactive)
    (defvar filename)
    (setq filename
	  (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
    (gtags-update-single filename)
    (message "Gtags updated for '%s'." filename))
  ;;
  (defun gtags-update-hook ()
    (when (and gtags-mode (gtags-root-dir))
      (gtags-update)
      ;; (gtags-update-current-file) ;; Doesn't work for some unknown reason.
      )
    )
  ;;
  (add-hook 'after-save-hook 'gtags-update-hook)
  ;;
  ;; PlantUML
  ;; (see https://github.com/skuro/plantuml-mode?tab=readme-ov-file#quick-guide)
  ;; modes: `executable`, `jar`, `server`
  ;;
  ;; 2024-02-29:
  ;; * PlantUML version is 1.2020.02 on Ubuntu 22.04 LTS.
  ;; * Downloard & install the LGL package on PlantUML web site and install as below.
  ;;
  ;; /home/stepalbe/opt/local/
  ;; ├── bin
  ;; │   ├── plantuml
  ;; └── share
  ;;     └── plantuml
  ;;         ├── plantuml-lgpl-1.2024.3.jar
  ;;         └── plantuml.jar -> /home/stepalbe/opt/local/share/plantuml/plantuml-lgpl-1.2024.3.jar
  (setq plantuml-default-exec-mode 'executable)
  ;; (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
  ;; (setq plantuml-executable-path "/usr/bin/plantuml")
  (setq plantuml-jar-path "~/opt/local/share/plantuml/plantuml.jar")
  (setq plantuml-executable-path "~/opt/local/bin/plantuml")
 ;;
 ;; Default
 (t nil)
 )

;;
;; Coding-style: SAT
(c-add-style
 "sat"
 ;;
 ;; Based on C+-style 'stroustrup'
 '("stroustrup"
   ;;
   ;; Amount of basic offset.
   ;; Offset by 2 characters
   (c-basic-offset . 2)
   (tab-width . 2)
   ;;
   (c-offsets-alist
    ;; ;;
    ;; ;; The construct is nested inside a namspace definition.
    ;; ;; Do not offset lines nested between curly-braces of a namespace definition.
    ;; (innamespace . 0)
    ;;
    ;; Brace that opens an in-class inline method.
    ;; Do not offset curly-braces under a header-file inline function definition.
    (inline-open . 0)
    )
   )
 )

;;
;; Coding-style: Geown
(c-add-style
 "geown"
 ;;
 ;; Based on C+-style 'stroustrup'
 '("stroustrup"
   ;;
   (c-offsets-alist
    ;;
    ;; Inside multi-line strings.
    ;; GNU Emacs default value.
    ;; (c . c-lineup-dont-change)
    ;;
    ;; The construct is nested inside a namspace definition.
    ;; Do not offset lines nested between curly-braces of a namespace definition.
    (innamespace . -)
    )
   )
 )

;;
;; Coding-style: OTB/ITK
(c-add-style
 "md"
 ;;
 ;; Based on C+-style 'stroustrup'
 '("geown"
   ;;
   ;; Amount of basic offset.
   ;; Offset by 2 characters
   (c-basic-offset . 2)
   )
 )

;;
;; Coding-style: OTB/ITK
(c-add-style
 "itk"
 ;;
 ;; Based on C+-style 'stroustrup'
 '("stroustrup"
   ;;
   ;; Amount of basic offset.
   ;; Offset by 2 characters
   (c-basic-offset . 2)
   ;;
   (c-offsets-alist
    ;;
    ;; Inside multi-line strings.
    ;; GNU Emacs default value.
    ;; (c . c-lineup-dont-change)
    ;;
    ;; The construct is nested inside a namspace definition.
    ;; Do not offset lines nested between curly-braces of a namespace definition.
    (innamespace . 0)
    ;;
    ;; Brace that opens an in-class inline method.
    ;; Do not offset curly-braces under a header-file inline function definition.
    (inline-open . 0)
    ;;
    ;; The brace that open a substatement block.
    (substatement-open . +)
    ;;
    ;; The first line in a new statement block.
    (statement-block-intro . 0)
    ;;
    ;; The first line in an argument list.
    ;; GNU Emacs default value.
    ;; (arglist-intro . +)
    ;;
    ;; The solo close paren of an argument list.
    (arglist-close . 0)
    ;;
    ) ) )

;;
;; Use 'itk' style as default style for C++ files.
(add-hook
 'c++-mode-hook
 (function (lambda ()
	     ;; (c-set-style "itk")
	     (c-set-style "sat")
	     ;; (c-set-style "geown")
	     (turn-on-auto-fill)
	     (imenu-add-menubar-index)
	     (gtags-mode t)
	     ;;
	     (setq c-noise-macro-names "[A-Z0-9_]+_EXPORT")
	     ) ) )

;;
;; Add '*.txx' files to C++ style.
(add-to-list 'auto-mode-alist '("\\.txx\\'" . c++-mode) )
;;
;; Add '*.hxx' files to C++ style.
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode) )
;;
;; Add '*.h' files to C++ style.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode) )
;;
;; Add '*.puml' files to PlantUML style.
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode) )
