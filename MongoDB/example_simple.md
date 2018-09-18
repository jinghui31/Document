# General
### Insert
```sh
db.bar.insert({
  _id : 123,  
  total : 100,
  items : [
    { name : "A", price : 20 },
    { name : "B", price : 50 },
    { name : "C", price : 30 }
  ]})
```

### Find
```sh
db.bar.findOne({}, {_id: 0})
```

### Push
```sh
db.bar.update({_id: 123}, {$push: {items: 'D', price:100}}})
```

### Pull
```sh
db.bar.update({_id: 123}, {$pull: {items: 'D'}}})
```

### Rename_Forever
```sh
db.blog.items.updateMany({}, {$rename {count: "Qty"}})
```

### Rename_Temp
```sh
db.blog.items.aggregate({$project: {userId: "$_id", _id: 0}})
```

### Count
```sh
db.blog.items.aggregate({$project: {author: 1}},
  {$group: {_id: "$author", count: {$sum: 1}}},		//mutilple group
  {$sort: {count: -1}},
  {$limit: 3})
```

### Sum
```sh
db.blog.items.aggregate({$project: {author: 1, Qty: 1}},
  {$group: {_id: "$author", total: {$sum: "$Qty"}}},
  {$sort: {total: -1}},
  {$limit: 3})
```

# Project
### Mathematical expressions: $add, $subtract, $multiply, $divide, $mod
```sh
db.employees.aggregate({$project: {totalpay: {$add: ["$salary", "$bonus"]}}})
db.employees.aggregate({$project: {totalpay: $subtract[{$add: ["$salary", "$bonus"]}, "$401k"]}})
```

### Date expressions: $year, $month, $week, $dayOfMonth, $dayOfYear, $hour, $minute, $second
```sh
db.employees.insert({employee: "Tony", hireDate: new Date("2015-05-15")
db.employees.aggregate({$project: {hiredIn: {$month: "$hireDate"}}})
db.employees.aggregate({$project: {tenure: {$subtract: [{$year: new Date()}, {$year: "$hireDate"}]}}})
```

### String expressions: $substr, $concat, $toLower, $toUpper
```sh
db.employees.aggregate({$project: {email: {
  $concat: [
    {$substr: [$firstName, 0, 1]}, ".", "$lastName", "@pomerobotservices.com"]}}})
```

### Logical expressions: $cmp, $strcasecmp, $eq/$ne/$gt/$gte/$lt/$lte, $in, $nin, $and, $or, $not, $cond, $ifNull
```sh
db.students.aggregate({$project: {grade: {
  $cond: [$teachersPet, 100,
    {$add: [{$multiply: [.1, "$attendanceAvg"]},{$multiply: [.3, "$quizzAvg"]},{$multiply: [.6, "$testAvg"]}]}]}}})
```

# Group
### Arithmetic operators: $sum, $average
```sh
db.sales.aggregate({$group: {_id: "$country",
  totalRevenue: {$average: $revenue},
  numSales: {$sum: 1}}})
```

### Extreme operators: $max, $min, $first, $last
```sh
db.scores.aggregate({$group: {_id, $grade,
  lowestScore: {$min: $score},
  hightestScore: {$max: $score}}})
```

### Array operators: $addToSet(distinct), $push

---

## $unwind: $unwind the subdocuments and then $match the ones you want
```sh
db.blog.aggregate({$project: {subComments:  "$comments"}},
  {$unwind: "$subComments},
  {$match: {subComments.author: "Mark"}})
```

## $sort
```sh
db.employees.aggregate({$project: {compensation: {$add: ["$salary", "$bonus"]}, name:1}},
  {$sort: {compensation: -1, name: 1})
```

## $limit

## $skip

## $keyf
```sh
db.orders.group({
  key: {ord_dt:1, 'item.sku': 1},
  cond: {ord_dt: { $gt: new Date("01/01/2012")}},
  reduce: function (curr, result) { },
  initial: { }})
```