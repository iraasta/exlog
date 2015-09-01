defmodule Exlog do
  
  
  defmacro __using__([]) do
    quote do
      import Exlog
      Module.register_attribute __MODULE__,
      :rules, accumulate: true, persist: false
    end
  end

  defmacro simulation(block) do
    quote do
      var!(rules) = []
      unquote(block)
    end
  end
  
  defmacro fact({name, _, params}) do
    IO.inspect(name)
    IO.inspect(params)
    quote do
      rules = var!(rules)
      var!(rules) = [{unquote(name), unquote(params)}| rules ]
    end
  end
  defmacro fact(defin, block) do
    IO.inspect(defin)
    quote do: 0
  end

  defmacro solve(do: {name, _, params}) do
    quote do: do_solve(unquote({name, params}), var!(rules))
  end

  def do_solve(block, rules) do
    Enum.reduce rules, false, fn a, b -> b || (a == block) end 
  end
end
