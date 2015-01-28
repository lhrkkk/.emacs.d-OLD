;; -*- Emacs-Lisp -*-

;; Time-stamp: <2012-11-03 04:28:12 Saturday by lhr>

(defconst my-emacs-path           "~/emacs/" "我的emacs相关配置文件的路径")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/") "我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path     (concat my-emacs-path "lisps/") "我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "Path for templates")
(defconst my-emacs-addition-lisps-path (concat my-emacs-path "addition-lisps/") "Path for addition-lisps")

;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)
(my-add-subdirs-to-load-path my-emacs-addition-lisps-path)


(defun make-local-hook (hook)
  "Make the hook HOOK local to the current buffer.
The return value is HOOK.

When a hook is local, its local and global values
work in concert: running the hook actually runs all the hook
functions listed in *either* the local value *or* the global value
of the hook variable.

This function works by making `t' a member of the buffer-local value,
which acts as a flag to run the hook functions in the default value as
well.  This works for all normal hooks, but does not work for most
non-normal hooks yet.  We will be changing the callers of non-normal
hooks so that they can handle localness; this has to be done one by
one.

This function does nothing if HOOK is already local in the current
buffer.

Do not use `make-local-variable' to make a hook variable buffer-local."
  (if ;; (local-variable-p hook)
      (or (assq hook (buffer-local-variables)) ; local and bound.
    (memq hook (buffer-local-variables))); local but void.
      nil
    (or (boundp hook) (set hook nil))
    (make-local-variable hook)
    (set hook (list t)))
  hook)


