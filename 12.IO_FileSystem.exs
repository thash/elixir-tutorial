# get input
IO.gets "yes or no?\n"

# to write STDERR
iex(5)> IO.puts :stderr, "hello world"
hello world
:ok

# A file can also be opened with :utf8 encoding, which tells the File module to interpret the bytes read from the file as UTF-8-encoded bytes.


# when you add !, raise error if reading file fails
iex(6)> File.read "hello.txt"
{:error, :enoent}
iex(7)> File.read! "hello.txt"
** (File.Error) could not read file "hello.txt": no such file or directory
    (elixir) lib/file.ex:244: File.read!/1

# Avoid writing:
{:ok, body} = File.read(this_is_bad_example)


iex(8)> Path.join "/", "foo", "bar"
** (UndefinedFunctionError) function Path.join/3 is undefined or private. Did you mean one of:

      * join/1
      * join/2

    (elixir) Path.join("/", "foo", "bar")
iex(8)> Path.join "/", "foo"
"/foo"
iex(9)> Path.expand "~/.ssh/"
"/Users/hash/.ssh"


# You may have noticed that File.open/2 returns a tuple like {:ok, pid}:
iex> {:ok, file} = File.open "hello", [:write]
{:ok, #PID<0.47.0>}
# That happens because the IO module actually works with processes (see chapter 11).
