DECLARE SUB GameOver ()
'- CREAR NUEVAS PARTES DE LA HISTORIA
'- CREAR EVENTOS DE DECISIONES - EL JUGADOR ELIGE ENTRE VARIAS OPCIONES
'- CREAR HISTORIA INICIAL, INTRO
'- AGREGAR MAS SONIDOS
'- AGREGAR CIUDADES AL MAPA EN DONDE SE PUEDA DESCANSAR, COMER, ENTRENAR, COMPRAR.
'- AGREGAR ENCICLOPEDIA [SOBRE CRIATURAS, PERSONAJES Y LUGARES]
'- PODER ELEGIR UN NOMBRE PARA EL PERSONAJE
'- CREAR ALGUNAS NUEVAS TRANSICIONES
'- TERMINAR DE ORGANIZAR EL CODIGO EN FUNCIONES/SUBS

'======================== SUBS AND FUNCTIONS =========================

DECLARE SUB City ()
DECLARE SUB Information ()
DECLARE SUB Character ()
DECLARE SUB About ()
DECLARE SUB Pause ()
DECLARE SUB Intro ()
DECLARE SUB Trans1 ()
DECLARE SUB DisplayWeather ()
DECLARE SUB Decision ()
DECLARE FUNCTION rolld6 ()

'| GLOBAL VARIABLES FOR SUBS |
DIM SHARED DecisionResult, LastDecisionEvent, mana, hp, gold, Chance$, Chime$, IntroMusic$
DIM SHARED AT, DF, maxHP, MaxMana
DIM SHARED City1Exists, City2Exists, City3Exists, City4Exists, City5Exists, City6Exists

'======================== MUSIC and SOUNDS =========================

Chance$ = "b5e"
endfight$ = "O2b5ebo3c4o2eo3"
ENEMY$ = "e20 e20"
Chime$ = "MB o5 d20 d20"
levelup$ = "c20 d20 e20 c20 d20 e20"
IntroMusic$ = "MB o1ag#g#baao2co1bo2co1aecde o1g#g#baao2co1bo1o1a6a5a2"


'======================== MAIN MENU =========================

mainmenu:

opcion = 0

CLS
COLOR 15
PRINT ""
PRINT "WILD 0.3 (2021 - 2022)"
PRINT
Pause
PRINT "1) NEW GAME"
Pause
PRINT "2) CREDITS"
Pause
PRINT "3) EXIT"
Pause
PRINT ""
INPUT "Choose an option: ", opcion


IF opcion = 1 THEN
CLS
x = 0
DO UNTIL x = 4000
d1 = INT(RND * 75) + 1
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 9
LOCATE D2, d1
PRINT "갚�"
LOCATE 10, 34
COLOR 15
PRINT " GET READY FOR "
LOCATE 11, 34
PRINT "A NEW ADVENTURE"
LOOP
x = 0
DO UNTIL x = 4000
d1 = INT(RND * 75) + 1
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE D2, d1
PRINT "갚�"
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
CALL About
GOTO mainmenu
END IF

IF opcion = 3 THEN
END
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

'VARIABLES (Gold, attack, defence, HP, etc.) ================================

PRINT "Generating random gold values..."
					       'ALL THESE VARIABLES
gold = rolld6 * rolld6                         'HAVE BEEN RANDOMIZED, SO
PRINT "Generating random attack value..."      'EVERYTIME YOU PLAY A NEW
					       'GAME IT'S GONNA BE SOMETHING
AT = rolld6 * 2                                'DIFFERENT. I USED THE VALUE
PRINT "Generating random defence value..."  '6 TO RANDOMIZE THEM, SIMULATING
					   'A NORMAL SOLO RPG GAME, USING A
DF = (rolld6) * 2                          'SIMPLE D6 DIE.I'VE USED D6 RANDOM
PRINT "Generating random HP value..."      'VARIABLES AS A BASE FOR THE WHOLE
maxHP = (rolld6) + 5                       'RANDOMIZATION SYSTEM IN THE GAME,
hp = maxHP                                 'TO JUST TO KEEP IT SIMPLE.
PRINT "Generating random mana value..."

