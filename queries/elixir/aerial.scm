(call
  target: (identifier) @identifier (#any-of? @identifier "defmodule" "defprotocol")
  (arguments) @name
  (#set! "kind" "Function")
  ) @type

(call
  target: (identifier) @identifier (#eq? @identifier "defimpl")
  (arguments
    (alias) @protocol
    (keywords (pair
                key: (keyword) @kw (#match? @kw "^for:")
                value: (alias) @name))
    )
  (#set! "kind" "Function")
  ) @type

(call
  target: (identifier) @identifier (#any-of? @identifier "def" "defp" "defguard" "defmacro" "defmacrop")
  (arguments [
              (call target: (identifier) @name)
              (binary_operator left: (call target: (identifier) @name))
   ])
  (#set! "kind" "Function")
  ) @type

(unary_operator
  operator: "@"
  operand: (call
              target: (identifier) @identifier (#any-of? @identifier "callback" "spec")
  (arguments [
              (call target: (identifier) @name)
              (binary_operator left: (call target: (identifier) @name))
  ]))
  @type
  (#set! "kind" "Function")
  ) @start

(unary_operator
  operator: "@"
  operand: (call
    target: (identifier) @identifier (#eq? @identifier "module_attribute")
    (arguments) @name
    ) @type
  (#set! "kind" "Function")
  ) @start

(unary_operator
  operator: "@"
  operand: (call target: (identifier) @name (#not-any-of? @name "module_attribute" "callback" "spec")) @type
  (#set! "kind" "Constant")
  ) @start


(do_block
  (call
    target: (identifier) @identifier (#eq? @identifier "defstruct")) @type
  (#set! "kind" "Function")
  ) @start

; exunit unit test
(call
  target: (identifier) @identifier (#any-of? @identifier "describe" "test")
  (arguments [(string (quoted_content) @name)])
  (#set! "kind" "Function")
  ) @type

; exunit test setup
(do_block
  (call
    target: (identifier) @identifier @name (#eq? @identifier "setup")) @type
  (#set! "kind" "Function")
  ) @type

