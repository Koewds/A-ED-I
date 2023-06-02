import sys

def quienGana(j1: str, j2: str) -> str:
    if j1 == "Piedra":
        if j2 == "Papel":
            return "Jugador2"
        elif j2 == "Tijera":
            return "Jugador1"
        elif j2 == "Piedra":
            return "Empate"
    elif j1 == "Papel":
        if j2 == "Piedra":
            return "Jugador1"
        elif j2 == "Tijera":
            return "Jugador2"
        elif j2 == "Papel":
            return "Empate"
    elif j1 == "Tijera":
        if j2 == "Papel":
            return "Jugador1"
        elif j2 == "Piedra":
            return "Jugador2"
        elif j2 == "Tijera":
            return "Empate"
    else:
        return "Invalid input"

if __name__ == '__main__':
  x = input()
  jug = str.split(x)
  print(quienGana(jug[0], jug[1]))
