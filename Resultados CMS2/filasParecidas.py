from typing import List

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.
def filasParecidas(matriz: List[List[int]]) -> bool :
  if len(matriz) == 1:
    return True
  n = matriz[1][0] - matriz[0][0]
  for i in range (0, len(matriz) - 1):
    if dosFilasParecidas(matriz[i], matriz[i+1], n):
      continue
    else: return False
  return True

def dosFilasParecidas(f1: List[int], f2: List[int], n: int) -> bool:
  while f1 != []:
    if f2[0] == f1[0] + n:
      f1 = f1[1:]
      f2 = f2[1:]
    else:
      return False
  return True


if __name__ == '__main__':
  filas = int(input())
  columnas = int(input())
 
  matriz = []
 
  for i in range(filas):         
    fila = input()
    if len(fila.split()) != columnas:
      print("Fila " + str(i) + " no contiene la cantidad adecuada de columnas")
    matriz.append([int(j) for j in fila.split()])
  
  print(filasParecidas(matriz))