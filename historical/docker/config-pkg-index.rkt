#lang racket/base
(require racket/runtime-path)
(require net/url)
(require web-server/http)
(require "../main.rkt")
(define-runtime-path here ".")
(define var "/var/lib/pkgserver")
(main (hash 'static-path (build-path var "public_html/pkg-index-static")
            'root (build-path var "pkg-index")
            's3cmd-path "/bin/true" ;; TODO
            'redirect-to-static-proc
            (lambda (req)
              (printf "Would redirect to static version of ~a\n"
                      (url->string (request-uri req)))
              (redirect-to "http://localhost/~tonyg/pkg-catalog-static/FIXME"))
            'email-sender-address "The Beta Racket Package Server <new-pkg-server-beta@racket-lang.org>"
            'atom-package-url-format-string
              "https://localhost/~~tonyg/pkg-catalog-static/package/~a"
            ))
