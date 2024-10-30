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
    "enum_map_list" => fn {enum_list, _aja_vector} -> Enum.map(enum_list, &(&1 + 1)) end,
    "enum_map_aja_vector" => fn {_enum_list, aja_vector} -> Enum.map(aja_vector, &(&1 + 1)) end,
    "aja_map_list" => fn {enum_list, _aja_vector} -> Aja.Enum.map(enum_list, &(&1 + 1)) end,
    "aja_map_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.map(aja_vector, &(&1 + 1)) end
 },
 title: "comparing enum map and aja enum map",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_map.benchee")],
 formatters: [
   Benchee.Formatters.Console,
   {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_map/enum_map.html")}
 ]
)

Benchee.report(load: ["bench/enum_map.benchee"])
