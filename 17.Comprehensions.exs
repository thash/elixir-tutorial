# http://elixir-lang.org/getting-started/comprehensions.html

for n <- [1,2,3,4], do: n * n
[1, 4, 9, 16]

# cannot use do ... end. only do: ...
for n <- [1,2,3,4], do n * n end
** (SyntaxError) iex:3: unexpected token "do". In case you wanted to write a "do" expression, you must either separate the keyword argument with comma or use do-blocks. For example, the following construct:

# for in ruby does not return evaluated value. use map for this purpose
for i in [1,2,3,4] do
  i * i
end
# => [1, 2, 3, 4]
[1,2,3,4].map do |i|
  i * i
end
# => [1, 4, 9, 16]

multiple_of_3? = fn(n) -> rem(n, 3) == 0 end
#Function<6.118419387/1 in :erl_eval.expr/5>

multiple_of_3?.(100) #=> false
multiple_of_3?.(101) #=> false
multiple_of_3?.(102) #=> true
for n <- 0..10, multiple_of_3?.(n), do: n * n
[0, 9, 36, 81]

# difference between for/Enum.map, for match/Enum.filter

for i <- [:a, :b, :c], j <- [1,2], do: {i, j}
[a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]

iex(11)> asdf = fn(n) -> for a <- 1..n, b <- 1..n, c <- 1..n, a + b + c <= n, a*a + b*b == c*c, do: {a,b,c} end
#Function<6.118419387/1 in :erl_eval.expr/5>
iex(13)> asdf.(12)
[{3, 4, 5}, {4, 3, 5}]
iex(15)> asdf.(60)
[{3, 4, 5}, {4, 3, 5}, {5, 12, 13}, {6, 8, 10}, {7, 24, 25}, {8, 6, 10},
 {8, 15, 17}, {9, 12, 15}, {10, 24, 26}, {12, 5, 13}, {12, 9, 15}, {12, 16, 20},
 {15, 8, 17}, {15, 20, 25}, {16, 12, 20}, {20, 15, 25}, {24, 7, 25},
 {24, 10, 26}]

# for more effective search: a <- 1..n-2, b <- a+1..n-1, b+1..n

# into ... change output format
for n <- [1,2,3,4], into: %{}, do: {n, n * n}
%{1 => 1, 2 => 4, 3 => 9, 4 => 16}

for n <- [1,2,3,4], into: %{}, do: {String.to_atom(Integer.to_string(n)), n * n}
%{"1": 1, "2": 4, "3": 9, "4": 16}

# by default (without into), when using "for" with map it automatically convert map into list.
for {key, val} <- %{ruby: 100, erlang: 120, elixir: 150}, do: {key, val * val}
[elixir: 22500, erlang: 14400, ruby: 10000]

# A common use case of :into can be transforming values in a map
for {key, val} <- %{ruby: 100, erlang: 120, elixir: 150}, into: %{}, do: {key, val * val}
%{elixir: 22500, erlang: 14400, ruby: 10000}
