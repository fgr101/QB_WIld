DECLARE SUB DrawWolf ()
DECLARE SUB DrawMountains ()
DECLARE SUB PrintLines ()
DECLARE SUB NegativeSub ()
DECLARE SUB Negative ()
DECLARE SUB DrawBugio ()


'- QUE EL TERRENO INFLUYA EN LAS BATALLAS. UN TERRENO QUE SEA FAVORABLE
'  PARA EL PERSONAJE, OTRO TERRENO DEBE SER DESFAVORABLE.


' - AGREGAR DETALLES Y GRAFICOS ASCII
' - MEJORAR CODIGO USANDO [SUB PrintLines] PARA MOSTRAR LINEAS DE TEXTO.
' - TERMINAR DE DESARROLLAR LA PARTE DEL TEMPLO. [DECISIONES]
' - AGREGAR COMO EN STEAM, LOGROS DESBLOQUEABLES A ALCANZAR EN EL JUEGO.


' - AGREGAR CONVERSACIONES EN TALK TO STRANGERS (BAR).
' - AGREGAR CONVERSACIONES EN TALK TO STRANGERS (CITY).
' - QUE SE PUEDA SALVAR EL JUEGO EN LA CIUDAD (POR UN PRECIO MUY ALTO)
' - AGREGAR PELEA DE PRACTICA EN EL GIMNASIO DE LA CIUDAD, CON VALORES
'   ALEATORIOS.
' - DESARROLLAR LAS 6 SITUACIONES DE `DECISIONES' EN EL JUEGO.
' - AGREGAR ALGUNAS TORRES EN EL MAPA EN DONDE PUEDAS ENTRAR Y
'   ENFRENTAR A ALGUN ENEMIGO MUCHO MAS FUERTE.
' - AGREGAR BATALLAS CONTRA LOS MAGOS OSCUROS.
' - DESARROLLAR OBJETIVO DEL JUEGO: 100% MAPA EXPLORADO, ENCONTRAR Y
'   ELIMINAR A LOS TRES JEFES (MAGOS) OCULTOS DE LA BLACK ORDER.
' - CONSEGUIR 10.000 DE ORO.
' - LLEGAR AL NIVEL 50.

'- CONTINUAR DESARROLLANDO LA HISTORIA
'- CREAR EVENTOS DE DECISIONES - EL JUGADOR ELIGE ENTRE VARIAS OPCIONES
'- AGREGAR MAS DETALLES EN LA HISTORIA INICIAL, INTRO.
'- AGREGAR MAS SONIDOS
'- AGREGAR ENCICLOPEDIA [SOBRE CRIATURAS, PERSONAJES Y LUGARES]
'- PODER ELEGIR UN NOMBRE PARA EL PERSONAJE
'- CREAR ALGUNAS NUEVAS TRANSICIONES
'- TERMINAR DE ORGANIZAR EL CODIGO EN FUNCIONES/SUBS

'- MECANICAS DEL KARMA Y QUE ESTAS IMPACTEN EN EL JUEGO.
'- QUE UN TERRENO SEA DESFAVORABLE PARA EL PERSONAJE.

'- TRADUCIR JUEGO AL ESPANHOL
'- TRADUCIR JUEGO A PT BRASIL

'======================== SUBS AND FUNCTIONS =========================

DECLARE SUB Music ()
DECLARE SUB GameOver ()
DECLARE SUB Pause ()
DECLARE SUB Trans1 ()

DECLARE SUB About ()
DECLARE SUB Intro ()
DECLARE SUB Character ()
DECLARE SUB DisplayWeather ()

DECLARE SUB Information ()
DECLARE SUB Decision ()

DECLARE SUB City ()
DECLARE SUB NewCityText ()
DECLARE SUB TalkToStrangers ()
DECLARE SUB BetGame ()

' CHALLENGES:

DECLARE SUB SaveChallenges ()
DECLARE SUB LoadChallenges ()
DECLARE SUB CheckChallenges ()
DECLARE SUB Challenges ()


'FIGHT INTRO & ASCII DRAWINGS:

DECLARE SUB FightIntro ()
DECLARE SUB DrawWitch ()
DECLARE SUB DrawCrawler ()
DECLARE SUB DrawScorpion ()
DECLARE SUB DrawCriminal ()


DECLARE FUNCTION rolld6 ()

'| GLOBAL VARIABLES FOR SUBS |

DIM SHARED DecisionResult, LastDecisionEvent, mana, hp, gold
DIM SHARED AT, DF, maxHP, MaxMana
DIM SHARED City1Exists, City2Exists, City3Exists, City4Exists, City5Exists, City6Exists
DIM SHARED OptionMusic, barfight, line$(25)
DIM SHARED LastNegativeEvent, LastPositiveEvent, LinesToPrint
DIM SHARED BonusTerrain, LandName$, NegativeTerrain, LandNameNegative$

' ENEMIES VARIABLES

DIM SHARED Enemyname$, enemyAT, enemyDF

'==================== MUSIC and SOUNDS ======================

DIM SHARED Chance$, endfight$, enemy$, Chime$, levelup$, NegativeMusic$, positive$
DIM SHARED IntroMusic$

OptionMusic = 1      'BOOLEAN for Music ON and OFF
CALL Music           'CREATES Music string variables

'======================== CHALLENGES =========================
DIM SHARED FindACity, OneHundredGold, OneThousandGold, ReachLevelTen

FindACity = 0
OneHundredGold = 0
OneThousandGold = 0
ReachLevelTen = 0

CALL LoadChallenges

'======================== MAIN MENU =========================

mainmenu:

opcion = 0

CLS

COLOR 15
LOCATE 1, 1
COLOR 10, 2
PRINT "                              WILD 0.5 (2021 - 2022)                            "
COLOR 15, 0
PRINT
PRINT
PRINT "1) NEW GAME"
PRINT "2) ACHIEVEMENTS"
PRINT "3) CREDITS"
PRINT "4) EXIT"
PRINT ""

IF OptionMusic = 1 THEN
COLOR 15, 4
LOCATE 2, 26
PRINT "[12] Turn Sound OFF"
END IF

IF OptionMusic = 0 THEN
COLOR 15, 4
LOCATE 2, 26
PRINT "[12] Turn Sound ON"
END IF

LOCATE 10, 1
COLOR 15, 0
INPUT "Choose an option: ", opcion


IF opcion = 1 THEN
CLS
x = 0
DO UNTIL x = 4000
d1 = INT(RND * 75) + 1
d2 = INT(RND * 23) + 1
x = x + 1
COLOR 9
LOCATE d2, d1
PRINT "°±²"
LOCATE 10, 34
COLOR 15
PRINT " GET READY FOR "
LOCATE 11, 34
PRINT "A NEW ADVENTURE"
LOOP
x = 0
DO UNTIL x = 4000
d1 = INT(RND * 75) + 1
d2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE d2, d1
PRINT "°±²"
LOCATE 10, 34
COLOR 15
PRINT "   MS-DOS    "
LOCATE 11, 34
PRINT "-   WILD    -"
LOOP
CLS
GOTO startnewgame
END IF

IF opcion = 2 THEN
CALL Challenges
GOTO mainmenu
END IF

IF opcion = 3 THEN
CALL About
GOTO mainmenu
END IF

IF opcion = 4 THEN
CALL SaveChallenges
CLS
END
END IF

IF opcion = 12 THEN

	IF OptionMusic = 1 THEN

	     OptionMusic = 0
	     CALL Music
	     PRINT "Music OFF"
	     Pause
	     GOTO mainmenu

	END IF

	IF OptionMusic = 0 THEN

	     OptionMusic = 1
	     CALL Music
	     PRINT "Music ON"
	     Pause
	     GOTO mainmenu

	END IF

END IF

IF NOT (opcion = 1) AND NOT (opcion = 2) THEN
GOTO mainmenu
END IF

'======================== START NEW GAME =========================

startnewgame:

CALL Intro 'GAME INTRO - STORY PRESENTATION

CLS
COLOR 7

DIM SHARED PositionCol(500) AS INTEGER
DIM SHARED PositionCH

RANDOMIZE TIMER

level = 0
xpoints = 0

d1 = 2

turno = 0
lugary = 5
lugarx = 25

position = 0
PRINT "Generating a random position..."
PositionCH = (INT(RND * 400) + 1)
PositionCol(PositionCH) = 6
lasttextposition$ = "MOUNTAINS"

x = 0
DO UNTIL x = 500
PositionCol(x) = 3
x = x + 1
LOOP


'============= RANDOM CITIES =============

PRINT "Randomizing number of cities..."

City1Exists = 1

d1 = rolld6
IF d1 > 3 THEN
City2Exists = 1
END IF

d1 = rolld6
IF d1 > 3 THEN
City3Exists = 1
END IF

d1 = rolld6
IF d1 > 3 THEN
City4Exists = 1
END IF

d1 = rolld6
IF d1 > 3 THEN
City5Exists = 1
END IF

d1 = rolld6
IF d1 > 3 THEN
City6Exists = 1
END IF

PRINT "Generating cities position..."
PositionCity1 = (INT(RND * 400) + 1)
PositionCity2 = (INT(RND * 400) + 1)
PositionCity3 = (INT(RND * 400) + 1)
PositionCity4 = (INT(RND * 400) + 1)
PositionCity5 = (INT(RND * 400) + 1)
PositionCity6 = (INT(RND * 400) + 1)

DIM SHARED City1Visited, City2Visited, City3Visited
DIM SHARED City4Visited, City5Visited, City6Visited

City1Visited = 0
City2Visited = 0
City3Visited = 0
City4Visited = 0
City5Visited = 0
City6Visited = 0

'VARIABLES (Gold, attack, defence, HP, etc.) ================================

PRINT "Generating random gold values..."
					       'ALL THESE VARIABLES
gold = rolld6 * rolld6                         'HAVE BEEN RANDOMIZED, SO
PRINT "Generating random attack value..."      'EVERYTIME YOU PLAY A NEW
					       'GAME IT'S GONNA BE SOMETHING
AT = rolld6 * 2                                'DIFFERENT. I USED THE VALUE
PRINT "Generating random defence value..." '6 TO RANDOMIZE THEM, SIMULATING
					   'A NORMAL SOLO RPG GAME, USING A
DF = (rolld6) * 2                          'SIMPLE D6 DIE.I'VE USED D6 RANDOM
PRINT "Generating random HP value..."      'VARIABLES AS A BASE FOR THE WHOLE
maxHP = (rolld6) + 5                       'RANDOMIZATION SYSTEM IN THE GAME,
hp = maxHP                                 'TO JUST TO KEEP IT SIMPLE.
PRINT "Generating random mana value..."

MaxMana = 5 + rolld6
mana = MaxMana

Pause


'======================= GENERATING BONUS TERRAIN ============================

' The bonus terrain is a a piece of terrain that can give you extra attack pts
' during the battle. For instance, if the BONUS TERRAIN of the character is the
' FOREST, everytime the character has an encounter in a forest, will get extra
' force when attacking & will cause more damage.

d1 = rolld6
d2 = d1

SELECT CASE d1

	CASE 1
	BonusTerrain = 2
	LandName$ = "forest"

	CASE 2
	BonusTerrain = 6
	LandName$ = "mountains"

	CASE 3
	BonusTerrain = 8
	LandName$ = "swamps"

	CASE 4
	BonusTerrain = 14
	LandName$ = "desert"

	CASE 5
	BonusTerrain = 7
	LandName$ = "frozen lands"

	CASE 6
	BonusTerrain = 1
	LandName$ = "lakes and rivers"

END SELECT

denuevo:
d1 = rolld6

IF d1 = d2 THEN
GOTO denuevo
END IF

SELECT CASE d1

	CASE 1
	NegativeTerrain = 2
	LandNameNegative$ = "forest"

	CASE 2
	NegativeTerrain = 6
	LandNameNegative$ = "mountains"

	CASE 3
	NegativeTerrain = 8
	LandNameNegative$ = "swamps"

	CASE 4
	NegativeTerrain = 14
	LandNameNegative$ = "desert"

	CASE 5
	NegativeTerrain = 7
	LandNameNegative$ = "frozen lands"

	CASE 6
	NegativeTerrain = 1
	LandNameNegative$ = "lakes and rivers"

END SELECT


'=============================================================================

CALL Character


inicio:

d1 = (rolld6) / 10
hp = hp + d1
mana = mana + d1

inicio2:
RANDOMIZE TIMER

CALL CheckChallenges     'Checks if there are challenges acomplished and
			 'if so, shows a message.
IF hp <= 0 THEN
GOTO GameOver
END IF

IF hp > maxHP THEN
hp = maxHP
END IF

IF mana > MaxMana THEN
mana = MaxMana
END IF

'MAP ==========================    'THE MAP IS GENERATED FOR THE FIRST TIME
				   'THEN IT WILL BE GENERATED AGAIN IN ORDER
CLS                                'TO BEING UPDATE AFTER THE PLAYER INPUTS A
				   'DIRECTION (NORTH, SOUTH, EAST, WEST).
y = 0
DO UNTIL y = 10
x = 0

DO UNTIL x = 40
x = x + 1
COLOR PositionCol(position)

LOCATE lugary, lugarx                'Shows normal tiles or cities.

