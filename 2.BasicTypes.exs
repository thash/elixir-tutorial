iex(10)> i 1
Term
  1
Data type
  Integer
Reference modules
  Integer
Implemented protocols
  IEx.Info, Inspect, List.Chars, String.Chars

iex(12)> i 1.0
Term
  1.0
Data type
  Float
Reference modules
  Float
Implemented protocols
  IEx.Info, Inspect, List.Chars, String.Chars

iex(14)> i [1,2,3]
Term
  [1, 2, 3]
Data type
  List
Reference modules
  List
Implemented protocols
  IEx.Info, Collectable, Enumerable, Inspect, List.Chars, String.Chars

iex(36)> [1,2,3] ++ [4,5,6]
[1, 2, 3, 4, 5, 6]

iex(16)> i {1,2,3}
Term
  {1, 2, 3}
Data type
  Tuple
Reference modules
  Tuple
Implemented protocols
  IEx.Info, Inspect


iex(69)> elem({:ok, 1, true, :hoge}, 3)
:hoge


iex(17)> i :attt
Term
  :attt
Data type
  Atom
Reference modules
  Atom
Implemented protocols
  IEx.Info, Inspect, List.Chars, String.Chars

_
iex(20)> div(10,2)
5
iex(21)> round(3.14)
3

iex(22)> is_integer(234)
true

iex(23)> is_
is_atom/1         is_binary/1       is_bitstring/1    is_boolean/1
is_float/1        is_function/1     is_function/2     is_integer/1
is_list/1         is_map/1          is_nil/1          is_number/1
is_pid/1          is_port/1         is_reference/1    is_tuple/1

iex(23)> world = "Earth"
"Earth"
iex(24)> "hello #{world}"
"hello Earth"


### Anonymous Functions

iex(25)> add = fn a,b -> a + b end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(26)> add(1,2)
** (CompileError) iex:26: undefined function add/2

iex(26)> add.(1,2)
3

# http://elixir-lang.org/getting-started/basic-types.html
# Note a dot (.) between the variable and parentheses is required to invoke an anonymous function...
# Elixir makes a clear distinction between anonymous functions and named functions. We will explore those differences in Chapter 8.

iex(27)> i add
Term
  #Function<12.52032458/2 in :erl_eval.expr/5>
Data type
  Function
Type
  local
Arity
  2
Description
  This is an anonymous function.
Implemented protocols
  IEx.Info, Enumerable, Inspect


iex(41)> i div
warning: variable "div" does not exist and is being expanded to "div()", please use parentheses to remove the ambiguity or change the variable name
  iex:41
** (CompileError) iex:41: undefined function div/0

iex(41)> h div

                           def div(dividend, divisor)

Performs an integer division.

Raises an ArithmeticError exception if one of the arguments is not an integer,
or when the divisor is 0.

Allowed in guard tests. Inlined by the compiler.

div/2 performs truncated integer division. This means that the result is always
rounded towards zero.

If you want to perform floored integer division (rounding towards negative
infinity), use Integer.floor_div/2 instead.

## Examples

    div(5, 2)
    #=> 2

    div(6, -4)
    #=> -1

    div(-99, 2)
    #=> -49

    div(100, 0)
    #=> ** (ArithmeticError) bad argument in arithmetic expression


### car/cdr
iex(45)> hd([1,2,3])
1
iex(46)> tl([1,2,3])
[2, 3]

iex(47)> [104, 101, 108, 108, 111]
'hello'

# iex(50)> i 'hello'
# Term
#   'hello'
# Data type
#   List
# Description
#   This is a list of integers that is printed as a sequence of characters
#   delimited by single quotes because all the integers in it represent valid
#   ASCII characters. Conventionally, such lists of integers are referred to as
#   "charlists" (more precisely, a charlist is a list of Unicode codepoints,
#   and ASCII is a subset of Unicode).
# Raw representation
#   [104, 101, 108, 108, 111]
# Reference modules
#   List
# Implemented protocols
#   IEx.Info, Collectable, Enumerable, Inspect, List.Chars, String.Chars
#
# iex(48)> i "hello"
# Term
#   "hello"
# Data type
#   BitString
# Byte size
#   5
# Description
#   This is a string: a UTF-8 encoded binary. It's printed surrounded by
#   "double quotes" because all UTF-8 encoded codepoints in it are printable.
# Raw representation
#   <<104, 101, 108, 108, 111>>
# Reference modules
#   String, :binary
# Implemented protocols
#   IEx.Info, Collectable, Inspect, List.Chars, String.Chars

iex(49)> 'hello' == "hello"
false

iex(55)> is_tuple({:ok, "hello", 1, 3, true})
true


# Lists are stored in memory as linked lists
iex(56)> hoge = [1 | [2 | [3 | []]]]
[1, 2, 3]

iex(58)> [hoge | 4]
[[1, 2, 3] | 4] # NG.

iex(59)> [999 | hoge]
[999, 1, 2, 3] # OK.


iex(65)> File.read("README.md")
{:ok,
 "http://elixir-lang.org/getting-started/introduction.html\n\n$ elixir --version..."}

iex(66)> File.stream!("README.md")
%File.Stream{line_or_bytes: :line, modes: [:raw, :read_ahead, :binary],
 path: "README.md", raw: true}


# Elixir also provides Port, Reference, and PID as data types (usually used in process communication)