MaxMana = 5 + rolld6
mana = MaxMana

Pause


CALL Character


inicio:

d1 = (rolld6) / 10
hp = hp + d1
mana = mana + d1

inicio2:
RANDOMIZE TIMER

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
IF position = PositionCH THEN
COLOR 4
END IF

LOCATE lugary, lugarx                'Shows normal tiles or cities.
SELECT CASE position

	CASE PositionCity1

	IF PositionCH = PositionCity1 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	
	CASE PositionCity2

	IF City2Exists = 1 THEN
	IF PositionCH = PositionCity2 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	ELSE
	COLOR , 0
	PRINT "�"
	END IF

	CASE PositionCity3

	IF City3Exists = 1 THEN
	IF PositionCH = PositionCity3 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"

	ELSE
	COLOR , 0
	PRINT "�"

	END IF

	CASE PositionCity4

	IF City4Exists = 1 THEN
	IF PositionCH = PositionCity4 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"

	ELSE
	COLOR , 0
	PRINT "�"

	END IF

	CASE PositionCity5

	IF City5Exists = 5 THEN
	IF PositionCH = PositionCity5 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"

	ELSE
	COLOR , 0
	PRINT "�"

	END IF

	CASE PositionCity6

	IF City6Exists = 6 THEN
	IF PositionCH = PositionCity6 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"

	ELSE
	COLOR , 0
	PRINT "�"

	END IF

	CASE ELSE
	COLOR , 0
	PRINT "�"

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

IF direction = 5 THEN

CALL City

	IF hp <= 0 THEN
	GOTO mainmenu
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

	CASE PositionCity1

	IF PositionCH = PositionCity1 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0

	CASE PositionCity2

	IF City2Exists = 1 THEN
	IF PositionCH = PositionCity2 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0
	END IF

	CASE PositionCity3

	IF City3Exists = 1 THEN
	IF PositionCH = PositionCity3 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0
	END IF

	CASE PositionCity4

	IF City4Exists = 1 THEN
	IF PositionCH = PositionCity4 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0
	END IF

	CASE PositionCity5

	IF City5Exists = 5 THEN
	IF PositionCH = PositionCity5 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0
	END IF

	CASE PositionCity6

	IF City6Exists = 6 THEN
	IF PositionCH = PositionCity6 THEN
	COLOR 15, 4
	ELSE
	COLOR 15, PositionCol(position)
	END IF

	PRINT "C"
	COLOR , 0
	END IF

	CASE ELSE
	PRINT "�"

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
	PLAY Chime$
	GOTO inicio

	CASE PositionCity2
	IF City2Exists = 1 THEN
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity3
	IF City3Exists = 1 THEN
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity4
	IF City4Exists = 1 THEN
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity5
	IF City5Exists = 1 THEN
	PLAY Chime$
	GOTO inicio
	END IF

	CASE PositionCity6
	IF City6Exists = 1 THEN
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
PLAY ENEMY$
SLEEP 2
GOTO ENEMY
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
GOTO negative
END IF

IF d1 = 6 THEN
PRINT " - INFORMATION -"
CALL Information
GOTO inicio
END IF


DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
negative:

d1 = rolld6

IF d1 = LastNegativeEvent THEN      'This part of the code should avoid
GOTO negative                       'the same negative event repeating twice
END IF                              'in a very short period of time.
LastNegativeEvent = d1

COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 = 1 THEN
PRINT "You are trying to climb a huge rock that blocks the way and end up falling down."
Pause
PRINT "You hurt your back when falling (-1 HP)."
hp = hp - 1
END IF

IF d1 = 2 THEN
PRINT "You are walking around the place and hear the sound of an animal coming"
Pause
PRINT "towards you from behind. When you turn, you see a GIANT BUGIO (a huge"
Pause
PRINT "and violent monkey) coming. You run, you run and save your life but in"
Pause
PRINT "the escape you lose all your gold coins (Gold = 0)."
gold = 0
END IF

