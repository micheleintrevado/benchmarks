inputs = %{
  # "10" => { Enum.to_list(1..10), Aja.Vector.new(1..10), :rand.uniform(10)} ,
  # "100" => { Enum.to_list(1..100), Aja.Vector.new(1..100), :rand.uniform(100) },
  # "1_000" => { Enum.to_list(1..1_000), Aja.Vector.new(1..1_000), :rand.uniform(1_000) },
  # "10_000" => { Enum.to_list(1..10_000), Aja.Vector.new(1..10_000), :rand.uniform(10_000) },
  # "100_000" => { Enum.to_list(1..100_000), Aja.Vector.new(1..100_000), :rand.uniform(100_000) },
  # "1_000_000" => { Enum.to_list(1..1_000_000), Aja.Vector.new(1..1_000_000), :rand.uniform(1_000_000) },
  "10_000_000" => { Enum.to_list(1..10_000_000), Aja.Vector.new(1..10_000_000), :rand.uniform(10_000_000) }
}

Benchee.run(
 %{
    "enum_find_list" => fn {enum_list, _aja_vector, element_to_find} -> Enum.find(enum_list, fn x -> x == element_to_find end) end,
    "enum_find_aja_vector" => fn {_enum_list, aja_vector, element_to_find} -> Enum.find(aja_vector, fn x -> x == element_to_find end) end,
    "aja_find_list" => fn {enum_list, _aja_vector, element_to_find} -> Aja.Enum.find(enum_list, fn x -> x == element_to_find end) end,
    "aja_find_aja_vector" => fn {_enum_list, aja_vector, element_to_find} -> Aja.Enum.find(aja_vector, fn x -> x == element_to_find end) end
 },
 title: "comparing enum find and aja enum find",
 inputs: inputs,
 profile_after: true,
 parallel: 4,
 time: 10,
 memory_time: 5,
 measure_function_call_overhead: true,
 save: [path: Path.join(__DIR__, "enum_find_profiler.benchee")],
 formatters: [
  #  Benchee.Formatters.Console,
  #  {Benchee.Formatters.HTML, file: Path.join(__DIR__, "enum_find/enum_find.html")}
 ]
)

# Benchee.report(load: ["bench/enum_find.benchee"])
