{:ok, pid} = Redix.start_link()
Redix.command!(pid, ["SET", "hello", "world"])
Redix.command!(pid, ["GET", "hello"]) |> IO.inspect()
