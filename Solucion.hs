module Solucion where
import qualified Data.Set as Set


-- Completar con los datos del grupo
--
-- Nombre de Grupo: xx
-- Integrante 1: Nombre Apellido, email, LU
-- Integrante 2: Nombre Apellido, email, LU
-- Integrante 3: Nombre Apellido, email, LU
-- Integrante 4: Nombre Apellido, email, LU

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])


usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejs Aux

pertenece :: Eq a => a -> [a] -> Bool
pertenece x [] = False
pertenece x xs | x == (head xs) = True
               | otherwise = pertenece x (tail xs)

-- Elimina los elementos repetidos en una lista
quitarRepetidos :: Eq a => [a] -> [a]
quitarRepetidos (l:lis) | pertenece l lis = quitarRepetidos lis
                        | otherwise = l:(quitarRepetidos lis)


-- Quita el primer elemento de cada tupla de Usuario en la lista
quitarPrimero :: [Usuario] -> [String] 
quitarPrimero [] = []
quitarPrimero (u:us) = (snd u):quitarPrimero us

listaContenidaEnOtra :: Eq a => [a] -> [a] -> Bool
listaContenidaEnOtra [] _ = True
listaContenidaEnOtra lista1 lista2 | pertenece (head lista1) lista2 = listaContenidaEnOtra (tail lista1) lista2
                                   | otherwise = False

quitarElem :: Eq a => a -> [a] -> [a]
quitarElem _ [] = []
quitarElem elem lista | elem == (head lista) = quitarElem elem (tail lista)
                      | otherwise = (head lista):quitarElem elem (tail lista)

quitarElems :: Eq a => [a] -> [a] -> [a]
quitarElems [] lista2 = lista2
quitarElems lista1 lista2 = quitarElems (tail lista1) (quitarElem (head lista1) lista2)

-- Ejercicios

-- 
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios (us, r, p) = quitarRepetidos(quitarPrimero (usuarios (us, r, p)))


-- Devuelve los usuarios que se relacionan en la RedSocial con el usuario
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_, [], _) _ = []
amigosDe (usuarios, r, p) usuario | fst (head r) == usuario = (snd (head r)):amigosDe (usuarios, (tail r), p) usuario
                                  | snd (head r) == usuario = (fst (head r)):amigosDe (usuarios, (tail r), p) usuario
                                  | otherwise = amigosDe (usuarios, (tail r), p) usuario


-- describir qué hace la función: Devuelve la cantidad de relaciones del Usuario en la RedSocial
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos (_, [], _) _ = 0
cantidadDeAmigos (usuarios, rel, p) usuario | fst (head rel) == usuario || snd (head rel) == usuario = 1 + (cantidadDeAmigos (usuarios, (tail rel), p) usuario)
                                            | otherwise = cantidadDeAmigos (usuarios, (tail rel), p) usuario

-- describir qué hace la función: Devuelve el usuario con más relaciones en la RedSocial dada
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos (us, r, p) = usuarioConMasAmigosAux (us, r, p) (usuarios (us, r, p)) (head us)

usuarioConMasAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Usuario
usuarioConMasAmigosAux (_, _, _) [] mayor = mayor
usuarioConMasAmigosAux (u, r, p) (l:lista) mayor | cantidadDeAmigos (u, r, p) l > cantidadDeAmigos (u, r, p) mayor = usuarioConMasAmigosAux (u, r, p) lista l
                                                 | otherwise = usuarioConMasAmigosAux (u, r, p) lista mayor

-- describir qué hace la función: .....
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos (u, r, p) = cantidadDeAmigos (u, r, p) (usuarioConMasAmigos (u, r, p)) > 1000000

-- describir qué hace la función: .....
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) _ = []
publicacionesDe (u, r, p:pu) usuario | usuarioDePublicacion p == usuario = p:(publicacionesDe (u, r, pu) usuario)
                                     | otherwise = publicacionesDe (u, r, pu) usuario