;; kill client的时候不提示
;;(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; 一些基本的小函数
(require 'ahei-misc)

;; 利用`eval-after-load'加快启动速度的库
;; 用eval-after-load避免不必要的elip包的加载
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)

(require 'util)

;; 一些Emacs的小设置
(require 'misc-settings)

;; 编码设置
(require 'coding-settings)


;;--------------------------------------------MSCC-------------------------------------

;; edit-settings中对M-w重新定义,但是kde-emacs中也对其定义了
;; 所以必须要放在kde-emacs后面
(require 'edit-settings)

;; 所有关于buffer方面的配置

(require 'all-buffer-settings)

;; 非常酷的一个扩展。可以“所见即所得”的编辑一个文本模式的表格
(if is-before-emacs-21 (require 'table "table-for-21"))

;; 把文件或buffer彩色输出成html
(require 'htmlize)

;; Emacs可以做为一个server, 然后用emacsclient连接这个server,
;; 无需再打开两个Emacs
(require 'emacs-server-settings)

;; 显示ascii表
(require 'ascii)

;; 所有关于查看帮助方面的配置
(require 'all-help-settings)

;; 定义一些emacs 21没有的函数
(if is-before-emacs-21 (require 'for-emacs-21))

;; 可以为重名的buffer在前面加上其父目录的名字来让buffer的名字区分开来，而不是单纯的加一个没有太多意义的序号
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;;----Buffer,color----

;; 不要menu-bar和tool-bar
;; (unless window-system
;;   (menu-bar-mode -1))
(menu-bar-mode -1)
;; GUI下显示toolbar的话select-buffer会出问题
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;; 打开压缩文件时自动解压缩
;; 必须放在session前面
(auto-compression-mode 1)



;; 鼠标配置
(require 'mouse-settings)

;; 可以把光标由方块变成一个小长条
(require 'bar-cursor)
;; Emacs才是世界上最强大的IDE － 智能的改变光标形状
;; http://emacser.com/cursor-change.htm
(require 'cursor-change)
(cursor-change-mode 1)

;; `mode-line'显示格式
(require 'mode-line-settings)

;; 图片mode
(require 'image-mode-settings)

;; 显示行号
(require 'linum-settings)

;; color theme Emacs主题
(require 'color-theme-settings)

(require 'ahei-face)
(require 'color-theme-ahei)
(require 'face-settings)


;;(setq hl-line-face 'hl-line-nonunderline-face)
;;(setq hl-line-overlay nil)
;;(color-theme-adjust-hl-line-face)
;; 高亮当前行ngs
;;(require 'hl-line-settings)

;; 最近打开的文件
(require 'recentf-settings)

;; 字体配置
(require 'font-settings)



;;----Move----

;; ffap,打开当前point的文件
;;(require 'ffap-settings)

;; 返回到最近去过的地方
(require 'recent-jump-settings)



;;----Search and Replace----

;; 在buffer中方便的查找字符串: color-moccur
(require 'moccur-settings)

;; Emacs超强的增量搜索Isearch配置
(require 'isearch-settings)

(require 'ioccur)



;;----Copy and Paste ,Select----

;; CUA的矩阵区域操作特别方便
(require 'cua-settings)

;; 矩形区域操作
(require 'rect-mark-settings)

;; 关于mark的一些设置，使你非常方便的选择region
(require 'mark-settings)

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

;; 方便的在kill-ring里寻找需要的东西
(require 'browse-kill-ring-settings)

;;----Complete----

;; 用M-x执行某个命令的时候，在输入的同时给出可选的命令名提示
(require 'icomplete-settings)

;; minibuffer中输入部分命令就可以使用补全
(unless is-after-emacs-23
  (partial-completion-mode 1))

(require 'apropos-settings)
(require 'completion-list-mode-settings)
;; 简写模式
(setq-default abbrev-mode t)
(setq save-abbrevs nil)

;; time-stamp, 在文件头记录修改时间, 并动态更新
(require 'time-stamp-settings)



;; frame-cmds.el必须放在multi-term前面,否则ediff退出时会出现错误
;; 而icicles soft-requires frame-cmds.el, 所以icicles也必须放在multi-term前面
;; emacs22下也必须放在kde-emacs前面, 否则会说shell-command是void-function
;; http://emacser.com/icicles-doremi-palette.htm
(require 'icicles-settings)
(require 'doremi-settings)
(require 'palette-settings)





;;--------------------------------------------DDTS-------------------------------------------

;;----Develope----

;; 各种语言开发方面的设置
; (require 'dev-settings)



;;----Dired----

;; Emacs的超强文件管理器
(require 'dired-settings)

;; 以目录形式显示linkd文档
(require 'linkd-settings)



;;----Tabbar----

;;(require 'tabbar-settings)

;;启用winner-mode
(when (fboundp 'winner-mode)
  (winner-mode 1))
(global-set-key (kbd "C-c H-j") 'winner-undo)
(global-set-key (kbd "C-c C-l") 'winner-redo)

(require 'elscreen-settings)

;;(require 'escreen-settings)

;;revive
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "R" 'resume)
(define-key ctl-x-map "K" 'wipe)
;;emacs退出时候保存到档案1,emacs启动时载入档案1
(add-hook 'kill-emacs-hook 'save-current-configuration)
(resume)


(require 'windows)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)


;; 方便的切换major mode
(defvar switch-major-mode-last-mode nil)

(defun major-mode-heuristic (symbol)
  (and (fboundp symbol)
       (string-match ".*-mode$" (symbol-name symbol))))

(defun switch-major-mode (mode)
  "切换major mode"
  (interactive
   (let ((fn switch-major-mode-last-mode) val)
     (setq val
           (completing-read
            (if fn (format "切换major-mode为(缺省为%s): " fn) "切换major mode为: ")
            obarray 'major-mode-heuristic t nil nil (symbol-name fn)))
     (list (intern val))))
  (let ((last-mode major-mode))
    (funcall mode)
    (setq switch-major-mode-last-mode last-mode)))
(global-set-key (kbd "C-x q") 'switch-major-mode)

(defun get-mode-name ()
  "显示`major-mode'及`mode-name'"
  (interactive)
  (message "major-mode为%s, mode-name为%s" major-mode mode-name))
(global-set-key (kbd "C-x m") 'get-mode-name)

;; 查看Emacs内进程
(autoload 'list-processes+ "list-processes+" "增强的`list-processes'命令" t)

(require 'view-mode-settings)

(defun revert-buffer-no-confirm ()
  "执行`revert-buffer'时不需要确认"
  (interactive)
  (when (buffer-file-name)
    (let ((emaci emaci-mode))
      (revert-buffer buffer-file-name t)
      (emaci-mode (if emaci 1 -1)))))
(eal-define-keys-commonly
 global-map
 `(("C-x u"   revert-buffer-no-confirm)
   ("C-x M-K" revert-buffer-with-gbk)
   ("C-x U"   revert-buffer-with-coding-system-no-confirm)))

(defun count-brf-lines (&optional is-fun)
  "显示当前buffer或region或函数的行数和字符数"
  (interactive "P")
  (let (min max)
    (if is-fun
        (save-excursion
          (beginning-of-defun) (setq min (point))
          (end-of-defun) (setq max (point))
          (message "当前函数%s内共有%d行, %d个字符" (which-function) (count-lines min max) (- max min)))
      (if mark-active
          (progn
            (setq min (min (point) (mark)))
            (setq max (max (point) (mark))))
        (setq min (point-min))
        (setq max (point-max)))
      (if (or (= 1 (point-min)) mark-active)
          (if mark-active
              (message "当前region内共有%d行, %d个字符" (count-lines min max) (- max min))
            (message "当前buffer内共有%d行, %d个字符" (count-lines min max) (- max min)))
        (let ((nmin min) (nmax max))
          (save-excursion
            (save-restriction
              (widen)
              (setq min (point-min))
              (setq max (point-max))))
          (message "narrow下buffer内共有%d行, %d个字符, 非narrow下buffer内共有%d行, %d个字符"
                   (count-lines nmin nmax) (- nmax nmin) (count-lines min max) (- max min)))))))
(eal-define-keys-commonly
 global-map
 `(("C-x l" count-brf-lines)
   ("C-x L" (lambda () (interactive) (count-brf-lines t)))))

;; 增加更丰富的高亮
(require 'generic-x)

(defun switch-to-scratch ()
  "切换到*scratch*"
  (interactive)
  (let ((buffer (get-buffer-create "*scratch*")))
    (switch-to-buffer buffer)
    (unless (equal major-mode 'lisp-interaction-mode)
      (lisp-interaction-mode))))
(global-set-key (kbd "C-x s") 'switch-to-scratch)

(defun visit-.emacs ()
  "访问.emacs文件"
  (interactive)
  (find-file (concat my-emacs-path ".emacs")))
(global-set-key (kbd "C-x E") 'visit-.emacs)




;;----Shell----


;; grep
(require 'grep-settings)

;; ack-grep, grep纯perl的代替品
(require 'full-ack-settings)



;; 统计命令使用频率XC
(require 'command-frequence)

;; Emacs中的文本浏览器w3m
;; http://emacser.com/w3m.htm
; (require 'w3m-settings)

;; 以另一用户编辑文件, 或者编辑远程主机文件
;;(require 'tramp-settings)

;; erc: Emacs中的IRCO
;; ERC使用简介 emacser.com/erc.htm
(require 'erc-settings)

;; spell check
(setq-default ispell-program-name "aspell")

;; Emacs中的包管理器
(require 'package)
(package-initialize)

(require 'auto-install)
(setq auto-install-directory (concat my-emacs-lisps-path "auto-install"))

(unless mswin
  (defun install-.emacs ()
    (interactive)
    (shell-command (concat my-emacs-path "install.emacs.sh")))

  (add-hook 'kill-emacs-hook 'install-.emacs))

;; 把pdf,ps,dvi文件转换为png格式, 在Emacs里面浏览
(if is-after-emacs-23
    (require 'doc-view)
  (setq doc-view-conversion-refresh-interval 3))

;; 在Emacs里面使用shell
(require 'term-settings)
(require 'multi-term-settings)

;; (require 'anything-settings)


;; 查询天气预报
(require 'weather-settings)

(defun goto-my-emacs-lisps-dir ()
  "Goto `my-emacs-lisps-path'."
  (interactive)
  (dired my-emacs-lisps-path))
(defun goto-my-emacs-my-lisps-dir ()
  "Goto `my-emacs-my-lisps-path'."
  (interactive)
  (dired my-emacs-my-lisps-path))
(defun goto-my-emacs-dir ()
  "Goto `my-emacs-path'."
  (interactive)
  (dired my-emacs-path))
(defun goto-my-home-dir ()
  "Goto my home directory."
  (interactive)
  (dired "~"))
(define-key-list
  global-map
  `(("C-x G l" goto-my-emacs-lisps-dir)
    ("C-x G m" goto-my-emacs-my-lisps-dir)
    ("C-x G e" goto-my-emacs-dir)
    ("C-x M-H" goto-my-home-dir)))

(define-key global-map (kbd "C-x M-c") 'describe-char)

;; 启动Emacs的时候最大化Emacs
(require 'maxframe-settings)
;;(require 'maxframe-simple)

(defun dos2unix ()
  "dos2unix on current buffer."
  (interactive)
  (set-buffer-file-coding-system 'unix))

(defun unix2dos ()
  "unix2dos on current buffer."
  (interactive)
  (set-buffer-file-coding-system 'dos))

(define-key global-map (kbd "C-x M-D") 'dos2unix)

(define-key-list
  global-map
  `(("C-x M-k" Info-goto-emacs-key-command-node)
    ))


(defun copy-file-name (&optional full)
  "Copy file name of current-buffer.
If FULL is t, copy full file name."
  (interactive "P")
  (let ((file (buffer-name)))
    (if full
        (setq file (expand-file-name file)))
    (kill-new file)
    (message "File `%s' copied." file)))
(eal-define-keys
 `(emacs-lisp-mode-map lisp-interaction-mode-map java-mode-map sh-mode-map
                       c-mode-base-map text-mode-map ruby-mode-map html-mode-map
                       java-mode-map conf-javaprop-mode-map conf-space-mode-map
                       python-mode-map)
 `(("C-c M-C" copy-file-name)))

;; notification tool
(require 'todochiku-settings)

;; twitter client
(require 'eagle-settings)
(require 'twit-settings)

;; 模拟vi的点(.)命令
(require 'dot-mode)

;; 用渐变颜色显示你最近的修改
;; http://emacser.com/highlight-tail.htm
;; 与semantic冲突，启动了它后，打开大文件的时候，会发现buffer大范围的刷屏
;; (require 'highlight-tail-settings)





;;;###autoload
(defun update-current-file-autoloads (file &optional save-after)
  "`update-file-autoloads' for current file."
  (interactive "fUpdate autoloads for file: \np")
  (let* ((load-file (expand-file-name "loaddefs.el"))
         (generated-autoload-file load-file))
    (unless (file-exists-p load-file)
      (shell-command (concat "touch " load-file)))
    (update-file-autoloads file save-after)))

;; 大纲mode
(require 'outline-settings)

;; org是一个非常强大的GTD工具
(require 'org-settings)

;; 强大的发布工具
(require 'muse-settings)

;; 用weblogger写WordPress博客
;; http://emacser.com/weblogger.htm
(require 'weblogger-settings)

;; 非常强大的文本画图的工具
(require 'artist-settings)

;; google-maps-el – Emacs中的谷歌地图
;; http://emacser.com/emacs-google-map.htm
(require 'google-maps-settings)

;; 关闭buffer的时候, 如果该buffer有对应的进程存在, 不提示, 烦
(delq 'process-kill-buffer-query-function kill-buffer-query-functions)

;; session,可以保存很多东西，例如输入历史(像搜索、打开文件等的输入)、
;; register的内容、buffer的local variables以及kill-ring和最近修改的文件列表等。非常有用。
(require 'session-settings)

;; 王纯业的desktop, 比desktop快多了,press any key to load buffer 不记录光标位置
;;(require 'wcy-desktop-settings)

;;普通的desktop,比wcy的记录信息多,包含文件光标位置
;; (desktop-save-mode 1)
;; (setq desktop-path '("~/.emacs.d/"))
;; (setq desktop-dirname "~/.emacs.d/")
;; (setq desktop-base-file-name ".emacs-desktop")

;; HACK: 要放在最后,免得会出现比较奇怪的现象
;; 保存和恢复工作环境
;; desktop,用来保存Emacs的桌面环境 — buffers、以及buffer的文件名、major modes和位置等等
;; (require 'desktop-settings)

;; diff
(require 'diff-settings)

;; Emacs的diff: ediff
(require 'ediff-settings)

;;auctex-settings
(require 'auctex-settings)




;;----------------------------------------独立配置------------------------------


;;-----------------全局通用键位设置-------------------

;;b = 标记段落
(global-set-key (kbd "C-b") 'mark-paragraph)
(global-set-key (kbd "M-b") 'mark-whole-buffer)
;;, . = 翻页
(global-set-key (kbd "M-,") [prior])
(global-set-key (kbd "M-.") [next])


;; 翻译C-i和C-j Translate the problematic keys to the function key Hyper:
(keyboard-translate ?\C-i ?\H-i)
(keyboard-translate ?\C-j ?\H-j)
                                        ;(keyboard-translate ?\C-m ?\H-m)
                                        ;(keyboard-translate ?\C-d ?\H-d)
;; Rebind then accordantly:
                                        ;(global-set-key [?\H-m] 'set-mark-command)
;;i k j l = 上下左右

;;(global-set-key (kbd "C-i") [up])
(global-set-key [?\H-i] [up])
(global-set-key (kbd "C-k") [down])
;;(global-set-key (kbd "C-j") [left])
(global-set-key [?\H-j] [left])
(global-set-key (kbd "C-l") [right])
(global-set-key (kbd "M-i") [C-up])
(global-set-key (kbd "M-k") [C-down])
(global-set-key (kbd "M-j") [C-left])
(global-set-key (kbd "M-l") [C-right])

;;p = delete 删除 向后删单词
;;n = kill-line 删除行
;; (global-set-key (kbd "C-p") "\C-d")
(global-set-key (kbd "C-p") [delete])
;;(global-set-key (kbd "M-p") 'kill-word)
(global-set-key (kbd "M-p") "\M-d")
(global-set-key (kbd "C-M-p") 'my-kill-word)
(global-set-key (kbd "C-n") 'kill-line)
(global-set-key (kbd "M-n") 'kill-whole-line)

;;h = backspace 退格键 向前删单词
(global-set-key (kbd "M-h") 'backward-kill-word)
;;C-TAB = indent
(global-set-key [C-tab] 'indent-for-tab-command)



;;window控制键位
(defun display-buffer-name ()
  (interactive)
  (message (buffer-file-name (current-buffer))))

(defun back-window ()
  (interactive)
  (other-window -1))
;;9,0 = tabbar 和 window 的切换
;; (global-set-key (kbd "C-M-9")'tabbar-backward-group)
;; (global-set-key (kbd "C-M-0") 'tabbar-forward-group)
;; (global-set-key (kbd "C-9") 'tabbar-backward)
;; (global-set-key (kbd "C-0") 'tabbar-forward)
(global-set-key (kbd "M-9") 'back-window)
(global-set-key (kbd "M-0") 'other-window)

;;tabbar废弃,使用elscreen
;;(global-set-key  [\?C-9] 'elscreen-previous)
;;(global-set-key  [\?C-0]   'elscreen-next)

;;8 = 关闭buffer 或者 window
;;(global-set-key (kbd "C-8") 'kill-this-buffer)
(global-set-key (kbd "M-8") 'delete-window)
(global-set-key (kbd "C-M-8") 'kill-buffer-and-window)

;;1,2,3控制窗口分割
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
;;(global-set-key [(meta backspace)] 'delete-window)
(global-set-key (kbd "M-5") 'display-buffer-name)

;;jump 到文件
(global-set-key (kbd "C-x f") 'find-file-at-point)
;;重载buffer
(global-set-key (kbd "C-x c") 'revert-buffer)




;;调整line or region 的上下位置
(global-set-key [s-up] (quote move-region-up))
(global-set-key [s-down] (quote move-region-down))
;;旋转window
(global-set-key "\M-7" 'circle-windows)



;; Emacs才是世界上最强大的IDE － 用Emaci阅读文件
;; http://emacser.com/emaci.htm
;;(require 'emaci-settings)

(require 'emacs-buffer)
