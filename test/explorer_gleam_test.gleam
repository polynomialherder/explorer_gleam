import gleeunit
import gleeunit/should
import series.{BadIndex}
import gleam/float

pub fn main() {
  gleeunit.main()
}

pub fn integer_series_test() {
  let int_series = series.from_list([1, 2, 3])

  let assert 6 = series.sum_int(int_series)

  let assert Ok(1) = series.at(int_series, 0)
  let assert Ok(2) = series.at(int_series, 1)
  let assert Ok(3) = series.at(int_series, 2)

  let assert Error(BadIndex) = series.at(int_series, 3)

  let assert 2 = series.argmax_int(int_series)
}

pub fn float_series_test() {
  let float_series = series.from_list([3.0, -1.0, -2.0])

  let assert sum_result = series.sum_float(float_series)

  sum_result
  |> float.loosely_equals(0.0, 0.00001)
  |> should.be_true

  let assert Ok(3.0) = series.at(float_series, 0)
  let assert Ok(-1.0) = series.at(float_series, 1)
  let assert Ok(-2.0) = series.at(float_series, 2)

  let assert 0 = series.argmax_float(float_series)
}

pub fn string_series_test() {
  let string_series = series.from_list(["hello", "goodbye", "world"])

  let assert Ok("hello") = series.at(string_series, 0)
  let assert Ok("goodbye") = series.at(string_series, 1)
  let assert Ok("world") = series.at(string_series, 2)
  let assert Error(BadIndex) = series.at(string_series, -1)
  let assert Error(BadIndex) = series.at(string_series, 3)
}
