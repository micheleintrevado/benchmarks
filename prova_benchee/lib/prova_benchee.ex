defmodule TestPrivate do
  def double(a) do
    sum(a, a)
  end

  defp sum(a,b)do
    a + b
  end
end



user = %{name: "Michele" , age: 25} # %{name: "Michele", age: 25}
Map.put(user, :age, 26) # %{name: "Michele", age: 26}
IO.inspect (user) # %{name: "Michele", age: 25}
user = Map.put(user , :age , 26 ) # # %{name: "Michele", age: 26}
IO.inspect(user) # %{name: "Michele", age: 26}



list = Enum.to_list(1..10_000)
map_fun = fn i -> [i, i * i] end

Benchee.run(%{
  "flat_map"    => fn -> Enum.flat_map(list, map_fun) end,
  "map.flatten" => fn -> list |> Enum.map(map_fun) |> List.flatten() end
},
  save: [path: Path.join(__DIR__, "bench_flat.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "flat/bench_flat.html")}
  ]
)
