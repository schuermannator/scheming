# Racket

Goals:
- Learn LOP with racket
- Go through [beautiful racket](https://beautifulracket.com)

## Setup

Installed with Homebrew: 
```bash
$ brew cask install racket
```

```racket
#lang racket

(require 2htdp/image) ; draw a picture
(let sierpinski ([n 8])
  (cond
    [(zero? n) (triangle 2 'solid 'red)]
    [else (define t (sierpinski (- n 1)))
          (freeze (above t (beside t t)))]))
```

Using [racket-mode](https://github.com/greghendershott/racket-mode) with Emacs. 
