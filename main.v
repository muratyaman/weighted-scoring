import json
import math
import os

fn round(n f64) f64 {
  return math.round(100.0 * n) / 100.0
}

struct Input {
pub mut:
  categories []Category [required]
  category_weight_sum   f64  // not input => sum(category[x].weight)
  score                 f64  // not input => sum(category[x].score weighted)
}

struct Category {
pub:
  id            string     [required]
  name          string     [required]
  fail_if_below f64        [json: failIfBelow]
  disabled      bool
  params        []Param    [required]
  weight        f64        [required]
pub mut:
  weight_pctg      f64     // not input => weight / sum(weight)
  param_weight_sum f64     // not input => sum(params[x].weight)
  score            f64     // not input => sum(params[x].score weighted)
}

struct Param {
pub:
  id          string   [required]
  name        string   [required]
  value       f64      [required]
  weight      f64      [required]
pub mut:
  weight_pctg f64      // not input
  score       f64      // not input => value * weight_pctg
}


fn calculate(mut input Input) f64 {
  // V lang initializes numeric props using zero

  // sum all category weight
  input.category_weight_sum = 0.0
  for mut category in input.categories {
    input.category_weight_sum += category.weight
  }

  // calculate scores
  input.score = 0.0
  for mut category in input.categories {
    category.weight_pctg = category.weight / input.category_weight_sum

    // sum all param weight
    category.param_weight_sum = 0.0
    for param in category.params {
      category.param_weight_sum += param.weight
    }

    category.score = 0.0
    for mut param in category.params {
      param.weight_pctg = param.weight / category.param_weight_sum
      param.score       = param.value * param.weight_pctg
      category.score    += param.score
    }
    category.score = category.score * category.weight_pctg
    input.score += category.score
  }

  return input.score
}


fn main() {
  println('scoring started...')
  json_text := os.read_file('./input.json') or {
    panic('failed to open file')
    return
  }
  mut input := json.decode(Input, json_text) or {
    eprintln('Failed to decode json, error: $err')
    return
  }
  score := calculate(mut input)
  println('details start  ----')
  println(json.encode(input))
  println('details finish ----')
  println('scoring started...done! score: $score')
}
