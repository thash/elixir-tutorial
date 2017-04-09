# map vs Structs
# map is a Struct.
# Structs take the name of the module they’re defined in.
iex(1)> defmodule User do
...(1)>   defstruct name: "John", age: 27
...(1)> end
{:module, User,
 <<70, 79, 82, 49, 0, 0, 9, 48, 66, 69, 65, 77, 69, 120, 68, 99, 0, 0, 0, 186,
   131, 104, 2, 100, 0, 14, 101, 108, 105, 120, 105, 114, 95, 100, 111, 99, 115,
   95, 118, 49, 108, 0, 0, 0, 4, 104, 2, ...>>, %User{age: 27, name: "John"}}

iex(2)> User
User
iex(3)> %User{}
%User{age: 27, name: "John"}
iex(4)> %User{age: 14, name: "lain"}
%User{age: 14, name: "lain"}

# Struct is just a map.
iex(10)> Map.put(%User{}, :age, 14)
%User{age: 14, name: "John"}

# Structs provide compile-time guarantees that only the fields (and all of them)
# defined through defstruct will be allowed to exist in a struct:
iex(5)> %User{sex: "male"}
** (KeyError) key :sex not found in: %User{age: 27, name: "John"}
    (stdlib) :maps.update(:sex, "male", %User{age: 27, name: "John"})
             iex:2: anonymous fn/2 in User.__struct__/1
    (elixir) lib/enum.ex:1755: Enum."-reduce/3-lists^foldl/2-0-"/3
             expanding struct: User.__struct__/1
             iex:5: (file)

iex(5)> me = %User{}
%User{age: 27, name: "John"}

iex(7)> hogesan = %{me | name: "hoge"} # update syntax "|"
%User{age: 27, name: "hoge"}

iex(8)> me.
__struct__    age           name
iex(8)> me.__struct__
User

# struct is a map.
iex(9)> is_map(me)
true

# Erlang's Record?

# default = nil
iex(14)> defmodule Product do
...(14)>   defstruct [:name]
...(14)> end
iex(15)> %Product{}
%Product{name: nil}
iex(16)> %Product{name: "hi"}
%Product{name: "hi"}

# require keys
iex(20)> defmodule Product do
...(20)>   @enforce_keys [:name]
...(20)>   defstruct [:name]
...(20)> end

iex(21)> %Product{}
** (ArgumentError) the following keys must also be given when building struct Product: [:name]
    expanding struct: Product.__struct__/1
    iex:21: (file)
