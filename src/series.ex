defmodule GleamExplorer.Series do
  defstruct [:data, :dtype]

  defp atom_to_string(atom), do: Atom.to_string(atom)

  def to_elixir_struct(tuple) do
    {:series, {:resource, resource}, dtype} = tuple
    %Explorer.Series{data: %{resource: resource, __struct__: Explorer.PolarsBackend.Series}, dtype: dtype}
  end

  def to_gleam_series(series_struct) do
    {
      :series, {:resource, series_struct.data.resource},
      series_struct.dtype
    }
  end

  def from_list(list) do
    series_struct = Explorer.Series.from_list(list)
   end

  def sum(series) do
    try do
      {:ok, Explorer.Series.sum(series)}
    rescue
      Elixir.ArgumentError -> {:error, :op_not_implemented_for_datatype}
    end
  end

  def at(series, index) do
    try do
      value = series |> Explorer.Series.at(index)
      {:ok, value}
    rescue
      Elixir.RuntimeError -> {:error, :bad_index}
    end
  end

  def sort(series) do
    Explorer.Series.sort(series)
  end
end
