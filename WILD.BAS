'- CREAR NUEVAS PARTES DE LA HISTORIA
'- COMPLETAR EVENTOS DE ACCIDENTES
'- CREAR EVENTOS DE DECISIONES - EL JUGADOR ELIGE ENTRE VARIAS OPCIONES
'- CREAR HISTORIA INICIAL, INTRO
'- AGREGAR MAS SONIDOS
'- AGREGAR CIUDADES AL MAPA EN DONDE SE PUEDA DESCANSAR, COMER, ENTRENAR, COMPRAR.
'- AGREGAR ENCICLOPEDIA [SOBRE CRIATURAS, PERSONAJES Y LUGARES]
'- PODER ELEGIR UN NOMBRE PARA EL PERSONAJE
'- CREAR ALGUNAS NUEVAS TRANSICIONES
'- TERMINAR DE ORGANIZAR EL CODIFO EN FUNCIONES/SUBS

'======================== SUBS AND FUNCTIONS =========================

DECLARE SUB DisplayWeather ()
DECLARE FUNCTION rolld6 ()

'======================== MUSIC and SOUNDS =========================

chance$ = "b5e"
endfight$ = "O2b5ebo3c4o2eo3"
enemy$ = "e20 e20"
chime$ = "d20 d20"
levelup$ = "c20 d20 e20 c20 d20 e20"

'======================== MAIN MENU =========================

mainmenu:

opcion = 0

CLS
COLOR 15
PRINT ""
PRINT "WILD 0.2 (2021 - 2022)"
PRINT
PRINT "1) NEW GAME"
PRINT "2) EXIT"
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
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE D2, d1
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
END
END IF

IF NOT (opcion = 1) AND NOT (opcion = 2) THEN
GOTO mainmenu
END IF

'======================== START NEW GAME =========================

startnewgame:
CLS
COLOR 2

DIM SHARED positionCOL(500) AS INTEGER
RANDOMIZE TIMER


level = 0
xpoints = 0

turno = 0
lugary = 5
lugarx = 25

position = 0
PRINT "Generating a random position..."
positionCH = (INT(RND * 400) + 1)
positionCOL(positionCH) = 6
lasttextposition$ = "MOUNTAINS"



x = 0
DO UNTIL x = 500
positionCOL(x) = 3
x = x + 1
LOOP


'VARIABLES (Gold, attack, defence, HP, etc.) ================================

PRINT "Generating random gold values..."
						   'ALL THESE VARIABLES
Gold = rolld6 * rolld6                             'HAVE BEEN RANDOMIZED, SO
PRINT "Generating random attack value..."          'EVERYTIME YOU PLAY A NEW
					       'GAME IT'S GONNA BE SOMETHING
AT = rolld6 * 2                                'DIFFERENT. I USED THE VALUE
PRINT "Generating random defence value..."  '6 TO RANDOMIZE THEM, SIMULATING
					   'A NORMAL SOLO RPG GAME, USING A
DF = (rolld6) * 2                          'SIMPLE D6 DIE.I'VE USED D6 RANDOM
PRINT "Generating random HP value..."      'VARIABLES AS A BASE FOR THE WHOLE
maxHP = (rolld6) + 5                       'RANDOMIZATION SYSTEM IN THE GAME,
hp = maxHP                                 'TO JUST TO KEEP IT SIMPLE.
PRINT "Generating random mana value..."

maxmana = 5 + rolld6
mana = maxmana

SLEEP 1

inicio:

d1 = (rolld6) / 10
hp = hp + d1
mana = mana + d1

inicio2:
RANDOMIZE TIMER

IF hp <= 0 THEN
GOTO gameover
END IF

IF hp > maxHP THEN
hp = maxHP
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
COLOR positionCOL(position)
IF position = positionCH THEN
COLOR 4
END IF

LOCATE lugary, lugarx
PRINT "±"
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

COLOR 3
LOCATE 1, 1
PRINT "ATK:"; AT; "| DEF:"; DF; "| HP:"; hp; "| ( LEVEL"; level; ")"
LOCATE 2, 1
PRINT "Mana"; mana; "| Expert Points:"; xpoints; "| Gold:"; Gold

