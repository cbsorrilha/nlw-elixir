defmodule Inmana.Welcomer do
  # Receber um nome e idade do usuario
  # Se o usuario chamar banana e tiver idade 42, ele recebe mensagem especial
  # Se o usuario for maior de idade, ele recebe uma mensagem normal
  # Se o usuario for menor de idade, retornamos erro
  # tratar nome de usuario para entradas erradas
  def welcome(%{"name" => name, "age" => age}) do
    age = age |> String.to_integer()

    name
    |> String.trim()
    |> String.downcase()
    |> evaluate(age)
  end

  defp evaluate("banana", 42) do
    {:ok, "You are very special banana"}
  end

  defp evaluate(name, age) when age >= 18 do
    {:ok, "Welcome #{name}"}
  end

  defp evaluate(name, _age) do
    {:error, "You shall not pass #{name}"}
  end
end