SELECT CASE position

	CASE PositionCH
	COLOR 20, 15
	PRINT ""
	COLOR , 0

	CASE PositionCity1

	IF PositionCH = PositionCity1 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF
	
	IF City1Visited = 1 THEN
	PRINT "C"
	ELSE
	COLOR 3, 0 'change to color 3
	PRINT "±"
	END IF

	CASE PositionCity2

	IF City2Exists = 1 THEN

		IF PositionCH = PositionCity2 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City2Visited = 1 THEN
		PRINT "C"
		ELSE
		COLOR 3, 0 'change to color 3
		PRINT "±"
		END IF

	ELSE
	COLOR PositionCol(position)
	PRINT "±"

	END IF

	CASE PositionCity3

	IF City3Exists = 1 THEN

		IF PositionCH = PositionCity3 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City3Visited = 1 THEN
		PRINT "C"
		ELSE
		COLOR 3, 0 'change to color 3
		PRINT "±"
		END IF

	ELSE
	COLOR PositionCol(position)
	PRINT "±"

	END IF
	
	CASE PositionCity4

	IF City4Exists = 1 THEN

		IF PositionCH = PositionCity4 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City4Visited = 1 THEN
		PRINT "C"
		ELSE
		COLOR 3, 0 'change to color 3
		PRINT "±"
		END IF

	ELSE
	COLOR PositionCol(position)
	PRINT "±"

	END IF

	CASE PositionCity5

	IF City5Exists = 5 THEN

		IF PositionCH = PositionCity5 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City5Visited = 1 THEN
		PRINT "C"
		ELSE
		COLOR 3, 0 'change to color 3
		PRINT "±"
		END IF

	ELSE
	COLOR PositionCol(position)
	PRINT "±"

	END IF

	CASE PositionCity6

	IF City6Exists = 6 THEN

		IF PositionCH = PositionCity6 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City6Visited = 1 THEN
		PRINT "C"
		ELSE
		COLOR 3, 0 'change to color 3
		PRINT "±"
		END IF

	ELSE
	COLOR PositionCol(position)
	PRINT "±"


	END IF

	CASE ELSE
	COLOR PositionCol(position)
	PRINT "±"

END SELECT

COLOR , 0


lugarx = lugarx + 1
position = position + 1

LOOP

y = y + 1
lugary = lugary + 1
lugarx = 25

LOOP

lugarx = 25
lugary = 5

turno = turno + 1
position = 0

'MENU ==========================

'THE PLAYER INPUTS A DIRECTION OR GIVES OTHER KINDS OF ORDERS
'USING THE MENU. THE DIRECTIONS ARE PROCESSED HERE.

COLOR 15, 4
LOCATE 1, 1
PRINT "[10] Exit"
LOCATE 1, 11
PRINT "[11] Character"

IF OptionMusic = 1 THEN
LOCATE 1, 26
PRINT "[12] Turn Sound OFF"
END IF

IF OptionMusic = 0 THEN
LOCATE 1, 26
PRINT "[12] Turn Sound ON"
END IF


COLOR , 0

COLOR 3
LOCATE 3, 1
PRINT "ATK:"; AT; "| DEF:"; DF; "| HP:"; hp; "| ( LEVEL"; level; ")"
LOCATE 4, 1
PRINT "Mana"; mana; "| Expert Points:"; xpoints; "| Gold:"; gold

COLOR 2
PRINT
PRINT "1- North"
PRINT "2- South"
PRINT "3- East"
PRINT "4- West"
PRINT

IF PositionCH = PositionCity1 OR PositionCH = PositionCity2 OR PositionCH = PositionCity3 THEN
PRINT "5 - Enter in the city."
END IF
IF PositionCH = PositionCity4 OR PositionCH = PositionCity5 OR PositionCH = PositionCity6 THEN
PRINT "5 - Enter in the city."
END IF

PRINT
PRINT
COLOR 3
INPUT "Where to go? ", direction
PRINT
COLOR 2


'DIRECTIONS ==========================

IF direction = 0 THEN
GOTO inicio2
END IF


IF direction = 3 THEN

	IF PositionCH = 39 OR PositionCH = (39 + 40) OR PositionCH = (39 + (40 * 2)) THEN
	PositionCH = PositionCH - 40
	END IF

	IF PositionCH = (39 + (40 * 3)) OR PositionCH = (39 + (40 * 4)) OR PositionCH = (39 + (40 * 5)) THEN
	PositionCH = PositionCH - 40
	END IF

	IF PositionCH = (39 + (40 * 7)) OR PositionCH = (39 + (40 * 8)) OR PositionCH = (39 + (40 * 9)) THEN
	PositionCH = PositionCH - 40
	END IF

	PositionCH = PositionCH + 1

END IF

IF direction = 4 THEN

	IF PositionCH = 0 OR PositionCH = 40 OR PositionCH = 80 THEN
	PositionCH = PositionCH + 40
	END IF

	IF PositionCH = 120 OR PositionCH = 160 OR PositionCH = 200 THEN
	PositionCH = PositionCH + 40
	END IF

	IF PositionCH = 240 OR PositionCH = 280 OR PositionCH = 320 OR PositionCH = 360 THEN
	PositionCH = PositionCH + 40
	END IF

	PositionCH = PositionCH - 1

END IF

IF direction = 1 THEN
PositionCH = PositionCH - 40

	IF PositionCH < 0 THEN
	PositionCH = PositionCH + (40 * 10)
	END IF

END IF

IF direction = 2 THEN
PositionCH = PositionCH + 40

	IF PositionCH > 399 THEN
	PositionCH = PositionCH - (40 * 10)
	END IF

END IF




DirectionCity:        '============= IF DIRECTION = 5, GO BACK TO THE CITY
IF direction = 5 THEN

SELECT CASE PositionCH

	CASE PositionCity1
	City1Visited = 1
	CALL City

	CASE PositionCity2
	City2Visited = 1
	CALL City

	CASE PositionCity3
	City3Visited = 1
	CALL City

	CASE PositionCity4
	CALL CheckChallenges
	City4Visited = 1
	CALL City

	CASE PositionCity5
	CALL CheckChallenges
	City5Visited = 1
	CALL City

	CASE PositionCity6
	CALL CheckChallenges
	City6Visited = 1
	CALL City

	CASE ELSE
	GOTO inicio

END SELECT

	IF hp <= 0 THEN
	GOTO mainmenu
	END IF


IF barfight = 1 THEN
GOTO enemy
END IF

GOTO inicio
END IF

IF direction = 10 THEN
GOTO mainmenu
END IF

IF direction = 11 THEN
CALL Character
GOTO inicio
END IF


IF direction = 12 THEN

	IF OptionMusic = 1 THEN

	     OptionMusic = 0
	     CALL Music
	     PRINT "Music OFF"
	     Pause
	     GOTO EndOptionMusic
	END IF

	IF OptionMusic = 0 THEN
	     OptionMusic = 1
	     CALL Music
	     PRINT "Music ON"
	     Pause
	END IF

EndOptionMusic:
GOTO inicio
END IF


'=================== SHORTCUTS FOR DEBUGGING THE GAME ===============



IF direction = 555 THEN

	CALL City

		IF hp <= 0 THEN
		GOTO mainmenu
		END IF

		IF barfight = 1 THEN
		GOTO enemy
		END IF

	GOTO inicio

END IF


'MAP UPDATE ========================== 'AFTER THE PLAYER GIVES A NEW DIRECTION
				       'THE MAP GETS UPDATED. IT IS GENERATED
y = 0                                  'FOR A SECOND TIME USING THE NEW
DO UNTIL y = 10                        'VARIABLES.
x = 0

DO UNTIL x = 40
x = x + 1
COLOR PositionCol(position)
IF position = PositionCH THEN
COLOR 4
END IF



LOCATE lugary, lugarx                'Shows normal tiles or cities.
SELECT CASE position

	CASE PositionCH
	COLOR 20, 15
	PRINT ""
	COLOR , 0

	CASE PositionCity1

	IF PositionCH = PositionCity1 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	IF City1Visited = 1 THEN
	PRINT "C"
	END IF

	IF City1Visited = 0 THEN
	COLOR 3, 0
	PRINT "±"
	END IF

	COLOR , 0

	CASE PositionCity2

	IF City2Exists = 1 THEN

		IF PositionCH = PositionCity2 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City2Visited = 0 THEN
		COLOR 3, 0
		PRINT "±"
		END IF

		IF City2Visited = 1 THEN
		PRINT "C"
		END IF
		
	END IF
	COLOR , 0

	CASE PositionCity3

	IF City3Exists = 1 THEN

		IF PositionCH = PositionCity3 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City3Visited = 0 THEN
		COLOR 3, 0
		PRINT "±"
		END IF

		IF City3Visited = 1 THEN
		PRINT "C"
		END IF

	END IF
	COLOR , 0

	CASE PositionCity4

	IF City4Exists = 1 THEN

		IF PositionCH = PositionCity4 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City4Visited = 0 THEN
		COLOR 3, 0
		PRINT "±"
		END IF

		IF City4Visited = 1 THEN
		PRINT "C"
		END IF

	END IF
	COLOR , 0

	CASE PositionCity5

	IF City5Exists = 5 THEN

		IF PositionCH = PositionCity5 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City5Visited = 0 THEN
		COLOR 3, 0
		PRINT "±"
		END IF

		IF City5Visited = 1 THEN
		PRINT "C"
		END IF

	END IF
	COLOR , 0

	CASE PositionCity6

	IF City6Exists = 6 THEN

		IF PositionCH = PositionCity6 THEN
		COLOR 15, 4
		ELSE
		COLOR 15, PositionCol(position)
		END IF

		IF City6Visited = 0 THEN
		COLOR 3, 0
		PRINT "±"
		END IF

		IF City6Visited = 1 THEN
		PRINT "C"
		END IF

	END IF
	COLOR , 0

	CASE ELSE
	PRINT "±"

END SELECT

lugarx = lugarx + 1
position = position + 1

LOOP

y = y + 1
lugary = lugary + 1
lugarx = 25

LOOP

lugarx = 25
lugary = 5

position = 0

'TERRAIN ===========================================

d1 = rolld6

IF d1 > 3 THEN

	IF NOT PositionCol(PositionCH) = 2 AND NOT PositionCol(PositionCH) = 8 AND NOT PositionCol(PositionCH) = 7 AND NOT PositionCol(PositionCH) = 14 AND NOT PositionCol(PositionCH) = 1 AND NOT PositionCol(PositionCH) = 6 THEN
	PositionCol(PositionCH) = lastterrain
	d1 = copyd1                            '| It increases the probabilities of
	GOTO SkipRest                          '| repeating the last terrain in order
	END IF                                 '| to have a less randomized map.

END IF

d1 = rolld6
IF PositionCol(PositionCH) = 2 THEN
d1 = 1
END IF
IF PositionCol(PositionCH) = 8 THEN
d1 = 2
END IF
IF PositionCol(PositionCH) = 7 THEN
d1 = 3
END IF
IF PositionCol(PositionCH) = 14 THEN
d1 = 4
END IF
IF PositionCol(PositionCH) = 1 THEN
d1 = 5
END IF
IF PositionCol(PositionCH) = 6 THEN
d1 = 6
END IF

SkipRest:
COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 = 0 THEN
d1 = 1
END IF

IF d1 = 1 THEN
PRINT "FOREST"
PositionCol(PositionCH) = 2
copyd1 = d1
END IF

IF d1 = 2 THEN
PRINT "SWAMP"
PositionCol(PositionCH) = 8
copyd1 = d1
END IF

IF d1 = 3 THEN
PRINT "FROZEN LANDS"
PositionCol(PositionCH) = 7
copyd1 = d1
END IF

IF d1 = 4 THEN
PRINT "DESERT"
PositionCol(PositionCH) = 14
copyd1 = d1
END IF

IF d1 = 5 THEN
PRINT "WATER (sea, lake or river)"
PositionCol(PositionCH) = 1
copyd1 = d1
END IF

IF d1 = 6 THEN
PRINT "MOUNTAINS"
PositionCol(PositionCH) = 6
copyd1 = d1
END IF

lastterrain = PositionCol(PositionCH)

'WEATHER ---------------------------------

weather:
CALL DisplayWeather


'---------------------------------------------------------
situations:

SELECT CASE PositionCH        'If you get to a city don't show any events, just
			      'play a sound and show the menu with the option to
	CASE PositionCity1    'get into the city.

	IF City1Visited = 0 THEN
	CALL NewCityText
	CALL CheckChallenges
	END IF
	
	City1Visited = 1
	PLAY Chime$
	GOTO inicio

	CASE PositionCity2
	IF City2Exists = 1 THEN

		IF City2Visited = 0 THEN
		CALL NewCityText
		CALL CheckChallenges
		END IF

	City2Visited = 1
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity3
	IF City3Exists = 1 THEN

		IF City3Visited = 0 THEN
		CALL NewCityText
		CALL CheckChallenges
		END IF

	City3Visited = 1
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity4
	IF City4Exists = 1 THEN

		IF City4Visited = 0 THEN
		CALL NewCityText
		CALL CheckChallenges
		END IF

	City4Visited = 1
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity5
	IF City5Exists = 1 THEN

		IF City5Visited = 0 THEN
		CALL NewCityText
		CALL CheckChallenges
		END IF
	
	City5Visited = 1
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity6
	IF City6Exists = 1 THEN

		IF City6Visited = 0 THEN
		CALL NewCityText
		CALL CheckChallenges
		END IF

	City6Visited = 1
	PLAY Chime$
	GOTO inicio
	END IF

END SELECT

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 = 1 THEN
PRINT " - DECISION -"
GOTO Decision
END IF

IF d1 = 2 THEN
PRINT " - ENEMY -"
LOCATE 11, 32
COLOR 15, PositionCol(PositionCH)
PRINT "ENEMY ENCOUNTER!"
PLAY enemy$
SLEEP 2
GOTO enemy
END IF

IF d1 = 3 THEN
PRINT " - NOTHING HAPPENS -"
END IF

IF d1 = 4 THEN
PRINT " - POSITIVE EVENT -"
GOTO positive
END IF

IF d1 = 5 THEN
PRINT " - NEGATIVE EVENT -"
GOTO Negative
END IF

IF d1 = 6 THEN
PRINT " - INFORMATION -"
CALL Information
GOTO inicio
END IF


DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'+++++++++++++++++++++++++++++++ NEGATIVE EVENTS +++++++++++++++++++++++++++++
Negative:

