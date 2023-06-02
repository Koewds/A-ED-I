from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def mesetaMasLarga(l: List[int]) -> int :
  return len(listaMasLarga(subSecuencias(l)))


def subSecuencias(ssq: List[int]) -> List[List[int]]:
  result = []
  actual = []
  for elem in ssq:
    if actual == []:
      actual.append(elem)
      continue
    elif elem == actual[-1]:
      actual.append(elem)
    else:
      result.append(actual)
      actual = [elem]
  result.append(actual)
  return result

def listaMasLarga(l: List[List[int]]) -> List[int]:
  masLarga = []
  for elem in l:
    if masLarga == []:
      masLarga = elem
    else:
      if len(elem) >= len(masLarga):
        masLarga = elem
  return masLarga

if __name__ == '__main__':
  x = input()
  print(mesetaMasLarga([int(j) for j in x.split()]))