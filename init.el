;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)
(setq-default cursor-type 'box)

(let ((minver "27.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "28.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(eval-when-compile
  (require 'use-package))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;;(require 'init-benchmarking) ;; Measure startup time
(require 'hello-world)
(require 'init-theme)

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))


;; Adjust garbage collection threshold for early startup (see use of gcmh below)
(setq gc-cons-threshold (* 128 1024 1024))


;; Process performance tuning
(global-set-key (kbd "C-x C-j") 'dired-jump)

(use-package hydra
  :ensure t)

(use-package use-package-hydra
  :ensure t
  :after hydra) 

(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)


(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
						 ("melpa-stable" . "https://stable.melpa.org/packages/")
						 ))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "e29a6c66d4c383dbda21f48effe83a1c2a1058a17ac506d60889aba36685ed94" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(package-selected-packages
   '(evil dracula-theme treemacs-projectile gnu-elpa-keyring-update magit counsel-projectile projectile dap-mode lsp-ivy lsp-ui lsp-mode flycheck yasnippet-snippets yasnippet company rainbow-delimiters highlight-symbol tiny select-themes use-package-hydra hydra marginalia mc-extras which-key atom-one-dark-theme undo-tree good-scroll counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-j") nil)

 (use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :init
  (ivy-mode 1)
  (counsel-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (("C-s" . 'swiper)
   ("C-x b" . 'ivy-switch-buffer)
   ("C-c v" . 'ivy-push-view)
   ("C-c s" . 'ivy-switch-view)
   ("C-c V" . 'ivy-pop-view)
   ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
   ("C-x C-SPC" . 'counsel-mark-ring)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history)))

(use-package amx
  :ensure t
  :init (amx-mode))
(use-package ace-window
  :ensure t
  :bind (("C-x o" . 'ace-window)))
(use-package mwim
  :ensure t
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))


(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :after hydra
  :bind ("C-x C-h u" . hydra-undo-tree/body)
  :hydra (hydra-undo-tree (:hint nil)
  "
  _p_: undo  _n_: redo _s_: save _l_: load   "
  ("p"   undo-tree-undo)
  ("n"   undo-tree-redo)
  ("s"   undo-tree-save-history)
  ("l"   undo-tree-load-history)
  ("u"   undo-tree-visualize "visualize" :color blue)
  ("q"   nil "quit" :color blue)))

(use-package smart-mode-line
  :ensure t
  :init 
  (setq sml/theme 'atom-one-dark)
  (sml/setup)
  (setq sml/no-confirm-load-theme t)
  )


(use-package good-scroll
  :ensure t
  :if window-system          ; 在图形化界面时才使用这个插件
  :init (good-scroll-mode))

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package avy
  :ensure t
  :bind
  (("C-j C-SPC" . avy-goto-char-timer)))
 
(use-package marginalia
  :ensure t
  :init (marginalia-mode)
  :bind (:map minibuffer-local-map
			  ("M-A" . marginalia-cycle)))

(use-package multiple-cursors
  :ensure t
  :after hydra
  :bind
  (("C-x C-h m" . hydra-multiple-cursors/body)
   ("C-S-<mouse-1>" . mc/toggle-cursor-on-click))
  :hydra (hydra-multiple-cursors
		  (:hint nil)
		  "
Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Prev     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search      [_q_] Quit
 [_|_] Align with input CHAR       [Click] Cursor at point"
		  ("l" mc/edit-lines :exit t)
		  ("a" mc/mark-all-like-this :exit t)
		  ("n" mc/mark-next-like-this)
		  ("N" mc/skip-to-next-like-this)
		  ("M-n" mc/unmark-next-like-this)
		  ("p" mc/mark-previous-like-this)
		  ("P" mc/skip-to-previous-like-this)
		  ("M-p" mc/unmark-previous-like-this)
		  ("|" mc/vertical-align)
		  ("s" mc/mark-all-in-region-regexp :exit t)
		  ("0" mc/insert-numbers :exit t)
		  ("A" mc/insert-letters :exit t)
		  ("<mouse-1>" mc/add-cursor-on-click)
		  ;; Help with click recognition in this hydra
		  ("<down-mouse-1>" ignore)
		  ("<drag-mouse-1>" ignore)
		  ("q" nil)))

 (use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs!") ;; 个性签名，随读者喜好设置
  ;; (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
  (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
  (setq dashboard-items '((recents  . 5)   ;; 显示多少个最近文件
			  (bookmarks . 5)  ;; 显示多少个最近书签
			  (projects . 10))) ;; 显示多少个最近项目
  (dashboard-setup-startup-hook))

(use-package tiny
  :ensure t
  ;; 可选绑定快捷键，笔者个人感觉不绑定快捷键也无妨
  :bind
  ("C-;" . tiny-expand))

(use-package highlight-symbol
  :ensure t
  :init (highlight-symbol-mode)
  :bind ("<f3>" . highlight-symbol)) ;; 按下 F3 键就可高亮当前符号

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package yasnippet
  :ensure t
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  ;; add company-yasnippet to company-backends
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
	backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  ;; unbind <TAB> completion
  (define-key yas-minor-mode-map [(tab)]        nil)
  (define-key yas-minor-mode-map (kbd "TAB")    nil)
  (define-key yas-minor-mode-map (kbd "<tab>")  nil)
  :bind
  (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(global-set-key (kbd "M-/") 'hippie-expand)

(use-package flycheck
  :ensure t
  :config
  (setq truncate-lines nil) ; 如果单行信息很长会自动换行
  :hook
  (prog-mode . flycheck-mode))

 (use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
  (setq lsp-headerline-breadcrumb-enable t)
  :bind
  ("C-c l s" . lsp-ivy-workspace-symbol)) ;; 可快速搜索工作区内的符号（类名、函数名、变量名等）
 
 (use-package lsp-ui
  :ensure t
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))

 (use-package lsp-ivy
  :ensure t
  :after (lsp-mode))

 (use-package dap-mode
  :ensure t
  :after hydra lsp-mode
  :commands dap-debug
  :custom
  (dap-auto-configure-mode t)
  :config
  (dap-ui-mode 1)
  :hydra
  (hydra-dap-mode
   (:color pink :hint nil :foreign-keys run)
   "
^Stepping^          ^Switch^                 ^Breakpoints^         ^Debug^                     ^Eval
^^^^^^^^----------------------------------------------------------------------------------------------------------------
_n_: Next           _ss_: Session            _bb_: Toggle          _dd_: Debug                 _ee_: Eval
_i_: Step in        _st_: Thread             _bd_: Delete          _dr_: Debug recent          _er_: Eval region
_o_: Step out       _sf_: Stack frame        _ba_: Add             _dl_: Debug last            _es_: Eval thing at point
_c_: Continue       _su_: Up stack frame     _bc_: Set condition   _de_: Edit debug template   _ea_: Add expression.
_r_: Restart frame  _sd_: Down stack frame   _bh_: Set hit count   _ds_: Debug restart
_Q_: Disconnect     _sl_: List locals        _bl_: Set log message
                  _sb_: List breakpoints
                  _sS_: List sessions
"
   ("n" dap-next)
   ("i" dap-step-in)
   ("o" dap-step-out)
   ("c" dap-continue)
   ("r" dap-restart-frame)
   ("ss" dap-switch-session)
   ("st" dap-switch-thread)
   ("sf" dap-switch-stack-frame)
   ("su" dap-up-stack-frame)
   ("sd" dap-down-stack-frame)
   ("sl" dap-ui-locals)
   ("sb" dap-ui-breakpoints)
   ("sS" dap-ui-sessions)
   ("bb" dap-breakpoint-toggle)
   ("ba" dap-breakpoint-add)
   ("bd" dap-breakpoint-delete)
   ("bc" dap-breakpoint-condition)
   ("bh" dap-breakpoint-hit-condition)
   ("bl" dap-breakpoint-log-message)
   ("dd" dap-debug)
   ("dr" dap-debug-recent)
   ("ds" dap-debug-restart)
   ("dl" dap-debug-last)
   ("de" dap-debug-edit-template)
   ("ee" dap-eval)
   ("ea" dap-ui-expressions-add)
   ("er" dap-eval-region)
   ("es" dap-eval-thing-at-point)
   ("q" nil "quit" :color blue)
   ("Q" dap-disconnect :color red)))


(use-package projectile
  :ensure t
  :bind (("C-c p" . projectile-command-map))
  :config
  (setq projectile-mode-line "Projectile")
  (setq projectile-track-known-projects-automatically nil))

(use-package counsel-projectile
  :ensure t
  :after (projectile)
  :init (counsel-projectile-mode))

(use-package magit
  :ensure t)

(defun file-name-only ()
  "Get the current buffer file name without directory."
  (file-name-nondirectory (buffer-name)))

(defun file-name-only-noext ()
  "Get the currennt buffer file name without directory and extension."
  (file-name-sans-extension (file-name-only)))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (treemacs-tag-follow-mode)
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ;; ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  (:map treemacs-mode-map
	("/" . treemacs-advanced-helpful-hydra)))

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile))

(use-package lsp-treemacs
  :ensure t
  :after (treemacs lsp))


 (provide 'init)
