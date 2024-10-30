inputs = %{
  "10" => { Enum.to_list(1..10), Aja.Vector.new(1..10) },
  "100" => { Enum.to_list(1..100), Aja.Vector.new(1..100) },
  "1_000" => { Enum.to_list(1..1_000), Aja.Vector.new(1..1_000) },
  "10_000" => { Enum.to_list(1..10_000), Aja.Vector.new(1..10_000) },
  "100_000" => { Enum.to_list(1..100_000), Aja.Vector.new(1..100_000) },
  "1_000_000" => { Enum.to_list(1..1_000_000), Aja.Vector.new(1..1_000_000) }
}

Benchee.run(
 %{
    "enum_reduce_list" => fn {enum_list, _aja_vector} -> Enum.reduce(enum_list, 0, &(&1 + &2)) end,
    "enum_reduce_aja_vector" => fn {_enum_list, aja_vector} -> Enum.reduce(aja_vector, 0, &(&1 + &2)) end,
    "aja_reduce_list" => fn {enum_list, _aja_vector} -> Aja.Enum.reduce(enum_list, 0, &(&1 + &2)) end,
    "aja_reduce_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.reduce(aja_vector, 0, &(&1 + &2)) end
 },
 title: "comparing enum reduce and aja enum reduce",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_reduce.benchee")],
 formatters: [
   Benchee.Formatters.Console,
   {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_reduce/enum_reduce.html")}
 ]
)

Benchee.report(load: ["bench/enum_reduce.benchee"])
