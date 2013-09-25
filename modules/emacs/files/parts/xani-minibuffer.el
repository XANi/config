;;; xani-minibuffer.el ---
;;

(setq
 enable-recursive-minibuffers t
 minibuffer-prompt-properties (quote(read-only t point-entered minibuffer-avoid-prompt))
)


(provide 'xani-minibuffer)
