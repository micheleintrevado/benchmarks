defmodule OrderedMapListMaps do
  defstruct data: %{}, order: []

  def new() do
    %OrderedMapListMaps{}
  end

  def new(initial_map) when is_map(initial_map) do
    keys_in_order = Enum.map(initial_map, fn {key, _value} -> key end)
    %OrderedMapListMaps{data: initial_map, order: keys_in_order}
  end

  def put(%OrderedMapListMaps{data: data, order: order} = map, key, value) do
    {new_data, new_order} =
      if Map.has_key?(data, key) do
        {Map.put(data, key, value), order}
      else
        {Map.put(data, key, value), order ++ [key]}
      end

    %OrderedMapListMaps{map | data: new_data, order: new_order}
  end

  def get(map, key) do
    Map.get(map.data, key)
  end

  def keys(map) do
    map.order
  end

  def values(map) do
    Enum.map(map.order, &Map.get(map.data, &1))
  end

  def delete(map, key) do
    %OrderedMapListMaps{data: Map.delete(map.data, key), order: List.delete(map.order, key)}
  end

end
