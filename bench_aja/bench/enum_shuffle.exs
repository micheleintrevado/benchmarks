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
    "enum_shuffle_list" => fn {enum_list, _aja_vector} -> Enum.shuffle(enum_list) end,
    "enum_shuffle_aja_vector" => fn {_enum_list, aja_vector} -> Enum.shuffle(aja_vector) end,
    "aja_shuffle_list" => fn {enum_list, _aja_vector} -> Aja.Enum.shuffle(enum_list) end,
    "aja_shuffle_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.shuffle(aja_vector) end
 },
 title: "comparing enum shuffle and aja enum shuffle",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_shuffle.benchee")],
 formatters: [
   Benchee.Formatters.Console,
   {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_shuffle/enum_shuffle.html")}
 ]
)

Benchee.report(load: ["bench/enum_shuffle.benchee"])