CALL NegativeSub
GOTO inicio

'+++++++++++++++++++++++++++++++ DECISION EVENTS +++++++++++++++++++++++++++++
Decision:
CALL Decision

SELECT CASE DecisionResult
CASE 0
GOTO inicio
CASE 1
GOTO enemy
END SELECT

'+++++++++++++++++++++++++++++++ POSITIVE EVENTS +++++++++++++++++++++++++++++
positive:

d1 = rolld6

IF d1 = LastPositiveEvent THEN   'This part of the code should avoid
GOTO positive                    'the same positive event repeating twice
END IF                           'in a very short period of time.
LastPositiveEvent = d1


COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 = 1 THEN
Pause
PRINT "You find a good place to sleep and spend the night there. It's an inn."
Pause
PRINT "You've been there before and know the owner. You feel much better"
Pause
PRINT "the next day. (+1 HP)"
hp = hp + 1
END IF

IF d1 = 2 THEN
Pause
PRINT "You find an abandoned house in the place. It's an old house but seems"
Pause
PRINT "to be in perfect conditions. The front door is open. You get in. The place"
Pause
PRINT "is clean, there's even a room with a bed, old chairs and a big table. You "
Pause
PRINT "even find a shelf with many old books. Books about black and white magic,"
Pause
PRINT "the natural world, about creatures, the kingdom's history, music, poetry"
Pause
PRINT "and even short stories. You also find some old gold coins around the place."
Pause
PRINT "You spend the rest of the day resting and reading. Seems to be a safe and "
Pause
PRINT "good place to spend the night too. (+5 HP) (+20 GOLD) (100% MANA pts)"
hp = hp + 5
gold = gold + 20
mana = MaxMana
END IF

IF d1 = 3 THEN
Pause
PRINT "You see something shiny in the middle of the path."
Pause
PRINT "Some gold coins are spread all over the place!!! (+10 GOLD)"
gold = gold + 10
END IF

IF d1 = 4 THEN
Pause
PRINT "You stop, set a place to camp. Start a fire and cook something to eat."
Pause
PRINT "You spend your time practicing fighting techniques and training with your"
Pause
PRINT "knives and sword. The mission has been pretty rough and hard, so difficult.  "
Pause
PRINT "You needed to take some time for you, to rest and relax a little bit. It's"
Pause
PRINT "always a good thing to practice with your weapons and improve your fighting"
Pause
PRINT "techniques. (HP + 3) (AT + 0.5) "
hp = hp + 3
AT = AT + .5
END IF

IF d1 = 5 THEN
Pause
PRINT "Street vendor by the road! He offers you the following items:"
PRINT
Pause
PRINT "[1] Mix of Herbs   (+5 HP)   - $25"
Pause
PRINT "[2] Energetic Soup (+5 MANA) - $25"
Pause
PRINT "[3] NO, THANKS!"
PRINT
Pause
INPUT "Would you like to buy something sir?"; opcion

IF opcion = 3 THEN
Pause
PRINT "- Oh, that's ok then..."
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

IF gold < 25 THEN
Pause
PRINT "- Mmmm... you don't have that money. I didn't say it was for free!"
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF


IF opcion = 1 THEN
Pause
PRINT "- Nice, MIX OF HERBS! Here you have!"
DO WHILE INKEY$ = ""
LOOP
PRINT
Pause
PRINT "YOU DRINK IT AND FEEL MUCH BETTER. YOU FEEL LESS TIRED, RELAXED, WITH"
Pause
PRINT "LOTS OF NEW ENERGY. YOUR BODY DOESN'T HURT ANYMORE."
hp = hp + 5
gold = gold - 25
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

IF opcion = 2 THEN
Pause
PRINT "- Nice, ENERGETIC SOUP! Here you have!"
DO WHILE INKEY$ = ""
LOOP
PRINT
Pause
PRINT "YOU DRINK IT AND FEEL YOUR BODY MUCH STRONGER. YOU FEEL MORE CONFIDENT"
Pause
PRINT "IS IT ACTUALLY SOUP? OR IS IT LIKE A DRUG OR SOMETHING? IT EVEN TASTES"
Pause
PRINT "PRETTY GOOD."
mana = mana + 5
gold = gold - 25
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

END IF

IF d1 = 6 THEN
Pause
PRINT "You find a family of travelers by the road. They've heard about you and"
Pause
PRINT "they know you are there to help. The husband invites you to join them. You"
Pause
PRINT "rest, eat good food and take a shower. You stay a good time with them."
Pause
PRINT "The man also teaches you some fighting and defensive techniques. Before"
Pause
PRINT "you leave, they give you some food and gold coins to support you. "
Pause
PRINT "You thank them and continue with your travel. (Gold + 25) (HP + 10) (AT + 0.5) "
gold = gold + 25
hp = hp + 10
AT = AT + .5
END IF

DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
enemy:

CALL Trans1
d1 = rolld6

IF d1 = 1 THEN
Enemyname$ = "Wild Wolf"
enemyAT = 3
enemyDF = 5

	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Demonic Black Panther"
	enemyAT = 6
	enemyDF = 10
	END IF

	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Mogmurch"
	enemyAT = 6
	enemyDF = 10
	END IF
	
END IF

IF d1 = 2 THEN
Enemyname$ = "Wild Bugio"
enemyAT = 4.5
enemyDF = 6

	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Damned Walker"
	enemyAT = 6
	enemyDF = 15
	END IF

	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Rat"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 3 THEN
Enemyname$ = "Witch"
enemyAT = 4
enemyDF = 5.5
	
	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Tortured Soul"
	enemyAT = 8
	enemyDF = 12
	END IF

	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Giant Flying Spider"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 4 THEN
Enemyname$ = "Crawler"
enemyAT = 5
enemyDF = 5

	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Giant Acid Centipede"
	enemyAT = 30
	enemyDF = 54
	END IF

	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Goblin"
	enemyAT = 35
	enemyDF = 59
	END IF

END IF

IF d1 = 5 THEN
Enemyname$ = "Criminal"
enemyAT = 4
enemyDF = 5

	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Forest Demon"
	enemyAT = 6
	enemyDF = 10
	END IF
	
	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Draco"
	enemyAT = 11
	enemyDF = 15
	END IF

END IF

IF d1 = 6 THEN
Enemyname$ = "Giant Scorpion"
enemyAT = 6
enemyDF = 7

	IF AT > 12 OR hp > 12 OR DF > 12 THEN
	Enemyname$ = "Corrupted Soul"
	enemyAT = 14
	enemyDF = 16
	END IF

	IF AT > 22 OR hp > 22 OR DF > 22 THEN
	Enemyname$ = "Giant Flying Centipede"
	enemyAT = 19
	enemyDF = 21
	END IF

END IF


IF barfight = 1 THEN     '================ BAR FIGHT =================

	d1 = rolld6

	SELECT CASE d1

		CASE 1
		Enemyname$ = "Drunk Guy"
		d1 = rolld6
		enemyAT = 0 + d1
		d1 = rolld6
		enemyDF = 0 + d1
	
		CASE 2
		Enemyname$ = "Random Guy"
		d1 = rolld6
		enemyAT = 5 + d1
		d1 = rolld6
		enemyDF = 5 + d1

		CASE 3
		Enemyname$ = "Strong Fat and Bald Guy"
		d1 = rolld6
		enemyAT = 10 + d1
		d1 = rolld6
		enemyDF = 10 + d1


		CASE 4
		Enemyname$ = "Guard"
		d1 = rolld6
		enemyAT = 15 + d1
		d1 = rolld6
		enemyDF = 15 + d1

		CASE 5
		Enemyname$ = "Huge Luciano"
		d1 = rolld6
		enemyAT = 20 + d1
		d1 = rolld6
		enemyDF = 20 + d1

		CASE 6
		Enemyname$ = "Soldier"
		d1 = rolld6
		enemyAT = 25 + d1
		d1 = rolld6
		enemyDF = 25 + d1


	END SELECT

END IF


' ======================== FIGHT INTRO SCENE ============================

CALL FightIntro

'============================ COMBAT INI ================================
combatINI:

COLOR 2
PRINT
PRINT "You: HP ("; hp; ") === DEF ("; DF; ") / ATK ("; AT; ") === MANA ("; mana; ")"
COLOR 4
PRINT ; Enemyname$; ": HP ("; enemyDF; ") === DEF ("; enemyDF; ") / ATK ("; enemyAT; ")"
COLOR 2
PRINT
PRINT "--------------------------------------------"
DO WHILE INKEY$ = ""
LOOP

PRINT
PRINT "You ATTACK:"
d1 = rolld6

COLOR 3
PRINT "Die: "; d1;
COLOR 2
damage1 = AT + d1
PRINT " Damage: "; damage1


'================= TERRAIN AT BONUS DURING FIGHT ============================

IF combatloop = 3 AND BonusTerrain = PositionCol(PositionCH) THEN
Pause
PRINT
COLOR BonusTerrain, 0
PRINT LandName$; " BONUS attack!"
COLOR 15, PositionCol(PositionCH)
PRINT "YOU GET EXTRA ATTACK PTS FOR BEING USED TO THIS KIND OF TERRAIN!"
COLOR , 0
d1 = rolld6
COLOR 3
Pause
PRINT "Die: "; d1; " | ";
PRINT "Damage + "; d1; " of terrain bonus!";
damage1 = damage1 + d1
COLOR 15
PRINT " DAMAGE PTS increased to "; damage1; " now! ±±±±±"
PRINT
END IF

'============================================================================

d1 = rolld6
COLOR 3
PRINT "Die (enemy defence):"; d1;
COLOR 2
def2 = enemyDF + d1
PRINT "Enemy Defence: "; def2
finaldamage = damage1 - def2
IF finaldamage < 0 THEN
finaldamage = 0
END IF
COLOR 15
PRINT "The "; Enemyname$; " receives"; finaldamage; "points of damage."
COLOR 2

enemyDF = enemyDF - finaldamage

PRINT
PRINT "--------------------------------------------"

DO WHILE INKEY$ = ""
LOOP

PRINT
PRINT "THE "; Enemyname$; " ATTACKS YOU:"
'RANDOMIZE TIMER

d1 = rolld6
COLOR 3
PRINT "Die: "; d1;
COLOR 2
damageEN = enemyAT + d1
PRINT "Enemy Damage: "; damageEN
d1 = rolld6
COLOR 3
PRINT "Die (for YOUR defence):"; d1;
COLOR 2
yourdefence = DF + d1
PRINT "YOUR Defence: "; yourdefence

'================= NEGATIVE TERRAIN DURING FIGHT ============================

IF combatloop = 3 AND NegativeTerrain = PositionCol(PositionCH) THEN
Pause
PRINT
COLOR NegativeTerrain, 0
PRINT "Being in the "; LandNameNegative$; " affects your defence!"
COLOR 15, PositionCol(PositionCH)
PRINT "REDUCTION OF DEFENCE PTS FOR NOT BEING USED TO THIS KIND OF TERRAIN!"
COLOR , 0
d1 = rolld6
COLOR 3
Pause
PRINT "Die: "; d1; " | ";
PRINT "-"; d1; " PTS of DEFENCE REDUCTION!";
yourdefence = yourdefence - d1
COLOR 15
PRINT " DEFENCE PTS reduced to "; yourdefence; " now! ±±±±±±"
PRINT
END IF

'============================================================================



finaldamage = damageEN - yourdefence
IF finaldamage < 0 THEN
finaldamage = 0
END IF

COLOR 15
PRINT "YOU receive"; finaldamage; "points of damage."
COLOR 2


hp = hp - finaldamage


DO WHILE INKEY$ = ""
LOOP

PRINT "--------------------------------------------"


IF hp <= 0 THEN
GOTO GameOver
END IF

IF enemyDF <= 0 THEN                             'WHEN YOU WIN A COMBAT
PRINT
COLOR 3
Pause
PRINT "GOOD JOB! The "; Enemyname$; " has been defeated!"

d1 = rolld6
gold = gold + d1
Pause
PRINT "You receive"; d1; "gold coins."

d1 = rolld6
xpoints = xpoints + d1
Pause
PRINT "You receive"; d1; "expert points."
COLOR 2

PLAY endfight$
DO WHILE INKEY$ = ""
LOOP

IF xpoints >= 10 THEN                            'WHEN YOU LEVEL UP!
COLOR 3
PRINT
Pause
PRINT "LEVEL UP!"
xpoints = 0
level = level + 1
Pause
PRINT "What would you like to improve?"          'IMPROVING SKILL POINTS
PRINT
Pause
PRINT "1) ATTACK      2)DEFENCE"
Pause
PRINT "3) HEALTH PTS  4)MANA"
PRINT

PLAY levelup$

INPUT opcion

IF opcion = 1 THEN
AT = AT + 1
END IF
IF opcion = 2 THEN
DF = DF + 1
END IF
IF opcion = 3 THEN
maxHP = maxHP + 1
END IF
IF opcion = 4 THEN
MaxMana = MaxMana + 1
END IF

mana = MaxMana
hp = maxHP

END IF

combatloop = 0

	IF barfight = 1 THEN '======= Turns the barfight BOOLEAN to FALSE(0)
			     '======= and goes back to the city.
		barfight = 0
		GOTO DirectionCity

	END IF

GOTO inicio2
END IF

combatloop = combatloop + 1  '== LOOPS COUNTER FOR EACH COMBAT ROUND ==


'FIVE LOOPS MENU ============

