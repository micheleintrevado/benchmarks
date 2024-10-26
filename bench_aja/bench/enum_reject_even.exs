inputs = %{
  "10" => { Enum.to_list(1..10), Aja.Vector.new(1..10)} ,
  "100" => { Enum.to_list(1..100), Aja.Vector.new(1..100)},
  "1_000" => { Enum.to_list(1..1_000), Aja.Vector.new(1..1_000)},
  "10_000" => { Enum.to_list(1..10_000), Aja.Vector.new(1..10_000)},
  "100_000" => { Enum.to_list(1..100_000), Aja.Vector.new(1..100_000)},
  "1_000_000" => { Enum.to_list(1..1_000_000), Aja.Vector.new(1..1_000_000)}
}

Benchee.run(
 %{
    "enum_reject_list" => fn {enum_list, _aja_vector} -> Enum.reject(enum_list, fn x -> rem(x, 2) == 0 end) end,
    "enum_reject_aja_vector" => fn {_enum_list, aja_vector} -> Enum.reject(aja_vector, fn x -> rem(x, 2) == 0 end) end,
    "aja_reject_list" => fn {enum_list, _aja_vector} -> Aja.Enum.reject(enum_list, fn x -> rem(x, 2) == 0 end) end,
    "aja_reject_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.reject(aja_vector, fn x -> rem(x, 2) == 0 end) end
 },
 title: "comparing enum reject and aja enum reject",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_reject_even.benchee")]
)

Benchee.report(load: ["bench/enum_reject_even.benchee"])
