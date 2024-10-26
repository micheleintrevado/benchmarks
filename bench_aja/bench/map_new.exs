inputs = %{
  "10" => (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}),
  "100" => (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}),
  "1_000" => (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}),
  "10_000" => (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}),
  "100_000" => (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}),
  "1_000_000" => (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n})
}

Benchee.run(
 %{
     "map new" => fn map -> Map.new(map) end,
     "ordered_map new" => fn map -> Aja.OrdMap.new(map) end
 },
 title: "comparing aja new ordered maps and elixir new map",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "map_new.benchee")]
)

Benchee.report(load: ["bench/map_new.benchee"])
