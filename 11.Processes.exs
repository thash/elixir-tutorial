# http://elixir-lang.org/getting-started/processes.html
# Elixir’s processes should not be confused with operating system processes.
# spawn, send, receive ... and Links, Tasks, State

iex(32)> pid = spawn fn -> 10 * 2 end

iex(31)> Process.alive?(pid)
false

iex(34)> me = self()
#PID<0.80.0>

iex(35)> send me, {:hello, :hooo}
{:hello, :hooo}
iex(36)> receive do
...(36)>   {:hello, sth} -> "aisatsu from #{sth}"
...(36)> end
"aisatsu from hooo"

iex(40)> send self(), :hahaha
:hahaha
iex(41)> flush()
:hahaha
:ok
iex(42)> flush()
:ok

# iex(38)> Process.list
# [#PID<0.0.0>, #PID<0.1.0>, #PID<0.4.0>, #PID<0.30.0>, #PID<0.31.0>,
# ...
#  #PID<0.77.0>, #PID<0.78.0>, #PID<0.80.0>]

### Links
# The majority of times we spawn processes in Elixir, we spawn them as linked processes.

# the parent process is still running.
iex(43)> spawn fn -> raise("aaaaa") end
#PID<0.141.0>
iex(44)>
18:01:19.401 [error] Process #PID<0.141.0> raised an exception
** (RuntimeError) aaaaa
    :erlang.apply/2
nil

# use spawn_link ... parent dies.
iex(45)> spawn_link fn -> raise("bbbb") end
** (EXIT from #PID<0.80.0>) an exception was raised:
    ** (RuntimeError) bbbb
        :erlang.apply/2
18:01:31.312 [error] Process #PID<0.144.0> raised an exception
** (RuntimeError) bbbb
    :erlang.apply/2

Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>

# Because processes are linked, we now see a message saying the parent process,
# which is the shell process, has received an EXIT signal from another process causing the shell to terminate.
# ... "EXIT from #PID<0,80,0>"


### Tasks
# Tasks build on top of the spawn functions to provide better error reports and introspection:
# Task provides convenience functions, like Task.async/1 and Task.await/1, and functionality to ease distribution.
iex(1)> Task.start fn -> raise("bbbb") end
{:ok, #PID<0.82.0>}
iex(2)>
18:07:35.441 [error] Task #PID<0.82.0> started from #PID<0.80.0> terminating
** (RuntimeError) bbbb
    (elixir) lib/task/supervised.ex:85: Task.Supervised.do_apply/2
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Function: #Function<20.52032458/0 in :erl_eval.expr/5>
    Args: []

nil


### State ... Agent module
# you need to parse a file and keep it in memory, where would you store it?
# We can write processes that loop infinitely, maintain state, and send and receive messages.

# without Agent.
# ... unlike "Task", there's no module named State?
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end
  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

iex(2)> {:ok, pid} = KV.start_link
{:ok, #PID<0.100.0>}
iex(5)> send pid, {:put, :hello, "eeeeeeelixir"}
{:put, :hello, "eeeeeeelixir"}
iex(6)> flush()
:ok
iex(7)> send pid, {:get, :hello, self()}
{:get, :hello, #PID<0.80.0>}
iex(8)> flush()
"eeeeeeelixir"
:ok

# It is also possible to register the pid, giving it a name,
# and allowing everyone that knows the name to send it messages:
iex(9)> Process.register(pid, :conf)
iex(10)> send :conf, {:get, :hello, self()}
iex(11)> flush()
"eeeeeeelixir"
:ok


# we need not to implement KV module like above. just use Agent.
# Elixir provides agents, which are simple abstractions around state:
iex(12)> {:ok, pid} = Agent.start_link(fn -> %{} end)
{:ok, #PID<0.112.0>}
iex(13)> Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
:ok
iex(14)> Agent.get(pid, fn map -> Map.get(map, :hello) end)
:world


# Besides agents, Elixir provides an API for building generic servers (called GenServer),
# tasks, and more, all powered by processes underneath.