IF combatloop = 5 THEN
PRINT ""
COLOR 3
Pause
PRINT "You realize that there is a chance for you to:"
PRINT ""
Pause
PRINT "1) Try to escape"
Pause
PRINT "2) Use your concentration [mana pts]"
Pause
PRINT "3) Just continue with the combat"
PRINT ""
PLAY Chance$
askagain:
INPUT "What will you do...", opcion

	IF opcion = 0 THEN
	GOTO askagain
	END IF

	IF opcion = 1 THEN
	d1 = rolld6
	COLOR 2
	Pause
	PRINT "You decide to run and try to escape..."
	COLOR 3
	PRINT "Die:"; d1; "[1 to 3 means failure - 4 to 6 means success]"

	DO WHILE INKEY$ = ""
	LOOP

	COLOR 2
		
		IF d1 >= 1 AND d1 <= 3 THEN
		PRINT
		Pause
		PRINT "[FAILURE]"
		Pause
		PRINT "You try to escape but can't. It seems you aren't fast enough for that."
		Pause
		PRINT "You receive "; enemyAT; " points of damage from "; Enemyname$; "."
		hp = hp - enemyAT
		Pause
		PRINT "Your HP is "; hp; " now."
		PRINT
		COLOR 2
		Pause
		PRINT "--------------------------------------------"

		DO WHILE INKEY$ = ""
		LOOP

			IF hp <= 0 THEN
			GOTO GameOver
			END IF

		END IF

		IF d1 >= 4 AND d1 <= 6 THEN
		PRINT
		Pause
		PRINT "[SUCCESS]"
		Pause
		PRINT "You try to escape. You are fast enough to run away!"
		Pause
		PRINT
		COLOR 2
		Pause
		PRINT "--------------------------------------------"
		DO WHILE INKEY$ = ""
		LOOP
		combatloop = 0
		GOTO inicio2
		END IF

	END IF

	IF opcion = 2 THEN
	PRINT ""
	COLOR 3
	Pause
	PRINT "Using your concentration:"
	PRINT ""
	Pause
	PRINT "1) Use energy to attack [3pts]"
	Pause
	PRINT "2) Use energy to recover HP [3pts]"
	Pause
	PRINT "3) Use energy to escape [3pts]"
	PRINT ""
	PRINT
	PLAY Chime$
1248 :
	INPUT "What will you do...", opcion

		IF opcion = 0 THEN
		GOTO 1248
		END IF

		IF opcion = 1 AND mana < 3 THEN ' ====  MANA OPTION 1 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		Pause
		PRINT "body for that attack!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 1 AND mana >= 3 THEN
		mana = mana - 3
		enemyDF = enemyDF - AT
		COLOR 15
		PRINT
		Pause
		PRINT "You use your energy and concentration to attack"
		Pause
		PRINT "the "; Enemyname$; "! Your attack is very effective!"
		Pause
		PRINT "The "; Enemyname$; " gets "; AT; " points of damage!"
		Pause
		PRINT "Its HP is"; enemyDF; " now!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 2 AND mana < 3 THEN ' ====  MANA OPTION 2 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		Pause
		PRINT "body to recover your health!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 2 AND mana >= 3 THEN
		mana = mana - 3
		hp = maxHP
		COLOR 15
		PRINT
		Pause
		PRINT "You use your energy and concentration to recover your health"
		Pause
		PRINT "Your HP is now "; hp; "! You feel much better and renewed!"
		Pause
		PRINT "Ready to fight back!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 3 AND mana < 3 THEN ' ====  MANA OPTION 3 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		Pause
		PRINT "body to run away like that!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 3 AND mana >= 3 THEN
		mana = mana - 3
		COLOR 15
		PRINT
		Pause
		PRINT "You use your energy and concentration to run away!"
		Pause
		PRINT "The "; Enemyname$; " runs behind you but fails!"
		Pause
		PRINT "You succeed and escape!"
		PRINT
		PLAY Chime$
		DO WHILE INKEY$ = ""
		LOOP
		combatloop = 0
		GOTO inicio2
		END IF


	END IF


	IF opcion = 3 THEN
	PRINT
	COLOR 2
	PRINT "--------------------------------------------"
	combatloop = 0
	GOTO combatINI
	END IF

combatloop = 0
END IF

GOTO combatINI


'GAME OVER ======================================
GameOver:
CALL GameOver
GOTO mainmenu

SUB About

CLS

PRINT
Pause
PRINT "Wild 0.5 - 2021 / 2022"
Pause
PRINT "Created by Fernando Gaston Ramirez as a free software and open source project."
PRINT
Pause
PRINT "Contributors from GitHub:"
PRINT
Pause
PRINT "- Alan Monroe from Ohio, USA."


DO WHILE INKEY$ = ""
LOOP

END SUB

SUB BetGame

CLS

COLOR 15, 7
LOCATE 1, 10
PRINT "Luciano the Huge"

COLOR 10, 0

PRINT
PRINT "Hey foreigner! Sit there, common!"
Pause
PRINT "Let's see what you have!"
PRINT
Pause
PRINT "This are MY rules! I roll a die, a D6... "
PRINT
Pause
PRINT "- If you get a [6] I give you double."
Pause
PRINT "- If you get a [5] I give your money plus half of it."
Pause
PRINT "- If you get a [4] I give your money back. It's a tie."
Pause
PRINT "- If you get a [3] I give you half of it."
Pause
PRINT "- If you get a [2] I give nothing."
Pause
PRINT "- If you get a [1] I give you a sh*t."
PRINT
Pause
PRINT "This is my table, these are my dice and these are my rules.."
Pause
PRINT "Take it or leave it."

PRINT
Pause

PRINT "What are you going to do?"

VolverAPreguntar:
COLOR 3
Pause
INPUT "1) Play - 2) Forget it: ", BetOptions
COLOR 10

SELECT CASE BetOptions

       CASE 1

       PRINT
       Pause
       INPUT "How much money would you like to bet?", howmuch



       IF gold < howmuch OR gold = 0 THEN
       PRINT
       Pause
       PRINT "You don't have that money! Better get out of here!"
       DO WHILE INKEY$ = ""
       LOOP
       GOTO BetEndOfSub
       END IF

       d1 = rolld6
       
       COLOR 10
       Pause
       PRINT
       PRINT "OK... Let's see."
       Pause
       COLOR 3
       PRINT "Rolling..."
       Pause
       PRINT "Die: "; d1
       Pause
       COLOR 10
       PRINT "So you got a ["; d1; "]."

	     SELECT CASE d1

		   CASE 1
		   PLAY NegativeMusic$
		   Pause
		   PRINT
		   PRINT "YOU LOSE 100% OF YOUR MONEY!"
		   gold = gold - howmuch

		   CASE 2
		   PLAY NegativeMusic$
		   Pause
		   PRINT
		   PRINT "YOU LOSE 100% OF YOUR MONEY!"
		   gold = gold - howmuch

		   CASE 3
		   PLAY NegativeMusic$
		   Pause
		   PRINT
		   PRINT "YOU LOSE 50% OF YOUR MONEY!"
		   gold = gold - (howmuch / 2)


		   CASE 4
		   PLAY positive$
		   PRINT
		   PRINT "TIE! YOU KEEP YOUR MONEY!"

		   CASE 5
		   PLAY positive$
		   PRINT
		   PRINT "YOU WIN +50% OF YOUR BET!"
		   gold = gold + (howmuch / 2)

		   CASE 6
		   PLAY positive$
		   PRINT
		   PRINT "YOU WIN +100% OF YOUR BET!"
		   gold = gold + howmuch


	     END SELECT

       COLOR 3
       PLAY Chime$
       PRINT
       PRINT "Your gold is"; gold; "now."
       COLOR 10

       DO WHILE INKEY$ = ""
       LOOP

       CASE 2
       PRINT
       Pause
       PRINT "Better to keep my money safe..."
       Pause
       GOTO BetEndOfSub

       CASE ELSE
       GOTO VolverAPreguntar

END SELECT

BetEndOfSub:
END SUB

SUB Challenges

CLS

COLOR 4

IF FindACity = 1 THEN
COLOR 10
END IF

Pause
PRINT
PRINT "# Find a city for the first time."

COLOR 4

IF OneHundredGold = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Get 100 gold."

COLOR 4

IF OneThousandGold = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Get 1000 gold."

COLOR 4

IF ReachLevelTen = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Reach level 10."


DO WHILE INKEY$ = ""
LOOP

END SUB

SUB Character

CLS

LOCATE 6, 1
COLOR , 9
PRINT "                       "
PRINT "                       "
PRINT "                       "
PRINT "                       "



COLOR 9, 0
LOCATE 3, 1
PRINT "CHARACTER"
COLOR 15, 0
PRINT "Type: Explorer / Demons Hunter"
PRINT
COLOR 15, 9
LOCATE 6, 1
PRINT "  AT   = "; AT; "    "
PRINT "  DEF  = "; DF; "    "
PRINT "  HP   = "; maxHP; "    "
PRINT "  MANA = "; MaxMana; "    "
COLOR , 0
PRINT
COLOR 14, 9
PRINT "  GOLD   = "; gold; "   "
COLOR , 0

PRINT

COLOR 3, 0
PRINT "You were born in the ";
COLOR BonusTerrain, 0
PRINT LandName$; "."

COLOR 3, 0
PRINT "You are not used to be in the ";
COLOR NegativeTerrain, 0
PRINT LandNameNegative$; "."

COLOR 15

COLOR 4
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"


DO WHILE INKEY$ = ""
LOOP

END SUB

SUB CheckChallenges

IF gold >= 100 AND OneHundredGold = 0 THEN
COLOR 14, 2
LOCATE 10, 25
PRINT "CHALLENGE [GET 100 GOLD] COMPLETED!"
COLOR , 0
OneHundredGold = 1
END IF

IF gold >= 1000 AND OneThousandGold = 0 THEN
COLOR 14, 2
LOCATE 10, 24
PRINT "CHALLENGE [GET 1000 GOLD] COMPLETED!"
COLOR , 0
OneThousandGold = 1
END IF

IF FindACity = 0 THEN
COLOR 14, 2
LOCATE 10, 15
PRINT "CHALLENGE [FIND A CITY FOR THE FIRST TIME] COMPLETED!"
COLOR , 0
FindACity = 1
END IF

IF level >= 10 AND ReachLevelTen = 0 THEN
COLOR 14, 2
LOCATE 10, 23
PRINT "CHALLENGE [REACH LEVEL TEN] ACHIEVED!"
COLOR , 0
ReachLevelTen = 1
END IF

DO WHILE INKEY$ = ""
LOOP

END SUB

SUB City
CityIni:

IF hp <= 0 THEN
CALL GameOver
GOTO EndOfSub
END IF

CLS
COLOR 15, 9

PRINT "         WELCOME TO THE CITY                    "
PRINT
PRINT "1) Sleep one night at the local hotel ($25 GOLD)"
PRINT "2) Go for some beers at the local pub           "
PRINT "3) Train at the Local Fighting GYM              "
PRINT "4) See if you can steal something.              "
PRINT "5) Talk to strangers.                           "
PRINT "6) Get out of the city.                         "
PRINT

LOCATE 1, 50
COLOR 14, 0
PRINT "Gold: "; gold;

LOCATE 10, 1
COLOR 15, 9
PLAY Chime$
INPUT "What to do? ", opcion


CityOpcionIni:
BarIni:

SELECT CASE opcion

     CASE 1

     IF gold < 25 THEN
     COLOR 10, 0
     PRINT
     Pause
     PRINT "You don't have enough money for that!"
     DO WHILE INKEY$ = ""
     LOOP
     GOTO CityIni
     END IF
     
     COLOR 10, 0
     PRINT
     PRINT "You spend the night at the local hotel. You eat something, have some"
     Pause
     PRINT "free coffee as well. You even take a look at some local newspapers."
     Pause
     PRINT "It is always nice to take a shower and feel clean again."
     Pause
     PRINT
     PRINT "You finally sleep very well and have a good night of sleep after"
     Pause
     PRINT "many days sleeping on trees, in abandoned buildings and inside bushes."
     PRINT
     Pause
     COLOR 3
     PRINT
     PRINT "(HP 100% / MANA 100%)"
     gold = gold - 25
     hp = maxHP
     mana = MaxMana
     DO WHILE INKEY$ = ""
     LOOP
     
     CASE 2
	COLOR , 0
	CLS
	COLOR 15, 5

	PRINT "           AT THE LOCAL BAR                    "
	PRINT
	PRINT "1) Grab a beer                       ($10 GOLD)"
	PRINT "2) Try luck! Bet to get some money   ($?? GOLD)"
	PRINT "3) Talk to strangers                           "
	PRINT "4) Look for trouble, fight                     "
	PRINT "5) Walk out of the bar                         "

	LOCATE 1, 50
	COLOR 14, 0
	PRINT "Gold: "; gold;
	PRINT

	LOCATE 10, 1
	COLOR 15, 5
	INPUT "What to do? ", BarOption
	PRINT

	COLOR 10, 0

	SELECT CASE BarOption

		CASE 1

		IF gold < 10 THEN
		COLOR 10, 0
		PRINT
		Pause
		PRINT "You don't have enough money for that!"
		DO WHILE INKEY$ = ""
		LOOP
		GOTO BarIni
		END IF
     
		COLOR 10, 0
		PRINT
		PRINT "You go to the local bar..."
		Pause
		PRINT "Drink a couple beers and relax at the place..."
		Pause
		PRINT "The beer costs you around 10 gold coins. You are having a good time."
		Pause
		PRINT "You feel much better now. Are you gonna have another one?"
		COLOR 3
		Pause
		PRINT "(+2 MANA)"
		Pause
		PRINT "(-10 GOLD)"
		Pause
		PRINT "(-0.5 HP)"
		gold = gold - 10
		mana = mana + 3
		hp = hp - .5

		DO WHILE INKEY$ = ""
		LOOP
		GOTO BarIni

		CASE 2
		CALL BetGame
		GOTO BarIni


		CASE 3
		CALL TalkToStrangers
		GOTO BarIni

		CASE 4

		COLOR 10
		CLS
		Pause
		PRINT
		PRINT "You look around the place..."
		PRINT
		Pause
		PRINT "There's a drunk guy falling asleep in one of the corners."
		Pause
		PRINT "There are some random guys and women having a beer, talking and smoking."
		Pause
		PRINT
		PRINT "There's a big and bald guy who looks very strong, he's chatting with"
		Pause
		PRINT "some women and drinking beer with them."
		Pause
		PRINT
		PRINT "There is another big and fat guy, he has only one eye. He is bald and he's"
		Pause
		PRINT "playing cards and rolling some dice. He looks huge!"
		Pause
		PRINT
		PRINT "The security guard is standing next to the door. He's pretty tall "
		Pause
		PRINT "and looks very serious."
		Pause
		PRINT
		PRINT "There's a lonely soldier, he's writing something on a paper while smoking "
		Pause
		PRINT "a cigarrete. He's wearing a navy blue military uniform."
		PRINT
		Pause
		COLOR 3
		PRINT "Are you sure you want to create trouble?"
		Pause
