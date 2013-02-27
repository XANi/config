;;; xani-undo-tree.el ---
;;
(require 'undo-tree)

(global-undo-tree-mode)
(setq
 undo-tree-visualizer-diff t
 undo-tree-visualizer-timestamps t
 undo-tree-mode-lighter " UT"
 )
(provide 'xani-undo-tree)
