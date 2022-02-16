import { readFileSync } from 'fs';
import { resolve } from 'path';

main();

interface Input {
  categories:          Category[];
  category_weight_sum: number; // not input => sum(category[x].weight)
  score:               number; // not input => sum(category[x].score weighted)
}

interface Category {
  id: string;
  name:             string;
  failIfBelow:      number;
  disabled:         boolean;
  params:           Param[];
  weight:           number;
  weight_pctg:      number; // not input => weight / sum(weight)
  param_weight_sum: number; // not input => sum(params[x].weight)
  score:            number; // not input => sum(params[x].score weighted)
}

interface Param {
  id:          string;
  name:        string;
  value:       number;
  weight:      number;
  weight_pctg: number; // not input
  score:       number; // not input => value * weight_pctg
}


function calculate(input: Input): number  {
  // V lang initializes numeric props using zero

  // sum all category weight
  input.category_weight_sum = 0.0;
  for (let category of input.categories) {
    input.category_weight_sum += category.weight;
  }

  // calculate scores
  input.score = 0.0;
  for (let category of input.categories) {
    category.weight_pctg = category.weight / input.category_weight_sum;

    // sum all param weight
    category.param_weight_sum = 0.0;
    for (let param of category.params) {
      category.param_weight_sum += param.weight;
    }

    category.score = 0.0
    for (let param of category.params) {
      param.weight_pctg = param.weight / category.param_weight_sum;
      param.score       = param.value * param.weight_pctg;
      category.score    += param.score;
    }
    category.score = category.score * category.weight_pctg;
    input.score += category.score;
  }

  return input.score;
}


function main() {
  console.log('scoring started...');
  const json_text = readFileSync(resolve(__dirname, './input.json')).toString();
  const input = JSON.parse(json_text);
  const score = calculate(input);
  console.log(`scoring started...done! score: ${score}`);
  console.log('details');
  console.log(JSON.stringify(input, null, 2));
}
