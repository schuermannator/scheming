# Scheming with LISP  
Learning Scheme/Common Lisp

## Resources  
- The Little Schemer 4th Ed.
- The Seasoned Schemer 2nd Ed.
- The Reasoned Schemer 2nd Ed.
- The Little Typer
- [Practical Common Lisp](http://www.gigamonkeys.com/book/)
- [Teach Yourself Scheme in Fixnum Days](http://ds26gte.github.io/tyscheme/index.html)

## Getting Started  

#### Scheme Installation
- [MIT/GNU Scheme 10.1.3 Binary](https://www.gnu.org/software/mit-scheme/)
- Link after install
```bash
$ sudo ln -s /Applications/MIT\:GNU\ Scheme\ 10.1.3.app/Contents/Resources /usr/local/lib/mit-scheme-x86-64
$ sudo ln -s /usr/local/lib/mit-scheme-x86-64/mit-scheme /usr/local/bin/scheme
```
- Invoke interpreter with `scheme` and `C-c q` to quit (or (exit))

#### Common Lisp Installation
- [Steel Bank Common Lisp (SBCL)](http://sbcl.org/getting.html)
- `$ brew install sbcl` (current version 1.4.14)
- invoke with `sbcl` and `(quit)` to quit

#### Development Environment
- Evil-mode Emacs 
- Using scheme-mode
- `M-x run-scheme`
- Load file `C-c C-l`
- Eval s-expr before cursor: `C-x C-e`
- Switch buffers `C-x o`

#### Check this out
[Cool Repo](https://github.com/siraben/zkeme80)
