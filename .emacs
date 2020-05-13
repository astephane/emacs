
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-hl-line-mode t)
 '(global-lh-line-mode t)
 '(global-linenum-mode t)
 '(global-linum-mode t)
 '(package-selected-packages (quote (cmake-font-lock elgrep cmake-mode)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "wheat" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "misc" :family "fixed"))))
 '(hl-line ((t (:inherit highlight :background "grey15"))))
 '(region ((t (:background "DodgerBlue4")))))

;;
;; MS-Windows Emacs runemacs.bat
;;
;; @echo off
;; REM call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
;; call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
;; C:\Users\FRAGO_1\emacs-26.3-x86_64\bin\runemacs.exe
;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;
;; OS specific settings.
(cond
 ;;
 ;; MS-Windows
 ((eq system-type 'windows-nt)
  (custom-set-faces '(default ((t (:foundry "outline" :family "Consolas" :height 100)))))
  ;; (setenv "PATH"
  ;; 	  (concat (getenv "PATH")
  ;; 		  ; ";C:\\Program Files\\JetBrains\\CLion 2019.3.3\\bin\\cmake\\win\\bin"
  ;; 		  ";C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\CMake\\CMake\\bin"
  ;; 		  ";C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\Common7\\IDE\\CommonExtensions\\Microsoft\\CMake\\Ninja"
  ;; 		  ";C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.16.27023\\bin\\Hostx64\\x64"))
  )
 ;;
 ;; GNU/Linux
 ((eq system-type 'gnu/linux)
  nil
  )
 ;;
 ;; Default
 (t nil)
 )


;; Remove trailing whitespaces when saving.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
   ;; Amount of basic offset.
   ;; Offset by 2 characters
   (c-basic-offset . 4)
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
    ;;
    ;; Brace that opens an in-class inline method.
    ;; Do not offset curly-braces under a header-file inline function definition.
    ; (inline-open . 0)
    ;;
    ;; The brace that open a substatement block.
    ; (substatement-open . +)
    ;;
    ;; The first line in a new statement block.
    ; (statement-block-intro . 0)
    ;;
    ;; The first line in an argument list.
    ;; GNU Emacs default value.
    ;; (arglist-intro . +)
    ;;
    ;; The solo close paren of an argument list.
    ; (arglist-close . 0)
    ;;
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
