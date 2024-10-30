inputs = %{
  "small_input" => {:crypto.strong_rand_bytes(5) |> NimbleLZ4.compress(), 5},
  "medium_input" => {:crypto.strong_rand_bytes(256) |> NimbleLZ4.compress(), 256},
  "large_input" => {:crypto.strong_rand_bytes(1024 * 1024) |> NimbleLZ4.compress(), 1024 * 1024},
  "very_large_input" => {:crypto.strong_rand_bytes(1024 * 1024 * 1024) |> NimbleLZ4.compress(), 1_024 * 1_024 * 1_024}
}

Benchee.run(
  %{
    # "lz4_1.1.0" => fn {compressed, uncompressed_size} -> NimbleLZ4.decompress(compressed, uncompressed_size) end
    "lz4_0.1.3" => fn {compressed, uncompressed_size} -> NimbleLZ4.decompress(compressed, uncompressed_size) end
  },
  inputs: inputs,

  title: "decompress lz4 0.1.3",
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "decompress_lz4_0.1.3.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "decompress/decompress_lz4_0.1.3.html")}
  ]
)

Benchee.report(load: ["bench/decompress_lz4_1.1.0.benchee", "bench/decompress_lz4_0.1.3.benchee"])