IF d1 = 3 THEN
PRINT "You feel something like a bite in your leg. You stop and check what was it."
Pause
PRINT "You see two red points and a thin blood string coming out from your leg."
Pause
PRINT "You wish it was only an insect and not a snake."
DO WHILE INKEY$ = ""
LOOP
d1 = rolld6
COLOR 3
PRINT "Die:"; d1;
'''''''''''
	IF d1 = 1 THEN
	COLOR 10
	PRINT "Some meters ahead you see it... it was a snake! (-6 HP)"
	hp = hp - 6
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 2 THEN
	COLOR 10
	PRINT "Some meters ahead you see it... it was a brown spider! (-3 HP)"
	hp = hp - 3
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 3 THEN
	COLOR 10
	PRINT "You don't see anything... well maybe it was just a plant or a rock."
	Pause
	PRINT "The pain goes away..."
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 4 THEN
	COLOR 10
	PRINT "It hurst a lot at the beginning! Then it feels better but the area"
	Pause
	PRINT "seems to be infected... It's swelling! "
	Pause
	RANDOMIZE TIMER
	d1 = INT(RND * 6) + 1
	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."
	hp = hp - d1
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 5 THEN
	COLOR 10
	PRINT "Oh... it's nothing. Probably you cut your leg against a rock."
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 6 THEN
	COLOR 10
	PRINT "Some centimeters away from your leg there's a huge poisonous centipede..."
	Pause
	PRINT "It's in attack position, seems to be annoyed. It's an horrible and disgusting"
	Pause
	PRINT "animal. That creepy thing bit you!"

	d1 = rolld6

	Pause
	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."
	hp = hp - d1
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
END IF


IF d1 > 3 AND d1 < 7 THEN
COLOR 10
PRINT "There is a huge storm coming. You seem worried cause it looks very bad."
Pause
PRINT "You try to hurry up and find a place to hide. However, you are not lucky today."
Pause
PRINT "All your clothes get wet and you feel terrible after walking so much with"
Pause
PRINT "wet feet and wet clothes. You also feel very cold. (-1 HP)"
hp = hp - 1.5
END IF

DO WHILE INKEY$ = ""
LOOP



GOTO inicio


'---------------------------------------------------------

Decision:
CALL Decision

SELECT CASE DecisionResult
CASE 0
GOTO inicio
CASE 1
GOTO ENEMY
END SELECT

'---------------------------------------------------------
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
ENEMY:

CALL Trans1
d1 = rolld6

IF d1 = 1 THEN
Enemyname$ = "Wild Wolf"
enemyAT = 3
enemyDF = 5

	IF AT > 12 THEN
	Enemyname$ = "Demonic Black Panther"
	enemyAT = 6
	enemyDF = 10
	END IF

	IF AT > 22 THEN
	Enemyname$ = "Demonic Mogmurch"
	enemyAT = 6
	enemyDF = 10
	END IF
	
END IF

IF d1 = 2 THEN
Enemyname$ = "Wild Bugio"
enemyAT = 4.5
enemyDF = 6

	IF AT > 12 THEN
	Enemyname$ = "Damned Walker"
	enemyAT = 6
	enemyDF = 15
	END IF

	IF AT > 22 THEN
	Enemyname$ = "Demonic Rat"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 3 THEN
Enemyname$ = "Witch"
enemyAT = 4
enemyDF = 5.5
	
	IF AT > 12 THEN
	Enemyname$ = "Tortured Soul"
	enemyAT = 8
	enemyDF = 12
	END IF

	IF AT > 22 THEN
	Enemyname$ = "Giant Flying Spider"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 4 THEN
Enemyname$ = "Crawler"
enemyAT = 5
enemyDF = 5

	IF AT > 12 THEN
	Enemyname$ = "Giant Acid Centipede"
	enemyAT = 30
	enemyDF = 54
	END IF

	IF AT > 22 THEN
	Enemyname$ = "Demonic Goblin"
	enemyAT = 35
	enemyDF = 59
	END IF

END IF

IF d1 = 5 THEN
Enemyname$ = "Criminal"
enemyAT = 4
enemyDF = 5

	IF AT > 12 THEN
	Enemyname$ = "Forest Demon"
	enemyAT = 6
	enemyDF = 10
	END IF
	
	IF AT > 22 THEN
	Enemyname$ = "Demonic Draco"
	enemyAT = 11
	enemyDF = 15
	END IF

END IF

IF d1 = 6 THEN
Enemyname$ = "Giant Black Scorpion"
enemyAT = 6
enemyDF = 7

	IF AT > 12 THEN
	Enemyname$ = "Corrupted Soul"
	enemyAT = 14
	enemyDF = 16
	END IF

	IF AT > 22 THEN
	Enemyname$ = "Giant Flying Centipede"
	enemyAT = 19
	enemyDF = 21
	END IF

END IF

PRINT
COLOR 2
PRINT Enemyname$; "! ATTACK:"; enemyAT; "DEFENCE:"; enemyDF

DO WHILE INKEY$ = ""
LOOP
CLS


combatINI:   '================== COMBAT INI ==================


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
' RANDOMIZE TIMER
d1 = rolld6
gold = gold + d1
Pause
PRINT "You receive"; d1; "gold coins."
' RANDOMIZE TIMER
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
		COLOR 2
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
		COLOR 2
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
		COLOR 2
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
PRINT "Wild 0.3 - 2021 / 2022"
Pause
PRINT "Created by Fernando Gaston Ramirez as an open source project."
PRINT
Pause
PRINT "Contributors from GitHub:"
PRINT
Pause
PRINT "- Alan Monroe from Ohio, USA."


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

COLOR 4
LOCATE 1, 1
PRINT "같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같"

LOCATE 23, 1
PRINT "같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같"


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

PRINT "         WELCOME TO THE CITY             "
PRINT
PRINT "1) Rest for one night at the local hotel."
PRINT "2) Go for some beers at the local pub.   "
PRINT "3) See if you can steal something.       "
PRINT "4) Talk to strangers.                    "
PRINT "5) Get out of the city.                  "
PRINT
INPUT "What to do", opcion

SELECT CASE opcion

     CASE 1
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
     hp = maxHP
     mana = MaxMana
     DO WHILE INKEY$ = ""
     LOOP
     
     CASE 3
	
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
     INPUT "1) Yes - 2) No", opcion
     
	SELECT CASE opcion

		CASE 1
		d1 = rolld6
		
		IF d1 < 4 THEN
		COLOR 10
		PRINT
		Pause
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
		Pause
		COLOR 10
		PRINT "It works"
		COLOR 3
		Pause
		PRINT "(Gold +25)"
		gold = gold + 25
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
     
     CASE 5
     GOTO EndOfSub
     CASE ELSE
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
Pause
PRINT "You are walking out of the road, exploring the place and checking"
Pause
PRINT "the surroundings. Behind some dead trees there's something that looks"
Pause
PRINT "like a circle made of huge stones with some strange symbols written on them."
Pause
PRINT "As soon as you see them, you realize it's an archaic temple, probably"
Pause
PRINT "built by the ancient tribes that lived in the region."

DO WHILE INKEY$ = ""
LOOP

PRINT
PRINT "It's easy for you to recognize these symbols, you've seen them before."
Pause
PRINT "They aren't part of the dark side, probably this temple was offered and"
Pause
PRINT "built to summon and pray to the gods of nature."

DO WHILE INKEY$ = ""
LOOP

PRINT
PRINT "You feel that talking to the gods, trying to comunicate with them could"
Pause
PRINT "be a good idea."

DO WHILE INKEY$ = ""
LOOP


PRINT
COLOR 3
PRINT "Do you stop and try to pray to the guardians of nature?"
INPUT "1) Yes, let me try. 2) Not really, let's just continue. "; opcion
COLOR 10

	IF opcion = 1 THEN

	PRINT
	PRINT "You stop and sit in the middle of the circle, you feel the wind in"
	Pause
	PRINT "your ears, over your skin, playing with your hair. You can hear the"
	Pause
	PRINT "birds around the place, wolves howlling in the distance, the trees "
	Pause
	PRINT "dancing with the air, knowing that you are there."
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
		Pause
		PRINT "After being in deep meditational state, connected with nature,"
		Pause
		PRINT "communicating with their gods and astral guardians. You feel "
		Pause
		PRINT "much better, 100% energized and recovered. They said this"
		Pause
		PRINT "would be one of your hardest missions, a tough one, but they"
		Pause
		PRINT "would be by your side. You will succeed."

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
INPUT "What is your choose?", opcion
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

     IF opcion = 0 THEN
     GOTO 333
     END IF

     IF opcion = 1 THEN
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

     END IF


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

SUB GameOver
CLS
x = 0
DO UNTIL x = 4000
'RANDOMIZE TIMER
d1 = INT(RND * 75) + 1
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 4
LOCATE D2, d1
PRINT "갚�"
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
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE D2, d1
PRINT "갚�"
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
Pause
PRINT "Peasant: So, you are looking for some terrible criminals, right?"
Pause
PRINT "Well, some of them hide in places like forests or in the mountains"
Pause
PRINT "if you are lucky, you'll find them in those places."
END IF

IF d1 = 3 THEN
Pause
PRINT "Tavern owner: Good to know you are taking care of those terrible killers."
Pause
PRINT "Some of them are wizards who practice the arts of the dark side. People"
Pause
PRINT "even say they kidnap kids and young women for their sacrifices, offering"
Pause
PRINT "them to the black lord."
END IF

IF d1 = 4 THEN
Pause
PRINT "Farmer: Be very a careful man, we all know what you're doing over here"
Pause
PRINT "and they know too. They expect to meet you soon, so I guess they are ready."
Pause
PRINT "Don't be a fool, don't think they are weak. Get ready as much as you can."
Pause
PRINT "These people are dark and they aren't ordinary ones, they posses supernatural"
Pause
PRINT "powers, and this power doesn't come from light. Many families around here"
Pause
PRINT "lost some of their children... and we all know they took them."
END IF

IF d1 = 5 THEN
Pause
PRINT "Priest: They are part of a satanic order. These black sorcerers have already"
Pause
PRINT "carried out thousands of killings and murders, terrifying our village. They"
Pause
PRINT "They kidnap babies, kids and young women. We have already found the places"
Pause
PRINT "where these beasts celebrate their bloody rituals and hideous feasts."
END IF

IF d1 = 6 THEN
Pause
PRINT "You're following a narrow path, seeing huge vultures above in the sky. "
Pause
PRINT "Something is not ok. A strong and awful smell gets to you. You continue"
Pause
PRINT "walking not knowing what you're about to find. Behind some rocks, hidden "
Pause
PRINT "by high grass, you find a rotten corpse. Rotten bones and flesh. You vomit,"
Pause
PRINT "the view is overwhelming, disgusting. Danger seems to be near."
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
PRINT "같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같"

LOCATE 23, 1
PRINT "같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같"

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

SUB Notes

'================================================
'
' v 0.4
'
' - Cities added.
' - Cities system and options under development
'
'
'
'
'
'
'
'
END SUB

SUB Pause
pausex = 0

DO UNTIL pausex = 10000
pausex = pausex + 1
LOOP

END SUB

FUNCTION rolld6
RANDOMIZE TIMER
rolld6 = INT(RND * 6) + 1
END FUNCTION

'============================ SCREEN TRANSITION 1 ===========================
SUB Trans1

transicion1:

COLOR PositionCol(PositionCH), 0
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
PRINT "께�"
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

