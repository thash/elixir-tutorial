# http://elixir-lang.org/getting-started/case-cond-and-if.html

### case

iex(100)> case {1,2,3} do
...(100)>   {9,x,7} ->
...(100)>     "wei"
...(100)>   {1,x,3} ->
...(100)>     "hoi"
...(100)>   _ ->
...(100)>     "default"
...(100)> end
"hoi"

# If you want to pattern match against an existing variable, you need to use the ^ operator:
x = 1
case 10 do
  ^x -> "Won't match"
  _ -> "Will match"
end


### Expressions in guard clauses

iex(101)> case {1,2,3} do
...(101)> {1,x,3} when x > 1 -> "hoge"
...(101)> _ -> :fuga
...(101)> end
"hoge"

iex(102)> f = fn
...(102)>   x,y when x > 0 -> x + y
...(102)>   x,y -> x * y
...(102)> end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(103)> f.(1,3)
4
iex(104)> f.(-9,3)
-27

# errors in guards do not leak but instead make the guard fail:
iex(105)> hd(1)
** (ArgumentError) argument error
    :erlang.hd(1)
iex(105)> case 1 do
...(105)>   x when hd(x) -> "Won't match"
...(105)>   x -> "Got #{x}"
...(105)> end
"Got 1"


### cond
# case is useful when you need to match against different values.
# This is equivalent to else if clauses in many imperative languages


### if and unless
# Note: An interesting note regarding if/2 and unless/2 is that they are implemented as macros in the language;
# https://hexdocs.pm/elixir/Kernel.html

iex(106)> h if
defmacro if(condition, clauses)

Provides an if/2 macro.

This macro expects the first argument to be a condition and the second argument
to be a keyword list.

## One-liner examples

if(foo, do: bar)

# do を非 block 的に書く方法
iex(120)> if 2 == 1 + 1, do: 999+1
1000


### do/end blocks
# "do ... end" = "do: (...)"

iex(121)> if false, do: :this, else: :that
:that

iex(122)> if true do 123 end
123

iex(122)> if true do: (123) end
** (SyntaxError) iex:122: unexpected token: end

iex(123)> if true, do 123 end
** (SyntaxError) iex:123: unexpected token "do".

iex(123)> if true, do: (123)
123


# One thing to keep in mind when using do/end blocks is they are always bound to the outermost function call.
