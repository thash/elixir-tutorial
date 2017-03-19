# use recursion istead of loop with mutation

defmodule MyCalc do
  def fib(n) when n <= 0, do: raise("invalid")
  # http://elixir-lang.org/getting-started/case-cond-and-if.html#expressions-in-guard-clauses
  def fib(n) when not is_integer(n), do: raise("invalid type")
  def fib(n) when n <= 2, do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)
end

iex(10)> Enum.map((1..12), &MyCalc.fib(&1))
[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]

iex(12)> Enum.reduce([1,2,3,4,5,6,7,8,9,10], 0, &(&1 + &2))
55
