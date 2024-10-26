inputs = %{
  "10" => {(for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "11", 11},
  "100" => {(for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "101", 101},
  "1_000" => {(for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "1001", 1_001},
  "10_000" => {(for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "10001",10_001},
  "100_000" => {(for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "100001", 100_001},
  "1_000_000" => {(for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), "1000001", 1_000_001}
}

Benchee.run(
 %{
     "map put" => fn {map, _ordered_map, key, value} -> Map.put(map, key, value) end,
     "ordered_map put" => fn {_map, ordered_map, key, value} -> Aja.OrdMap.put(ordered_map, key, value) end
 },
 title: "comparing aja put on ordered map and elixir put map",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "map_put.benchee")]
)

Benchee.report(load: ["bench/map_put.benchee"])
