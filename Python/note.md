### 僅限關鍵字
```py
*args, **kwargs
der f(a, *, b, c = 56):
    return a, b, c

f(12, b = 34)     # return (12, 34, 56)
f(12)             # TypeError Exception
                  # missing 1 required keywork-only argument: 'b'
```

```py
der g(x, *a, b = 23, **k):      # b 是僅限關鍵字參數
    return x, a, b, k

g(1, 2, 3, c = 99)      # return (1, (2, 3), 23, {'c':99})
```

### decorator
- normal use
```py
def spend_money():
    money = money - 100

print("I spent money!!")
spend_money()
print("I spent money!!")
spend_money()
print("I spent money!!")
spend_money()
```

- reuse model
```py
def record_bill(f):
    def recording(*args, **kargs):
        print("I spent money!!")
        return f(*args, **kargs)
    return recording

@record_bill
def spend_money():
    money = money - 100

spend_money()
```

- class model
```py
def record_bill(things, cost):
    def outter_recording(f):
        def recording(*args, **kargs):
            print("I spent money!!")
            return f(*args, **kargs)
        return recording
    def outter_recording

@record_bill("Apple", 100)
def spend_money():
    money = money - 100

spend_money()
```