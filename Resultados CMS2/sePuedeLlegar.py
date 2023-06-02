from typing import List
from typing import Tuple

# Aclaración: Debido a la versión de Python del CMS, para el tipo Lista y Tupla, la sintaxis de la definición de tipos que deben usar es la siguiente:
# l: List[int]  <--Este es un ejemplo para una lista de enteros.
# t: Tuple[str,str]  <--Este es un ejemplo para una tupla de strings.
# Respetar esta sintaxis, ya que el CMS dirá que no pasó ningún test si usan otra notación.

def sePuedeLlegar(origen: str, destino: str, vuelos: List[Tuple[str, str]]) -> int :
  actual = origen
  flightsCount = 0
  while flightsCount < len(vuelos):
    if encontrarVuelo(vuelos, actual) == None:
      return -1
    actual = encontrarVuelo(vuelos, actual)
    flightsCount += 1
    if actual == destino:
      return flightsCount
  return -1

def encontrarVuelo(vuelos: List[Tuple], ciudad: str) -> str :
  for i in range (0, len(vuelos)):
    if ciudad == vuelos[i][0]:
      return vuelos[i][1]
  return None


if __name__ == '__main__':
  origen = input()
  destino = input()
  vuelos = input()

  print(sePuedeLlegar(origen, destino, [tuple(vuelo.split(',')) for vuelo in vuelos.split()]))