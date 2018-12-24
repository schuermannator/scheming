;;; LISP Final Project--1D+2D CA Simulator (Game of Life)
;;; Lucas Schuermann (lvs2124)
;;;
;;; Brief Introduction:
;;;
;;; This project is based upon the simulation of cellular automata. Cellular automata (CA) are 
;;; frequently studied in information and computability theory. CAs defined on grids, where each 
;;; cell has a particular finite state, and a rule updates all states at once.
;;; 1D cellular automata have been used in cryptography, information theory, and more, notably
;;; as explored by Stephen Wolfram's seminal work, A New Kind Of Science.
;;; 2D cellular automata are perhaps best known by the example of Conway's Game of Life, a
;;; specific rule set that produces interesting generative and cyclic behavior, constructed
;;; originally to study the constraints placed on the forward time evolution of small lifeforms.
;;; Perhaps most notably, cellular automata such as Rule 110 and the Game of Life are Turing-
;;; complete, meaning that, given enough space (grid size), computing time (number of steps),
;;; and the proper initial state/configuration, they have the same computational power as the
;;; generalized Turing machine. I won't go into depth about how this works/can be proven, but
;;; I leave some analysis to the user by demonstrating these in simulation, and the following
;;; basic proof idea: tag systems can be used to enumerate repetitious cycles, which can then
;;; shown to map to a set of symbols and operators, which, in limiting time, are produced in
;;; all necessary combinations to approximate a Turing machine.
;;;
;;; Regarding my code, I support both the simulation of 1D and 2D cellular automata. The rendering
;;; system in particular took some work, as I had to try out a number of visualization techniques
;;; for reasonably displaying the grid states in ASCII.
;;;
;;; For 1D simulations, the propagation continues for a set number of steps (the y-dimension of
;;; the simulation), given a central initial state and a constraint on the x-dimension size of
;;; the simulation grid. The final simulated set of states therefore comprise a 2D grid, which is
;;; displayed to the user. The user has the option to select a rule number. The help screen guides
;;; some reasonable choices with interesting behavior (as described above). The convention of the
;;; rule number is a binary encoding of the 8 rule pattern results for the 1D elementary cellular
;;; automaton. For more information about this convention, referred to as the 'Wolfram code',
;;; please see https://en.wikipedia.org/wiki/Elementary_cellular_automaton#The_numbering_system
;;;
;;; For 2D simulations, propagation is in forward time, as 3D visualization is essentially
;;; intractable for the purposes of this project. The rule is fixed, as the search space for
;;; 2D rules is much more complex, and therefore larger, sometimes yielding uninteresting
;;; results. Thus, the implementation follows perhaps the best studied 2D CA, Conway's Game
;;; of Life. For each step in the simulation, the rule is applied, giving a new 2D state which is
;;; rendered as a grid to the user. The free parameter of the simulation is the initial state,
;;; which is the main decider of the time-limiting behavior and interestingness. A number of
;;; different options can be viewed from the prompted help menu, all of which are constructed to
;;; show various interesting systems that can be simulated/become emergent with these very simple
;;; rules. Inspiration for the initial states that provide interesting behaviors came from an
;;; excellent Stanford article on the Game of Life: http://web.stanford.edu/~cdebs/GameOfLife/.
;;;
;;; This LISP project demonstrates a good grasp of user I/O, manipulating data/data structures,
;;; LOOPS (to a very large extent), and the use of functional paradigms (where possible, in
;;; small number), along with the elegance of the language, to make a very powerful concise demo.
;;;
;;; I hope that you find my final project interesting, and I hope that it motivates some interest
;;; in further exploring cellular automata and the research area around them! Thank you! :)
;;;
;;; - Lucas Schuermann, May 2017
;;;
;;;
;;; RUNNING: (ca-sim), follow prompted input guidelines

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; general helpers
(defun make-grid (width height)
        (make-array (list height width) :initial-element nil))