-- describir qué hace la función: .....
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA (_, _, []) _ = []
publicacionesQueLeGustanA (u, r, p:pu) usuario | pertenece usuario (likesDePublicacion p) = p:(publicacionesQueLeGustanA (u, r, pu) usuario)
                                               | otherwise = publicacionesQueLeGustanA (u, r, pu) usuario

-- describir qué hace la función: .....
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones (u, r, p) usuario1 usuario2 = publicacionesQueLeGustanA (u, r, p) usuario1 == publicacionesQueLeGustanA (u, r, p) usuario2

-- describir qué hace la función: .....
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel (u, r, p) usuario | publicacionesDe (u, r, p) usuario == [] = False
                                       | otherwise = tieneUnSeguidorFielAux (u, r, p) (publicacionesDe (u, r, p) usuario) (likesDePublicacion(head (publicacionesDe (u, r, p) usuario)))

tieneUnSeguidorFielAux :: RedSocial -> [Publicacion] -> [Usuario] -> Bool
tieneUnSeguidorFielAux _ _ [] = False
tieneUnSeguidorFielAux (u, r, p) pub (us:usuarios) | estaEnTodasLasPub pub us = True
                                                   | otherwise = tieneUnSeguidorFielAux (u, r, p) pub usuarios

estaEnTodasLasPub :: [Publicacion] -> Usuario -> Bool
estaEnTodasLasPub [] _ =  True
estaEnTodasLasPub pub usuario | pertenece usuario (likesDePublicacion(head pub)) = estaEnTodasLasPub (tail pub) usuario
                              | otherwise = False


-- describir qué hace la función: .....

existeSecuenciaDeAmigosAux :: RedSocial -> [Usuario] -> [[Usuario]] -> Usuario -> [(Usuario, Usuario)] -> Bool
existeSecuenciaDeAmigosAux _ _ [] _  _ = False
existeSecuenciaDeAmigosAux (u, r, p) [] (l:lista) u2 noRepetir = existeSecuenciaDeAmigosAux (u, r, p) u lista u2 noRepetir
existeSecuenciaDeAmigosAux (u, r, p) (us:usuarios) (l:lista) u2 noRepetir | us == u2 && not ( pertenece us l ) && lPerteneceARelacion = True -- Encuentra cadena
                                                                          | lPerteneceAnoRepetir = existeSecuenciaDeAmigosAux (u, r, p) usuarios (l:lista) u2 noRepetir
                                                                          | not (pertenece us l) && lPerteneceARelacion = 
                                                                            existeSecuenciaDeAmigosAux (u, r, p) usuarios ( agregarCasos ++ lista ) u2 ( ( us, head ( reverse l ) ):noRepetir)
                                                                          | otherwise = existeSecuenciaDeAmigosAux (u, r, p) usuarios ( l:lista ) u2 noRepetir
                                                                           where lPerteneceARelacion = pertenece ( us, head ( reverse l ) ) r || pertenece ( head ( reverse l ), us ) r
                                                                                 lPerteneceAnoRepetir = pertenece ( us, head ( reverse l ) ) noRepetir || pertenece ( head ( reverse l ), us ) noRepetir
                                                                                 agregarCasos = createListOfN2 ((lengthOfList u) - (lengthOfList l)) (l ++ [us])




existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos (u, r, p) u1 u2 =  existeSecuenciaDeAmigosAux (u, r, p) u ( createListOfN ( ( lengthOfList u ) - 1 ) u1 ) u2 []

-----------------


createListOfN :: Eq a => Int -> a -> [[a]]
createListOfN 0 _ = []
createListOfN a b = [b]:createListOfN (a-1) b

createListOfN2 :: Eq a => Int -> a -> [a]
createListOfN2 0 _ = []
createListOfN2 a b = b:createListOfN2 (a-1) b

lengthOfList :: Eq a => [a] -> Int
lengthOfList [] = 0
lengthOfList list = 1 + lengthOfList (tail (list))