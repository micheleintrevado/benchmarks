inputs = %{
  "10" => {
    (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..10, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..10, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    :rand.uniform(10) |> Integer.to_string(),
  },
  "100" => {
    (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..100, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..100, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    :rand.uniform(100) |> Integer.to_string(),
  },
  "1_000" => {
    (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..1_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..1_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    :rand.uniform(1_000) |> Integer.to_string(),
  },
  "10_000" => {
    (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    Enum.reduce(1..10_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
    Enum.reduce(1..10_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end),
    :rand.uniform(10_000) |> Integer.to_string(),
  }
}

Benchee.run(
  %{
    "elixir_not_ordered_map_delete" => fn {map, _aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key} -> Map.delete(map, key) end,
    "aja_ordered_map_delete" => fn {_map, aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key} -> Aja.OrdMap.delete(aja_ordered_map, key) end,
    "ordered_map_list_maps_delete" => fn {_map, _aja_ordered_map, custom_ordered_map_list_maps, _custom_ordered_map_list_tuples, key} -> OrderedMapListMaps.delete(custom_ordered_map_list_maps, key) end,
    "ordered_map_list_tuples_delete" => fn {_map, _aja_ordered_map, _custom_ordered_map_list_maps, custom_ordered_map_list_tuples, key} -> OrderedMapListTuples.delete(custom_ordered_map_list_tuples, key) end,

  },
  title: "Comparing delete function on various ordered maps and Elixir Map",
  inputs: inputs,
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "custom_map_delete.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "delete/custom_map_delete.html")}
  ]
)

Benchee.report(load: ["bench/custom_map_delete.benchee"])