defmodule MyServer do
  # @vsn is used by the code reloading mechanism in the Erlang VM to check if a module has been updated or not.
  # If no version is specified, the version is set to the MD5 checksum of the module functions.
  @vsn 2
end

# Elixir has a handful of reserved attributes.
# @moduledoc - provides documentation for the current module.
# @doc - provides documentation for the function or macro that follows the attribute.
defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

      iex> Math.sum(1, 2)
      3

  """

  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end

# You could refer these docs by
# iex> h Math
# iex> h Math.sum

# @behaviour - (notice the British spelling) used for specifying an OTP or user-defined behaviour.
# @before_compile - provides a hook that will be invoked before the module is compiled.
#                   This makes it possible to inject functions inside the module exactly before compilation.

defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456} # exists only compilation time!
  IO.inspect @initial_state
end
# Note: Unlike Erlang, user defined attributes are not stored in the module by default.
# The value exists only during compilation time.
# A developer can configure an attribute to behave closer to Erlang by calling Module.register_attribute/3.

# the value is read at compilation time and not at runtime.

# => We cannot use attributes to store "states". They should lie in agents.

# used as temporary storage
# the focus here is on how using module attributes as storage allows developers to create DSLs.

# Plug https://github.com/elixir-lang/plug
#   - A specification for composable modules between web applications
#   - Connection adapters for different web servers in the Erlang VM

defmodule MyPlug do
  use Plug.Builder
  plug :set_header
  def set_header(conn, _opts) do
    put_resp_header(conn, "x-header", "set")
  end
end

# plug/1 macro to connect functions that will be invoked when there is a web request.
# Internally, every time you call plug/1, the Plug library stores the given argument in a @plugs attribute.