COLOR 2
PRINT
PRINT "1- North"
PRINT "2- South"
PRINT "3- East"
PRINT "4- West"
PRINT
PRINT "10- Exit"
PRINT
COLOR 3
INPUT "Where to go? ", direction
PRINT
COLOR 2


'DIRECTIONS ==========================

IF direction = 3 THEN

	IF positionCH = 39 OR positionCH = (39 + 40) OR positionCH = (39 + (40 * 2)) THEN
	positionCH = positionCH - 40
	END IF

	IF positionCH = (39 + (40 * 3)) OR positionCH = (39 + (40 * 4)) OR positionCH = (39 + (40 * 5)) THEN
	positionCH = positionCH - 40
	END IF

	IF positionCH = (39 + (40 * 7)) OR positionCH = (39 + (40 * 8)) OR positionCH = (39 + (40 * 9)) THEN
	positionCH = positionCH - 40
	END IF

	positionCH = positionCH + 1

END IF

IF direction = 4 THEN

	IF positionCH = 0 OR positionCH = 40 OR positionCH = 80 THEN
	positionCH = positionCH + 40
	END IF

	IF positionCH = 120 OR positionCH = 160 OR positionCH = 200 THEN
	positionCH = positionCH + 40
	END IF

	IF positionCH = 240 OR positionCH = 280 OR positionCH = 320 OR positionCH = 360 THEN
	positionCH = positionCH + 40
	END IF

	positionCH = positionCH - 1

END IF

IF direction = 1 THEN
positionCH = positionCH - 40

	IF positionCH < 0 THEN
	positionCH = positionCH + (40 * 10)
	END IF

END IF

IF direction = 2 THEN
positionCH = positionCH + 40

	IF positionCH > 399 THEN
	positionCH = positionCH - (40 * 10)
	END IF

END IF

IF direction = 10 THEN
GOTO mainmenu
END IF


'MAP UPDATE ========================== 'AFTER THE PLAYER GIVES A NEW DIRECTION
				       'THE MAP GETS UPDATED. IT IS GENERATED
y = 0                                  'FOR A SECOND TIME USING THE NEW
DO UNTIL y = 10                        'VARIABLES.
x = 0

DO UNTIL x = 40
x = x + 1
COLOR positionCOL(position)
IF position = positionCH THEN
COLOR 4
END IF

LOCATE lugary, lugarx
PRINT "±"
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
positionCOL(positionCH) = lastterrain  '| It increases the probabilities of
d1 = copyd1                            '| repeating the last terrain in order
GOTO SkipRest                          '| to have a less randomized map.
END IF

d1 = rolld6
IF positionCOL(positionCH) = 2 THEN
d1 = 1
END IF
IF positionCOL(positionCH) = 8 THEN
d1 = 2
END IF
IF positionCOL(positionCH) = 7 THEN
d1 = 3
END IF
IF positionCOL(positionCH) = 14 THEN
d1 = 4
END IF
IF positionCOL(positionCH) = 1 THEN
d1 = 5
END IF
IF positionCOL(positionCH) = 6 THEN
d1 = 6
END IF

SkipRest:
COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 = 1 THEN
PRINT "FOREST"
positionCOL(positionCH) = 2
copyd1 = d1
END IF

IF d1 = 2 THEN
PRINT "SWAMP"
positionCOL(positionCH) = 8
copyd1 = d1
END IF

IF d1 = 3 THEN
PRINT "FROZEN LANDS"
positionCOL(positionCH) = 7
copyd1 = d1
END IF

IF d1 = 4 THEN
PRINT "DESERT"
positionCOL(positionCH) = 14
copyd1 = d1
END IF

IF d1 = 5 THEN
PRINT "WATER (sea, lake or river)"
positionCOL(positionCH) = 1
copyd1 = d1
END IF

IF d1 = 6 THEN
PRINT "MOUNTAINS"
positionCOL(positionCH) = 6
copyd1 = d1
END IF

lastterrain = positionCOL(positionCH)

'WEATHER ---------------------------------

weather:
CALL DisplayWeather


'---------------------------------------------------------

situations:

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 = 1 THEN
PRINT " - ACCIDENT -"
GOTO accident
END IF

IF d1 = 2 THEN
PRINT " - ENEMY -"
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
GOTO negative
END IF

IF d1 = 6 THEN
PRINT " - INFORMATION -"
GOTO information
END IF


DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
negative:

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 > 0 AND d1 < 4 THEN
PRINT "You feel something like a bite in your leg. You stop and check what was it."
PRINT "You see two red points and a thin blood string coming out from your leg."
PRINT "You wish it was only an insect and not a snake."
DO WHILE INKEY$ = ""
LOOP
d1 = rolld6
COLOR 3
PRINT "Die:"; d1;
'''''''''''
	IF d1 = 1 THEN
	COLOR 2
	PRINT "Some meters ahead you see it... it was a snake! (-6 HP)"
	hp = hp - 6
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 2 THEN
	COLOR 2
	PRINT "Some meters ahead you see it... it was a brown spider! (-3 HP)"
	hp = hp - 3
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 3 THEN
	COLOR 2
	PRINT "You don't see anything... well maybe it was just a plant or a rock."
	PRINT "The pain goes away..."
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 4 THEN
	COLOR 2
	PRINT "It hurst a lot at the beginning! Then it feels better but the area"
	PRINT "seems to be infected... It's swelling! "
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
	COLOR 2
	PRINT "Oh... it's nothing. Probably you cut your leg against a rock."
	DO WHILE INKEY$ = ""
	LOOP
	GOTO inicio
	END IF
'''''''''''
	IF d1 = 6 THEN
	COLOR 2
	PRINT "Some centimeters away from your leg there's a huge poisonous centipede..."
	PRINT "It's in attack position, seems to be annoyed. It's an horrible and disgusting"
	PRINT "animal. That creepy thing bit you!"

	d1 = rolld6

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
COLOR 2
PRINT "There is a huge storm coming. You seem worried cause it looks very bad."
PRINT "You try to hurry up and find a place to hide. However, you are not lucky today."
PRINT "All your clothes get wet and you feel terrible after walking so much with"
PRINT "wet feet and wet clothes. You also feel very cold. (-1 HP)"
hp = hp - 1.5
END IF

DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
accident:

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 > 0 AND d1 < 4 THEN
PRINT "You are trying to climb a huge rock that blocks the way and end up falling down."
PRINT "You hurt your back when falling (-1 HP)."
hp = hp - 1
END IF

IF d1 > 3 AND d1 < 7 THEN
PRINT "You are walking around the place and hear the sound of an animal coming"
PRINT "towards you from behind. When you turn, you see a GIANT BUGIO (a huge"
PRINT "and violent monkey) coming. You run, you run and save your life but in"
PRINT "the escape you lose all your gold coins (Gold = 0)."
Gold = 0
END IF


DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
positive:

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 > 0 AND d1 < 3 THEN
PRINT "You find a good place to sleep and spend the night there. It's an inn."
PRINT "You've been there before and know the owner. You feel much better"
PRINT "the next day. (+1 HP)"
hp = hp + 1
END IF

IF d1 = 3 THEN
PRINT "You see something shiny in the middle of the path."
PRINT "Some gold coins are spread all over the place!!! (+10 GOLD)"
Gold = Gold + 10
END IF

IF d1 = 4 THEN
PRINT "You stop, set a place to camp. Start a fire and cook something to eat."
PRINT "You spend your time practicing fighting techniques and training with your"
PRINT "knives and sword. The mission has been pretty rough and hard, so difficult.  "
PRINT "You needed to take some time for you, to rest and relax a little bit. It's"
PRINT "always a good thing to practice with your weapons and improve your fighting"
PRINT "techniques. (HP + 3) (AT + 0.5) "
hp = hp + 3
AT = AT + .5
END IF

IF d1 = 5 THEN
PRINT "Street vendor by the road! He offers you the following items:"
PRINT
PRINT "[1] Mix of Herbs   (+5 HP)   - $25"
PRINT "[2] Energetic Soup (+5 MANA) - $25"
PRINT "[3] NO, THANKS!"
PRINT
INPUT "Would you like to buy something sir?"; opcion

IF opcion = 3 THEN
PRINT "- Oh, that's ok then..."
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

IF Gold < 25 THEN
PRINT "- Mmmm... you don't have that money. I didn't say it was for free!"
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF


