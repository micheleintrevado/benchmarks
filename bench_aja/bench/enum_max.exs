inputs = %{
  # "10" => { Enum.to_list(1..10), Aja.Vector.new(1..10) },
  # "100" => { Enum.to_list(1..100), Aja.Vector.new(1..100) },
  # "1_000" => { Enum.to_list(1..1_000), Aja.Vector.new(1..1_000) },
  # "10_000" => { Enum.to_list(1..10_000), Aja.Vector.new(1..10_000) },
  # "100_000" => { Enum.to_list(1..100_000), Aja.Vector.new(1..100_000) },
  # "1_000_000" => { Enum.to_list(1..1_000_000), Aja.Vector.new(1..1_000_000) },
  "10_000_000" => { Enum.to_list(1..10_000_000), Aja.Vector.new(1..10_000_000) }
}

Benchee.run(
 %{
    "enum_max_list" => fn {enum_list, _aja_vector} -> Enum.max(enum_list) end,
    "enum_max_aja_vector" => fn {_enum_list, aja_vector} -> Enum.max(aja_vector) end,
    "aja_max_list" => fn {enum_list, _aja_vector} -> Aja.Enum.max(enum_list) end,
    "aja_max_aja_vector" => fn {_enum_list, aja_vector} -> Aja.Enum.max(aja_vector) end
 },
 title: "comparing enum max and aja enum max",
 inputs: inputs,
 profile_after: true,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_max_profiler.benchee")],
 formatters: [
  #  Benchee.Formatters.Console,
  #  {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_max/enum_max.html")}
 ]
)

# Benchee.report(load: ["bench/enum_max.benchee"])
