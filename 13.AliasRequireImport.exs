### alias
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar
# or, multi alias
alias MyApp.{Foo, Bar, Baz}


# understainding alias
defmodule Foo do
  defmodule Bar do
  end
end
# The code above is exactly the same as:
defmodule Elixir.Foo do
  defmodule Elixir.Foo.Bar do
  end
  alias Elixir.Foo.Bar, as: Bar
end

# An alias in Elixir is a capitalized identifier (like String, Keyword, etc) which is converted to an atom during compilation. For instance, the String alias translates by default to the atom :"Elixir.String":

# へぇ

iex(17)> is_atom(List)
true
iex(18)> to_string(List)
"Elixir.List"


### require
# Ensure the module is compiled and available (usually for macros)
require Foo
# Macros are chunks of code that are executed and expanded at compilation time. This means, in order to use a macro, we need to guarantee its module and implementation are available during compilation. This is done with the require directive:
# In Elixir, Integer.is_odd/1 is defined as a macro so that it can be used as a guard. This means that, in order to invoke Integer.is_odd/1, we need to first require the Integer module.

### import & use
# Import functions from Foo so they can be called without the `Foo.` prefix
import Foo

# Invokes the custom code defined in Foo as an extension point
use Foo
# Although not a directive, use is a macro tightly related to require that allows you to use a module in the current context. The use macro is frequently used by developers to bring external functionality into the current lexical scope, often modules.
# use requires the given module and then calls the __using__/1 callback on it allowing the module to inject some code into the current context.
# Generally speaking, the following module:
defmodule Example do
 use Feature, option: :value
end
# is compiled into
defmodule Example do
 require Feature
 Feature.__using__(option: :value)
end

# default modules are defined under Elixir. namespace.
# Note: All modules defined in Elixir are defined inside a main Elixir namespace. However, for convenience, you can omit “Elixir.” when referencing them.

iex(15)> import List, only: [duplicate: 2]
List
iex(16)> duplicate :hey, 5
[:hey, :hey, :hey, :hey, :hey]

# import also supports :macros and :functions to be given to :only. For example, to import all macros, one could write:
import Integer, only: :macros


# you don’t have to define the Foo module before being able to define the Foo.Bar modul, as the language translates all module names to atoms. e
