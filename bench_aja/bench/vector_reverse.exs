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
        "list reverse" => fn {list, _vector} -> Enum.reverse(list) end,
        "aja reverse" => fn {_list, vector} -> Aja.Vector.reverse(vector) end
    },
    title: "comparing aja reverse and elixir list reverse",
    inputs: inputs,
    parallel: 4,
    time: 10,
    memory_time: 5,
    measure_function_call_overhead: true,
    save: [path: Path.join(__DIR__, "vector_reverse.benchee")],
    formatters: [
      Benchee.Formatters.Console,
      {Benchee.Formatters.HTML, file: Path.join(__DIR__, "vector_reverse/vector_reverse.html")}
    ]
)

Benchee.report(load: ["bench/vector_reverse.benchee"])
