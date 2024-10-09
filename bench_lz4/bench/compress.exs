inputs = %{
  # "small_input" => :crypto.strong_rand_bytes(5),
  # "medium_input" => :crypto.strong_rand_bytes(256),
  # "large_input" => :crypto.strong_rand_bytes(1_024 * 1_024),
  "very_large_input" => :crypto.strong_rand_bytes(1_024 * 1_024 * 1_024)
}

Benchee.run(
  %{
    "lz4_1.1.0" => fn input -> NimbleLZ4.compress(input) end
    #"lz4_0.1.3" => fn input -> NimbleLZ4.compress(input) end
  },
  inputs: inputs,

  title: "compress lz4 1.1.0",
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "compress_lz4_1.1.0.benchee")]
)

Benchee.report(load: ["bench/compress_lz4_1.1.0.benchee", "bench/compress_lz4_0.1.3.benchee"])
