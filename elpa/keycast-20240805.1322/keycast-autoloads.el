;;; keycast-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "keycast" "keycast.el" (0 0 0 0))
;;; Generated autoloads from keycast.el

(defvar keycast-mode-line-mode nil "\
Non-nil if Keycast-Mode-Line mode is enabled.
See the `keycast-mode-line-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keycast-mode-line-mode'.")

(custom-autoload 'keycast-mode-line-mode "keycast" nil)

(autoload 'keycast-mode-line-mode "keycast" "\
Show current command and its key binding in the mode line.

This is a minor mode.  If called interactively, toggle the
`Keycast-Mode-Line mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='keycast-mode-line-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(defvar keycast-header-line-mode nil "\
Non-nil if Keycast-Header-Line mode is enabled.
See the `keycast-header-line-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keycast-header-line-mode'.")

(custom-autoload 'keycast-header-line-mode "keycast" nil)

(autoload 'keycast-header-line-mode "keycast" "\
Show current command and its key binding in the header line.

This is a minor mode.  If called interactively, toggle the
`Keycast-Header-Line mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='keycast-header-line-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(defvar keycast-tab-bar-mode nil "\
Non-nil if Keycast-Tab-Bar mode is enabled.
See the `keycast-tab-bar-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keycast-tab-bar-mode'.")

(custom-autoload 'keycast-tab-bar-mode "keycast" nil)

(autoload 'keycast-tab-bar-mode "keycast" "\
Show current command and its key binding in the tab bar.

This is a minor mode.  If called interactively, toggle the
`Keycast-Tab-Bar mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='keycast-tab-bar-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(defvar keycast-log-mode nil "\
Non-nil if Keycast-Log mode is enabled.
See the `keycast-log-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `keycast-log-mode'.")

(custom-autoload 'keycast-log-mode "keycast" nil)

(autoload 'keycast-log-mode "keycast" "\
Log invoked commands and their key bindings in a buffer.

This is a minor mode.  If called interactively, toggle the
`Keycast-Log mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='keycast-log-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "keycast" '("keycast-" "read-passwd"))

;;;***

;;;### (autoloads nil nil ("keycast-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; keycast-autoloads.el ends here
