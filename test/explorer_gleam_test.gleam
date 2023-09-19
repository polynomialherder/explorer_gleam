import gleeunit
import gleeunit/should
import series.{BadIndex}
import gleam/float

pub fn main() {
  gleeunit.main()
}

pub fn integer_series_test() {
  let list_series = series.from_list([1, 2, 3])

  let assert Ok(6) = series.sum(list_series)

  let assert Ok(1) = series.at(list_series, 0)
  let assert Ok(2) = series.at(list_series, 1)
  let assert Ok(3) = series.at(list_series, 2)

  let assert Error(BadIndex) = series.at(list_series, 3)
}

pub fn float_series_test() {
  let list_series = series.from_list([-1.0, -2.0, 3.0])

  let assert Ok(sum_result) = series.sum(list_series)

  sum_result
  |> float.loosely_equals(0.0, 0.001)
  |> should.be_true

  let assert Ok(-1.0) = series.at(list_series, 0)
  let assert Ok(-2.0) = series.at(list_series, 1)
  let assert Ok(3.0) = series.at(list_series, 2)
}

pub fn string_series_test() {
  let string_series = series.from_list(["hello", "goodbye", "world"])

  let assert Error(series.OpNotImplementedForDatatype) =
    series.sum(string_series)
}
