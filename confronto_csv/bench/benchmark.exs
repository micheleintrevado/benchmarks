# confronto parsing tra CSV 3.2 e CSV 2.5
inputs = %{
  "sales.csv" => File.stream!("bench/data/10000_sales.csv"),
  "customers-100000.csv" => File.stream!("bench/data/customers-100000.csv"),
  "customers-500000.csv" => File.stream!("bench/data/customers-500000.csv"),
  "customers-1000000.csv" => File.stream!("bench/data/customers-1000000.csv"),
  "customers-2000000.csv" => File.stream!("bench/data/customers-2000000.csv")
}

Benchee.run(
  %{
    "CSV 3.2" => fn data -> CSV.decode!(data) |> Stream.run() end
    # "CSV 2.5" => fn data -> CSV.decode!(data) |> Stream.run() end
  },
  inputs: inputs,
  title: "parsing comparison CSV 3.2 vs CSV 2.5",
  parallel: 4,
  time: 10,
  memory_time: 5,
  measure_function_call_overhead: true,
  save: [path: Path.join(__DIR__, "bench_csv_3.2.benchee")],
  formatters: [
    Benchee.Formatters.Console,
    {Benchee.Formatters.HTML, file: Path.join(__DIR__, "csv_3.2/bench_csv_2.5.html")}
  ]
)

Benchee.report(load: ["bench/bench_csv_2.5.benchee", "bench/bench_csv_3.2.benchee"])
