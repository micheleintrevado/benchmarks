inputs = %{
  "10" => {Enum.to_list(1..10), Aja.Vector.new(1..10)},
  "100" => {Enum.to_list(1..100), Aja.Vector.new(1..100)},
  "1_000" => {Enum.to_list(1..1_000), Aja.Vector.new(1..1_000)},
  "10_000" => {Enum.to_list(1..10_000), Aja.Vector.new(1..10_000)},
  "100_000" => {Enum.to_list(1..100_000), Aja.Vector.new(1..100_000)},
  "1_000_000" => {Enum.to_list(1..1_000_000), Aja.Vector.new(1..1_000_000)}
}

Benchee.run(
  %{
    "enum_filter_list" => fn {enum_list, _aja_vector} -> Enum.filter(enum_list, fn x -> rem(x, 2) == 0 end) end,
    "enum_filter_aja_vector" => fn {_enum_list, aja_vector} -> Enum.filter(aja_vector, fn x -> rem(x, 2) == 0 end) end,
    "aja_filter_list" => fn {enum_list, _aja_vector} -> Aja.Enum.filter(enum_list, fn x -> rem(x, 2) == 0 end) end,
    "aja_filter_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.filter(aja_vector, fn x -> rem(x, 2) == 0 end) end
  },
  title: "comparing enum filter and aja enum filter",
  inputs: inputs,
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "enum_filter_even.benchee")]
)

Benchee.report(load: ["bench/enum_filter_even.benchee"])
