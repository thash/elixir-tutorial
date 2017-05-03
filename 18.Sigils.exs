# http://elixir-lang.org/getting-started/sigils.html
# Sigils start with the tilde (~) character which is followed by a letter (which identifies the sigil) and then a delimiter

# Regex ... Sigil example
~r/hoge/
~r|hoge|

# ~r/foo/ is equivalent to calling sigil_r
sigil_r(<<"hoge">>, 'i')
~r/hoge/i

# difference between "hello" and 'hello'

# "" creates BitString
iex(3)> i "hello"
# Data type
#   BitString
# Description
#   This is a string: a UTF-8 encoded binary. It's printed surrounded by
#   "double quotes" because all UTF-8 encoded codepoints in it are printable.
# Raw representation
#   <<104, 101, 108, 108, 111>>
# Reference modules
#   String, :binary

# '' creates List of char
'hello' |> List.first
104
iex(4)> i 'hello'
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

~s(this is a string with "double" quotes, not 'single' ones)
# => "this is a string with \"double\" quotes, not 'single' ones"

~c(this is a "char list" containing 'single quotes')
# => 'this is a "char list" containing \'single quotes\''

~w|aaa bb c|  #=> ["aaa", "bb", "c"]
~w|aaa bb c|a #=> [:aaa, :bb, :c]

# iex(13)> ~s"""
# ...(13)> this
# ...(13)> is a
# ...(13)> heredoc
# ...(13)> ~~~
# ...(13)> """
# "this\nis a\nheredoc\n~~~\n"

# define origilnal sigils

defmodule MySigils do
  def sigil_i(str, []), do: String.to_integer(str)
  def sigil_i(str, [?n]), do: -String.to_integer(str)
end
import MySigils
~i|123|n # => -123


# https://github.com/elixir-lang/elixir/blob/ac1194b386d039528ed39bb386284356915fcd1e/lib/elixir/lib/kernel.ex#L4388-L4415
defmacro sigil_r(term, modifiers)
defmacro sigil_r({:<<>>, _meta, [string]}, options) when is_binary(string) do
  binary = Macro.unescape_string(string, fn(x) -> Regex.unescape_map(x) end)
  regex  = Regex.compile!(binary, :binary.list_to_bin(options))
  Macro.escape(regex)
end

# https://github.com/elixir-lang/elixir/blob/26f68bc79bc875368af85a51a085a11664b338dc/lib/elixir/lib/macro.ex#L9
# https://github.com/elixir-lang/elixir/blob/26f68bc79bc875368af85a51a085a11664b338dc/lib/elixir/lib/macro.ex#L933-L944
defp sigil_call({func, _, [{:<<>>, _, _} = bin, args]} = ast, fun) when is_atom(func) and is_list(args) do
  sigil =
    case Atom.to_string(func) do
      <<"sigil_", name>> ->
        "~" <> <<name>> <>
        interpolate(bin, fun) <>
        sigil_args(args, fun)
      _ ->
        nil
    end
  fun.(ast, sigil)
end
