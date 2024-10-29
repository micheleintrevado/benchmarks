inputs = %{
  "10" => {
    (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..10, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..10, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    "11", 11
  },
  "100" => {
    (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..100, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..100, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    "101", 101
  },
  "1_000" => {
    (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..1_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..1_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    "1001", 1_001
  },
  "10_000" => {
    (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..10_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..10_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    "10001", 10_001
  }
  # "100_000" => {
  #   (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..100_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..100_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..100_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
  #   "100001", 100_001
  # },
  # "1_000_000" => {
  #   (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..1_000_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..1_000_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..1_000_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
  #   "1000001", 1_000_001
  # }
}

Benchee.run(
  %{
    "elixir_not_ordered_map_put" => fn {map, _aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key, value} -> Map.put(map, key, value) end,
    "aja_ordered_map_put" => fn {_map, aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key, value} -> Aja.OrdMap.put(aja_ordered_map, key, value) end,
    "ordered_map_list_maps_put" => fn {_map, _aja_ordered_map, custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key, value} -> OrderedMapListMaps.put(custom_ordered_map_list_maps, key, value) end,
    "ordered_map_list_tuples_put" => fn {_map, _aja_ordered_map, _custom_ordered_map_list_maps, custom_ordered_map_list_tuples, key, value} -> OrderedMapListTuples.put(custom_ordered_map_list_tuples, key, value) end,

  },
  title: "Comparing put function on various ordered maps and Elixir Map",
  inputs: inputs,
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "custom_map_put.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "put/custom_map_put.html")}
  ]
)

Benchee.report(load: ["bench/custom_map_put.benchee"])
