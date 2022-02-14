import pprint

# pip install pyyaml
import yaml

from yaml.loader import SafeLoader

pp = pprint.PrettyPrinter()


def calc_yaml(data):

  # convert weights to percentage for categories
  sumWeight = 0
  for category in data['categories']:
    sumWeight += category['weight']
  # end for

  for category in data['categories']:
    category['weight'] = round(category['weight'] / sumWeight, 4)
  # end for

  # convert weights to percentage for parameters of each category
  for category in data['categories']:
    sumCatWeight = 0
    for param in category['params']:
      sumCatWeight += param['weight']
    # end for
    for param in category['params']:
      param['weight'] = round(param['weight'] / sumCatWeight, 4)
    # end for
  # end for

  # calculate assessment scores
  data['score'] = 0
  for category in data['categories']:
    category['score'] = 0
    for param in category['params']:
      s = param['weight'] * param['value']
      param['score'] = round(s, 2)
      category['score'] += s
      param['weight%'] = round(param['weight'] * 100, 2)
    # end for
    data['score'] += round(category['weight'] * category['score'], 2)
    category['score'] = round(category['score'], 2)
    category['weight%'] = round(category['weight'] * 100, 2)
  # end for
  data['score'] = round(data['score'], 2)

  print('assessment---start')
  pp.pprint(data)
  print('assessment---end')
# end def


def main():

  # Open the file and load the file
  with open('input.yaml') as f:
    data = yaml.load(f, Loader=SafeLoader)
    print('input---start')
    pp.pprint(data)
    print('input-----end')

    calc_yaml(data)
  #end with

# end def

main()
