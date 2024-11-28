# inputs = %{
#   "10" => {(for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(10) |> Integer.to_string()},
#   "100" => {(for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(100) |> Integer.to_string()},
#   "1_000" => {(for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(1_000) |> Integer.to_string()},
#   "10_000" => {(for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(10_000) |> Integer.to_string()},
#   "100_000" => {(for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(100_000) |> Integer.to_string()},
#   "1_000_000" => {(for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}), (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(), :rand.uniform(1_000_000) |> Integer.to_string()}
# }

# Benchee.run(
#  %{
#      "map get" => fn {map, _ordered_map, key_to_get} -> Map.delete(map, key_to_get) end,
#      "ordered_map get" => fn {_map, ordered_map, key_to_get} -> Aja.OrdMap.delete(ordered_map, key_to_get) end
#  },
#  title: "comparing aja get on ordered map and elixir get map",
#  inputs: inputs,
#  parallel: 4,
#  time: 10,
#  memory_time: 5,
#  measure_function_call_overhead: true,
#  save: [path: Path.join(__DIR__, "map_get.benchee")],
#  formatters: [
#    Benchee.Formatters.Console,
#    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "map_get/map_get.html")}
#  ]
# )

Benchee.report(load: ["bench/map_get.benchee"])
