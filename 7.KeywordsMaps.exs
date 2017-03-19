# http://elixir-lang.org/getting-started/keywords-and-maps.html

### Keyword Lists
# keyword list = a list of tuples
iex(156)> [{:a, 1}, {:b, 2}]
[a: 1, b: 2]

# NOTE: [key: val] ... OK / [:key val] ... WRONG
iex(161)> [x: 10]
[x: 10]
iex(162)> [:y 10]
** (SyntaxError) iex:162: syntax error before: 10

iex(159)> list = [{:a, 1}, {:b, 2}]
[a: 1, b: 2]
iex(160)> list ++ [c: 3]
[a: 1, b: 2, c: 3]

# remember if. do/else are actually keyword list.
iex(162)> if false, do: :this, else: :that
:that
iex(163)> if false, [do: :this, else: :that]
:that
iex(164)> if false, [{:do, :this}, {:else, :that}]
:that

iex(166)> [recursive: xx, force: yy] = [recursive: true, force: false]
[recursive: true, force: false]
iex(167)> xx
true
iex(168)> yy
false


### Maps ... like Ruby!
# Maps were recently introduced into the Erlang VM
# and only from Elixir v1.2 they are capable of holding millions of keys efficiently. 
iex(170)> %{:a => 1}
%{a: 1}
iex(169)> %{a: 1}
%{a: 1}
iex(169)> %{:a, 1}
** (SyntaxError) iex:169: syntax error before: '}'

# accessing maps
iex(171)> mymap = %{opt1: 123, opt2: 234}
%{opt1: 123, opt2: 234}
iex(173)> mymap[:opt2]
234
iex(174)> mymap.opt1
123
