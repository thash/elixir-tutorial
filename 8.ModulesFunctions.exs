# http://elixir-lang.org/getting-started/modules-and-functions.html
# In Elixir we group several functions into modules.

iex(175)> defmodule Math do
...(175)>   def sum(a,b) do
...(175)>     a + b
...(175)>   end
...(175)> end
{:module, Math,
 <<70, 79, 82, 49, 0, 0, 4, 204, 66, 69, 65, 77, 69, 120, 68, 99, 0, 0, 0, 157,
   131, 104, 2, 100, 0, 14, 101, 108, 105, 120, 105, 114, 95, 100, 111, 99, 115,
   95, 118, 49, 108, 0, 0, 0, 4, 104, 2, ...>>, {:sum, 2}}
iex(176)> Mat
MatchError    Math
iex(176)> Math.sum(2,3)
5

## Compiling Modules

# [2017/03/18 17:02] ~...elixir-tutorial/8.ModulesFunctions $ cat math.exs
# defmodule Math do
#   def sum(a, b) do
#     a + b
#   end
# end
#
# [2017/03/18 17:03] ~...elixir-tutorial/8.ModulesFunctions $ elixirc math.exs
# [2017/03/18 17:03] ~...elixir-tutorial/8.ModulesFunctions $ ls
# Elixir.Math.beam  math.exs


# > Elixir projects are usually organized into three directories:
# >   ebin - contains the compiled bytecode
# >   lib - contains elixir code (usually .ex files)
# >   test - contains tests (usually .exs files)

# so what's the "exs" we've been writing until now? It reads:
#   > In addition to the Elixir file extension .ex, Elixir also supports .exs files for scripting.
# scripting.
# only .ex files write their bytecode to disk in the format of .beam files.


# defp.
# we can define functions with def/2 and private functions with defp/2

# cannot define private and public function outside module
iex(177)> defp hoge(a) do
...(177)>   IO.puts "hi #{a}"
...(177)> end
** (ArgumentError) cannot invoke defp/2 outside module

iex(178)> def hof(f) do # its' def. not defp
...(178)>   f
...(178)> end
** (ArgumentError) cannot invoke def/2 outside module

# cannot call private functions from outside of the module.
iex(177)> defmodule MyModule do
...(177)>   defp hoge(a) do
...(177)>     IO.puts "hi #{a}"
...(177)>   end
...(177)> end
warning: function hoge/1 is unused
  iex:178
iex(178)> MyModule.hoge("hhh")
** (UndefinedFunctionError) function MyModule.hoge/1 is undefined or private
    MyModule.hoge("hhh")

# Guard function definitions
defmodule Math do
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end
# You may use do: for one-liners but always use do/end for functions spanning multiple lines.


### Refering functions
# [2017/03/18 17:11] ~...elixir-tutorial/8.ModulesFunctions $ iex math.exs
iex(1)> Math.zero?(0)
true

# it's regarded as function call.
iex(2)> is_function(Math.zero?)
** (UndefinedFunctionError) function Math.zero?/0 is undefined or private. Did you mean one of:

      * zero?/1

    Math.zero?()

# to refer function, use &. but we need arity with it.
iex(2)> is_function(&Math.zero?)
** (CompileError) iex:2: invalid args for &, expected an expression in the format of &Mod.fun/arity, &local/arity or a capture containing at least one argument as &1, got: Math.zero?()

iex(2)> is_function(&Math.zero?/1)
true
iex(3)> zerofun = &Math.zero?/1
&Math.zero?/1
iex(5)> zerofun.(99)
false

# Note the capture syntax can also be used as a shortcut for creating functions:
iex(180)> myfun = &(&1 * 100)
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(181)> myfun.(12)
1200

# exactly the same as fn x -> x * 100 end
iex(183)> (fn x -> x * 100 end).(9)
900

iex(184)> fun = &List.flatten(&1, &2)
&List.flatten/2
iex(185)> fun = &List.flatten/2
&List.flatten/2


## Default argument ... `\\`
defmodule Concatter do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

iex(187)> Concatter.join("hello", "me")
"hello me"
iex(188)> Concatter.join("hello", "me", "---")
"hello---me"

# function is called multiple times with default values
defmodule Concatter do
  def join(a, b \\ nil, sep \\ " ") # no content... just applying default values
  def join(a, b, _sep) when is_nil(b), do: (a)
  def join(a, b, sep), do: (a <> sep <> b)
end

iex(190)> Concatter.join("mf")
"mf"
