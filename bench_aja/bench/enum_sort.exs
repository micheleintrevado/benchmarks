inputs = %{
  "10" => { Enum.to_list(1..10) |> Enum.shuffle(), Aja.Vector.new(1..10) |> Aja.Enum.shuffle()} ,
  "100" => { Enum.to_list(1..100) |> Enum.shuffle(), Aja.Vector.new(1..100) |> Aja.Enum.shuffle()},
  "1_000" => { Enum.to_list(1..1_000) |> Enum.shuffle(), Aja.Vector.new(1..1_000) |> Aja.Enum.shuffle()},
  "10_000" => { Enum.to_list(1..10_000) |> Enum.shuffle(), Aja.Vector.new(1..10_000) |> Aja.Enum.shuffle()},
  "100_000" => { Enum.to_list(1..100_000) |> Enum.shuffle(), Aja.Vector.new(1..100_000) |> Aja.Enum.shuffle()},
  "1_000_000" => { Enum.to_list(1..1_000_000) |> Enum.shuffle(), Aja.Vector.new(1..1_000_000) |> Aja.Enum.shuffle()}
}

Benchee.run(
 %{
    "enum_sort_list" => fn {enum_list, _aja_vector} -> Enum.sort(enum_list) end,
    "enum_sort_aja_vector" => fn {_enum_list, aja_vector} -> Enum.sort(aja_vector) end,
    "aja_sort_list" => fn {enum_list, _aja_vector} -> Aja.Enum.sort(enum_list) end,
    "aja_sort_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.sort(aja_vector) end
 },
 title: "comparing enum sort and aja enum sort",
 inputs: inputs,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_sort.benchee")],
 formatters: [
   Benchee.Formatters.Console,
   {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_sort/enum_sort.html")}
 ]
)

Benchee.report(load: ["bench/enum_sort.benchee"])
