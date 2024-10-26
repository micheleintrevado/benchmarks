defmodule OrderedMapListTuples do
    defstruct data: []

    def new() do
        %OrderedMapListTuples{}
    end

    def put(%OrderedMapListTuples{data: data} = map, key, value) do
        data =
          case Enum.find_index(data, fn {k, _v} -> k == key end) do
            nil -> data ++ [{key, value}]
            index -> List.replace_at(data, index, {key, value})
          end

        %OrderedMapListTuples{map | data: data}
    end

    def get(%OrderedMapListTuples{data: data}, key) do
        case Enum.find(data, fn {k, _v} -> k == key end) do
          {_, v} -> v
          nil -> nil
        end
    end

    def keys(map) do
        Enum.map(map.data, fn {k, _v} -> k end)
    end

    def values(map) do
        Enum.map(map.data, fn {_k, v} -> v end)
    end

    def delete(%OrderedMapListTuples{data: data} = map, key) do
        filtered_data = Enum.filter(data, fn {k, _v} -> k != key end)
        %OrderedMapListTuples{map | data: filtered_data}
    end
end