175 :
		COLOR 3
		INPUT "1) Yes - 2) No: ", BarOption
		COLOR 10

		SELECT CASE BarOption

			CASE 1
			barfight = 1
			GOTO EndOfSub

			CASE 2
			PRINT
			PRINT "Maybe it's not a good idea..."
			Pause
			GOTO BarIni

			CASE ELSE
			GOTO 175

		END SELECT

		CASE 5
		PRINT
		PRINT "You walk out of the local pub.."
		Pause
		GOTO CityIni

		CASE ELSE
		GOTO BarIni

		END SELECT


     CASE 3

     COLOR , 0
     CLS
     COLOR 15, 7
     LOCATE 1, 10
     PRINT "AT THE TRAINING GROUND"
     COLOR 10, 0

     PRINT
     Pause
     PRINT "What would you like to do?"
     PRINT
     Pause
     PRINT "1) Train with Swords and Knives ($10 GOLD)"
     Pause
     PRINT "2) Train Attack and Resistance  ($10 GOLD)"
     Pause
     PRINT "3) Train Defensive Movements    ($10 GOLD)"
     Pause
     PRINT "4) Leave..."

     LOCATE 1, 50
     COLOR 14, 0
     PRINT "Gold: "; gold;
     PRINT


     PRINT
     COLOR 10
     LOCATE 10, 1
     INPUT "What would you like to practice? ", TrainingOptions
     PRINT

     IF gold < 10 AND NOT TrainingOptions = 4 THEN
     PRINT
     PLAY NegativeMusic$
     Pause
     PRINT "You don't have any money to pay me!"
     DO WHILE INKEY$ = ""
     LOOP
     GOTO CityIni
     END IF

     SELECT CASE TrainingOptions

	CASE 1
	PRINT "You train Swords and Knives"
	d1 = rolld6 / 5
	COLOR 3
	PLAY Chance$
	Pause
	PRINT "(+"; d1; " AT)"
	AT = AT + d1
	gold = gold - 10

	CASE 2
	PRINT "You train Attack and Resistance"
	d1 = rolld6 / 8
	COLOR 3
	PLAY Chance$
	Pause
	PRINT "(+"; d1; " AT / +"; d1; " DEF)"
	AT = AT + d1
	DF = DF + d1
	gold = gold - 10

	CASE 3
	PRINT "You train Defensive Movements"

	d1 = rolld6 / 5
	COLOR 3
	PLAY Chance$
	Pause
	PRINT "(+"; d1; " DEF)"
	DF = DF + d1
	gold = gold - 10

	CASE 4

	PRINT
	PRINT "You walk out of the training ground..."
	Pause
	GOTO CityIni

	CASE ELSE
	GOTO CityOpcionIni

     END SELECT

     DO WHILE INKEY$ = ""
     LOOP
     GOTO CityOpcionIni



     CASE 4
	
     COLOR 10, 0
     PRINT
     PRINT "You walk around the streets of the city looking for an expensive store."
     Pause
     PRINT "There are several shops with expensive items. You see one that is "
     Pause
     PRINT "almost crowded, people are distracted there. It's a good option."
     Pause
     PRINT
     PRINT "You get in, and look around until you see something that looks"
     Pause
     PRINT "interesting. People don't seem to care about you being there. "
     PRINT
     Pause
     COLOR 3
     PRINT "Do you want to try now?"
     Pause
1517 :
     INPUT "1) Yes - 2) No: ", opcion
     
	SELECT CASE opcion

		CASE 1
		d1 = rolld6
		
		IF d1 < 4 THEN
		COLOR 10
		PRINT
		PLAY NegativeMusic$
		PRINT "DOESNT WORK"
		COLOR 10, 0
		PRINT
		PRINT "You don't realize but someone is looking at you, this woman is"
		Pause
		PRINT "suspicious of your intentions so she quietly communicates that to "
		Pause
		PRINT "one of the shop owners."
		Pause
		PRINT
		PRINT "They wait until you try to grab something. Two big guys appear and with"
		Pause
		PRINT "the help of the rest of the costumers they give you a lesson."
		PRINT

		COLOR 3
		Pause
		d1 = rolld6
		PRINT "Die:"; d1; "*2 | you get -"; d1 * 2; "HP."
		hp = hp - (d1 * 2)

		d1 = rolld6
		Pause
		PRINT "Die:"; d1; "*2 | you get -"; d1 * 2; " GOLD."
		gold = gold - (d1 * 2)

		Pause
		d1 = rolld6
		PRINT "Die:"; d1; "*2 | you get -"; d1 * 2; " MANA."
		mana = mana - (d1 * 2)
		
		DO WHILE INKEY$ = ""
		LOOP

		GOTO CityIni
		END IF
		
		IF d1 > 3 THEN
		COLOR 10
		PLAY positive$
		PRINT "SUCCES!"
		Pause
		PRINT
		PRINT "You find something interesting. That looks very expensive and easy to sell! "
		Pause
		PRINT "When no one is looking you just grab the object, put it under your jacket"
		Pause
		PRINT "and get out quickly from the store."
		Pause
		PRINT
		PRINT "You sell that item some hours later in the local street market where almost"
		Pause
		PRINT "anything can be bought and sold."
		PRINT

		COLOR 3
		Pause
		d1 = rolld6
		PRINT "Die:"; d1; "*5 | you get +"; d1 * 5; "GOLD."
		gold = gold + (d1 * 5)
		DO WHILE INKEY$ = ""
		LOOP
		GOTO CityIni
		END IF
		
		DO WHILE INKEY$ = ""
		LOOP

		CASE 2
		
		COLOR 10
		Pause
		PRINT
		PRINT "It doesn't seem to be a good idea. Better get out of here."

		DO WHILE INKEY$ = ""
		LOOP

	END SELECT
     

     CASE 6
     COLOR 10, 0
     PRINT
     PRINT "You decide to leave the city.."
     Pause
     GOTO EndOfSub

     CASE ELSE
     COLOR , 0
     GOTO CityIni

END SELECT

GOTO CityIni

EndOfSub:
COLOR , 0
END SUB

SUB Decision

DecisionsIni:
d1 = rolld6

IF d1 = LastDecisionEvent THEN     'This part of the code should avoid
GOTO DecisionsIni                  'the same decision event repeating twice
END IF                             'in a very short period of time.
LastDecisionEvent = d1

DecisionResult = 0

COLOR 10

'-----------------------  1  -----------------------------

IF d1 = 1 THEN

PRINT

line$(1) = "You are walking out of the road, exploring the place and checking"
line$(2) = "the surroundings. Behind some dead trees there's something that looks"
line$(3) = "like a circle made of huge stones with some strange symbols written on them."
line$(4) = "As soon as you see them, you realize it's an archaic temple, probably"
line$(5) = "built by the ancient tribes that lived in the region."

PrintLines

DO WHILE INKEY$ = ""
LOOP

PRINT

line$(1) = "It's easy for you to recognize these symbols, you've seen them before."
line$(2) = "They aren't part of the dark side, probably this temple was offered and"
line$(3) = "built to summon and pray to the gods of nature."

PrintLines

DO WHILE INKEY$ = ""
LOOP

PRINT

line$(1) = "You feel that talking to the gods, trying to comunicate with them could"
line$(2) = "be a good idea."

PrintLines

DO WHILE INKEY$ = ""
LOOP

PRINT
COLOR 3
PRINT "Do you stop and try to pray to the guardians of nature?"
INPUT "1) Yes, let me try. 2) Not really, let's just continue. "; opcion
COLOR 10

	IF opcion = 1 THEN

	PRINT

	line$(1) = "You stop and sit in the middle of the circle, you feel the wind in"
	line$(2) = "your ears, over your skin, playing with your hair. You can hear the"
	line$(3) = "birds around the place, wolves howlling in the distance, the trees "
	line$(4) = "dancing with the air, knowing that you are there."

	PrintLines

	PRINT

	DO WHILE INKEY$ = ""
	LOOP

	d1 = rolld6

	SELECT CASE d1

		CASE 1
		PRINT
		Pause
		PRINT "Nothing happens."
		GOTO EndSub
		DO WHILE INKEY$ = ""
		LOOP

		CASE 2
		'YOU FEEL BETTER AND RECOVER HP

		PRINT

		line$(1) = "After being in deep meditational state, connected with nature,"
		line$(2) = "communicating with their gods and astral guardians. You feel "
		line$(3) = "much better, 100% energized and recovered. They said this"
		line$(4) = "would be one of your hardest missions, a tough one, but they"
		line$(5) = "would be by your side. You will succeed."

		PrintLines

		PRINT

		d1 = rolld6
		COLOR 3
		Pause
		PRINT "Rolling D6... "
		Pause
		PRINT "["; d1; "]"
		PRINT
		Pause
		PRINT "(+"; d1; " MANA pts)"
		Pause
		PRINT "(+"; d1; " HP pts)"
		COLOR 10

		hp = hp + d1
		mana = mana + d1

		DO WHILE INKEY$ = ""
		LOOP
		GOTO EndSub

		CASE 3
		'SOMEONE SHOTS YOU
		Pause
		PRINT
		Pause
		PRINT "You've been praying for a while now, trying to get in contact"
		Pause
		PRINT "with the spirits of nature. Escape as soon as you can... That"
		Pause
		PRINT "thought came suddendly to your mind but you don't know why."

		DO WHILE INKEY$ = ""
		LOOP

		PRINT
		PRINT "BOOM! A strong explosion behind you. You realize that someone"
		Pause
		PRINT "is attacking you with a fire gun from the distance! "

		DO WHILE INKEY$ = ""
		LOOP

		PRINT
		PRINT "You stand up and try to run away!"
		Pause
		PRINT "When you finally escape, you stop, breathe... and realize that you've"
		Pause
		PRINT "been shot in the shoulder and are heavily wounded."

		d1 = 5 + rolld6
		hp = hp - d1
		
		Pause
		COLOR 3
		PRINT
		PRINT "(-"; d1; "HP pts)"
		COLOR 2

		DO WHILE INKEY$ = ""
		LOOP

		GOTO EndSub

		CASE 4
		'ENEMY
		PRINT
		Pause
		PRINT "You are meditating, praying, connecting with the astral guardians of nature."
		Pause
		PRINT "Suddenly, some cracking sounds of dry leaves make you open your"
		Pause
		PRINT "eyes. It seems the place wasn't as quiet as you thought!"

		DecisionResult = 1
		DO WHILE INKEY$ = ""
		LOOP
		GOTO EndSub
		
		CASE 5
		'ASK SOMETHING {PROTECTION, WISDOM, STRENGTH}
		Pause
		PRINT "After being in deep meditational state for some minutes, you"
		Pause
		PRINT "fall asleep. In your dreams, an entity, one of the guardians"
		Pause
		PRINT "of the forests, appears. He talks to you and gives you good"
		Pause
		PRINT "advice of what you should do. They will protect you."
		Pause
		PRINT "At the end he shows you three books with words on them."
		Pause
		PRINT "There's a red one with the word BLOOD, a green one with"
		Pause
		PRINT "the word TREE, and a grey one with the word ROCK."
		Pause
		PRINT "The entity asks you to choose one of them."
		PRINT

		Pause
		COLOR 3
		PRINT "1) BLOOD 2) TREE 3) ROCK"

askagainbooks:

		Pause
		COLOR 3
		INPUT "What is your choice? ", opcion
		COLOR 10
		PRINT

		SELECT CASE opcion

			CASE 1

			PRINT "You choose the RED book with the word BLOOD on the cover."

			CASE 2

			PRINT "You choose the GREEN book with the word TREE on the cover."

			CASE 3

			PRINT "You choose the GREY book with the word ROCK on the cover."

			CASE ELSE
			GOTO askagainbooks

		END SELECT

		' CONTINUAR AQUI


		PRINT



		PRINT "ASK SOMETHING"

		DO WHILE INKEY$ = ""
		LOOP
		GOTO EndSub


		CASE 6
		'NOTHING HAPPENS
		Pause
		PRINT "NOTHING HAPPENS"

		DO WHILE INKEY$ = ""
		LOOP
		GOTO EndSub

	END SELECT

	END IF

END IF




IF d1 > 1 AND d1 < 4 THEN
Pause
PRINT "The road divides in two different directions in front of you."
Pause
PRINT "One way goes west and the other east. Both roads seem to be"
Pause
PRINT "dangerous as the area is infested with creatures and dark souls."
PRINT
COLOR 3
Pause
PRINT "1) Go WEST"
Pause
PRINT "2) Go EAST"
PRINT
Pause
224 :
COLOR 3
INPUT "What is your choice?", opcion
COLOR 10

	IF opcion = 0 THEN
	GOTO 224
	END IF


	PRINT

	IF opcion = 1 THEN
	Pause
	PRINT "You continue walking by the road and after some kilometers"
	Pause
	PRINT "you see that the road goes through a huge and dangerous forest."
	Pause
	PRINT "You hear the sounds of creatures all around you, but can't see"
	Pause
	PRINT "them."
	PRINT
	COLOR 3
	Pause
	PRINT "Do you think running is an option?"
	Pause
	PRINT "1) RUN"
	Pause
	PRINT "2) DO NOT RUN"
	COLOR 10
	PRINT