(defun cls()
    (format t "~A[H~@*~A[J" #\escape))

;;; some magic recommended on stackoverflow/google about preserving size when printing ascii grids
(defun draw (grid)
    (destructuring-bind (height width) (array-dimensions grid)
        (loop for y from 0 to (- height 1) by 2 do
            (loop for x from 0 to (- width 1) do
                (let ((v (aref grid y x)) (b (when (< y (- height 1)) (aref grid (+ y 1) x))))
                    (princ
                        (cond
                            ((or (stringp v) (stringp b))
                                (incf x (length (or v b)))
                                (or v b))
                            ((and v b) 
                                #\FULL_BLOCK)
                            (v
                                #\UPPER_HALF_BLOCK)
                            (b 
                                #\LOWER_HALF_BLOCK)
                            (t 
                                #\space)))))
            (fresh-line))))

(defun prompt (string)
    (format t "~a: " string)
    (finish-output nil)
    (read-line))

(defun numeric-string-p (string)
    (let ((*read-eval* nil))
        (ignore-errors (numberp (read-from-string string)))))

;;; 1D simulation logic
(defun gen-rule (seed)
    (loop for c in '((nil nil nil) 
                     (nil nil t) 
                     (nil t nil) 
                     (nil t t) 
                     (t nil nil) 
                     (t nil t) 
                     (t t nil) 
                     (t t t))
        for i from 0 when (logbitp i seed) collect c))

(defun step-1d (x y grid rule-fn)
    (when (find (list
        (aref grid (- y 1) (- x 1))
        (aref grid (- y 1) x)
        (aref grid (- y 1) (+ x 1)))
        rule-fn :test #'equalp)
    (setf (aref grid y x) t)))

(defun sim-1d (rule-number dimx dimy)
    (let ((rule-fn (gen-rule rule-number)) (grid (make-grid dimx dimy)))
        (setf (aref grid 0 (floor dimx 2)) t)
        (loop for y from 1 to (- dimy 1) do
            (loop for x from 1 to (- dimx 2) do
                (step-1d x y grid rule-fn)))
    grid))

;;; http://web.stanford.edu/~cdebs/GameOfLife/#1D
(defun sim-1d-interactive (&optional (dimx 64) (dimy 32))
    (loop do
        (let ((r (prompt "1D: rule number (h for help, q to go back)")))
            (if (not (numeric-string-p r))
                (if (string= r "h")
                    (format t "some interesting rules are '30', '90', and '110' (turing-complete)~%")
                    (return))
                (let ((grid (sim-1d (parse-integer r) dimx dimy)))
                    (draw grid))))))

;;; 2D simulation logic
;;; gets a list of all grid coordinate values
(defun get-grid-coords (dim)
    (let ((coords nil))
        (loop for i from 0 to dim do
            (loop for j from 0 to dim do
                (setf coords (append coords (list (list i j))))))
        coords))

;;; list with neighboring 8 cells
(defun gen-neighbor-coords (x y)
    (list 
        (list (- x 1) (- y 1)) (list (- x 1) y) (list (- x 1) (+ y 1))
        (list x (- y 1)) (list x (+ y 1))
        (list (+ x 1) (- y 1)) (list (+ x 1) y) (list (+ x 1) (+ y 1))))

;;; count neighbors   
(defun get-num-neighbors (state neighbors)
    (let ((ret 0))
        (dolist (neighbor neighbors ret)
            (if (member neighbor state :test #'equal)
                (setf ret (+ 1 ret))))))

;;; implement the game rules for neighbors
(defun test-GOL (num-neighbors cell-alive)
    (cond ((< num-neighbors 2) nil)
        ((and (= num-neighbors 2) cell-alive) t)
        ((= num-neighbors 3) t)
        ((> num-neighbors 3) nil)))

(defun draw-from-state (state grid dim)
    (let ((draw-grid (make-grid dim dim)))
        (dolist (cell grid)
            (when (member cell state :test #'equal)
                (destructuring-bind (y x) cell
                    (progn
                        (when (> y (- dim 1))
                            (setq y (- dim 1)))
                        (when (> x (- dim 1))
                            (setq x (- dim 1)))
                        (setf (aref draw-grid y x) t)))))
        (cls)
        (draw draw-grid)))

(defun step-2d (rule-name state grid dim epochs total-steps)
    (if (zerop epochs)
    epochs
    (progn
        (let ((next-state nil) (num-neighbors 0) (cell-alive nil))
            (dolist (cell grid next-state)
                ;; get our neighbor list
                (let ((neighbors (gen-neighbor-coords (first cell) (second cell))))
                    ; find how many neighbors we have by comparing to the state
                    (setf num-neighbors (get-num-neighbors state neighbors))
                    ; find out if we are alive
                    (setf cell-alive (member cell state :test #'equal))
                    ; update accordingly
                    (if (test-GOL num-neighbors cell-alive)
                        (setf next-state (append next-state (list cell))))))
            (draw-from-state next-state grid dim)
            (format t "initial state: ~a, epoch ~a of ~a~%" rule-name (+ 1 (- total-steps epochs)) total-steps)
            (sleep 0.05)
            (step-2d rule-name next-state grid dim (- epochs 1) total-steps)))))

(defun sim-2d (rule-name init-state dim epochs)
    (let ((grid (get-grid-coords dim)))
        (step-2d rule-name init-state grid dim epochs epochs)))

;;; configs from http://web.stanford.edu/~cdebs/GameOfLife
(defun sim-2d-interactive (&optional (dim 50) (steps 250))
    (loop do
        (let ((r (prompt "2D: starting config (h for help, q to go back)")))
            (when (not (stringp r))
                (return))
            (when (string= r "q")
                (return))
            (if (string= r "h")
                (format t "choose one of the following (default: emitter)~%oscillators: 'blinker', 'beacon'~%ships: 'glider'~%tests: 'convergent', 'chaotic'~%emitter: 'glider gun'~%")
                (let ((init-state '((5 1) (5 2) (6 1) (6 2) (5 11) (6 11) (7 11) (4 12) (3 13) (3 14) (8 12) (9 13) (9 14) (6 15) (4 16) (5 17) (6 17) (7 17) (6 18) (8 16) (3 21) (4 21) (5 21) (3 22) (4 22) (5 22) (2 23) (6 23) (1 25) (2 25) (6 25) (7 25) (3 35) (4 35) (3 36) (4 36))) (name "emitter"))
                    (cond
                        ((string= r "blinker")
                            (setq init-state '((0 1) (1 1) (2 1)))
                            (setq name "blinker"))
                        ((string= r "beacon")
                            (setq init-state '((1 1) (2 1) (1 2) (4 3) (3 4) (4 4)))
                            (setq name "beacon"))
                        ((string= r "glider")
                            (setq init-state '((1 0) (2 1) (0 2) (1 2) (2 2)))
                            (setq name "glider"))
                        ((string= r "convergent")
                            (setq init-state '((0 12) (1 12) (2 12) (1 6) (2 7) (0 8) (1 8) (2 8)))
                            (setq name "convergent"))
                        ((string= r "chaotic")
                            (setq init-state '((7 11) (6 12) (7 12) (8 12) (6 13)))
                            (setq name "chaotic")))
                        ;(string= r "emitter") is already handled by default value
                    (sim-2d name init-state dim steps))))))

;;; user interface helper
(defun ca-sim ()
    (loop do
        (let ((r (prompt "CA dimensionality (1 or 2, q to quit)")))
            (when (not (numeric-string-p r))
                (return))
            (when (= (parse-integer r) 1)
                (sim-1d-interactive))
            (when (= (parse-integer r) 2)
                (sim-2d-interactive)))))
