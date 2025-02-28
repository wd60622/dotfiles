; python_docstrings.scm

; Module docstring
(module . (expression_statement (string) @comment))

; Module docstring
(module
  (expression_statement (string) @comment)
  (#match? @comment "^\"\"\"")
  (#match? @comment "\"\"\"$"))

; Class docstring
(class_definition
  body: (block . (expression_statement (string) @comment)))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string) @comment)))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @comment))


; leave space after comment marker if there is one
((comment) @single_comment)
