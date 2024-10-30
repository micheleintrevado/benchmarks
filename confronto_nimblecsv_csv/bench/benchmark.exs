# confronto parsing tra nimbleCSV e CSV
inputs = %{
  "sales.csv" => File.stream!("bench/data/10000_sales.csv"),
  "customers-100000.csv" => File.stream!("bench/data/customers-100000.csv"),
  "customers-500000.csv" => File.stream!("bench/data/customers-500000.csv"),
  "customers-1000000.csv" => File.stream!("bench/data/customers-1000000.csv"),
  "customers-2000000.csv" => File.stream!("bench/data/customers-2000000.csv")
}

Benchee.run(
  %{
    "nimble_csv" => fn data -> NimbleCSV.RFC4180.parse_stream(data) |> Stream.run() end,
    "csv" => fn data -> CSV.decode!(data) |> Stream.run() end
  },
  inputs: inputs,
  title: "parsing comparison NimbleCSV vs CSV",
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "bench_nimble_csv.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "nimble_csv/bench_nimble_csv.html")}
  ]
)

Benchee.report(load: ["bench/bench_nimble_csv.benchee"])
