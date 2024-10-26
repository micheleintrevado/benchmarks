# listMap = OrderedMapListMaps.new() |> OrderedMapListMaps.put(:a, 1) |> OrderedMapListMaps.put(:c, 3) |> OrderedMapListMaps.put(:b, 2)
# OrderedMapListMaps.get(listMap, :c) |> dbg()
# OrderedMapListMaps.keys(listMap) |> dbg()

aja_map = Aja.OrdMap.new() |> Aja.OrdMap.put(:a, 1) |> Aja.OrdMap.put(:c, 3) |> Aja.OrdMap.put(:b, 2) |> Aja.OrdMap.put(:c, 4)

my_map = OrderedMapListMaps.new() |> OrderedMapListMaps.put(:a, 1) |> OrderedMapListMaps.put(:c, 3) |> OrderedMapListMaps.put(:b, 2) |> OrderedMapListMaps.put(:c, 4)

Aja.OrdMap.values(aja_map) |> dbg()
OrderedMapListMaps.values(my_map) |> dbg()
