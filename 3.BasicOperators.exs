iex(73)> [1, 2, 3] ++ [9]
[1, 2, 3, 9]

iex(72)> [1, 2, 3] -- [2]
[1, 3]

iex(74)> "foo" <> "bar"
"foobar"

iex(75)> (1 == 1) and is_float(3.14)
true

iex(76)> (1 == 2) or raise("wawaaaaaaa")
** (RuntimeError) wawaaaaaaa

# Note: If you are an Erlang developer,
# `and` and `or` in Elixir actually map to the andalso and orelse operators in Erlang.

# and ... &&
# or  ... ||

iex(78)> nil && 13
nil

iex(79)> !(1 == 99)
true
