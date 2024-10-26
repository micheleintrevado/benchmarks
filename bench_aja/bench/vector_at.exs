create_input= fn length ->
  list = Enum.map(1..length, fn _ -> :rand.uniform() end)
  index = :rand.uniform(length) - 1
  {list, list |> Aja.Vector.new(), index}
end

inputs = %{
  "10" => create_input.(10),
  "100" => create_input.(100),
  "1_000" => create_input.(1_000),
  "10_000" => create_input.(10_000),
  "100_000" => create_input.(100_000),
  "1_000_000" => create_input.(1_000_000)
}

Benchee.run(
  %{
      "list at" => fn {list, _vector, i} -> Enum.at(list, i) end,
      "aja at" => fn {_list, vector, i} -> Aja.Vector.at(vector, i) end
  },
  title: "comparing aja at and elixir list at",
  inputs: inputs,
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "vector_at.benchee")]
)

Benchee.report(load: ["bench/vector_at.benchee"])
