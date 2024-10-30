inputs = %{
  "10" => {(for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(10) |> Integer.to_string()},
  "100" => {(for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(100) |> Integer.to_string()},
  "1_000" => {(for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(1_000) |> Integer.to_string()},
  "10_000" => {(for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(10_000) |> Integer.to_string()},
  "100_000" => {(for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(100_000) |> Integer.to_string()},
  "1_000_000" => {(for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(1_000_000) |> Integer.to_string()}
}

Benchee.run(
 %{
     "map delete" => fn {map, _ordered_map, number_to_delete} -> Map.delete(map, number_to_delete) end,
     "ordered_map delete" => fn {_map, ordered_map, number_to_delete} -> Aja.OrdMap.delete(ordered_map, number_to_delete) end
 },
 title: "comparing aja delete on ordered map and elixir delete map",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "map_delete.benchee")],
 formatters: [
   Benchee.Formatters.Console,
   {Benchee.Formatters.HTML, file: Path.join(__DIR__, "map_delete/map_delete.html")}
 ]
)

Benchee.report(load: ["bench/map_delete.benchee"])
