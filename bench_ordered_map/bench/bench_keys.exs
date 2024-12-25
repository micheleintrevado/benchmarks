inputs = %{
  # "10" => {
  #   (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..10, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..10, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..10, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end)
  # },
  # "100" => {
  #   (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..100, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..100, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..100, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end)
  # },
  # "1_000" => {
  #   (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..1_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..1_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..1_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end)
  # },
  # "10_000" => {
  #   (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}),
  #   (for n <- 1..10_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
  #   Enum.reduce(1..10_000, OrderedMapListMaps.new(), fn n, acc -> OrderedMapListMaps.put(acc, Integer.to_string(n), n) end),
  #   Enum.reduce(1..10_000, OrderedMapListTuples.new(), fn n, acc -> OrderedMapListTuples.put(acc, Integer.to_string(n), n) end)
  # }
  "2_000_000" => {
    (for n <- 1..2_000_000, into: %{}, do: {Integer.to_string(n), n}),
    (for n <- 1..2_000_000, into: %{}, do: {Integer.to_string(n), n}) |> Aja.OrdMap.new(),
    (for n <- 1..2_000_000, into: %{}, do: {Integer.to_string(n), n}) |> OrderedMapListMaps.new(),
    (for n <- 1..2_000_000, into: %{}, do: {Integer.to_string(n), n}) |> OrderedMapListTuples.new()
  }
}

Benchee.run(
  %{
    "elixir_not_ordered_map_keys" => fn {map, _aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples} -> Map.keys(map) end,
    "aja_ordered_map_keys" => fn {_map, aja_ordered_map, _custom_ordered_map_list_maps, _custom_ordered_map_list_tuples} -> Aja.OrdMap.keys(aja_ordered_map) end,
    "ordered_map_list_maps_keys" => fn {_map, _aja_ordered_map, custom_ordered_map_list_maps, _custom_ordered_map_list_tuples} -> OrderedMapListMaps.keys(custom_ordered_map_list_maps) end,
    "ordered_map_list_tuples_keys" => fn {_map, _aja_ordered_map, _custom_ordered_map_list_maps, custom_ordered_map_list_tuples} -> OrderedMapListTuples.keys(custom_ordered_map_list_tuples) end,

  },
  title: "Comparing keys function on various ordered maps and Elixir Map",
  inputs: inputs,
  profile_after: true,
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "custom_map_keys.benchee")],
  formatters: [
    # Benchee.Formatters.Console,
    # {Benchee.Formatters.HTML, file: Path.join(__DIR__, "keys/custom_map_keys.html")}
  ]
)

# Benchee.report(load: ["bench/custom_map_keys.benchee"])
