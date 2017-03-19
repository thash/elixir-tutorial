# http://elixir-lang.org/getting-started/enumerables-and-streams.html
# reduce/map expression
iex(12)> Enum.reduce([1,2,3,4,5,6,7,8,9,10], 0, &(&1 + &2))
55
# 3rd argument is a function, so you could write it like:
iex(14)> Enum.reduce(1..10, 0, &+/2)
55
# most redundant version of the argument function:
iex(15)> Enum.reduce(1..10, 0, fn (a,b) -> a + b end)
55

### Eager vs Lazy
# All the functions in the Enum module are eager.
iex(16)> even? = &(rem(&1, 2) == 0)
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(18)> Enum.filter(1..15, even?)
[2, 4, 6, 8, 10, 12, 14]


### Pipeline
# instead of writing like this,
iex(19)> Enum.map(Enum.filter(1..15, even?), &(&1 * 10))
[20, 40, 60, 80, 100, 120, 140]
# you could use pipeline operator `|>`. like Ruby method chain, or Clojure doto macro.
iex(20)> Enum.filter(1..15, even?) |> Enum.map(&(&1 * 10))
[20, 40, 60, 80, 100, 120, 140]


### Lazy ... use Stream instead of Enum
# As an alternative to Enum, Elixir provides the Stream module which supports lazy operations:

iex(22)> 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(even?) |> Enum.sum
7500150000
iex(21)> 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(even?) |> Enum.sum
7500150000

# creating streams.
iex(23)> stream = Stream.cycle([1, 2, 3])
#Function<61.34404916/2 in Stream.unfold/2>
iex(24)> Enum.take(stream, 10)
[1, 2, 3, 1, 2, 3, 1, 2, 3, 1] # use it to create a kind of clock.

iex(25)> stream = File.stream!("README.md")
%File.Stream{line_or_bytes: :line, modes: [:raw, :read_ahead, :binary],
 path: "README.md", raw: true}
iex(27)> Enum.take(stream, 2)
["http://elixir-lang.org/getting-started/introduction.html\n", "\n"]