IF opcion = 1 THEN
PRINT "- Nice, MIX OF HERBS! Here you have!"
DO WHILE INKEY$ = ""
LOOP
PRINT
PRINT "YOU DRINK IT AND FEEL MUCH BETTER. YOU FEEL LESS TIRED, RELAXED, WITH"
PRINT "LOTS OF NEW ENERGY. YOUR BODY DOESN'T HURT ANYMORE."
hp = hp + 5
Gold = Gold - 25
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

IF opcion = 2 THEN
PRINT "- Nice, ENERGETIC SOUP! Here you have!"
DO WHILE INKEY$ = ""
LOOP
PRINT
PRINT "YOU DRINK IT AND FEEL YOUR BODY MUCH STRONGER. YOU FEEL MORE CONFIDENT"
PRINT "IS IT ACTUALLY SOUP? OR IS IT LIKE A DRUG OR SOMETHING? IT EVEN TASTES"
PRINT "PRETTY GOOD."
mana = mana + 5
Gold = Gold - 25
DO WHILE INKEY$ = ""
LOOP
GOTO inicio
END IF

END IF

IF d1 = 6 THEN
PRINT "You find by the road a family of travelers. They've heard about you and"
PRINT "they know you are there to help. The husband invites to join them. You"
PRINT "rest, eat good food and take a shower. You stay a good time with them."
PRINT "The man also teaches you some fighting and defensive techniques. Before"
PRINT "you leave, they give you some food and gold coins to support you. "
PRINT "You thank them and continue with your travel. (Gold + 25) (HP + 10) (AT + 0.5) "
Gold = Gold + 25
hp = hp + 10
AT = AT + .5
END IF

DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
information:

d1 = INT(RND * 7) + 1

COLOR 3
PRINT "Die:"; d1;
COLOR 2

IF d1 > 0 AND d1 < 3 THEN
PRINT "Peasant: So, you are looking for some terrible criminals, right?"
PRINT "Well, some of them hide in places like forests or in the mountains"
PRINT "if you are lucky, you'll find them in those places."
END IF

IF d1 = 3 THEN
PRINT "Tavern owner: Good to know you are taking care of those terrible killers."
PRINT "Some of them are wizards who practice the arts of the dark side. People"
PRINT "even say they kidnap kids and young women for their sacrifices, offering"
PRINT "them to the black lord."
END IF

IF d1 = 4 THEN
PRINT "Farmer: Be very a careful man, we all know what you're doing over here"
PRINT "and they know too. They expect to meet you soon, so I guess they are ready."
PRINT "Don't be a fool, don't think they are weak. Get ready as much as you can."
PRINT "These people are dark and they aren't ordinary ones, they posses supernatural"
PRINT "powers, and this power doesn't come from light. Many families around here"
PRINT "lost some of their children... and we all know they took them."
END IF

IF d1 = 5 THEN
PRINT "Priest: They are part of a satanic order. These black sorcerers have already"
PRINT "carried out thousands of killings and murders, terrifying our village. They"
PRINT "They kidnap babies, kids and young women. We have already found the places"
PRINT "where these beasts celebrate their bloody rituals and hideous feasts."
END IF

IF d1 = 6 THEN
PRINT "You're following a narrow path, seeing huge vultures above in the sky. "
PRINT "Something is not ok. A strong and awful smell gets to you. You continue"
PRINT "walking not knowing what you're about to find. Behind some rocks, hidden "
PRINT "by high grass, you find a rotten corpse. Rotten bones and flesh. You vomit,"
PRINT "the view is overwhelming, disgusting. Danger seems to be near."
END IF

DO WHILE INKEY$ = ""
LOOP

GOTO inicio


'---------------------------------------------------------
enemy:

d1 = rolld6

IF d1 = 1 THEN
Enemyname$ = "Wild Wolf"
enemyAT = 3
enemyDF = 5

	IF AT > 10 THEN
	Enemyname$ = "Black Panther"
	enemyAT = 6
	enemyDF = 10
	END IF

	IF AT > 20 THEN
	Enemyname$ = "Demonic Mogmurch"
	enemyAT = 6
	enemyDF = 10
	END IF
	
END IF

IF d1 = 2 THEN
Enemyname$ = "Wild Bugio"
enemyAT = 4
enemyDF = 6

	IF AT > 10 THEN
	Enemyname$ = "Damned Walker"
	enemyAT = 6
	enemyDF = 15
	END IF

	IF AT > 20 THEN
	Enemyname$ = "Demonic Rat"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 3 THEN
