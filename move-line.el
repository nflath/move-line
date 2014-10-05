;;; move-line.el --- utilities for moving lines in file

;; Copyright (C) 2014 Nathaniel Flath <flat0103@gmail.com>

;; Author: Nathaniel Flath <flat0103@gmail.com>
;; URL: http://github.com/nflath/move-line
;; Version: 0.0.2

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file provides several utility functions for moving the current line
;; up/down.  The functions provided are move-line-up and move-line-down, bound
;; to control-shift-up and control-shift-down by default.

;;; Installation

;; To use this mode, put the following in your init.el:
;; (require 'move-line)

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (let ((col (current-column))
        (insert-newline nil)
        start
        end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (if (= (point) (point-max))
        (setq insert-newline t)
      (forward-char))
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      (if (and insert-newline (not (= (point) (point-max)))) (insert "\n"))
      ;; restore point to original column in moved line
      (forward-line -1)
      (forward-char col))))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key [(control shift up)] 'move-line-up)
(global-set-key [(control shift down)] 'move-line-down)

(provide 'move-line)
;;; move-line.el ends here
