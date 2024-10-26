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
