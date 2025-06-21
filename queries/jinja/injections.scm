; Inject YAML syntax into Jinja content nodes
((content) @injection.content
 (#set! injection.language "yaml"))

; Inject YAML syntax into text nodes that contain YAML-like content
((text) @injection.content
 (#match? @injection.content "^[[:space:]]*[a-zA-Z_][a-zA-Z0-9_]*:")
 (#set! injection.language "yaml"))