Enemyname$ = "Witch"
enemyAT = 4
enemyDF = 6
	
	IF AT > 10 THEN
	Enemyname$ = "Tortured Soul"
	enemyAT = 8
	enemyDF = 12
	END IF

	IF AT > 20 THEN
	Enemyname$ = "Estirge"
	enemyAT = 6
	enemyDF = 10
	END IF

END IF

IF d1 = 4 THEN
Enemyname$ = "Crawler"
enemyAT = 6
enemyDF = 6

	IF AT > 10 THEN
	Enemyname$ = "Giant Acid Centipede"
	enemyAT = 30
	enemyDF = 54
	END IF

	IF AT > 20 THEN
	Enemyname$ = "Demonic Goblin"
	enemyAT = 35
	enemyDF = 59
	END IF

END IF

IF d1 = 5 THEN
Enemyname$ = "Criminal"
enemyAT = 4
enemyDF = 6

	IF AT > 10 THEN
	Enemyname$ = "Forest Demon"
	enemyAT = 6
	enemyDF = 10
	END IF
	
	IF AT > 20 THEN
	Enemyname$ = "Demonic Draco"
	enemyAT = 11
	enemyDF = 15
	END IF

END IF

IF d1 = 6 THEN
Enemyname$ = "Giant Black Scorpion"
enemyAT = 7
enemyDF = 8

	IF AT > 10 THEN
	Enemyname$ = "Corrupted Soul"
	enemyAT = 14
	enemyDF = 16
	END IF

	IF AT > 20 THEN
	Enemyname$ = "Demonic Troll"
	enemyAT = 19
	enemyDF = 21
	END IF

END IF

PRINT
PRINT Enemyname$; "! ATTACK:"; enemyAT; "DEFENCE:"; enemyDF

PLAY enemy$

DO WHILE INKEY$ = ""
LOOP
CLS


combatINI:   '================== COMBAT INI ==================

COLOR 2
PRINT
PRINT "You: HP ("; hp; ") === DEF ("; DF; ") / ATK ("; AT; ")"
PRINT ; Enemyname$; ": HP ("; enemyDF; ") === DEF ("; enemyDF; ") / ATK ("; enemyAT; ")"
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
PRINT "The "; Enemyname$; " receives"; finaldamage; "points of damage."

enemyDF = enemyDF - finaldamage

DO WHILE INKEY$ = ""
LOOP

PRINT
PRINT "--------------------------------------------"
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
PRINT "YOU receive"; finaldamage; "points of damage."

hp = hp - finaldamage


DO WHILE INKEY$ = ""
LOOP

PRINT "--------------------------------------------"

IF hp <= 0 THEN
GOTO gameover
END IF

IF enemyDF <= 0 THEN                             'WHEN YOU WIN A COMBAT
PRINT
PRINT "GOOD JOB! The "; Enemyname$; " has been defeated!"
' RANDOMIZE TIMER
d1 = rolld6
Gold = Gold + d1
PRINT "You receive"; d1; "gold coins."
' RANDOMIZE TIMER
d1 = rolld6
xpoints = xpoints + d1
PRINT "You receive"; d1; "expert points."

PLAY endfight$

DO WHILE INKEY$ = ""
LOOP

IF xpoints >= 10 THEN                            'WHEN YOU LEVEL UP!
COLOR 3
PRINT
PRINT "LEVEL UP!"
xpoints = 0
level = level + 1
PRINT "What would you like to improve?"          'IMPROVING SKILL POINTS
PRINT
PRINT "1) ATTACK      2)DEFENCE"
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
maxmana = maxmana + 1
END IF

