raise "hoge"
raise ArgumentError, message: "hogehoge"

defmodule MyError do
  defexception message: "default message"
end

iex(3)> raise MyError
** (MyError) default message

try do
  raise "oops"
rescue
  e in RuntimeError -> e
end

# In practice, however, Elixir developers rarely use the try/rescue construct.
case File.read "hoge.txt" do
  {:ok, body}      -> IO.puts "Success : #{body}"
  {:error, reason} -> IO.puts "Error   : #{reason}"
end

# In Elixir, a value can be thrown and later be caught
try do
  Enum.each -50..50, fn(x) ->
    if rem(x, 17) == 0, do: throw(x)
  end
  "nothing"
catch
  x -> "Got #{x}"
end
#=> "Got -34"

# However there's a better way than throw.
Enum.find -50..50, &(rem(&1, 17) == 0)
# => -34

# When a process dies of “natural causes” (e.g., unhandled exceptions), it sends an exit signal.
# A process can also die by explicitly sending an exit signal
# Processes usually run under supervision trees which are themselves processes that listen to exit signals from the supervised processes.
# Once an exit signal is received, the supervision strategy kicks in and the supervised process is restarted.

# After with try ... like "finally"
# Else with try ... executed only when no error

aaa = fn(x) ->
  try do
    1 / x
  rescue
    ArithmeticError -> :infinity
  else
    y when y < 1 and y > -1 -> :small
    _ -> :large
  end
end

iex(15)> aaa.(0)
:infinity
iex(16)> aaa.(1)
:large
iex(17)> aaa.(2)
:small