ask1:
	Pause
	INPUT "What do you do?", opcion


		SELECT CASE opcion

		CASE 1
		PRINT
		Pause
		PRINT "You RUN with all your energy. You hear things running"
		Pause
		PRINT "by your side in the woods. You probably made the right"
		Pause
		PRINT "decision. This things were ready to attack and you escaped"
		Pause
		PRINT "at the right momment."
		PRINT
		PLAY Chance$

		CASE 2
		PRINT
		Pause
		PRINT "You decide to continue walking at a low pace."
		Pause
		PRINT "You hear noises inside the woods, among the trees and"
		Pause
		PRINT "the darkness of the forest. Suddenly, something jumps"
		Pause
		PRINT "quickly right in front of you, blocking the way!"
		PRINT
		PLAY Chance$
		DO WHILE INKEY$ = ""
		LOOP
		DecisionResult = 1
		GOTO EndSub
		CASE ELSE
		GOTO ask1
		END SELECT

	END IF

	IF opcion = 2 THEN
	PRINT
	PRINT "You decide to take the road that goes east. The road is"
	Pause
	PRINT "calm and silent. Things seem to be pretty quiet around here."
	Pause
	PRINT "The land is flat, you can hear birds and the sound of the wind."
	Pause
	PRINT "The weather seems to be better now. You even decide to stop by "
	Pause
	PRINT "the road, rest a little bit under a tree and then continue walking."
	PRINT
	COLOR 3
	Pause
	PRINT "(+5 MANA pts)"
	COLOR 10
	PLAY Chance$
	mana = mana + 5
	DO WHILE INKEY$ = ""
	LOOP
	END IF


END IF

'-----------------------  2  -----------------------------

IF d1 > 3 AND d1 < 7 THEN
Pause
PRINT "You find a small cave entrance. Looks like it's a small place."
Pause
PRINT "It goes inside the ground and rocks, and you can't see inside."
Pause
PRINT "Are you going to get in this cave and look for some objects, items "
Pause
PRINT "or maybe gold?"
PRINT
COLOR 3
Pause
PRINT "1) ENTER the cave."
Pause
PRINT "2) DO NOT ENTER the cave."
PRINT
Pause
333 :
COLOR 3
INPUT "What is your choose?", opcion
COLOR 10

     SELECT CASE opcion
     
     CASE 1
     d1 = rolld6

	SELECT CASE d1

	CASE 1
	PRINT ""
	Pause
	PRINT "There's an enemy or creature inside this cave!"
	PRINT ""
	PLAY Chance$
	DO WHILE INKEY$ = ""
	LOOP
	DecisionResult = 1
	GOTO EndSub

	CASE 2
	d1 = rolld6
	addgold = d1 * 2
	PRINT ""
	Pause
	PRINT "There are some items in this cave!"
	Pause
	PRINT "You found "; addgold; " GOLD!"
	PRINT ""
	PLAY Chance$
	DO WHILE INKEY$ = ""
	LOOP
	gold = gold + addgold
	GOTO EndSub

	CASE 3
	d1 = rolld6
	addmana = d1 * 2
	PRINT ""
	Pause
	PRINT "There is a dim blue light coming from somewhere in this cave!"
	Pause
	PRINT "You don't know what it means, however it makes you feel better."
	Pause
	PRINT "Seems like your body (all muscles) and mind are relaxed and healed."
	PRINT
	Pause
	PRINT "(+ "; addmana; " MANA pts)"
	PRINT ""
	PLAY Chance$
	DO WHILE INKEY$ = ""
	LOOP
	mana = mana + addmana
	GOTO EndSub
     
	CASE 4
	d1 = rolld6
	DiscountHP = d1 / 2
	PRINT ""
	Pause
	PRINT "There's nothing interesting to see there..."
	Pause
	PRINT "However, while exploring the cave you slip and fall over some rocks."
	Pause
	PRINT "You get out from the cave with one of your arms hurting really bad."
	Pause
	PRINT "It was a wrong decision to get in there."
	PRINT
	Pause
	PRINT "(-"; DiscountHP; " HP pts)"
	PRINT ""
	PLAY Chance$
	DO WHILE INKEY$ = ""
	LOOP
	hp = hp - DiscountHP
	GOTO EndSub

	CASE ELSE
	PRINT ""
	Pause
	PRINT "The cave is empty... Nothing interesting to see here."
	PRINT ""
	DO WHILE INKEY$ = ""
	LOOP
	GOTO EndSub

	END SELECT
     
CASE 2

Pause
PRINT "You just continue walking..."

CASE ELSE
GOTO 333

END SELECT

END IF

DO WHILE INKEY$ = ""
LOOP

EndSub:
END SUB

SUB DisplayWeather

d1 = rolld6
COLOR 3
PRINT "Die:"; d1;
COLOR 2

SELECT CASE d1
CASE 1
PRINT "It's sunny and mild."
CASE 2
PRINT "It's cloudy and breezy."
CASE 3
PRINT "It's snowy and cold."
CASE 4
PRINT "It's dry and very hot."
CASE 5
PRINT "It's stormy, heavy rain."
CASE 6
PRINT "Windy and cold."
END SELECT

END SUB

SUB DrawBugio

COLOR 4

LOCATE 5, 26
PRINT "#############################"
LOCATE 6, 26
PRINT "#                           #"
LOCATE 7, 26
PRINT "#                           #"
LOCATE 8, 26
PRINT "#                           #"
LOCATE 9, 26
PRINT "#                           #"
LOCATE 10, 26
PRINT "#                           #"
LOCATE 11, 26
PRINT "#                           #"
LOCATE 12, 26
PRINT "#                           #"
LOCATE 13, 26
PRINT "#                           #"
LOCATE 14, 26
PRINT "#                           #"
LOCATE 15, 26
PRINT "#                           #"
LOCATE 16, 26
PRINT "#############################"


COLOR 6
LOCATE 6, 27
PRINT "        Ý Ý Ý Ý Ý Ý"
LOCATE 7, 27
PRINT "       Ý ²°°°²²°°°² Ý"
LOCATE 8, 27
PRINT "      Ý ²  þ úú þ  ² Ý"
LOCATE 9, 27
PRINT "      ú°ú °°°úú°°°° ° Ý"
LOCATE 10, 27
PRINT "     Ýú° °° °°°° °° ú°úÝ"
LOCATE 11, 27
PRINT "      ° Ý°° °°°° °°ú Ý°"
LOCATE 12, 27
PRINT "     Ý° ÝÝ ± ± ± ± ÝúÝ°"
LOCATE 13, 27
PRINT "     Ý° ÝÝ± ± ± ± ±Ý Ý°"
LOCATE 14, 27
PRINT "       ²²°°°²²²²°°°²²²"
LOCATE 15, 27
COLOR 4
PRINT "         ° ° ° ° ° °"
LOCATE 16, 27
PRINT "##########°#####°"


COLOR 4
LOCATE 8, 38
PRINT "þ"
LOCATE 8, 43
PRINT "þ"

LOCATE 12, 38
COLOR 15
PRINT "±"
LOCATE 12, 40
PRINT "±"
LOCATE 12, 42
PRINT "±"
LOCATE 12, 44
PRINT "±"

LOCATE 13, 37
PRINT "±"
LOCATE 13, 39
PRINT "±"
LOCATE 13, 41
PRINT "±"
LOCATE 13, 43
PRINT "±"
LOCATE 13, 45
PRINT "±"

LOCATE 14, 36
COLOR 4
PRINT "°°°"
LOCATE 14, 43
PRINT "°°°"

LOCATE 17, 37
PRINT "°"

LOCATE 17, 43
PRINT "°"



END SUB

SUB DrawCrawler

COLOR 4
LOCATE 6, 26
PRINT "#############################"
LOCATE 7, 26
PRINT "#                           #"
LOCATE 8, 26
PRINT "#                           #"
LOCATE 9, 26
PRINT "#                           #"
LOCATE 10, 26
PRINT "#                           #"
LOCATE 11, 26
PRINT "#                           #"
LOCATE 12, 26
PRINT "#                           #"
LOCATE 13, 26
PRINT "#                           #"
LOCATE 14, 26
PRINT "#                           #"
LOCATE 15, 26
PRINT "#                           #"
LOCATE 16, 26
PRINT "#                           #"
LOCATE 17, 26
PRINT "#############################"

COLOR 7
LOCATE 8, 30
PRINT "                   EPD"
LOCATE 9, 30
PRINT "  w|w|w           ##  "
LOCATE 10, 30
PRINT "  #*#*#    ###  ###|  "
LOCATE 11, 30
PRINT "   #-#   #### ####|   "
LOCATE 12, 30
PRINT "  #############|   "
LOCATE 13, 30
PRINT " ## \ ## -----"
LOCATE 14, 30
PRINT " W   ##  "
LOCATE 15, 30
PRINT "     WW  "
LOCATE 16, 30
PRINT "         "

LOCATE 10, 33
COLOR 4
PRINT "*"

LOCATE 10, 35
COLOR 4
PRINT "*"

LOCATE 11, 34
COLOR 4
PRINT "-"

LOCATE 8, 49
COLOR 8
PRINT "EPD"

LOCATE 9, 32
COLOR 15
PRINT "w|w|w"

LOCATE 14, 30
COLOR 8
PRINT "WW"

LOCATE 15, 35
COLOR 8
PRINT "WW"

END SUB

SUB DrawCriminal

COLOR 4
LOCATE 6, 26
PRINT "#############################"
LOCATE 7, 26
PRINT "#                           #"
LOCATE 8, 26
PRINT "#                           #"
LOCATE 9, 26
PRINT "#                           #"
LOCATE 10, 26
PRINT "#                           #"
LOCATE 11, 26
PRINT "#                           #"
LOCATE 12, 26
PRINT "#                           #"
LOCATE 13, 26
PRINT "#                           #"
LOCATE 14, 26
PRINT "#                           #"
LOCATE 15, 26
PRINT "#                           #"
LOCATE 16, 26
PRINT "#                           #"
LOCATE 17, 26
PRINT "#############################"



COLOR 7

LOCATE 8, 30
PRINT "       ####### "
LOCATE 9, 30
PRINT "       ####### "
LOCATE 10, 30
PRINT "     ########### "
COLOR 15
LOCATE 11, 30
PRINT "       ##*#*## "
COLOR 6
LOCATE 12, 30
PRINT "        ##.## "
LOCATE 13, 30
PRINT "         #-# "
COLOR 1
LOCATE 14, 30
PRINT "  ##### ##### ##### "
LOCATE 15, 30
PRINT " ################### "
LOCATE 16, 30
PRINT "#### ########## ##### "


COLOR 8
LOCATE 11, 39
PRINT "*"
LOCATE 11, 41
PRINT "*"

LOCATE 12, 40
COLOR 15
PRINT "."

LOCATE 13, 40
COLOR 15
PRINT "-"

LOCATE 15, 40
COLOR 9
PRINT "#"

LOCATE 16, 40
COLOR 9
PRINT "#"

END SUB

SUB DrawMountains

COLOR 6
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ MOUNTAINS ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"



LOCATE 17
PRINT "                                                                                "
LOCATE 18
PRINT "°                 +            °        °²±         °²±          + Þ Ü"
LOCATE 19
PRINT "²±               °²²±         °²±      °²²²±       °²²²²±       °²Û²Û²Û±       °"
LOCATE 20
PRINT "²²²±   ß  °     °²²²²²±    ß °±²²±   °²²°±±±±   ß °²²²²²±  þ  °²Û²Û²Û²Û²Û±    °±"
LOCATE 21
PRINT "°²°²±  þ °²± þ °±²°²°²°²± þ °²°²°²± °±²°²°±±± þ  °²°°°²°²±   °²Û²Û²Û²Û²Û²Û±  °±±"
LOCATE 22
PRINT "²°²°²±  °²°²± °±°°²°°°²°²± °±²°²°²±²°°°°°°²²±±  °²°²°²°±°°°²°²Û°±Û°±Û°±Û°±Û²°±±±"
LOCATE 23
PRINT "°²°²°²±°²°²°²±±°°°°°±°°°°°±°°°°°°°°°°±²°°°°°°±°°²°°°°°°°°°²°²°°°°°°°°°°°°°°±°±°°"
LOCATE 24
PRINT "²°²°²°°°°²°°°°²°°°±°°°°°±°°°°°±°°°°°°°°±²°°°°°°±°°°±°°°°°°°°°°°°°°±°°°°°°°°°±°°°"

LOCATE 16, 5
COLOR 15
PRINT "þ"

LOCATE 16, 17
PRINT "ß"

LOCATE 16, 24
PRINT "þ"

LOCATE 16, 46
PRINT "ß"

LOCATE 16, 50
PRINT "ß"

LOCATE 16, 60
PRINT "þ"

LOCATE 16, 67
PRINT "ß"

LOCATE 17, 9
PRINT "þ"

LOCATE 17, 21
PRINT "ß"

LOCATE 17, 26
PRINT "þ"

LOCATE 17, 48
PRINT "ß"

LOCATE 17, 54
PRINT "ß"

LOCATE 17, 65
PRINT "þ"

LOCATE 17, 70
PRINT "ß"

LOCATE 18, 6
PRINT "þ"

LOCATE 18, 16
PRINT "þ"

LOCATE 18, 26
PRINT "ß"

LOCATE 18, 38
PRINT "þ"

LOCATE 18, 49
PRINT "ß"

LOCATE 18, 60
PRINT "þ"

LOCATE 18, 75
PRINT "ß"

