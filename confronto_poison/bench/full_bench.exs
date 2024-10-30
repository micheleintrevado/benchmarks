inputs = %{
  "github.json" => File.read!("bench/data/github.json"),
  "blockchain.json" => File.read!("bench/data/blockchain.json"),
  "geojson.json" => File.read!("bench/data/geojson.json"),
  "giphy:" => File.read!("bench/data/giphy.json"),
  "govtrack.json" => File.read!("bench/data/govtrack.json"),
  "issue-90.json" => File.read!("bench/data/issue-90.json"),
  "json-generator-pretty.json" => File.read!("bench/data/json-generator-pretty.json"),
  "json-generator.json" => File.read!("bench/data/json-generator.json"),
  "pokedex.json" => File.read!("bench/data/pokedex.json"),
  "reddit.json" => File.read!("bench/data/reddit.json"),
  "utf-8-escaped.json" => File.read!("bench/data/utf-8-escaped.json"),
  "utf-8-unescaped.json" => File.read!("bench/data/utf-8-unescaped.json")
}

Benchee.run(
  %{
    # "Poison6" => fn data-> Poison.decode!(data) |> Poison.encode!() end
    "Poison5" => fn data -> Poison.decode!(data) |> Poison.encode!() end
  },
  inputs: inputs,

  title: "decode_encode_Poison_5.0",
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "poison_5.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "poison_5/poison_5.html")}
  ]
)

Benchee.report(load: ["bench/poison_5.benchee", "bench/poison_6.benchee"])
