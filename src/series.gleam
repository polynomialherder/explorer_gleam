import gleam/bool.{guard}
import gleam/io
import gleam/map.{Map}
import gleam/erlang.{Reference}
import gleam/dynamic.{Dynamic}

pub type Data(t) {
  Data(List(t))
}

pub type Resource {
  Resource(resource: Reference)
}

pub type Series(t) {
  Series(data: Resource, t)
}

pub type Error {
  BadIndex
  InvalidData
  OpNotImplementedForDatatype
}

pub fn from_list(list: List(t)) -> Series(t) {
  let series = from_list_(list)
  series
  |> to_gleam_series
}

pub fn argmax_float(series: Series(Float)) -> Int {
  series
  |> to_elixir_struct
  |> argmax_
}

pub fn argmax_int(series: Series(Int)) -> Int {
  series
  |> to_elixir_struct
  |> argmax_
}

pub fn at(series: Series(t), index: Int) -> Result(t, Error) {
  use <- guard(when: index < 0, return: Error(BadIndex))
  series
  |> to_elixir_struct
  |> at_(index)
}

pub fn sum_int(series: Series(Int)) -> Int {
  series
  |> to_elixir_struct
  |> sum_
}

pub fn sum_float(series: Series(Float)) -> Float {
  series
  |> to_elixir_struct
  |> sum_
}

pub fn sort(series: Series(t)) -> Series(t) {
  series
  |> to_elixir_struct
  |> sort_
  |> to_gleam_series
}

@external(erlang, "Elixir.GleamExplorer.Series", "from_list")
fn from_list_(list: List(t)) -> Map(Dynamic, Dynamic)

@external(erlang, "Elixir.GleamExplorer.Series", "argmax")
pub fn argmax_(series: Map(Dynamic, Dynamic)) -> t

@external(erlang, "Elixir.GleamExplorer.Series", "sum")
pub fn sum_(series: Map(Dynamic, Dynamic)) -> t

@external(erlang, "Elixir.GleamExplorer.Series", "sort")
pub fn sort_(series: Map(Dynamic, Dynamic)) -> t

@external(erlang, "Elixir.GleamExplorer.Series", "at")
pub fn at_(series: Map(Dynamic, Dynamic), at: Int) -> Result(t, Error)

@external(erlang, "Elixir.GleamExplorer.Series", "to_gleam_series")
pub fn to_gleam_series(series: Map(Dynamic, Dynamic)) -> Series(t)

@external(erlang, "Elixir.GleamExplorer.Series", "to_elixir_struct")
pub fn to_elixir_struct(series: Series(t)) -> Map(Dynamic, Dynamic)