LOCATE 17, 6
COLOR 14
PRINT "+"

END SUB

SUB DrawScorpion

COLOR 4
LOCATE 6, 26
PRINT "#############################"
LOCATE 7, 26
PRINT "#                           #"
LOCATE 8, 26
PRINT "#                           #"
LOCATE 9, 26
PRINT "#                           #"
LOCATE 10, 26
PRINT "#                           #"
LOCATE 11, 26
PRINT "#                           #"
LOCATE 12, 26
PRINT "#                           #"
LOCATE 13, 26
PRINT "#                           #"
LOCATE 14, 26
PRINT "#                           #"
LOCATE 15, 26
PRINT "#                           #"
LOCATE 16, 26
PRINT "#                           #"
LOCATE 17, 26
PRINT "#############################"

COLOR 14

LOCATE 7, 30
PRINT "            #### "
LOCATE 8, 30
PRINT "           W   ##, "
LOCATE 9, 30
PRINT "              ###, "
LOCATE 10, 30
PRINT "            ####, "
LOCATE 11, 30
PRINT "         #######, "
LOCATE 12, 30
PRINT "      ###***#####, "
LOCATE 13, 30
PRINT "    ##   W W   ## "
LOCATE 14, 30
PRINT "    ###       ### "
LOCATE 15, 30
PRINT "   #  #      #   # "

LOCATE 12, 39
COLOR 8
PRINT "***"

LOCATE 13, 39
COLOR 6
PRINT "W W"

END SUB

SUB DrawWitch

COLOR 4
LOCATE 5, 26
PRINT "#############################"
LOCATE 6, 26
PRINT "#     S#############$$$$    #"
LOCATE 7, 26
PRINT "#    S###############$$$$   #"
LOCATE 8, 26
PRINT "#    S##$$$####$$$##$$$$    #"
LOCATE 9, 26
PRINT "#    SS##*#$##$#*###$$ $$$  #"
LOCATE 10, 26
PRINT "#    SS#####.#######$$$$$   #"
LOCATE 11, 26
PRINT "#   SSS###<<#######$$$$$$$$ #"
LOCATE 12, 26
PRINT "#  SSSS###########$$$$ $$$$$#"
LOCATE 13, 26
PRINT "# SSSSSS$# # # # #$$$$$$$   #"
LOCATE 14, 26
PRINT "#   $$$   # # # #   $$$$$$$ #"
LOCATE 15, 26
PRINT "# $$$ $$$  #####   $$$$ $$  #"
LOCATE 16, 26
PRINT "#############################"


COLOR 7
LOCATE 6, 27
PRINT "     S#############$$$$ "
LOCATE 7, 27
PRINT "    S###############$$$$   "
LOCATE 8, 27
PRINT "    S##$$$####$$$##$$$$    "
LOCATE 9, 27
PRINT "    SS##*#$##$#*###$$ $$$  "
LOCATE 10, 27
PRINT "    SS#####.#######$$$$$   "
LOCATE 11, 27
PRINT "   SSS###<<#######$$$$$$$$ "
LOCATE 12, 27
PRINT "  SSSS###########$$$$ $$$$$"
LOCATE 13, 27
PRINT " SSSSSS$# # # # #$$$$$$$   "
LOCATE 14, 27
PRINT "   $$$   # # # #   $$$$$$$ "
LOCATE 15, 27
PRINT " $$$ $$$  #####   $$$$ $$  "


LOCATE 8, 34
COLOR 8
PRINT "$$$"

LOCATE 9, 37
PRINT "$"


LOCATE 8, 41
PRINT "$$$"

LOCATE 9, 40
PRINT "$"

LOCATE 9, 35
COLOR 4
PRINT "*"

LOCATE 9, 42
PRINT "*"

LOCATE 13, 35
PRINT "# # # # #"

LOCATE 14, 36
PRINT "# # # #"

COLOR 15
LOCATE 6, 27
PRINT "     S"
LOCATE 7, 27
PRINT "    S"
LOCATE 8, 27
PRINT "    S"
LOCATE 9, 27
PRINT "    SS"
LOCATE 10, 27
PRINT "    SS"
LOCATE 11, 27
PRINT "   SSS"
LOCATE 12, 27
PRINT "  SSSS"
LOCATE 13, 27
PRINT " SSSSSS"
LOCATE 14, 27
PRINT "   $$$"
LOCATE 15, 27
PRINT " $$$ $$$"

LOCATE 6, 46
PRINT "$$$$"
LOCATE 7, 47
PRINT "$$$$"
LOCATE 8, 46
PRINT "$$$$"
LOCATE 9, 46
PRINT "$$ $$$"
LOCATE 10, 46
PRINT "$$$$$"
LOCATE 11, 45
PRINT "$$$$$$$$"
LOCATE 12, 44
PRINT "$$$$ $$$$$"
LOCATE 13, 44
PRINT "$$$$$$$"
LOCATE 14, 46
PRINT "$$$$$$$"
LOCATE 15, 45
PRINT "$$$$ $$"


END SUB

SUB DrawWolf

COLOR 7

LOCATE 3, 18
PRINT "              °              °"
LOCATE 4, 18
PRINT "              °°            °±°"
LOCATE 5, 18
PRINT "             °°±°         °°±±°"
LOCATE 6, 18
PRINT "             °°±±° °  ° ° °°±°°"
LOCATE 7, 18
PRINT "             °°±±±°°° °° °°   °"
LOCATE 8, 18
PRINT "            ° °°°±°     °  - °°"
LOCATE 9, 18
PRINT "             °° -°--° ° °--±±° ° °"
LOCATE 10, 18
PRINT "            ° °±±Ý * °² * Ý±±°° °"
LOCATE 11, 18
PRINT "          °   °±±± °°±±±°°° ±±±°° °"
LOCATE 12, 18
PRINT "         °   °   ²²²²±²±²²²²  ° ° ° ±"
LOCATE 13, 18
PRINT "         ± ° ° ° Ý²²°°°²Þþ ° °  ° °"
LOCATE 14, 18
PRINT "        °  °  ° °  °° ° °° ÝÝ° ° °  ° ²       "
LOCATE 15, 18
PRINT "         °  ° ° °°ÝÝÝÝÝÝ ° ° °   °     °      "
LOCATE 16, 18
PRINT "        ±  ±  ° ° Ý °°°° Ý ° °     °          "
LOCATE 17, 18
PRINT "          ± ²  ° °   °°    °°   ° °  ²        "
LOCATE 18, 18
PRINT "        ²         °°     °°           °       "
LOCATE 19, 18
PRINT "       °    ±       °° °°                     "
LOCATE 20, 18
PRINT "          °                                   "
LOCATE 21, 18
PRINT ""

COLOR 14
LOCATE 10, 37
PRINT "*"
LOCATE 10, 42
PRINT "*"

COLOR 4
LOCATE 15, 35
PRINT "°"
LOCATE 16, 34
PRINT "°"
LOCATE 17, 35
PRINT "°"
LOCATE 16, 44
PRINT "°"

LOCATE 15, 43
PRINT "°"
LOCATE 16, 40
PRINT "°"
LOCATE 16, 38
PRINT "°"
LOCATE 17, 39
PRINT "°"



END SUB

SUB FightIntro

PRINT
COLOR 15

'================= ALIGNING NAMES TO THE CENTER =============================

LOCATE 3, 25

IF Enemyname$ = "Giant Scorpion" THEN
LOCATE 3, 23
END IF

IF Enemyname$ = "Criminal" THEN
LOCATE 3, 25
END IF

IF Enemyname$ = "Crawler" THEN
LOCATE 3, 26
END IF

IF Enemyname$ = "Wild Wolf" THEN
LOCATE 5, 3
PRINT Enemyname$; "!"
LOCATE 6, 3
PRINT "ATTACK: "; enemyAT
LOCATE 7, 3
PRINT "DEFENCE: "; enemyDF
GOTO Skip
END IF

PRINT Enemyname$; "! ATTACK: "; enemyAT; "DEFENCE: "; enemyDF

Skip:

COLOR PositionCol(PositionCH), 0
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"



' ++++++++++++++++++++++++++++ FOREST BANNER ++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 2 THEN

COLOR 10, 0
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ FOREST ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 21, 1
COLOR 2
PRINT "°°° °°°°°°°°°°°°°°°°°°°°°°° °°° °°° °°°°°° °°° °°°°°°°°°°° °°°°°°°°°°°°°°°°° °°°"
LOCATE 22, 1
COLOR 6
PRINT " °   °  °  ° °  °  °  °  °   °   °   °  °   °   °  ° °  °   °  °  ° °  °  °   °"
LOCATE 23, 1
COLOR 10
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"


LOCATE 22, 13
COLOR 2
PRINT ";"

LOCATE 22, 16
COLOR 2
PRINT ";"

LOCATE 22, 19
COLOR 2
PRINT ";"

LOCATE 22, 22
COLOR 2
PRINT ";"

LOCATE 22, 25
COLOR 2
PRINT ";"

LOCATE 22, 28
COLOR 2
PRINT ";"

LOCATE 22, 32
COLOR 2
PRINT ";"

LOCATE 22, 35
COLOR 2
PRINT ";"

LOCATE 22, 37
COLOR 2
PRINT ";"

LOCATE 22, 62
COLOR 2
PRINT ";"

LOCATE 22, 65
COLOR 2
PRINT ";"

LOCATE 22, 68
COLOR 2
PRINT ";"
END IF

'++++++++++++++++++++++++++++ FROZEN LANDS +++++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 7 THEN

COLOR PositionCol(PositionCH), 0
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ FROZEN LANDS ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"


LOCATE 21, 1
COLOR 15
PRINT "  °°°°°°°   °°°°      °°° °°°   °°°°°°°    °°° °°°   °°°°°°°    °°°°°°°   °°°°°°"
LOCATE 22, 1
COLOR 15
PRINT " °°°°°°°°°°°°°°°°°°° °°°°°°°°°° °°°°°°°°°° °°°°°°°°° °°°°°°°°°° °°°°°°°° °°°°°°°"
LOCATE 23, 1
COLOR 7
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

END IF

'++++++++++++++++++++++++++++++ MOUNTAINS ++++++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 6 THEN

CALL DrawMountains

END IF

'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

IF Enemyname$ = "Criminal" THEN
CALL DrawCriminal
END IF

IF Enemyname$ = "Wild Wolf" THEN
CALL DrawWolf
END IF


IF Enemyname$ = "Giant Scorpion" THEN
CALL DrawScorpion
END IF

IF Enemyname$ = "Crawler" THEN
CALL DrawCrawler
END IF

IF Enemyname$ = "Witch" THEN
CALL DrawWitch
END IF

IF Enemyname$ = "Wild Bugio" THEN
CALL DrawBugio
END IF

DO WHILE INKEY$ = ""
LOOP

CLS

END SUB

SUB GameOver
CLS
x = 0
DO UNTIL x = 4000
'RANDOMIZE TIMER
d1 = INT(RND * 75) + 1
d2 = INT(RND * 23) + 1
x = x + 1
COLOR 4
LOCATE d2, d1
PRINT "°±²"
LOCATE 10, 33
COLOR 15
PRINT "YOU HAVE DIED"
LOCATE 11, 34
PRINT "-GAME OVER-"
LOOP

x = 0
DO UNTIL x = 4000
'RANDOMIZE TIMER
d1 = INT(RND * 75) + 1
d2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE d2, d1
PRINT "°±²"
LOCATE 10, 33
COLOR 15
PRINT "YOU HAVE DIED"
LOCATE 11, 34
PRINT "-GAME OVER-"
LOOP
CLS

END SUB

SUB Information

d1 = INT(RND * 7) + 1

COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 > 0 AND d1 < 3 THEN

line$(1) = "Peasant: So, you are looking for some terrible criminals, right?"
line$(2) = "Well, some of them hide in places like forests or in the mountains"
line$(3) = "if you are lucky, you'll find them in those places."

PrintLines

END IF

IF d1 = 3 THEN

line$(1) = "Tavern owner: Good to know you are taking care of those terrible killers."
line$(2) = "Some of them are wizards who practice the arts of the dark side. People"
line$(3) = "even say they kidnap kids and young women for their sacrifices, offering"
line$(4) = "them to the black lord."

PrintLines

END IF

IF d1 = 4 THEN

line$(1) = "Farmer: Be very a careful man, we all know what you're doing over here"
line$(2) = "and they know too. They expect to meet you soon, so I guess they are ready."
line$(3) = "Don't be a fool, don't think they are weak. Get ready as much as you can."
line$(4) = "These people are dark and they aren't ordinary ones, they posses supernatural"
line$(5) = "powers, and this power doesn't come from light. Many families around here"
line$(6) = "lost some of their children... and we all know they took them."

PrintLines

END IF

IF d1 = 5 THEN

line$(1) = "Priest: They are part of a satanic order. These black sorcerers have already"
line$(2) = "carried out thousands of killings and murders, terrifying our village."
line$(3) = "They kidnap babies, kids and young women. We have already found the places"
line$(4) = "where these beasts celebrate their bloody rituals and hideous feasts."

PrintLines

END IF

IF d1 = 6 THEN

line$(1) = "You're following a narrow path, seeing huge vultures above in the sky. "
line$(2) = "Something is not ok. A strong and awful smell gets to you. You continue"
line$(3) = "walking not knowing what you're about to find. Behind some rocks, hidden "
line$(4) = "by high grass, you find a rotten corpse. Rotten bones and flesh. You vomit,"
line$(5) = "the view is overwhelming, disgusting. Danger seems to be near."

PrintLines

END IF

DO WHILE INKEY$ = ""
LOOP

END SUB

SUB Intro

LOCATE 11, 34
PRINT "LOADING..."
PLAY IntroMusic$

CLS

COLOR 4
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

COLOR 14

