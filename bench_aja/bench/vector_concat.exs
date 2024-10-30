inputs = %{
     "10" => {Enum.to_list(1..10), Enum.to_list(1..10) |> Aja.Vector.new()},
     "100" => {Enum.to_list(1..100), Enum.to_list(1..100) |> Aja.Vector.new()},
     "1_000" => {Enum.to_list(1..1_000), Enum.to_list(1..1_000) |> Aja.Vector.new()},
     "10_000" => {Enum.to_list(1..10_000), Enum.to_list(1..10_000) |> Aja.Vector.new()},
     "100_000" => {Enum.to_list(1..100_000), Enum.to_list(1..100_000) |> Aja.Vector.new()},
     "1_000_000" => {Enum.to_list(1..1_000_000), Enum.to_list(1..1_000_000) |> Aja.Vector.new()}
}

Benchee.run(
     %{
          "list concat" => fn {list, _vector} -> Enum.concat(list, list) end,
          "aja concat" => fn {_list, vector} -> Aja.Vector.concat(vector, vector) end
     },
     title: "comparing aja concat and elixir list concat",
     inputs: inputs,
     parallel: 4,
     time: 10,
     memory_time: 5,
     measure_function_call_overhead: true,
     save: [path: Path.join(__DIR__, "vector_concat.benchee")],
     formatters: [
       Benchee.Formatters.Console,
       {Benchee.Formatters.HTML, file: Path.join(__DIR__, "vector_concat/vector_concat.html")}
     ]
)

Benchee.report(load: ["bench/vector_concat.benchee"])
