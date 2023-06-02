import sys

def fibonacciNoRecursivo(n: int) -> int:
  if n == 0:
    return 0
  elif n == 1:
    return 1
  fibx = 0
  fiby = 1
  for i in range(2, n+1):
    fibx, fiby = fiby, fibx + fiby
  return fiby


if __name__ == '__main__':
  x = int(input())
  print(fibonacciNoRecursivo(x))