LOCATE 3, 1
PRINT "Welcome explorer. Welcome to savage lands, inhabited by peaceful farmers "
Pause
LOCATE 4, 1
PRINT "and villagers but also by the most awful, violent and repulsive creatures"
Pause
LOCATE 5, 1
PRINT "never seen."
PRINT

PLAY Chime$

DO WHILE INKEY$ = ""
LOOP

PRINT
LOCATE 7, 1
PRINT "The folklore and stories told by the peasants here are full of ghosts"
Pause
LOCATE 8, 1
PRINT "stories, demons, witchery and satanic rituals."
PRINT

PLAY Chime$


DO WHILE INKEY$ = ""
LOOP

LOCATE 10, 1
PRINT "So that's why you are here. You've been an explorer all your life, a"
Pause
LOCATE 11, 1
PRINT "demon hunter and one who knows all about rituals done by the dark side."
Pause
LOCATE 12, 1
PRINT "You are here for curiosity but also because they promise a lot of money,"
Pause
LOCATE 13, 1
PRINT "gold taken directly from their mines, to that one who can eliminate The"
Pause
LOCATE 14, 1
PRINT "Order, a satanic group that lives hidden in the wild forests, swamps and"
Pause
LOCATE 15, 1
PRINT "mountains."
PRINT

PLAY Chime$

DO WHILE INKEY$ = ""
LOOP

LOCATE 17, 1
PRINT "All along the history of this region, they've committed hundreds of atrocities"
Pause
LOCATE 18, 1
PRINT "in the name of evil, in order to carry out their dark rituals performed by the"
Pause
LOCATE 19, 1
PRINT "use of human blood and flesh."

PLAY Chime$

DO WHILE INKEY$ = ""
LOOP

END SUB

SUB LoadChallenges

'Checking FILES +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'If FILES don't exist the program creates them. ++++++++++++++++++++++++++++

OPEN "chl.dat" FOR BINARY AS #1
IF LOF(1) = 0 THEN
CLOSE #1

OPEN "chl.dat" FOR OUTPUT AS #1

loopx = 0
DO UNTIL loopx = 100
WRITE #1, ""
loopx = loopx + 1
LOOP

CLS
PRINT "Challenges file created..."
Pause

END IF
CLOSE #1


OPEN "chl.dat" FOR INPUT AS #1

INPUT #1, OneHundredGold
INPUT #1, OneThousandGold
INPUT #1, FindACity
INPUT #1, ReachLevelTen

CLOSE #1

END SUB

SUB Music

IF OptionMusic = 1 THEN
Chance$ = "b5e"
endfight$ = "O2b5ebo3c4o2eo3"
enemy$ = "e20 e20"
Chime$ = "MB o5 d20 d20"
levelup$ = "c20 d20 e20 c20 d20 e20"
NegativeMusic$ = "MB o1 D#8 E4 o0 C4 B9C8B3"
positive$ = "MB o1 A8B8C7 A8D8D#8 o0 E4E4"
IntroMusic$ = "MB o1ag#g#baao2co1bo2co1aecde o1g#g#baao2co1bo1o1a6a5a2"
END IF

IF OptionMusic = 0 THEN
Chance$ = ""
endfight$ = ""
enemy$ = ""
Chime$ = ""
levelup$ = ""
NegativeMusic$ = ""
positive$ = ""
IntroMusic$ = ""
END IF


END SUB

SUB NegativeSub
Negative2:

d1 = rolld6

IF d1 = LastNegativeEvent THEN      'This part of the code should avoid
GOTO Negative2                      'the same negative event repeating twice
END IF                              'in a very short period of time.
LastNegativeEvent = d1

COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 = 1 THEN

line$(1) = "You are trying to climb a huge rock that blocks the way and end up falling down."
line$(2) = "You hurt your back when falling (-1 HP)."

PrintLines

hp = hp - 1

END IF


IF d1 = 2 THEN

line$(1) = "You are walking around the place and hear the sound of an animal coming"
line$(2) = "towards you from behind. When you turn, you see a GIANT BUGIO (a huge"
line$(3) = "and violent monkey) coming. You run, you run and save your life but in"
line$(4) = "the escape you lose all your gold coins (Gold = 0)."

PrintLines

gold = 0

END IF


IF d1 = 3 THEN

line$(1) = "You feel something like a bite in your leg. You stop and check what it was."
line$(2) = "You see two red points and a thin blood string coming out from your leg."
line$(3) = "You wish it was only an insect and not a snake."

PrintLines

DO WHILE INKEY$ = ""
LOOP

d1 = rolld6

COLOR 3

PRINT "Die:"; d1;

'''''''''''

	IF d1 = 1 THEN

	COLOR 10

	line$(1) = "Some meters ahead you see it... it was a snake! (-6 HP)"

	PrintLines

	hp = hp - 6

	DO WHILE INKEY$ = ""
	LOOP

	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 2 THEN

	COLOR 10

	line$(1) = "Some meters ahead you see it... it was a brown spider! (-3 HP)"
	
	PrintLines

	hp = hp - 3

	DO WHILE INKEY$ = ""
	LOOP

	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 3 THEN
	COLOR 10
	
	line$(1) = "You don't see anything... well maybe it was just a plant or a rock."
	line$(2) = "The pain goes away..."

	PrintLines

	DO WHILE INKEY$ = ""
	LOOP
	GOTO EndOfNegative
	END IF

'''''''''''
	IF d1 = 4 THEN

	COLOR 10

	line$(1) = "It hurst a lot at the beginning! Then it feels better but the area"
	line$(2) = "seems to be infected... It's swelling! "
	
	PrintLines

	RANDOMIZE TIMER

	d1 = INT(RND * 6) + 1

	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."

	hp = hp - d1

	DO WHILE INKEY$ = ""
	LOOP

	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 5 THEN

	COLOR 10

	line$(1) = "Oh... it's nothing. Probably you cut your leg against a rock."

	PrintLines

	DO WHILE INKEY$ = ""
	LOOP

	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 6 THEN

	COLOR 10

	line$(1) = "Some centimeters away from your leg there's a huge poisonous centipede..."
	line$(2) = "It's in attack position, seems to be annoyed. It's an horrible and disgusting"
	line$(3) = "animal. That creepy thing bit you!"

	PrintLines

	d1 = rolld6

	Pause

	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."

	hp = hp - d1

	DO WHILE INKEY$ = ""
	LOOP

	GOTO EndOfNegative

	END IF

'''''''''''

END IF


IF d1 > 3 AND d1 < 7 THEN

COLOR 10

line$(1) = "There is a huge storm coming. You seem worried cause it looks very bad."
line$(2) = "You try to hurry up and find a place to hide. However, you are not lucky today."
line$(3) = "All your clothes get wet and you feel terrible after walking so much with"
line$(4) = "wet feet and wet clothes. You also feel very cold. (-1 HP)"

PrintLines

hp = hp - 1.5

END IF


DO WHILE INKEY$ = ""
LOOP

EndOfNegative:
END SUB

SUB NewCityText

COLOR 15, 15
LOCATE 20, 27
PRINT "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
LOCATE 21, 27
PRINT "º  YOU FOUND A CITY!   º"
LOCATE 22, 27
PRINT "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
COLOR , 0

PLAY positive$

DO WHILE INKEY$ = ""
LOOP

END SUB

SUB Notes

'================================================

'v 0.5

' - System of CHALLENGES created.
' - First challenges added.
' - GET 100 GOLD challenge, created.
' - FIND A CITY FOR THE FIRST TIME challenge, created.
' - REACH LEVEL 10 challenge, created.
' - The chl.dat file is created to save challenges variables.
' - Challenges variables are saved everytime you exit the game.
' - Challenges variables are loaded everytime you start the game.
' - The Fight Intro has been improved.
' - Grapics made of ASCII characters added to Fight Intro.
' - Wild Bugio - ASCII graphic added.
' - Wild Wolf - ASCII graphic added.
' - ASCII BANNERS represent the TERRAIN you are in.
' - The kind of terrain influences in battle.
' - A randomly chosen terrain will give you extra AT pts in battle.
' - "You were born in the <terrain>" showed in the CHARACTER screen.


' v 0.4

' - Cities added
' - Cities system and options under development
' - Random number of cities (1 to 6)
' - Random location of the cities in the map.
' - Cities aren't shown until you discover them.
' - "YOU DISCOVERED A CITY!" tex box when a city is found.
' - HOTEL added to the cities.
' - You can rest and spend the night at the HOTEL.
' - LOCAL BAR added to cities
' - You can HAVE A BEER at the bar
' - You can BET at the bar
' - You can FIGHT at the bar
' - You can TALK TO STRANGERS at the bar.
' - GYM/TRAINING GROUND added to cities
' - You can train and improve your skills at the TRAINING GROUND.
' - OPTIONS: Music ON/OFF added. (during the game and in the main menu)
' - Main menu and some visual details of the game improved.
' - CHARACTER screen added (Statistics and Information about the character)

END SUB

SUB Pause
pausex = 0

DO UNTIL pausex = 10000
pausex = pausex + 1
LOOP

END SUB

SUB PrintLines

'Sub routine that prints text lines and the story lines.

loopx = 0               '========= LOOP for printing the line$() ARRAY

DO UNTIL loopx = 24

 IF line$(loopx) = "" THEN
 GOTO SkipLine
 END IF

 Pause
 PRINT line$(loopx)

SkipLine:

 loopx = loopx + 1

LOOP


'++++++++++++++++++++ CLEAR STRING VARIABLES ++++++++++++++++++++++++++++++++

loopx = 0

DO UNTIL loopx = 24
line$(loopx) = ""
loopx = loopx + 1
LOOP

END SUB

FUNCTION rolld6
RANDOMIZE TIMER
rolld6 = INT(RND * 6) + 1
END FUNCTION

SUB SaveChallenges

'========================== SAVES DATA ==========================

OPEN "chl.dat" FOR OUTPUT AS #1

WRITE #1, OneHundredGold
WRITE #1, OneThousandGold
WRITE #1, FindACity
WRITE #1, ReachLevelTen


LOCATE , 30
PRINT "Challenges saved..."
Pause
CLOSE #1

END SUB

SUB TalkToStrangers

CLS
d1 = rolld6

SELECT CASE d1

	CASE 1

	line$(1) = "Bar Tender: You don't look like you're from the town. Am I right?"
	line$(2) = "Some random foreigners come over here from time to time, some of them"
	line$(3) = "come to this bar looking for fight and trouble. See that man next to"
	line$(4) = "the door? He's crazy, has been in prison for many years and now is our"
	line$(5) = "security guard. See that other huge guy playing games at that table?"
	line$(6) = "Seems pretty quiet, but that's cause you don't know him well. However,"
	line$(7) = "if you come here in peace, just to relax and grab some beers. There's"
	line$(8) = "nothing to fear over here, people are usually friendly."

	CASE 2
	
	line$(1) = "Jason: Some people say that they built something like a small city"
	line$(2) = "inside the mountains. A huge place made of caves, connected by tunnels"
	line$(3) = "and that they live there. Some other people say that there's a small"
	line$(4) = "and hidden place in the haunted woods, where they have their houses that"
	line$(5) = "they made using trees and stones. I have never seen these places, don't"
	line$(6) = "even know if they really exist. No one  goes out of the town. No one."

	CASE 3
	
	line$(1) = "Soldier: Some years ago, me and a small group of soldiers, were sent to"
	line$(2) = "patrol the forest and the surroundings of the city. It was usual to find"
	line$(3) = "the areas where these people practice their rituals. Blood and corpses of"
	line$(4) = "all kinds were found in those places, even human bodies and lots of strange"
	line$(5) = "and scary dolls, made of plants, stones, feathers and animal skulls. Not so"
	line$(6) = "long ago I found out that one of our superiors was also part of the order."
	line$(7) = "You can't trust anyone here."
	
	CASE 4

	line$(1) = "Blonde Woman: There's some sort of magic in this town. Not so big, not too"
	line$(2) = "small. If you go out to the streets and look around, the trees, the houses"
	line$(3) = "and even the stores look tidy and neat, they are very nice. However, when"
	line$(4) = "the sun goes down, people hide in their homes and only come out the next"
	line$(5) = "morning. Everyone is terrified of darkness and no one dares to walk out of"
	line$(6) = "the city into the  woods. It's very dangerous. Chances of being killed or"
	line$(7) = "dissapearing are high."
	
	CASE ELSE

	line$(1) = "Bar Tender: You don't look like you're from the town. Am I right?"
	line$(2) = "Some random foreigners come over here from time to time, some of them"
	line$(3) = "come to this bar looking for fight and trouble. See that man next to"
	line$(4) = "the door? He's crazy, has been in prison for many years and now is our"
	line$(5) = "security guard. See that other huge guy playing games at that table?"
	line$(6) = "Seems pretty quiet, but that's cause you don't know him well. However,"
	line$(7) = "if you come here in peace, just to relax and grab some beers. There's"
	line$(8) = "nothing to fear over here, people are usually friendly."

END SELECT

PRINT
PRINT

CALL PrintLines        '========= SUB for printing the line$() ARRAY

DO WHILE INKEY$ = ""
LOOP

END SUB

'============================ SCREEN TRANSITION 1 ===========================
SUB Trans1

transicion1:

COLOR PositionCol(PositionCH), 0

IF barfight = 1 THEN
COLOR 11, 0
END IF

CLS

vueltas = 0

DO UNTIL vueltas = 2
vueltas = vueltas + 1
CLS

yloop = 1
xloop = 1

DO UNTIL xloop = 79

DO UNTIL yloop = 25
LOCATE yloop, xloop
PRINT "²²°"
yloop = yloop + 1

SELECT CASE INKEY$
	CASE CHR$(27)
	END
END SELECT
LOOP

xloop = xloop + 1
yloop = 1
LOOP


LOOP

COLOR 2, 0
CLS
END SUB

