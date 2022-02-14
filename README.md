# weighted-scoring
simple scoring formula used at schools

sample input:

```yaml
categories:
- id: "A."
  name: "Category A"
  weight: 30
  failIfBelow: 50
  disabled: false
  params:
  - id: "A.1."
    name: "Param A1"
    weight: 10
    value: 50
  - id: "A.2."
    name: "Param A2"
    weight: 5
    value: 90
  - id: "A.3."
    name: "Param A3"
    weight: 15
    value: 85
  - id: "A.4."
    name: "Param A4"
    weight: 20
    value: 100

- id: "B."
  name: "Category B"
  weight: 20
  params:
  - id: "B.1."
    name: "Param B1"
    weight: 5
    value: 80
  - id: "B.2."
    name: "Param B2"
    weight: 25
    value: 50
  - id: "B.3."
    name: "Param B3"
    weight: 35
    value: 90
```

sample output:

```json
{
  "categories": [
    {
      "disabled": false,
      "failIfBelow": 50,
      "id": "A.",
      "name": "Category A",
      "params": [
        {
          "id": "A.1.",
          "name": "Param A1",
          "score": 10.0,
          "value": 50,
          "weight": 0.2,
          "weight%": 20.0
        },
        {
          "id": "A.2.",
          "name": "Param A2",
          "score": 9.0,
          "value": 90,
          "weight": 0.1,
          "weight%": 10.0
        },
        {
          "id": "A.3.",
          "name": "Param A3",
          "score": 25.5,
          "value": 85,
          "weight": 0.3,
          "weight%": 30.0
        },
        {
          "id": "A.4.",
          "name": "Param A4",
          "score": 40.0,
          "value": 100,
          "weight": 0.4,
          "weight%": 40.0
        }
      ],
      "score": 84.5,
      "weight": 0.6,
      "weight%": 60.0
    },
    {
      "id": "B.",
      "name": "Category B",
      "params": [
        {
          "id": "B.1.",
          "name": "Param B1",
          "score": 6.15,
          "value": 80,
          "weight": 0.0769,
          "weight%": 7.69
        },
        {
          "id": "B.2.",
          "name": "Param B2",
          "score": 19.23,
          "value": 50,
          "weight": 0.3846,
          "weight%": 38.46
        },
        {
          "id": "B.3.",
          "name": "Param B3",
          "score": 48.46,
          "value": 90,
          "weight": 0.5385,
          "weight%": 53.85
        }
      ],
      "score": 73.85,
      "weight": 0.4,
      "weight%": 40.0
    }
  ],
  "score": 80.24
}
```
