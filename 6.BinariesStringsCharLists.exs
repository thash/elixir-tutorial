### UTF-8 and Unicode

iex(126)> is_binary("hoge")
true
iex(131)> is_binary('hoge')
false

iex(130)> is_binary <<1::3>>
false

iex(132)> i <<1::3>>
Term
  <<1::size(3)>>
Data type
  BitString
Bits size
  3
Description
  This is a bitstring. It's a chunk of bits that are not divisible by 8
  (the number of bytes isn't whole).
Implemented protocols
  IEx.Info, Collectable, Inspect, List.Chars, String.Chars

## http://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html
# A string is a UTF-8 encoded binary.
# In order to understand exactly what we mean by that,
# we need to understand the difference between bytes and code points.

# The Unicode standard assigns code points to many of the characters we know.
# For example, the letter a has code point 97 while the letter ł has code point 322.
# When writing the string "hełło" to disk, we need to convert this code point to bytes.
# If we adopted a rule that said one byte represents one code point,
# we wouldn’t be able to write "hełło", because it uses the code point 322 for ł,
# and one byte can only represent a number from 0 to 255.

iex(133)> byte_size("はろー")
9
iex(134)> String.length("はろー")
3

iex(138)> ?は
12399

iex(144)> to_charlist "はろー"
[12399, 12429, 12540]

iex(143)> to_string [12399,12429,12540]
"はろー"

# In Elixir, you can get a character’s code point by using ?:
iex(137)> ?a
97
iex(138)> ?は
12399


### Binaries (and bitstrings)
# In Elixir, you can define a binary using <<>>:

# iex(146)> i <<1,2,3>>
# Term
#   <<1, 2, 3>>
# Data type
#   BitString
# ...
# Description
#   This is a string: a UTF-8 encoded binary. It's printed with the `<<>>`
#   syntax (as opposed to double quotes) because it contains non-printable
#   UTF-8 encoded codepoints (the first non-printable codepoint being `<<1>>`)

iex(148)> to_string <<12399>>
"o"
iex(149)> to_string <<12399 :: utf8>> # the number is a code point
"は"

# String partial match
iex(154)> "ふが" <> rest = "ふがほげ"
"ふがほげ"
iex(155)> rest
"ほげ"
