# Protocols are a mechanism to achieve polymorphism in Elixir.
# multiple size functions: byte_size, tuple_size... let's define Size protocol for them.

defprotocol Size do
  @doc "Calculate the size"
  def size(data) # without do...end
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end


iex(11)> Size.size("hello")
5
iex(10)> Size.size({:ok, "hello"})
2

iex(12)> Size.size([1,2,3])
** (Protocol.UndefinedError) protocol Size not implemented for [1, 2, 3]
    iex:1: Size.impl_for!/1
    iex:3: Size.size/1

# we need to impl for List.

iex(12)> defimpl Size, for: List do
...(12)>   def size(list), do: List.
Chars                 delete/2              delete_at/2
duplicate/2           first/1               flatten/1
flatten/2             foldl/3               foldr/3
insert_at/3           keydelete/3           keyfind/3
keyfind/4             keymember?/3          keyreplace/4
keysort/2             keystore/4            keytake/3
last/1                myers_difference/2    pop_at/2
pop_at/3              replace_at/3          to_atom/1
to_existing_atom/1    to_float/1            to_integer/1
to_integer/2          to_string/1           to_tuple/1
update_at/3           wrap/1                zip/1

...(12)>   def size(list), do: Enum
Enum          Enumerable
...(12)>   def size(list), do: Enumerable.
File         Function     GenEvent     HashDict     HashSet      IO
List         Map          MapSet       Range        Stream       count/1
member?/2    reduce/3
...(12)>   def size(list), do: Enumerable.List.
count/1      member?/2    reduce/3
...(12)>   def size(list), do: Enumerable.List.count(list)
...(12)> end

defimpl Size, for: List do
  def size(list), do: Enumerable.List.count(list)
end

iex(13)> Size.size([1,2,3])
{:error, Enumerable.List}

# oh...

iex(15)> i [1,2,3]
Term
  [1, 2, 3]
Data type
  List
Reference modules
  List
Implemented protocols
  IEx.Info, Collectable, Enumerable, Inspect, List.Chars, String.Chars

# correct. surely it's a list.
# there's native (?) funciton.
iex(16)> length([1,2,3])
3
iex(17)> :erlang.length([1,2,3])
3

iex(18)> defimpl Size, for: List do
...(18)>   def size(list), do: length(list)
...(18)> end
warning: redefining module Size.List (current version defined in memory)

iex(19)> Size.size([1,2,3])
3

# OK.

# define something like "method_missing"
defimpl Size, for: Any do
  def size(_), do: nil
end

iex(21)> Size.size(:asdf)
** (Protocol.UndefinedError) protocol Size not implemented for :asdf
    iex:1: Size.impl_for!/1
    iex:3: Size.size/1

# ? => we need to declare @fallback_to_any

defprotocol Size do
  @fallback_to_any true
  def size(data)
end

iex(24)> Size.size(:asdf)
nil
iex(25)> Size.size(999)
nil

# derive. ... alternative to using @fallback_to_any
defmodule OtherUser do
  @derive [Size]
  defstruct [:name, :age]
end
# When deriving, Elixir will implement the Size protocol
# for OtherUser based on the implementation provided for Any.

# Elixir ships with some built-in protocols.
# ...Enum module which provides many functions that work with any data structure
# that implements the Enumerable protocol

iex(26)> "num: #{25}"
"num: 25"

iex(27)> "tuple: #{{:x,:y:,3}}"
** (SyntaxError) iex:27: unexpected token: ":" (column 17, codepoint U+003A)

iex(27)> "tuple: #{inspect {:x,:y,3}}"
"tuple: {:x, :y, 3}"


# consolidation...
# Because a protocol can dispatch to any data type,
# the protocol must check on every call if an implementation for the given type exists.
# This may be expensive.

# However, after our project is compiled using a tool like Mix,
# ...the protocol can be consolidated into a very simple and fast dispatch module.