mana = maxmana
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
PRINT "You realize that there is a chance for you to:"
PRINT ""
PRINT "1) Try to escape"
PRINT "2) Use your concentration [mana pts]"
PRINT "3) Just continue with the combat"
PRINT ""
PLAY chance$
INPUT "What will you do...", opcion

	IF opcion = 1 THEN
	d1 = rolld6
	COLOR 2
	PRINT "You decide to run and try to escape..."
	COLOR 3
	PRINT "Die:"; d1; "[1 to 3 means failure - 4 to 6 means success]"

	DO WHILE INKEY$ = ""
	LOOP

	COLOR 2
		
		IF d1 >= 1 AND d1 <= 3 THEN
		PRINT
		PRINT "[FAILURE]"
		PRINT "You try to escape but can't. It seems you aren't fast enough for that."
		PRINT "You receive "; enemyAT; " points of damage from "; Enemyname$; "."
		hp = hp - enemyAT
		PRINT "Your HP is "; hp; " now."
		PRINT
		COLOR 2
		PRINT "--------------------------------------------"

		DO WHILE INKEY$ = ""
		LOOP

			IF hp <= 0 THEN
			GOTO gameover
			END IF

		END IF

		IF d1 >= 4 AND d1 <= 6 THEN
		PRINT
		PRINT "[SUCCESS]"
		PRINT "You try to escape. You are fast enough to run away!"
		PRINT
		COLOR 2
		PRINT "--------------------------------------------"
		BEEP
		DO WHILE INKEY$ = ""
		LOOP
		combatloop = 0
		GOTO inicio2
		END IF

	END IF

	IF opcion = 2 THEN
	PRINT ""
	COLOR 3
	PRINT "Using your concentration:"
	PRINT ""
	PRINT "1) Use energy to attack [3pts]"
	PRINT "2) Use energy to recover HP [3pts]"
	PRINT "3) Use energy to escape [3pts]"
	PRINT ""
	PRINT
	PLAY chime$
	INPUT "What will you do...", opcion

		IF opcion = 1 AND mana < 3 THEN ' ====  MANA OPTION 1 ====
		COLOR 2
		PRINT
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		PRINT "body for that attack!"
		PRINT
		PRINT "--------------------------------------------"
		PLAY chime$
		END IF

		IF opcion = 1 AND mana >= 3 THEN
		mana = mana - 3
		enemyDF = enemyDF - AT
		COLOR 2
		PRINT
		PRINT "You use your energy and concentration to attack"
		PRINT "the "; Enemyname$; "! Your attack is very effective!"
		PRINT "The "; Enemyname$; " gets "; AT; " points of damage!"
		PRINT "Its HP is"; enemyDF; " now!"
		PRINT
		PRINT "--------------------------------------------"
		PLAY chime$
		END IF

		IF opcion = 2 AND mana < 3 THEN ' ====  MANA OPTION 2 ====
		COLOR 2
		PRINT
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		PRINT "body to recover your health!"
		PRINT
		PRINT "--------------------------------------------"
		PLAY chime$
		END IF

		IF opcion = 2 AND mana >= 3 THEN
		mana = mana - 3
		hp = maxHP
		COLOR 2
		PRINT
		PRINT "You use your energy and concentration to recover your health"
		PRINT "Your HP is now "; hp; "! You feel much better and renewed!"
		PRINT "Ready to fight back!"
		PRINT
		PRINT "--------------------------------------------"
		PLAY chime$
		END IF

		IF opcion = 3 AND mana < 3 THEN ' ====  MANA OPTION 3 ====
		COLOR 2
		PRINT
		PRINT "Your mana is"; mana; "! You don't have enough energy in your"
		PRINT "body to run away like that!"
		PRINT
		PRINT "--------------------------------------------"
		PLAY chime$
		END IF

		IF opcion = 3 AND mana >= 3 THEN
		mana = mana - 3
		COLOR 2
		PRINT
		PRINT "You use your energy and concentration to run away!"
		PRINT "The "; Enemyname$; " runs behind you but fails!"
		PRINT "You succeed and escape!"
		PRINT
		PLAY chime$
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
gameover:

CLS
x = 0
DO UNTIL x = 4000
'RANDOMIZE TIMER
d1 = INT(RND * 75) + 1
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 4
LOCATE D2, d1
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
D2 = INT(RND * 23) + 1
x = x + 1
COLOR 0
LOCATE D2, d1
PRINT "°±²"
LOCATE 10, 33
COLOR 15
PRINT "YOU HAVE DIED"
LOCATE 11, 34
PRINT "-GAME OVER-"
LOOP
CLS

GOTO mainmenu

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

FUNCTION rolld6
RANDOMIZE TIMER
rolld6 = INT(RND * 6) + 1
END FUNCTION

