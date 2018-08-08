;;;;;;;;;;;;;;;;;;;;;;;
;GENERALS
;;;;;;;;;;;;;;;;;;;;;;;

;; install el-files from dir
(add-to-list 'load-path "~/.emacs.d/el-files/")

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Text search
(setq-default case-fold-search nil)

;; backup files
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves_emacs"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
;(setq make-backup-files nil) ;no bla.txt~ files

;; kill Messages and Completions buffer
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))

;;;;;;;;;;;;;;;;;;;;;;;
;CONTROLS
;;;;;;;;;;;;;;;;;;;;;;;
(put 'eval-expression 'disabled nil) ; M-: erlaubt

(global-set-key (kbd "<f2>") 'find-file) ;; open file
(global-set-key (kbd "<f3>") 'kill-buffer) ;; close file
(global-set-key (kbd "<f4>") 'save-buffers-kill-terminal) ;;exit
(global-set-key (kbd "<f5>") 'save-buffer) ;;save

;; search for word(s)/highligh word(s)
(global-set-key (kbd "<f6>") 'highlight-regexp)
(global-set-key (kbd "<f7>") 'unhighlight-regexp)
;; search and replace
(global-set-key (kbd "<f8>") 'query-replace)

;;flyspell
(global-set-key (kbd "<f9>") 'flyspell-mode)
(global-set-key (kbd "<f10>") 'ispell-word)

;; recompile file (type "M-x compile" first to set command)
(global-set-key (kbd "<f12>") 'recompile)

;; cut/copy/paste/mark
;; split window, navigate



;;;;;;;;;;;;;;;;;;;;;;;
;HIGHLIGHTS & GRAPHICS
;;;;;;;;;;;;;;;;;;;;;;;

;; line numbers
(global-linum-mode 1)
(setq linum-format "%4d\u2502") ;; line after line numbers
;; line numbers red
(custom-set-variables
 '(inhibit-startup-screen t)
 '(minimap-hide-scroll-bar t)
 '(minimap-minimum-width 1)
 '(minimap-mode nil)
 '(minimap-window-location (quote right)))
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :foreground "red" :inverse-video t))))
 '(minimap-font-face ((t (:height 1 :family "DejaVu Sans Mono")))))

;; highlight TODOs
(add-hook 'text-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\<\\(FIXME\\|TODO\\|XXX\\|IMPROVE\\)" 1 '(:foreground "#7733FF" :weight bold :underline t) prepend)))))
(add-hook 'prog-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\<\\(FIXME\\|TODO\\|XXX\\|IMPROVE\\)" 1 '(:foreground "#7733FF" :weight bold :underline t) prepend)))))

;; highlight current line
;(require 'hightlight-current-line)
;(hightlight-current-line-on t)
;; color:
;(set-face-background 'hightlight-current-line-face "light white")

;; set color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-hober)
;; remove menu bar
(menu-bar-mode 0)

;; Default text width
(setq default-fill-column 67)
;; auto-fill-mode for text files
(add-hook 'latex-mode-hook
          (lambda ()
            (set-fill-column 67)))
(add-hook 'latex-mode-hook 'auto-fill-mode)

;; Default spaces/tabs/line endings
(setq-default indent-tabs-mode nil) ;nil = only spaces
(setq-default tab-width 4)
(setq-default default-buffer-file-coding-system 'utf-8-unix)

;; Default mode for unknown files
(setq default-major-mode 'text-mode)

;; set "c-mode" highlight style
(setq c-default-style "linux")
(setq-default c-basic-offset 2) ;indent

;; set "js-mode" highlight style
;; javascript modules
(setq auto-mode-alist (cons '("\\.jsm$" . javascript-mode) auto-mode-alist))
(setq-default js-indent-level 2) ;indent

;; set "rust-mode" highlight style
(autoload 'rust-mode "rust-mode" nil t)
(setq auto-mode-alist (cons '("\\.rs$" . rust-mode) auto-mode-alist))

;; python
(setq-default python-indent 4)

;; proverif
(setq auto-mode-alist
      (cons '("\\.pv$" . proverif-pv-mode)
      (cons '("\\.gen$" . proverif-pv-mode) auto-mode-alist)))
(autoload 'proverif-pv-mode "proverif" "" t)

;; asciidoc mode
(define-derived-mode asciidoc-mode text-mode
  (setq mode-name "asciidoc mode")
)
(setq auto-mode-alist (cons '("\\.adoc$" . asciidoc-mode) auto-mode-alist))
;; highlight _bla_ and *bla*
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\(\\ _[a-zA-Z0-9()]+[^_]*_[\\ \\\n\\\t]\\)"
	   1 '(:foreground "#1177FF") prepend)))))
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("[^\\\w]\\*\\([a-zA-Z0-9()]+[^*]*\\)\\*[\\ \\\n\\\t]"
	   1 '(:foreground "#EEEEEE" :underline t) prepend)))))
;; highlight [CAUTION etc.]
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\(\\\[TIP\\\]\\|\\\[CAUTION\\\]\\|\\\[NOTE\\\]\\)"
	   1 '(:foreground "#FF1111") prepend)))))
;; highlight headings
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\([^\\\n]+\\\n[-~^]+\\\n\\)" 1 '(:foreground "#FFDD22" :weight bold) prepend)))))
;; highlight descriptions
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\(^\\.[^\\ ][^\\\n]+\\\n\\)" 1 '(:foreground "#FFDD22") prepend)))))
;; highlight todo-boxes "[ ]::"
(add-hook 'asciidoc-mode-hook
	  (lambda()
	    (font-lock-add-keywords nil
	'(("\\(\\[\\ \\]\\)\\(::\\|;;\\|:::\\)" 1 '(:foreground "#FF1111" :weight bold :underline t) prepend)))))

;;;;;;;;;;;;;;;;;;;;;;;
;AUTO-COMPLETION/-CORRECTION
;;;;;;;;;;;;;;;;;;;;;;;

;; aspell
(setq-default ispell-program-name "aspell")
(setq ispell-change-dictionary "en-US")
;; flyspell
(add-hook 'text-mode-hook 'flyspell-mode) ;turn flyspell on for text-files

;;
;; End of file
;;
