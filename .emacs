;; .emacs


(define-key input-decode-map "\e\eOD" (kbd "C-M-<left>"))
(define-key input-decode-map "\e\eOC" (kbd "C-M-<right>"))
;;(define-key input-decode-map "\e\eOB" [(meta down)])
;; ===== Automatically load abbreviations table =====

 ;; Note that emacs chooses, by default, the filename
 ;; "~/.abbrev_defs", so don't try to be too clever
 ;; by changing its name


;;(setq-default abbrev-mode t)
;;(read-abbrev-file "~/.abbrev_defs")
;;(setq save-abbrevs t)

;; ===== Set the highlight current line minor mode ===== 

;; In every buffer, the line which contains the cursor will be fully
 ;; highlighted
 

;;(global-hl-line-mode 1)


;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;;(require `ibuffer)
;;(global-set-key [f1] `helm-buffers-list)
(global-set-key [f1] `list-buffers)
;;(global-set-key [f1] (lambda () 
;;					   (interactive)
;;					   (list-buffers)
;;					   (other-window 1)
;;					   (switch-to-buffer "*Buffer List*")))
(global-set-key [f2] `other-window)
(global-set-key [f5] `revert-buffer)
(global-set-key [f3] `ff-find-other-file)
(global-set-key [f4] `revert-buffer-with-coding-system)
(global-set-key [f12] `kill-buffer)
;; (global-set-key (kbd "C-x SPC") `gud-break)

;; ========== Place Backup Files in Specific Directory ==========
;; Enable backup files.
(setq make-backup-files t)
 

;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
 

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/appdata/emacs_backups/"))))

;; enable visual feedback on selections
(setq transient-mark-mode t)


;; ========== Enable Line and Column Numbering ==========
 
;; Show line-number in the mode line
 (line-number-mode 1)
 

;; Show column-number in the mode line
 (column-number-mode 1)


;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")




;; always end a file with a newline
;(setq require-final-newline 'query)
(setq-default c-basic-offset 4
               tab-width 4
               indent-tabs-mode nil)

(defun set_tab ()
  (interactive)
  (setq c-basic-offset 4)
  (tab-width 4)
  (setq indent-tabs-mode t))
(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here
  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 4)
  (setq indent-tabs-mode nil)  ; use spaces only if nil
   )

  

(defun set_no_tab ()
  (interactive)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq python-indent 4)
  (setq py-indent-offset 4))


(add-hook 'python-mode-hook 'set_no_tab)
(add-hook 'javascript-mode-hook
		  (lambda ()
			(setq indent-tabs-mode nil)
			(setq tab-width 4)
			(setq js-indent-level 4)
			(setq js2-indent-level 4)
			(setq javascript-indent-level 4)))

(add-hook 'after-change-major-mode-hook
          '(lambda ()
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 4)
             (setq tab-width 4)))

;;(add-hook 'c-mode-common-hook
;;		  (lambda() 
;;			(local-set-key  (kbd "M-o") `ff-find-other-file)))


(global-set-key  (kbd "M-o") `ff-find-other-file)
(global-set-key  (kbd "M-g") `goto-line)
(global-set-key  (kbd "C-M-<left>") `previous-buffer)
(global-set-key  (kbd "C-M-<right>") `next-buffer)
(global-set-key  (kbd "ESC <left>") `previous-buffer)
(global-set-key  (kbd "ESC <right>") `next-buffer)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;; 	(load
;;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
    (package-initialize))
;; (require `package)
;; (add-to-list 'package-archives
;; 			 '("melpa-stable" . "http://stable.melpa.org/packages/")
;; 			 t)


(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-.") 'helm-gtags-dwim)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)

;;multiple git repos in same dir
(setq projectile-git-command "git-ls-all-files")

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(add-hook 'c-mode-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-hook 'my-c-mode-common-hook)
(add-hook 'python-mode-hook
          (lambda () (set (make-local-variable 'electric-indent-mode) nil)))
;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;;(defvar gud-gdb-command-name "/usr/bin/gdb76")
;;(setq gud-gdb-command-name "/usr/bin/gdb76 --annotate=3")

