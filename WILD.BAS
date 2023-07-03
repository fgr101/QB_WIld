'======================== SUBS AND FUNCTIONS =========================

DECLARE SUB DrawDemon ()
DECLARE SUB PrintIMG ()

DECLARE SUB ManaBar ()
DECLARE SUB MainMenu ()
DECLARE SUB GameIntro1 ()

DECLARE SUB LoadTXT ()

DECLARE SUB GenDescription ()
DECLARE SUB WaitKey ()
DECLARE SUB DrawSwamp ()
DECLARE SUB DrawDesert ()
DECLARE SUB DrawIcons ()
DECLARE SUB PositiveSub ()
DECLARE SUB DrawWolf ()
DECLARE SUB DrawMountains ()
DECLARE SUB PrintLines ()
DECLARE SUB NegativeSub ()
DECLARE SUB Negative ()
DECLARE SUB DrawBugio ()

DECLARE SUB Music ()
DECLARE SUB GameOver ()
DECLARE SUB Pause ()

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

'TRANSITIONS AND DIE

DECLARE SUB Trans1 ()
DECLARE SUB Trans3 ()
DECLARE SUB showD6 ()

'HP BARS AND OTHER STATS

DECLARE SUB EnemyHPBar ()
DECLARE SUB HPBar ()

DECLARE FUNCTION rolld6 ()

'=====================================================================

'| GLOBAL VARIABLES FOR SUBS |


DIM SHARED DatFile$, D6DieX, D6DieY
DIM SHARED d1, opcion, DecisionResult, LastDecisionEvent, MANA, HP, GOLD
DIM SHARED AT, DF, MaxHP, MaxMana
DIM SHARED City1Exists, City2Exists, City3Exists, City4Exists, City5Exists, City6Exists
DIM SHARED OptionMusic, barfight, line$(40)
DIM SHARED LastNegativeEvent, LastPositiveEvent, LinesToPrint
DIM SHARED BonusTerrain, LandName$, NegativeTerrain, LandNameNegative$

'[GLOBAL VARIABLES TO GENETARATE DESCRIPTIONS]

DIM SHARED AdjPlace$(25), PluralNouns$(25), SingNoun$(25), hear$(25), feel$(25)
DIM SHARED YouAre$(25), its$(25), nameterrain$, WeatherText$

' ENEMIES VARIABLES

DIM SHARED Enemyname$, enemyAT, enemyDF

DIM SHARED BarChangeLocation, HPPercentage, EnemyHPPercentage, EnemyMaxDF AS INTEGER
DIM SHARED Xvalue, Yvalue, WitchFight AS INTEGER

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

MainMenu:

MainMenu  'PRINTS THE MAIN MENU

IF opcion = 1 THEN     'PASAR TODO A SELECT CASE
GameIntro1
GOTO startnewgame
END IF

IF opcion = 2 THEN
CALL Challenges
GOTO MainMenu
END IF

IF opcion = 3 THEN
CALL About
GOTO MainMenu
END IF

IF opcion = 4 THEN
CALL SaveChallenges
CLS
END
END IF

IF opcion = 12 THEN

	LOCATE , 2

	IF OptionMusic = 1 THEN

	     OptionMusic = 0
	     CALL Music
	     PRINT "Music OFF"
	     Pause
	     GOTO MainMenu

	END IF

	IF OptionMusic = 0 THEN

	     OptionMusic = 1
	     CALL Music
	     PRINT "Music ON"
	     Pause
	     GOTO MainMenu

	END IF

END IF

IF NOT (opcion = 1) AND NOT (opcion = 2) THEN
GOTO MainMenu
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
GOLD = rolld6 * rolld6                         'HAVE BEEN RANDOMIZED, SO
PRINT "Generating random attack value..."      'EVERYTIME YOU PLAY A NEW
					       'GAME IT'S GONNA BE SOMETHING
AT = rolld6 * 2                                'DIFFERENT. I USED THE VALUE
PRINT "Generating random defence value..." '6 TO RANDOMIZE THEM, SIMULATING
					   'A NORMAL SOLO RPG GAME, USING A
DF = (rolld6) * 2                          'SIMPLE D6 DIE.I'VE USED D6 RANDOM
PRINT "Generating random HP value..."      'VARIABLES AS A BASE FOR THE WHOLE
MaxHP = (rolld6) + 5                       'RANDOMIZATION SYSTEM IN THE GAME,
HP = MaxHP                                 'TO JUST TO KEEP IT SIMPLE.
PRINT "Generating random mana value..."

MaxMana = 5 + rolld6
MANA = MaxMana

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
	LandName$ = "FOREST"

	CASE 2
	BonusTerrain = 6
	LandName$ = "MOUNTAINS"

	CASE 3
	BonusTerrain = 8
	LandName$ = "SWAMPS"

	CASE 4
	BonusTerrain = 14
	LandName$ = "DESERT"

	CASE 5
	BonusTerrain = 7
	LandName$ = "FROZEN LANDS"

	CASE 6
	BonusTerrain = 1
	LandName$ = "LAKES AND RIVERS"

END SELECT

denuevo:
d1 = rolld6

IF d1 = d2 THEN
GOTO denuevo
END IF

SELECT CASE d1

	CASE 1
	NegativeTerrain = 2
	LandNameNegative$ = "FOREST"

	CASE 2
	NegativeTerrain = 6
	LandNameNegative$ = "MOUNTAINS"

	CASE 3
	NegativeTerrain = 8
	LandNameNegative$ = "SWAMPS"

	CASE 4
	NegativeTerrain = 14
	LandNameNegative$ = "DESERT"

	CASE 5
	NegativeTerrain = 7
	LandNameNegative$ = "FROZEN LANDS"

	CASE 6
	NegativeTerrain = 1
	LandNameNegative$ = "LAKES AND RIVERS"

END SELECT


'=============================================================================

CALL Character


inicio:

d1 = (rolld6) / 10
HP = HP + d1
MANA = MANA + d1

inicio2:
RANDOMIZE TIMER

CALL CheckChallenges     'Checks if there are challenges acomplished and
			 'if so, shows a message.
IF HP <= 0 THEN
GOTO GameOver
END IF

IF HP > MaxHP THEN
HP = MaxHP
END IF

IF MANA > MaxMana THEN
MANA = MaxMana
END IF

'MAP ==========================    'THE MAP IS GENERATED FOR THE FIRST TIME
				   'THEN IT WILL BE GENERATED AGAIN IN ORDER
CLS                                'TO BEING UPDATE AFTER THE PLAYER INPUTS A
				   'DIRECTION (NORTH, SOUTH, EAST, WEST).
Y = 0
DO UNTIL Y = 10
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

Y = Y + 1
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
PRINT "ATK:"; AT; "| DEF:"; DF; "| HP:"; HP; "| ( LEVEL"; level; ")"
LOCATE 4, 1
PRINT "Mana"; MANA; "| Expert Points:"; xpoints; "| Gold:"; GOLD

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

PRINT "6- Look around"

PRINT
PRINT

COLOR 15
LOCATE 2, 67
PRINT "HP: "

LOCATE 3, 67
PRINT "MN: "


BarChangeLocation = 1 '====== Draws the HP bar in the top right corner of the screen.
Xvalue = 2
Yvalue = 69
CALL HPBar

BarChangeLocation = 1
Xvalue = 3
Yvalue = 69
CALL ManaBar

COLOR 3
LOCATE 14, 1
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

	IF HP <= 0 THEN
	GOTO MainMenu
	END IF


IF barfight = 1 THEN
GOTO enemy
END IF

GOTO inicio
END IF

IF direction = 6 THEN
CALL GenDescription
WaitKey
GOTO inicio
END IF

IF direction = 10 THEN
GOTO MainMenu
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

		IF HP <= 0 THEN
		GOTO MainMenu
		END IF

		IF barfight = 1 THEN
		GOTO enemy
		END IF

	GOTO inicio

END IF


'MAP UPDATE ========================== 'AFTER THE PLAYER GIVES A NEW DIRECTION
				       'THE MAP GETS UPDATED. IT IS GENERATED
Y = 0                                  'FOR A SECOND TIME USING THE NEW
DO UNTIL Y = 10                        'VARIABLES.
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

Y = Y + 1
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

WaitKey

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

d1 = rolld6                      'Rolls the D6 die.

IF d1 = LastPositiveEvent THEN   'This part of the code should avoid
GOTO positive                    'the same positive event repeating twice
END IF                           'in a very short period of time.
LastPositiveEvent = d1

CALL PositiveSub
GOTO inicio

'---------------------------------------------------------
enemy:

CALL Trans1
d1 = rolld6

IF d1 = 1 THEN
Enemyname$ = "Wild Wolf"
enemyAT = 3
enemyDF = 5

	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Demonic Black Panther"
	enemyAT = 8
	enemyDF = 10
	END IF

	IF AT > 22 OR HP > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Mogmurch"
	enemyAT = 38
	enemyDF = 43
	END IF
	
END IF

IF d1 = 2 THEN
Enemyname$ = "Wild Bugio"
enemyAT = 4.5
enemyDF = 6

	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Damned Walker"
	enemyAT = 7
	enemyDF = 15
	END IF

	IF AT > 22 OR HP > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Rat"
	enemyAT = 26
	enemyDF = 35
	END IF

END IF

IF d1 = 3 THEN
Enemyname$ = "Witch"
enemyAT = 4
enemyDF = 5.5
	
	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Tortured Soul"
	enemyAT = 9
	enemyDF = 12
	END IF

	IF AT > 22 OR HP > 22 OR DF > 22 THEN
	Enemyname$ = "Giant Flying Spider"
	enemyAT = 36
	enemyDF = 40
	END IF

END IF

IF d1 = 4 THEN
Enemyname$ = "Crawler"
enemyAT = 5
enemyDF = 5

	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Giant Acid Centipede"
	enemyAT = 11
	enemyDF = 15
	END IF

	IF AT > 22 OR HP > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Goblin"
	enemyAT = 35
	enemyDF = 59
	END IF

END IF

IF d1 = 5 THEN
Enemyname$ = "Criminal"
enemyAT = 4
enemyDF = 5

	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Forest Demon"
	enemyAT = 6
	enemyDF = 10
	END IF
	
	IF AT > 22 OR HP > 22 OR DF > 22 THEN
	Enemyname$ = "Demonic Draco"
	enemyAT = 11
	enemyDF = 15
	END IF

END IF

IF d1 = 6 THEN
Enemyname$ = "Giant Scorpion"
enemyAT = 6
enemyDF = 7

	IF AT > 12 OR HP > 12 OR DF > 12 THEN
	Enemyname$ = "Corrupted Soul"
	enemyAT = 14
	enemyDF = 16
	END IF

	IF AT > 22 OR HP > 22 OR DF > 22 THEN
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

IF WitchFight = 1 THEN   '================ WITCH FIGHT =================
Enemyname$ = "Witch"
enemyAT = 5
enemyDF = 6.5
WitchFight = 0
END IF

EnemyMaxDF = enemyDF

' ======================== FIGHT INTRO SCENE ============================

CALL FightIntro

'============================ COMBAT INI ================================
combatINI:

COLOR 2
PRINT
PRINT "You: HP ("; HP; ") === DEF ("; DF; ") / ATK ("; AT; ") === MANA ("; MANA; ")"
BarChangeLocation = 0
CALL HPBar

PRINT

COLOR 4
PRINT
PRINT ; Enemyname$; ": HP ("; enemyDF; ") === DEF ("; enemyDF; ") / ATK ("; enemyAT; ")"
CALL EnemyHPBar
COLOR 2

CALL DrawIcons

PRINT
PRINT "--------------------------------------------"

WaitKey

PRINT
PRINT "You ATTACK:"
d1 = rolld6

IF combatloop = 2 OR combatloop = 4 THEN
GOTO combatloop24
END IF

COLOR 3
PRINT "Die: "; d1;
COLOR 2
damage1 = AT + d1
PRINT " Damage: "; damage1

'============================================================================
'COMBAT LOOP 2 AND 4       [CONTINUE WORKING HERE]
combatloop24:

IF combatloop = 2 OR combatloop = 4 THEN


COLOR 15, 1
PRINT
PRINT "You can choose your next move!"
COLOR 15, 0
PRINT "±°²±°²±°²±°²±°²±°²±°²±°²±°²±°²"

COLOR 0, 0
LOCATE 22, 31
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
LOCATE 23, 31
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
PRINT
PRINT
PRINT
COLOR 15

LOCATE 22, 1
PRINT "[1] Attack  [2] Charge"

INPUT opcion

d1 = rolld6

IF d1 > 0 AND d1 < 3 THEN
dodge = 3
PRINT
Pause
PRINT "THE ENEMY CHARGES AS WELL!"
END IF


IF d1 > 2 AND d1 < 5 THEN
dodge = 0
PRINT
Pause
PRINT "THE ENEMY STANDS"
END IF

IF d1 > 4 AND d1 < 7 THEN
dodge = 1
PRINT
Pause
PRINT "THE ENEMY DODGES"
END IF

SELECT CASE opcion

	CASE 1

	IF dodge = 0 THEN
	PRINT
	Pause
	PRINT "The enemy stands in place and receives the impact of your attack!"
	Pause
	PRINT "Your attack is normal."
	PRINT
	Pause

	COLOR 3
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = AT + d1
	PRINT " Damage: "; damage1

	END IF

	IF dodge = 1 THEN
	PRINT
	Pause
	PRINT "The enemy dodges and almost avoids your attack!"
	Pause
	PRINT "Your attack is not effective!"
	PRINT
	Pause

	COLOR 3
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = AT + d1
	PRINT "Total Damage:"; damage1; "[ -50% ="; (damage1 / 2); "]"
	damage1 = (AT + d1) / 2
	COLOR 15
	PRINT "Your damage pts are reduced to "; damage1; "!"
	PRINT

	END IF

	IF dodge = 3 THEN  ' =================AGREGAR OTRO RESULTADO DE ATAQUE
	PRINT
	Pause
	PRINT "CHANGE to some other kind of combat result."
	PRINT "The enemy dodges and almost avoids your attack!"
	Pause
	PRINT "Your attack is not effective!"
	PRINT
	Pause

	COLOR 3
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = AT + d1
	PRINT "Total Damage:"; damage1; "[ -50% ="; (damage1 / 2); "]"
	damage1 = (AT + d1) / 2
	COLOR 15
	PRINT "Your damage pts are reduced to "; damage1; "!"
	PRINT

	END IF




	CASE 2

	IF dodge = 0 THEN

	PRINT
	Pause
	PRINT "You charge against the enemy! "
	Pause
	PRINT "The enemy stands in place and receives the"
	Pause
	PRINT "impact of all your body. Your attack is very strong!"
	PRINT
	Pause

	COLOR 3
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = AT + d1
	PRINT "Total Damage:"; damage1; "[ x2 ="; (damage1 * 2); "]"
	damage1 = (AT + d1) * 2
	COLOR 15
	PRINT "Your damage pts have doubled to "; damage1; "!"
	PRINT

	END IF

	IF dodge = 1 THEN

	PRINT
	Pause
	PRINT "You charge against the enemy! "
	Pause
	PRINT "The enemy dodges and you end up landing against"
	Pause
	PRINT "the ground! You hurt yourself in the move!"
	PRINT

	COLOR 3
	Pause
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = 0
	PRINT "Total Damage:"; damage1; "[ATTACK FAILED]"
	damage1 = 0
	COLOR 15
	reduce = HP / 2
	PRINT "You hurt yourself [-"; reduce; "HP] during the attack!"
	HP = HP - reduce
	PRINT "Your HP is"; HP; "now."
	PRINT
	PRINT

	END IF

	IF dodge = 3 THEN

	PRINT
	Pause
	PRINT "You charge against the enemy! "
	Pause
	PRINT "The enemy charges at the same time!"
	Pause
	PRINT "Both get hurt in the attack!"
	PRINT

	COLOR 3
	Pause
	PRINT "Die: "; d1;
	COLOR 2
	damage1 = 0
	PRINT "Total Damage:"; damage1; "[ATTACK FAILED]"
	
	Pause
	COLOR 15
	reduce = HP / 2
	PRINT "You hurt yourself [-"; reduce; "HP] during the attack!"
	HP = HP - reduce
	PRINT "Your HP is"; HP; "now."
	
	Pause
	PRINT
	PRINT "The enemy hurts itself too!"
	PRINT "It loses half of its HP!"
	enemyDF = enemyDF / 2
	PRINT "Its HP is"; enemyDF; "now!"
	PRINT
	
	END IF


END SELECT

END IF

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
PRINT " DAMAGE increased to "; damage1; " now! ±±±±±±±"
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

IF enemyDF <= 0 THEN  'IF enemy's life is LESS OR EQUAL than 0 SHOW MESSAGE.
COLOR 15
Pause
PRINT "CRITICAL HIT!"
Pause
END IF


PRINT
COLOR 2
PRINT "--------------------------------------------"

WaitKey

IF enemyDF < 0 THEN    'IF enemy's life is less than 0 then SKIP enemy's
GOTO SkipEnemyAttack   'attack.
END IF

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


HP = HP - finaldamage

PRINT
PRINT "--------------------------------------------"

WaitKey

SkipEnemyAttack:         'CONTINUES HERE WHEN SKIPPING ENEMY'S ATTACK


IF HP <= 0 THEN
GOTO GameOver
END IF

IF enemyDF <= 0 THEN                             'WHEN YOU WIN A COMBAT
PRINT
COLOR 3
Pause
PRINT "GOOD JOB! The "; Enemyname$; " has been defeated!"

d1 = rolld6
GOLD = GOLD + d1
Pause
PRINT "You receive"; d1; "gold coins."

d1 = rolld6
xpoints = xpoints + d1
Pause
PRINT "You receive"; d1; "expert points."
COLOR 2

PLAY endfight$
WaitKey

IF xpoints >= 10 THEN                            'WHEN YOU LEVEL UP!
COLOR 3
PRINT
Pause
PRINT "LEVEL UP!"
xpoints = 0
level = level + 1

Pause
COLOR 10, 2
PRINT "ATK:"; AT; "| DEF:"; DF; "| HP:"; MaxHP; "MANA:"; MaxMana

COLOR 3, 0
Pause
PRINT "What would you like to improve?"          'IMPROVING SKILL POINTS

LOCATE 23, 32
COLOR 0, 0
PRINT "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"

COLOR 3
PRINT
Pause
PRINT "1) ATTACK      2)DEFENCE"
Pause
PRINT "3) HEALTH PTS  4)MANA"
PRINT

PLAY levelup$

OpcionLevelUp:
INPUT opcion

COLOR 15
SELECT CASE opcion

	CASE 1
	AT = AT + 1
	
	PRINT
	PRINT "Attack increased!"
	Pause
	PRINT "Your attack is"; AT; "now!"

	CASE 2
	DF = DF + 1

	PRINT
	PRINT "Defence increased!"
	Pause
	PRINT "Your defence is"; DF; "now!"

	CASE 3
	MaxHP = MaxHP + 1

	PRINT
	PRINT "HP increased!"
	Pause
	PRINT "Your HP is"; MaxHP; "now!"
	
	CASE 4
	MaxMana = MaxMana + 1

	PRINT
	PRINT "Mana increased!"
	Pause
	PRINT "Your mana is"; MaxMana; "now!"

	CASE ELSE
	GOTO OpcionLevelUp

END SELECT

MANA = MaxMana
HP = MaxHP

WaitKey

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

		PRINT

		COLOR 10
		line$(1) = "You decide to leave and try to run away from the battle."
		line$(2) = "However it's not an easy move. You can leave all your gold"
		line$(3) = "in the place and escape or you can try luck."

		PrintLines

		COLOR 3
		PRINT
		Pause
		PRINT "1) LEAVE GOLD and run away!"
		Pause
		PRINT "2) TRY LUCK to escape!"
		PRINT
		Pause
		INPUT "What do you think is better? ", opcion2

		SELECT CASE opcion2

			CASE 1
			PRINT
			Pause
			COLOR 15
			PRINT "You leave all your gold behind and run away!"

			WaitKey
			
			GOLD = 0
			combatloop = 0
			GOTO inicio2


			CASE 2
			d1 = rolld6
			COLOR 2
			Pause
			PRINT "You decide to run and try to escape..."
			COLOR 3
			PRINT "Die:"; d1; "[1 to 3 means failure - 4 to 6 means success]"

			WaitKey

			COLOR 2
		
			IF d1 >= 1 AND d1 <= 3 THEN

				PRINT
				Pause
				PRINT "[FAILURE]"
				Pause
				PRINT "You try to escape but can't. It seems you aren't fast enough for that."
				Pause
				PRINT "You receive "; enemyAT; " points of damage from "; Enemyname$; "."
				HP = HP - enemyAT
				Pause
				PRINT "Your HP is "; HP; " now."
				PRINT
				COLOR 2
				Pause
				PRINT "--------------------------------------------"

				WaitKey

				IF HP <= 0 THEN
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

				WaitKey

				combatloop = 0
				GOTO inicio2

			END IF

		END SELECT

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

		IF opcion = 1 AND MANA < 3 THEN ' ====  MANA OPTION 1 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; MANA; "! You don't have enough energy in your"
		Pause
		PRINT "body for that attack!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 1 AND MANA >= 3 THEN
		MANA = MANA - 3
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
		COLOR 2
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 2 AND MANA < 3 THEN ' ====  MANA OPTION 2 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; MANA; "! You don't have enough energy in your"
		Pause
		PRINT "body to recover your health!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 2 AND MANA >= 3 THEN
		MANA = MANA - 3
		HP = MaxHP
		COLOR 15
		PRINT
		Pause
		PRINT "You use your energy and concentration to recover your health"
		Pause
		PRINT "Your HP is now "; HP; "! You feel much better and renewed!"
		Pause
		PRINT "Ready to fight back!"
		PRINT
		COLOR 2
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 3 AND MANA < 3 THEN ' ====  MANA OPTION 3 ====
		COLOR 2
		PRINT
		Pause
		PRINT "Your mana is"; MANA; "! You don't have enough energy in your"
		Pause
		PRINT "body to run away like that!"
		PRINT
		Pause
		PRINT "--------------------------------------------"
		PLAY Chime$
		END IF

		IF opcion = 3 AND MANA >= 3 THEN
		MANA = MANA - 3
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
		WaitKey
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

CALL Trans3

HP = 0

LOCATE 2, 1
PRINT "You are unconcious! Almost dead!"
PRINT "Let's see if destiny gives you another chance!"

CALL showD6

IF d1 < 4 THEN
COLOR 4
PRINT "YOU COULDNT RESIST..."
PRINT

SELECT CASE d1

	CASE 1

	PRINT "Someone finds your dead body being eaten by crows and vultures."
	PRINT "Such a disgusting scene it was. These awful birds were eating your"
	PRINT "eyes at the moment the woman found your corpse. She reports"
	PRINT "all the details with sorrow and horror."

	CASE 2

	PRINT "As a result of bad actions done in life, the Gods cannot give you"
	PRINT "another chance. You see them in unconcious dreams, they are angry"
	PRINT "at you. Dark shadows fly around, laughing at you. Is it really you"
	PRINT "the one who is there? What was your name? All turns black. The soul"
	PRINT "liberates from the body."

	CASE 3  'OK

	PRINT "Such a violent and strong hit it was. Such a powerful impact"
	PRINT "you received. Your face landed on the floor and your head hit"
	PRINT "the ground with such a force. Then the blackout."
	PRINT
	PRINT "You feel like floating in the air and indeed you are. You hear a"
	PRINT "very strange voice calling your name. You look down and see your"
	PRINT "body below. You are being pulled up, and yes, you realize that the"
	PRINT "dead body you are seeing down at the distance is you, laying on the"
	PRINT "ground, lifeless. You are leaving your physical body."

END SELECT



WaitKey
CALL GameOver
GOTO MainMenu
END IF

IF d1 > 3 THEN
PRINT "YOU GOT A"; d1; "!"
PRINT "YOU GOT ANOTHER CHANCE!"
PRINT

SELECT CASE d1

	CASE 4
	PRINT "Someone finds your unconcious body being surrounded by vultures."
	PRINT "He or she saves your life before they could eat your eyes."
	PRINT "This unknown character takes you to a safe place nearby"
	PRINT "and leaves."
	PRINT

	d2 = rolld6
	HP = HP + d2
	xpoints = 0

	COLOR 15
	PRINT "* Your health has been restored by"; d2; "pts."
	PRINT "* You've lost all your confidence in battle."

	CASE 5
	PRINT "Thanks to some good actions done in life, the Gods give you"
	PRINT "another chance. You see them in unconcious dreams and wake"
	PRINT "up in the middle of the night. All is dark and you can only"
	PRINT "hear the sound of insects and the wind. You feel weak, cannot"
	PRINT "move or talk, breathing is difficult. However your feel well"
	PRINT "to continue. You should be more careful next time."
	PRINT

	HP = MaxHP
	xpoints = 0

	COLOR 15
	PRINT "* Your health has been completely restored."
	PRINT "* You've lost all your confidence in battle."

	CASE 6
	
	PRINT "Such a violent and strong hit it was. Such a powerful impact"
	PRINT "you received. Your face landed on the floor and your head hit"
	PRINT "the ground with such a force. Then the blackout."
	PRINT
	PRINT "After some time you wake up. How much time has passed? Your head"
	PRINT "hurts really bad and you don't know where you are or what happened."
	PRINT "You realize someone has taken all your money and that you are really"
	PRINT "injured. You need urgent medical assistance."
	PRINT

	d2 = rolld6
	HP = HP + d2
	xpoints = 0
	GOLD = 0

	COLOR 15
	PRINT "* Your health has been restored by"; d2; "HP Pts."
	PRINT "* You've lost all your confidence in battle."
	PRINT "* All your gold has been stolen."

END SELECT


WaitKey
GOTO inicio
END IF

SUB About
DrawDemon

COLOR 15
LOCATE 1, 1

PRINT
Pause
PRINT "Wild 0.7 - 2021 / 2023"
Pause
PRINT "Created by Fernando Gaston Ramirez as a free software and open source project."
PRINT
Pause
PRINT "Contributors from GitHub:"
PRINT
Pause
PRINT "- Alan Monroe from Ohio, USA."
Pause
PRINT "- YouTube user @dw817"

WaitKey

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



       IF GOLD < howmuch OR GOLD = 0 THEN
       PRINT
       Pause
       PRINT "You don't have that money! Better get out of here!"
       
       WaitKey
       
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
		   GOLD = GOLD - howmuch

		   CASE 2
		   PLAY NegativeMusic$
		   Pause
		   PRINT
		   PRINT "YOU LOSE 100% OF YOUR MONEY!"
		   GOLD = GOLD - howmuch

		   CASE 3
		   PLAY NegativeMusic$
		   Pause
		   PRINT
		   PRINT "YOU LOSE 50% OF YOUR MONEY!"
		   GOLD = GOLD - (howmuch / 2)


		   CASE 4
		   PLAY positive$
		   PRINT
		   PRINT "TIE! YOU KEEP YOUR MONEY!"

		   CASE 5
		   PLAY positive$
		   PRINT
		   PRINT "YOU WIN +50% OF YOUR BET!"
		   GOLD = GOLD + (howmuch / 2)

		   CASE 6
		   PLAY positive$
		   PRINT
		   PRINT "YOU WIN +100% OF YOUR BET!"
		   GOLD = GOLD + howmuch


	     END SELECT

       COLOR 3
       PLAY Chime$
       PRINT
       PRINT "Your gold is"; GOLD; "now."
       COLOR 10

       WaitKey

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
DrawDemon

COLOR 7
LOCATE 1, 1

IF FindACity = 1 THEN
COLOR 10
END IF

Pause
PRINT
PRINT "# Find a city for the first time."

COLOR 7

IF OneHundredGold = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Get 100 gold."

COLOR 7

IF OneThousandGold = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Get 1000 gold."

COLOR 7

IF ReachLevelTen = 1 THEN
COLOR 10
END IF

Pause
PRINT "# Reach level 10."

WaitKey

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
PRINT "  HP   = "; MaxHP; "    "
PRINT "  MANA = "; MaxMana; "    "
COLOR , 0
PRINT
COLOR 14, 9
PRINT "  GOLD   = "; GOLD; "   "
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
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"



'====== Draw BARS ======

COLOR 15
LOCATE 2, 67
PRINT "HP: "

LOCATE 3, 67
PRINT "MN: "

BarChangeLocation = 1
Xvalue = 2
Yvalue = 69
CALL HPBar

BarChangeLocation = 1
Xvalue = 3
Yvalue = 69
CALL ManaBar


WaitKey

END SUB

SUB CheckChallenges

IF GOLD >= 100 AND OneHundredGold = 0 THEN
COLOR 14, 2
LOCATE 10, 25
PRINT "CHALLENGE [GET 100 GOLD] COMPLETED!"
COLOR , 0
OneHundredGold = 1
END IF

IF GOLD >= 1000 AND OneThousandGold = 0 THEN
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

IF HP <= 0 THEN
CALL GameOver
GOTO endofsub
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
PRINT "Gold: "; GOLD;

LOCATE 10, 1
COLOR 15, 9
PLAY Chime$
INPUT "What to do? ", opcion


CityOpcionIni:
BarIni:

SELECT CASE opcion

     CASE 1

     IF GOLD < 25 THEN
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
     GOLD = GOLD - 25
     HP = MaxHP
     MANA = MaxMana
    
     WaitKey
     
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
	PRINT "Gold: "; GOLD;
	PRINT

	LOCATE 10, 1
	COLOR 15, 5
	INPUT "What to do? ", BarOption
	PRINT

	COLOR 10, 0

	SELECT CASE BarOption

		CASE 1

		IF GOLD < 10 THEN
		COLOR 10, 0
		PRINT
		Pause
		PRINT "You don't have enough money for that!"
		
		WaitKey
		
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
		GOLD = GOLD - 10
		MANA = MANA + 3
		HP = HP - .5

		WaitKey
		
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
			GOTO endofsub

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
     PRINT "Gold: "; GOLD;
     PRINT


     PRINT
     COLOR 10
     LOCATE 10, 1
     INPUT "What would you like to practice? ", TrainingOptions
     PRINT

     IF GOLD < 10 AND NOT TrainingOptions = 4 THEN
     PRINT
     PLAY NegativeMusic$
     Pause
     PRINT "You don't have any money to pay me!"
     
     WaitKey
     
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
	GOLD = GOLD - 10

	CASE 2
	PRINT "You train Attack and Resistance"
	d1 = rolld6 / 8
	COLOR 3
	PLAY Chance$
	Pause
	PRINT "(+"; d1; " AT / +"; d1; " DEF)"
	AT = AT + d1
	DF = DF + d1
	GOLD = GOLD - 10

	CASE 3
	PRINT "You train Defensive Movements"

	d1 = rolld6 / 5
	COLOR 3
	PLAY Chance$
	Pause
	PRINT "(+"; d1; " DEF)"
	DF = DF + d1
	GOLD = GOLD - 10

	CASE 4

	PRINT
	PRINT "You walk out of the training ground..."
	Pause
	GOTO CityIni

	CASE ELSE
	GOTO CityOpcionIni

     END SELECT

     WaitKey
     
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
		HP = HP - (d1 * 2)

		d1 = rolld6
		Pause
		PRINT "Die:"; d1; "*2 | you get -"; d1 * 2; " GOLD."
		GOLD = GOLD - (d1 * 2)

		Pause
		d1 = rolld6
		PRINT "Die:"; d1; "*2 | you get -"; d1 * 2; " MANA."
		MANA = MANA - (d1 * 2)
		
		WaitKey
		
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
		GOLD = GOLD + (d1 * 5)
		
		WaitKey
				
		GOTO CityIni
		END IF
		
		WaitKey
		
		CASE 2
		
		COLOR 10
		Pause
		PRINT
		PRINT "It doesn't seem to be a good idea. Better get out of here."

		WaitKey
		
	END SELECT
     

     CASE 6
     COLOR 10, 0
     PRINT
     PRINT "You decide to leave the city.."
     Pause
     GOTO endofsub

     CASE ELSE
     COLOR , 0
     GOTO CityIni

END SELECT

GOTO CityIni

endofsub:
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

WaitKey

PRINT

line$(1) = "It's easy for you to recognize these symbols, you've seen them before."
line$(2) = "They aren't part of the dark side, probably this temple was offered and"
line$(3) = "built to summon and pray to the gods of nature."

PrintLines

WaitKey

PRINT

line$(1) = "You feel that talking to the gods, trying to comunicate with them could"
line$(2) = "be a good idea."

PrintLines

WaitKey

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

	WaitKey
	
	d1 = rolld6

	SELECT CASE d1

		CASE 1
		PRINT
		Pause
		PRINT "Nothing happens."
		GOTO EndSub
		
		WaitKey
		
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

		HP = HP + d1
		MANA = MANA + d1

		WaitKey
				
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

		WaitKey
		
		PRINT
		PRINT "BOOM! A strong explosion behind you. You realize that someone"
		Pause
		PRINT "is attacking you with a fire gun from the distance! "

		WaitKey
		
		PRINT
		PRINT "You stand up and try to run away!"
		Pause
		PRINT "When you finally escape, you stop, breathe... and realize that you've"
		Pause
		PRINT "been shot in the shoulder and are heavily wounded."

		d1 = 5 + rolld6
		HP = HP - d1
		
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


       IF opcion = 2 OR opcion = 0 THEN

       line$(1) = "You just decide to continue walking..."
       line$(2) = "Maybe some other time."

       PRINT
       PrintLines

       END IF


END IF




IF d1 = 4 THEN
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
	MANA = MANA + 5
	DO WHILE INKEY$ = ""
	LOOP
	END IF


END IF

'-----------------------  5  -----------------------------


IF d1 = 2 OR d1 = 3 THEN


PRINT "You see a witch at the distance."
PRINT "Would you like to get closer and talk to her?"

RepeatWTQuestion:
PRINT
PRINT "[1]Yes | [2]No";
INPUT opcion

SELECT CASE opcion

	CASE 1

	d1 = rolld6

	IF d1 = 1 OR d1 = 2 THEN
	DecisionResult = 1
	WitchFight = 1
	PRINT "It's coming towards you!"
	PRINT "Seems to be very aggresive!"
	WaitKey
	GOTO EndSub
	END IF
	
	IF d1 = 3 OR d1 = 4 THEN
	PRINT "She sees you coming, makes an horrifying sound and runs away..."
	WaitKey
	GOTO EndSub
	END IF

	IF d1 = 5 OR d1 = 6 THEN
	GOTO WitchLine
	END IF

	CASE 2
	Pause
	PRINT "You just continue walking..."
	WaitKey
	GOTO EndSub

	CASE ELSE
	GOTO RepeatWTQuestion

END SELECT


WitchLine:
line$(1) = "Witch: Combine two of the next ingredients to generate something else."
line$(2) = "Choose Your Ingredients: "

PrintLines


ChooseIngredients:

line$(1) = "[1] Very Strange Pepper"
line$(2) = "[2] Light Blue Mushroom"
line$(3) = "[3] Rotten Smelling Liquid"

COLOR 3
PRINT
PrintLines
PRINT
PRINT "[10] Tell me more..."

line$(1) = "For instance, write the number 12 if you choose PEPPER + MUSHROOM."
line$(2) = "Write 23 if you choose MUSHROOM + LIQUID. You can combine ONLY two"
line$(3) = "ingredients."

COLOR 15
PRINT
PrintLines

PRINT

COLOR 10
INPUT "What ingredients would you like to combine? ", opcion

SELECT CASE opcion

	CASE 10

	COLOR 10

	Pause
	PRINT
	PRINT "Ok, I'll tell you more..."

	Pause
	PRINT
	PRINT "The PEPPER is really strange. Has a strange form, resembles a woman's face."
	PRINT "Its color is between pink and purple. Actually, you cannot say if it's pepper,"
	PRINT "a kind of garlic, or if it's a really rare fruit. "

	Pause
	PRINT
	PRINT "The MUSHROOM is white on its base, but its top is of a strong and bright blue"
	PRINT "color. It also has green, red and lighter blue dots on its surface. It looks"
	PRINT "bright, colorful, full of life. However, it could also be poisonous."

	Pause
	PRINT
	PRINT "The LIQUID smells awful. There's some kind of rotten meat or fluids inside that"
	PRINT "jar. You're almost sure. You try to smell it from closer and it almost makes you"
	PRINT "vomit."

	WaitKey
	GOTO ChooseIngredients

	CASE 12

	ResultIngredients = 1

	PRINT
	Pause
	COLOR 15
	PRINT "PEPPER + MUSHROOM"

	CASE 21

	ResultIngredients = 1

	PRINT
	Pause
	COLOR 15
	PRINT "MUSHROOM + PEPPER"

	CASE 13

	ResultIngredients = 2

	PRINT
	Pause
	COLOR 15
	PRINT "PEPPER + ROTTEN LIQUID"
	
	CASE 31

	ResultIngredients = 2

	PRINT
	Pause
	COLOR 15
	PRINT "ROTTEN LIQUID + PEPPER"
	
	CASE 23
	
	ResultIngredients = 3

	PRINT
	Pause
	COLOR 15
	PRINT "MUSHROOM + ROTTEN LIQUID"
	
	CASE 32

	ResultIngredients = 3

	PRINT
	Pause
	COLOR 15
	PRINT "ROTTEN LIQUID + MUSHROOM"

	CASE ELSE

	PRINT
	PRINT "You can only choose two ingredients. Try to choose two of the"
	PRINT "available options."

	WaitKey
	GOTO ChooseIngredients

END SELECT


IF ResultIngredients = 1 THEN '+++++++++++++ RESULT 1 +++++++++++++++++++++++

	COLOR 10
	line$(1) = "The witch takes both ingredients and put them in a glass jar."
	line$(2) = "She mixes it using her long and dirty finger nails."
	line$(3) = "The liquid inside the jar turns BLOOD RED."
	line$(4) = "She gives you the mix... You drink it..."

	PRINT
	PrintLines

	WaitKey

	line$(1) = "It tastes very spicy. Your body feels like burning. Your heart beats"
	line$(2) = "really quickly, like you never felt before. Then you feel your muscles"
	line$(3) = "contracting, then expanding. Your breathing gets deep, your lungs seem"
	line$(4) = "to be able of receiving much more oxygen than usual. After some minutes"
	line$(5) = "you feel much stronger, much resilient."

	PRINT
	PrintLines

	COLOR 3

	PRINT
	PRINT "(+ 0.1 AT / + 0.2 DF / + 0.3 HP / + 0.4 MANA)"

	AT = AT + .1
	DF = DF + .2
	MaxHP = MaxHP + .3
	MaxMana = MaxMana + .4
	
END IF


IF ResultIngredients = 2 THEN '+++++++++++++ RESULT 2 +++++++++++++++++++++++

	COLOR 10
	line$(1) = "The witch takes both ingredients and put them in a glass jar."
	line$(2) = "She mixes it using her long and dirty finger nails. The liquid"
	line$(3) = "inside the jar turns DARK GREEN. It smells horrible."
	line$(4) = "She gives you the mix... You drink it..."

	PRINT
	PrintLines

	WaitKey

	line$(1) = "It tastes awful. Your body trembles, your hands start shaking. Your heart"
	line$(2) = "beats more than usual. You vomit, you vomit a lot. Your throat hurts, but,"
	line$(3) = "but you can't stop throwing up. After that, you have a strong headache."
	line$(4) = "The witch promises that you'll feel much better and will be much stronger"
	line$(5) = "tomorrow. From suffering comes growth, from pain comes strength - she says."

	PRINT
	PrintLines

	COLOR 3

	PRINT
	PRINT "(+ 0.3 AT / + 0.3 DF / + 0.1 HP / + 0.3 MANA)"

	AT = AT + .3
	DF = DF + .3
	MaxHP = MaxHP + .1
	MaxMana = MaxMana + .3
	
END IF

IF ResultIngredients = 3 THEN '+++++++++++++ RESULT 3 +++++++++++++++++++++++

	COLOR 10
	line$(1) = "The witch takes both ingredients and put them in a glass jar."
	line$(2) = "She mixes it using her long and dirty finger nails. The liquid"
	line$(3) = "inside the jar turns a color between PURPLE and BROWN."
	line$(4) = "She gives you the mix... You look at it and smell it..."

	PRINT
	PrintLines

	WaitKey

	line$(1) = "You drink the purple brownish mix. It doesn't taste that bad after all."
	line$(2) = "However after drinking it, your body starts trembling, your hands start"
	line$(3) = "shaking. You feel your body burning. You have a strong headache, it feels"
	line$(4) = "like someone is stabbing your brain. Then blood comes out from your nose."

	PRINT
	PrintLines

	WaitKey

	line$(1) = "The witch looks serious... very worried. "
	line$(2) = "- It hasn't worked as expected! - she says."

	PRINT
	PrintLines

	COLOR 3

	Pause
	PRINT
	PRINT "(- 5 HP)"
	HP = HP - 5

END IF

WaitKey
GOTO EndSub

END IF

'-----------------------  6  -----------------------------

IF d1 = 6 OR d1 = 5 THEN
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

	WaitKey
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

	WaitKey
	GOLD = GOLD + addgold
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

	WaitKey
	MANA = MANA + addmana
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

	WaitKey
	HP = HP - DiscountHP
	GOTO EndSub

	CASE ELSE
	PRINT ""
	Pause
	PRINT "The cave is empty... Nothing interesting to see here."
	PRINT ""

	WaitKey
	GOTO EndSub

	END SELECT
     
CASE 2

Pause
PRINT "You just continue walking..."

CASE ELSE
GOTO 333

END SELECT

END IF

WaitKey

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
	WeatherText$ = "is sunny, not too cold, not too hot"

	CASE 2
	PRINT "It's cloudy and breezy."
	WeatherText$ = "is cloudy and a little windy"

	CASE 3
	PRINT "It's snowy and cold."
	WeatherText$ = "is very cold, it is snowing"

	CASE 4
	PRINT "It's dry and very hot."
	WeatherText$ = "is dry and quite hot"

	CASE 5
	PRINT "It's stormy, heavy rain."
	WeatherText$ = "is really bad, there is a huge storm going on"

	CASE 6
	PRINT "Windy and cold."
	WeatherText$ = "is very windy and really cold"

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

COLOR 6
LOCATE 4, 29
PRINT "    ²            ²"
LOCATE 5, 29
PRINT "   ° °    °     ° °"
LOCATE 6, 29
PRINT "  ±   °   ±    °   °"
LOCATE 7, 29
PRINT "       °  ²   °"
LOCATE 8, 29
PRINT "°      °±°²°²°°     °"
LOCATE 9, 29
PRINT "ú°     ß±²±²±²ß    °ú°"
LOCATE 10, 29
PRINT "°ú°    ±  ÝÝúú±   ° °"
LOCATE 11, 29
PRINT " °ú°   °°°ÝÝ°°   ° úú°"
LOCATE 12, 29
PRINT "²°úú°   °Ü°Ü°   °ú °²ú"
LOCATE 13, 29
PRINT " ²°úú°  Ý°Ý°Ý  °ú °²"
LOCATE 14, 29
PRINT "  ²°úú°  ÝÝÝ  °úú°²ú²"
LOCATE 15, 29
PRINT " °ú²°úÜßÜßÜßÜßÜú°²úú°"
LOCATE 16, 29
PRINT "°ú°ú°°°°ßÜßÜßÜ°°°° °ú°"
LOCATE 17, 29
PRINT "ú°ú°úú°°ßÜßÜßÜ°°úú°ú°"

COLOR 15
LOCATE 10, 41
PRINT "úú"

COLOR 4
LOCATE 11, 36
PRINT "°°"
LOCATE 12, 37
PRINT "°"
LOCATE 12, 39
PRINT "°"
LOCATE 13, 38
PRINT "°"

COLOR 7
LOCATE 14, 38
PRINT "ÝÝÝ"

LOCATE 15, 35
COLOR 8
PRINT "ÜßÜßÜßÜßÜ"
LOCATE 16, 37
PRINT "ßÜßÜßÜ"
LOCATE 17, 37
PRINT "ßÜßÜßÜ"
END SUB

SUB DrawCriminal
' CRIMINAL

COLOR 7
LOCATE 4, 29
PRINT "ú      ú  ú     ú  úú"
COLOR 4
LOCATE 4, 29
PRINT "    ú    !!!       ú"
COLOR 12
LOCATE 5, 29
PRINT "ú ú    °°°°°°°   ú  ú"
LOCATE 6, 29
PRINT "      °°°°°°°°°"
LOCATE 7, 29
PRINT "   °°°°°°°°°°°°°°°"
COLOR 7
LOCATE 8, 29
PRINT "      ± \±²±/ ±     ú"
LOCATE 9, 29
PRINT "  ú   ²±þÝ±Þþ±²  ú"
LOCATE 10, 29
PRINT "ú    ú ±°²-²°±"
COLOR 15
LOCATE 11, 29
PRINT " ú  ú             ú ú"
LOCATE 12, 29
PRINT " ú    °ß ÜßÜßÜ°  ú ú"
LOCATE 13, 29
COLOR 6
PRINT "ú  ú   °°°°°°°  ú"
COLOR 7
LOCATE 14, 29
PRINT "    ú    ±±±     ú"
COLOR 1
LOCATE 15, 29
PRINT "  ²±°²±±°°±°°±°±²²±°"
LOCATE 16, 29
PRINT " °°±±±±²²±°±±²²±°±°±°"
LOCATE 17, 29
PRINT " °±°±ú°±°±þ±±°±±ú±±°°"


COLOR 4
LOCATE 9, 37
PRINT "þ"
LOCATE 9, 41
PRINT "þ"

COLOR 6
LOCATE 12, 35
PRINT "°"
LOCATE 12, 43
PRINT "°"

COLOR 7
LOCATE 15, 39
PRINT "±"

COLOR 9
LOCATE 17, 39
PRINT "þ"

END SUB

SUB DrawDemon

CLS

DatFile$ = "IMGMENU.DAT"
LoadTXT

COLOR 4, 0
PrintIMG

xloop = 0

DO UNTIL xloop = 50

	COLOR 4

	d2 = INT(RND * 23) + 1
	d1 = INT(RND * 22) + 1

	'°±²

	LOCATE d2, d1
	PRINT "° "

	d1 = INT(RND * 23) + 1
	d2 = INT(RND * 20) + 60

	LOCATE d1, d2
	PRINT " °"

	xloop = xloop + 1

LOOP

COLOR 14
LOCATE 10, 49
PRINT "#"
LOCATE 10, 36
PRINT "#"

LOCATE 20, 32
COLOR 20
PRINT "@ .@   @@@@ @.@@ .  @@"

LOCATE 18, 27
COLOR 20
PRINT "   @@@%  &/(% &@ &%  &(@%@ "

END SUB

SUB DrawDesert
COLOR 14
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ DESERT ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"



LOCATE 19
PRINT "°                              °        °²±         °²±                         "
LOCATE 20
PRINT "²±   T     #     °²²±         °²±  T   °²²²±       °²²²²±  *    °²Û²Û²Û±   M   °"
LOCATE 21
PRINT "²²²±²²²²²²°²²²²²°²²²²²±²²²²²²°±²²±²²²°²²°±±±±²²²²²°²²²²²±²²²²²°²Û²Û²Û²Û²Û±²²²²°±"
LOCATE 22
PRINT "°²°²±²²²²°²±²²²°±²°²°²°²±²²²°²°²°²±²°±²°²°±±±²²²²°²°°°²°²±²²²°²Û²Û²Û²Û²Û²Û±²²°±±"
LOCATE 23
PRINT "²°²°²±²²°²°²±²°±°°²°°°²°²±²°±²°²°²±²°°°°°°²²±±²²°²°²°²°±°°°²°²Û°±Û°±Û°±Û°±Û²°±±±"

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
END SUB

SUB DrawIcons

COLOR 10

SELECT CASE Enemyname$

	CASE "Criminal"

	PRINT "°°°°°±±±°°°°°"
	PRINT "°°°°±±±±±°°°°"
	PRINT "°°°°°ßÛß°°°°°"
	PRINT "°°°°°±Þ±°°°°°"
	PRINT "°°°°±   ±°°°°"
	PRINT "°°²²±±±±±²²°°"

	CASE "Witch"

	PRINT "°°²°²þ±þ°±°°°"
	PRINT "°°°²°²ú°²°²°°"
	PRINT "°°°²±²±±²±°°°"
	PRINT "°°°ß°²±±°ß°°°"
	PRINT "°°°°°±°±°°°°°"
	PRINT "°°°°±°°±°°°°°"

	CASE "Wild Bugio"

	PRINT "°ßß°Ýþ±þÞ°°°°"
	PRINT "°±±°±ÝÝÝ±°°°°"
	PRINT "°±±±±±°±±±±±°"
	PRINT "°°°°±²²²±°±±°"
	PRINT "²°²±±²²²±±ÜÜ°"
	PRINT "°²°±±±°±±±°°°"

	CASE "Giant Scorpion"

	PRINT "°°°°°°°°°°°°°"
	PRINT "°°°°°²²±°°°°°"
	PRINT "°°°²±°°°²±°°°"
	PRINT "°°°°°°²²±°°°°"
	PRINT "°°°±²*²*²²±°°"
	PRINT "°°²°²°°°°²°²°"

	CASE "Crawler"

	PRINT "°²±°|±²±|°±²°"
	PRINT "²²°±þ±*±þ±°²²"
	PRINT "°°°²±ÝÝÝ±±°°°"
	PRINT "°°°°²ÞÞÞ±°°°°"
	PRINT "°°²±²±ú±²²±°°"
	PRINT "²±±°²±ú±²°±±²"

	CASE "Wild Wolf"

	PRINT "²°°±²±°±²±°°²"
	PRINT "²°°°\°°°/°°°²"
	PRINT "°²°±þ°±°þ±°²°"
	PRINT "²°²°±ÞÞÞ±°²°²"
	PRINT "°²°°°   °°°²°"
	PRINT "²°²²°² ²°²²°²"

	CASE ELSE

	PRINT "²°²±±²²²±±°²°"
	PRINT "²°²°²²²²±±°²°"
	PRINT "°±±±°²°±±±±±°"
	PRINT "²°²±±²²²±±°²°"
	PRINT "²°²±±²²²±±°²°"
	PRINT "°²°±±±°±±±°°°"

END SELECT

END SUB

SUB DrawMountains

COLOR 6
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ MOUNTAINS ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"



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
COLOR 14

LOCATE 7, 28
PRINT "           ²²²²²²±"
LOCATE 8, 28
PRINT "          ²±²° ²²±"
LOCATE 9, 28
PRINT "               ²²²±"
LOCATE 10, 28
PRINT "              ²²²²±"
LOCATE 11, 28
PRINT "           ²²²²²²²±"
LOCATE 12, 28
COLOR 2
PRINT "|ú|ú|úú|²²²***²²²²±ú|ú|'ú"
LOCATE 13, 28
PRINT "'ú ú  ²²°ú Ý Ýúú²²± ú'ú'ú"
LOCATE 14, 28
PRINT "ú ú|.²²²°' úú úú²²²± ú' ú "
LOCATE 15, 28
PRINT "''  ²°  ²° 'ú''²°  ²° ú' "


COLOR 14
LOCATE 12, 36
PRINT "²²²***²²²²±"

LOCATE 13, 34
PRINT "²²°"

LOCATE 13, 44
PRINT "²²²±"

LOCATE 14, 33
PRINT "²²²°"

LOCATE 14, 44
PRINT "²²²±"

LOCATE 15, 32
PRINT "²°  ²°"

LOCATE 15, 43
PRINT "²°  ²°"

LOCATE 12, 39
COLOR 15
PRINT "***"

LOCATE 13, 39
COLOR 6
PRINT "Ý Ý"

END SUB

SUB DrawSwamp

COLOR 8
LOCATE 20

COLOR 2
PRINT "ú     ú  +   ú    ú         -*-       +              ú     ú  -*-    ú  ú   ú  ú  ú"
LOCATE 21
COLOR 8
PRINT "°²Ü²ß°ß±Ü°²ß²°ßÜ±²ß²Ü°²ß±Ü±ß²ß²°ÝÜ²°±ß°Ý±Ü²°ß²±Ü°²ÜÝ°ß°²Ü±ß²ßÝÛÜÛ²ÛßÛÜÛ²ßÝ²ßÝ±°±"
LOCATE 22
COLOR 7
PRINT "²±°þ°²þ±þ°þ°Ýþ±²þ°ÝÜ±þ²°°þ°Ý±þ°Ýþ°±Ý°±þ°Ý±þ±þ±°þ²þ²°Ü°þ°þ°²Ý²°Ý°þ°°þ°Ýþ°²Ý°þ°±²°"
LOCATE 23
COLOR 8
PRINT "±°²°²°²°°²±°°±²°²°±²°±°²±°°°°±±°±°°±±°°²°°±²°°²°±°±°²±²°°±°²°±°²°²±°°±°²°±²°²°±²"
LOCATE 24
COLOR 3
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"


LOCATE 1
COLOR 7
PRINT "°°²°²°²°°²°±°²°°²±±²°±±°±°±°°±°±°²° [SWAMP] °²°°°±°±°°±°±°²°°°²°°±°°±°°±²°±°±°±²"

END SUB

SUB DrawWitch


COLOR 7
LOCATE 5, 17
PRINT "                   ° ° °"
LOCATE 6, 17
PRINT "                ú±ú ± ± ± °"
LOCATE 7, 17
PRINT "               ± °±° °±° ± °"
LOCATE 8, 17
PRINT "              ± °  ±   ±° ± °"
LOCATE 9, 17
PRINT "             ° ±  þ  ß  °°²±ú"
LOCATE 10, 17
PRINT "             ú± °  ÞÞ  °±ú± °"
LOCATE 11, 17
PRINT "             ° ± °Ý²ÝÝ²° ± ±"
LOCATE 12, 17
PRINT "              ±ú± °   ± ±ú° °"
LOCATE 13, 17
PRINT "              °±°  ²°² ° ° °ú"
LOCATE 14, 17
PRINT "               ± ±  ²  ± ± °ú"
COLOR 3
LOCATE 15, 17
PRINT "                  °±°±°±°  °ú"
LOCATE 16, 17
PRINT "               °±°±°±°±°±°±°°²"
LOCATE 17, 17
PRINT "              °±°±°±°±°±°±°±°°°²"




COLOR 4
LOCATE 9, 35
PRINT "þ  ß"

COLOR 15
LOCATE 11, 35
PRINT "Ý"
LOCATE 11, 37
PRINT "ÝÝ"

COLOR 4
LOCATE 11, 36
PRINT "²"
LOCATE 11, 39
PRINT "²"
LOCATE 12, 39
PRINT "±"

LOCATE 13, 38
PRINT "²"

LOCATE 11, 34
PRINT "°"
LOCATE 12, 35
PRINT "°"


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
PRINT "        °  °  ° °  °° ° °° ÝÝ° ° °  ° ²"
LOCATE 15, 18
PRINT "         °  ° ° °°ÝÝÝÝÝÝ ° ° °   °     °"
LOCATE 16, 18
PRINT "        ±  ±  ° ° Ý °°°° Ý ° °     °"
LOCATE 17, 18
PRINT "          ± ²  ° °   °°    °°   ° °  ²"
LOCATE 18, 18
PRINT "        ²         °°     °°           °"
LOCATE 19, 18
PRINT "       °    ±       °° °°"
LOCATE 20, 18
PRINT "          ° "
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

SUB EnemyHPBar 'Barra HP del enemigo

EnemyHPPercentage = (enemyDF / EnemyMaxDF) * 100
EnemyHPPercentage = EnemyHPPercentage / 10

COLOR 4
LOCATE , 1
PRINT "ÜÜÜÜÜÜÜÜÜÜ"

xloop = 1
DO UNTIL xloop >= EnemyHPPercentage + 1

IF EnemyHPPercentage > 0 THEN
xcolor = 4
END IF
IF EnemyHPPercentage > 3 THEN
xcolor = 14
END IF
IF EnemyHPPercentage > 6 THEN
xcolor = 10
END IF

COLOR xcolor

LOCATE , xloop + 0
PRINT "²";
xloop = xloop + 1
row% = row% - 1
LOOP

PRINT
PRINT

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
PRINT "ATTACK:"; enemyAT
LOCATE 7, 3
PRINT "DEFENCE:"; enemyDF
GOTO Skip
END IF

PRINT Enemyname$; "! ATTACK:"; enemyAT; "DEFENCE:"; enemyDF

Skip:

COLOR PositionCol(PositionCH), 0
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"


'+++++++++++++++++++++++++++++    DESERT    +++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 14 THEN
CALL DrawDesert
END IF

' ++++++++++++++++++++++++++++ FOREST BANNER ++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 2 THEN

COLOR 10, 0
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° [ FOREST ] °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

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

'++++++++++++++++++++++++++++ LAKES & RIVERS +++++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 1 THEN


COLOR 3
LOCATE 20
PRINT "ú  ú  ú     ú    ú                                  ú     ú      ú  ú   ú  ú  ú"
LOCATE 21
PRINT "°²Ü²ß°ß±Ü°²ß²°ßÜ±²ß²Ü°²ß±Ü±ß²ß²°ÝÜ²°±ß°Ý±Ü²°ß²±Ü°²ÜÝ°ß°²Ü±ß²ßÝÛÜÛ²ÛßÛÜÛ²ßÝ²ßÝ±°±"
LOCATE 22
PRINT "²±°þ°²þ±þ°þ°Ýþ±²þ°ÝÜ±þ²°°þ°Ý±þ°Ýþ°±Ý°±þ°Ý±þ±þ±°þ²þ²°Ü°þ°þ°²Ý²°Ý°þ°°þ°Ýþ°²Ý°þ°±²°"
LOCATE 23
PRINT "±°²°²°²°°²±°°±²°²°±²°±°²±°°°°±±°±°°±±°°²°°±²°°²°±°±°²±²°°±°²°±°²°²±°°±°²°±²°²°±²"
LOCATE 24
PRINT "°²°²°²°²°²°±°²°°±°±°²°°²°±°°±°±²°°±°°±°°±²°±°±°°±°²°±°°°±°²°±°°±°²°±°°²°±°°°±°²°"


LOCATE 1
COLOR 1
PRINT "°²°²°²°²°°²°±°²°°²°±²°±°²°±°²° [LAKES & RIVERS] °²°±°°±°±°²°°°²°°±°°±°°±²°±°±°±²"


END IF

'++++++++++++++++++++++++++++ FROZEN LANDS +++++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 7 THEN

COLOR 15
LOCATE 19
PRINT "*     *     *    *                                  *     *      *  *   *  *  *"
LOCATE 20
PRINT "°²Ü²ß°ß±Ü°²ß²°ßÜ±²ß²Ü°²ß±Ü±ß²ß²°ÝÜ²°±ß°Ý±Ü²°ß²±Ü°²ÜÝ°ß°²Ü±ß²ßÝÛÜÛ²ÛßÛÜÛ²ßÝ²ßÝ±°±"
LOCATE 21
PRINT "²±°þ°²þ±þ°þ°Ýþ±²þ°ÝÜ±þ²°°þ°Ý±þ°Ýþ°±Ý°±þ°Ý±þ±þ±°þ²þ²°Ü°þ°þ°²Ý²°Ý°þ°°þ°Ýþ°²Ý°þ°±²°"
LOCATE 22
PRINT "±°²°²°²°°²±°°±²°²°±²°±°²±°°°°±±°±°°±±°°²°°±²°°²°±°±°²±²°°±°²°±°²°²±°°±°²°±²°²°±²"
LOCATE 23
PRINT "²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²"


LOCATE 1
COLOR 15
PRINT "²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²² [FROZEN LANDS] ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²"

END IF

'++++++++++++++++++++++++++++ SWAMPS +++++++++++++++++++++++++++++++++++

IF PositionCol(PositionCH) = 8 THEN

CALL DrawSwamp

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

SUB GameIntro1

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

SUB GenDescription 'GENERATE DESCRIPTION OF THE PLACE

'===================================================
'TERRAIN and WEATHER introduction.

SELECT CASE PositionCol(PositionCH)
CASE 2
nameterrain$ = "in a forest"
CASE 8
nameterrain$ = "in the middle of a swamp"
CASE 7
nameterrain$ = "in frozen lands"
CASE 14
nameterrain$ = "in the desert"
CASE 1
nameterrain$ = "next to a lake or river"
CASE 6
nameterrain$ = "in the mountains"
END SELECT

CLS
COLOR 10

PRINT
Pause
PRINT "You are "; nameterrain$; ". "
Pause
PRINT "The day "; WeatherText$; "."
PRINT
'===================================================




AdjPlace$(1) = "quiet"
AdjPlace$(2) = "misterious"
AdjPlace$(3) = "silent"
AdjPlace$(4) = "scary"
AdjPlace$(5) = "dark"
AdjPlace$(6) = "relaxing"
AdjPlace$(7) = "comfortable"
AdjPlace$(8) = "haunted"
AdjPlace$(9) = "cold"
AdjPlace$(10) = "boring"
AdjPlace$(11) = "interesting"
AdjPlace$(12) = "awful"
AdjPlace$(11) = "disgusting"
AdjPlace$(13) = "uncomfortable"
AdjPlace$(14) = "dull"
AdjPlace$(15) = "familiar"


PluralNouns$(1) = "insects"
PluralNouns$(2) = "rocks"
PluralNouns$(3) = "flowers"
PluralNouns$(4) = "dead animals"
PluralNouns$(5) = "horses"
PluralNouns$(6) = "cows"
PluralNouns$(7) = "dunes"
PluralNouns$(8) = "mountains"
PluralNouns$(9) = "trees"
PluralNouns$(10) = "creatures"
PluralNouns$(11) = "enemies"
PluralNouns$(12) = "tents"
PluralNouns$(13) = "vultures"
PluralNouns$(14) = "black camels"
PluralNouns$(15) = "strange symbols"
PluralNouns$(16) = "satanic symbols"



SingNoun$(1) = "tree"
SingNoun$(2) = "mountain"
SingNoun$(3) = "abandoned house"
SingNoun$(4) = "tower"
SingNoun$(5) = "farm"
SingNoun$(6) = "stone wall"
SingNoun$(7) = "cave"
SingNoun$(8) = "lake"
SingNoun$(9) = "river"
SingNoun$(10) = "fallen tree"
SingNoun$(11) = "monument"
SingNoun$(11) = "huge rock with red symbols"
SingNoun$(12) = "satanic monument"
SingNoun$(13) = "statue"
SingNoun$(14) = "bridge"
SingNoun$(15) = "wild wolf"

hear$(1) = "birds"
hear$(2) = "people shouting"
hear$(3) = "the wind"
hear$(4) = "music"
hear$(5) = "water"
hear$(6) = "someone talking"
hear$(7) = "nothing"
hear$(8) = "dogs barking"
hear$(9) = "explosions"
hear$(10) = "strange sounds"
hear$(11) = "a rooster"
hear$(12) = "weird sounds"
hear$(13) = "a storm coming"
hear$(14) = "a wild wolf at the distance"

feel$(1) = "motivated"
feel$(2) = "ok"
feel$(3) = "bad"
feel$(4) = "inspired"
feel$(5) = "tired"
feel$(6) = "exhausted"
feel$(7) = "well rested"
feel$(8) = "strong"
feel$(9) = "overwhelmed"
feel$(10) = "sad"
feel$(11) = "weak"
feel$(12) = "happy"
feel$(13) = "anxious"
feel$(14) = "worried"


YouAre$(1) = "sitting on a rock"
YouAre$(2) = "standing on a rock"
YouAre$(3) = "on a tree"
YouAre$(4) = "standing under a tree"
YouAre$(5) = "following a path"
YouAre$(6) = "not following a path"
YouAre$(7) = "walking by a road"
YouAre$(8) = "in the middle of nowhere"
YouAre$(9) = "travelling out of the road, not following a path"
YouAre$(10) = "quite lost"
YouAre$(11) = "resting"
YouAre$(12) = "drinking some water"
YouAre$(13) = "eating something"
YouAre$(14) = "laying on the ground"
YouAre$(15) = "walking very fast"
YouAre$(16) = "moving fast"
YouAre$(17) = "going fast"
YouAre$(18) = "walking fast, almost running"

its$(1) = "It's getting colder."
its$(2) = "It's a really good place to be."
its$(3) = "It doesn't seem to be a very good place to be for a long time."
its$(4) = "It looks very safe."
its$(5) = "It doesn't look very safe."
its$(6) = "It's getting colder."
its$(7) = "It's an interesting area."
its$(8) = "It's starting to rain."
its$(9) = "It's getting darker."
its$(10) = "There's fog in the air."
its$(11) = "It feels like something bad is about to happen."
its$(12) = "It feels like something good is about to happen."
its$(13) = "You feel that something is watching you."
its$(14) = "An enemy or creature could appear any time."




RANDOMIZE TIMER

number1 = INT(RND * 14) + 1
number2 = INT(RND * 14) + 1
number3 = INT(RND * 14) + 1
number4 = INT(RND * 14) + 1
number5 = INT(RND * 14) + 1

Pause
PRINT "You are "; YouAre$(number5); ". "; its$(number2)

Pause
PRINT "The place is "; AdjPlace$(number1); ". There are "; PluralNouns$(number2); " all around the area."
Pause
PRINT "You can see a(n) "; SingNoun$(number3); " at the distance. You can hear "; hear$(number4); "."

number1 = INT(RND * 14) + 1
number2 = INT(RND * 14) + 1
number3 = INT(RND * 14) + 1
number4 = INT(RND * 14) + 1

PRINT
Pause
PRINT "On your left you can see a(n) "; SingNoun$(number1); ", on your right you see a(n) "; SingNoun$(number2); "."
Pause
PRINT "In front of you there are "; PluralNouns$(number3); ". You feel "; feel$(number2); "."

END SUB

SUB HPBar '========== BARRAS

'BarChangeLocation [Boolean] can change the bar location when activated [1].
'Use variables Xvalue and Yvalue for passing location coordinates.

'Variable % de HP declarada como SHARED INTEGER.

HPPercentage = (HP / MaxHP) * 100
HPPercentage = HPPercentage / 10

' Para sacar % de un numero respecto de otro, realizar division
' del primero por el segundo y, posteriormente, multiplicar por 100.

' Por ejemplo, si queremos saber qué % supone una rebaja de 2 EUR
'respecto de 10 EUR hacemos (2/10) * 100 = 20%
 
IF BarChangeLocation = 1 THEN
COLOR 7
LOCATE Xvalue, Yvalue + 1
PRINT "°°°°°°°°°°"
END IF

IF BarChangeLocation = 0 THEN
COLOR 2
LOCATE , 1
PRINT "ÜÜÜÜÜÜÜÜÜÜ"
END IF


xloop = 1

DO UNTIL xloop >= HPPercentage + 1

IF HPPercentage > 0 THEN
xcolor = 4
END IF
IF HPPercentage > 3 THEN
xcolor = 14
END IF
IF HPPercentage > 6 THEN
xcolor = 10
END IF

COLOR xcolor

IF BarChangeLocation = 1 THEN
LOCATE Xvalue, xloop + Yvalue
END IF

IF BarChangeLocation = 0 THEN
LOCATE , xloop + 0
END IF

PRINT "²";
xloop = xloop + 1
LOOP

BarChangeLocation = 0
END SUB

SUB Information

d1 = INT(RND * 7) + 1

COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 = 1 THEN

DatFile$ = "inf1.dat"
LoadTXT
PrintLines

END IF

IF d1 = 2 THEN

DatFile$ = "inf2.dat"
LoadTXT
PrintLines

END IF

IF d1 = 3 THEN

DatFile$ = "inf3.dat"
LoadTXT
PrintLines

END IF

IF d1 = 4 THEN

DatFile$ = "inf4.dat"
LoadTXT
PrintLines

END IF

IF d1 = 5 THEN

DatFile$ = "inf5.dat"
LoadTXT
PrintLines

END IF

IF d1 = 6 THEN

DatFile$ = "inf6.dat"
LoadTXT
PrintLines

END IF

WaitKey

END SUB

SUB Intro

LOCATE 11, 34
PRINT "LOADING..."

PLAY IntroMusic$
DatFile$ = "INTRO.DAT"
LoadTXT
CLS

COLOR 4
LOCATE 1, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

LOCATE 23, 1
PRINT "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"

COLOR 14
LOCATE 3, 1
PrintLines

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

SUB LoadTXT

OPEN DatFile$ FOR INPUT AS #1

loopx = 0
DO UNTIL loopx = 30

	INPUT #1, line$(loopx)
	loopx = loopx + 1

LOOP

CLOSE #1

END SUB

SUB MainMenu
DrawDemon

opcion = 0

COLOR 15
LOCATE 1, 1
COLOR 10, 2
PRINT "                              WILD 0.7 (2021 - 2023)                            "
COLOR 15, 0
LOCATE 7, 3
PRINT "1) NEW GAME"
LOCATE 8, 3
PRINT "2) ACHIEVEMENTS"
LOCATE 9, 3
PRINT "3) CREDITS"
LOCATE 10, 3
PRINT "4) EXIT"

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

LOCATE 12, 2
COLOR 15, 0
INPUT "Choose an option: ", opcion

END SUB

SUB ManaBar

MANAPercentage = (MANA / MaxMana) * 100
MANAPercentage = MANAPercentage / 10

IF BarChangeLocation = 1 THEN
COLOR 7
LOCATE Xvalue, Yvalue + 1
PRINT "°°°°°°°°°°"
END IF


xloop = 1

DO UNTIL xloop >= MANAPercentage + 1

IF MANAPercentage > 0 THEN
xcolor = 1
END IF
IF MANAPercentage > 3 THEN
xcolor = 1
END IF
IF MANAPercentage > 6 THEN
xcolor = 1
END IF

COLOR xcolor

IF BarChangeLocation = 1 THEN
LOCATE Xvalue, xloop + Yvalue
END IF

IF BarChangeLocation = 0 THEN
LOCATE , xloop + 0
END IF

PRINT "²";
xloop = xloop + 1
LOOP

BarChangeLocation = 0


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

DatFile$ = "neg1.dat"
LoadTXT
PrintLines

HP = HP - 1

END IF

IF d1 = 2 THEN

DatFile$ = "neg2.dat"
LoadTXT
PrintLines

GOLD = 0

END IF

IF d1 = 3 THEN

DatFile$ = "neg3.dat"
LoadTXT
PrintLines

WaitKey

d1 = rolld6

COLOR 3
PRINT "Die:"; d1;

'''''''''''

	IF d1 = 1 THEN

	COLOR 10

	line$(1) = "As you move forward, a chilling sight meets your gaze."
	line$(2) = "Just a few meters ahead, coiled and ready to strike, is"
	line$(3) = "the slithering form of a snake. Its scales glisten with"
	line$(4) = "a malevolent sheen, and its eyes fixate on you with predatory"
	line$(5) = "intent. Fear grips your heart, and a primal instinct urges"
	line$(6) = "you to retreat. (-6 HP)"

	PrintLines

	HP = HP - 6

	WaitKey
	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 2 THEN

	COLOR 10

	line$(1) = "As you make your way forward, your eyes catch something in the distance."
	line$(2) = "Just a few meters ahead, perched delicately on a web, is a brown"
	line$(3) = "spider. Its spindly legs quiver with anticipation, and its eight"
	line$(4) = "beady eyes lock onto your presence. A wave of unease washes over"
	line$(5) = "you as you realize the potential danger. The thought of its venomous"
	line$(6) = "bite sends a chill down your spine, and you instinctively take a step"
	line$(7) = "back. (-3 HP)"
	
	PrintLines

	HP = HP - 3

	WaitKey
	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 3 THEN
	COLOR 10
	
	line$(1) = "Scanning the surroundings for any signs of danger, you find nothing"
	line$(2) = "that matches your initial suspicion. It appears that your fears may have"
	line$(3) = "been unfounded, and the pain in your leg gradually diminishes. Perhaps it"
	line$(4) = "was nothing more than a harmless encounter with a plant or a rock, causing"
	line$(5) = "only a minor scrape or bruise. You shake off the unease that had settled"
	line$(6) = "within you and continue walking."

	PrintLines

	WaitKey
	GOTO EndOfNegative
	END IF

'''''''''''

	IF d1 = 4 THEN

	COLOR 10

	line$(1) = "The initial pain in your leg intensifies, causing you to wince and"
	line$(2) = "grip your throbbing limb. The discomfort is unbearable at first, making"
	line$(3) = "you fear the worst. However, as time passes, the sharp agony gradually"
	line$(4) = "subsides, replaced by a dull ache. Despite the diminishing pain, a new"
	line$(5) = "concern arises — the area around the bite begins to show signs of infection."
	
	PrintLines

	RANDOMIZE TIMER

	d1 = INT(RND * 6) + 1

	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."

	HP = HP - d1

	WaitKey
	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 5 THEN

	COLOR 10

	line$(1) = "You cautiously examine your leg, searching for any visible signs of damage."
	line$(2) = "- Oh... it's nothing - you mutter, trying to dismiss the discomfort that lingers"
	line$(3) = "in your leg. Rationalizing the pain, you convince yourself that it must have been"
	line$(4) = "a mere scrape against a rock. A small, inconsequential accident, you assure yourself."

	PrintLines

	WaitKey
	GOTO EndOfNegative

	END IF

'''''''''''

	IF d1 = 6 THEN

	COLOR 10

	DatFile$ = "neg3f.dat"
	LoadTXT
	PrintLines

	d1 = rolld6

	Pause

	COLOR 3
	PRINT "Die:"; d1; "| you get -"; d1; "HP."

	HP = HP - d1

	WaitKey
	GOTO EndOfNegative

	END IF

'''''''''''

END IF


IF d1 > 3 AND d1 < 7 THEN

COLOR 10

DatFile$ = "neg6.dat"
LoadTXT
PrintLines

HP = HP - 1.5

END IF

WaitKey

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

SUB Pause
pausex = 0

DO UNTIL pausex = 10000
pausex = pausex + 1
LOOP

END SUB

SUB PositiveSub

COLOR 3
PRINT "Die:"; d1;
COLOR 10

IF d1 = 1 THEN

DatFile$ = "pos1.dat"
LoadTXT
PrintLines

COLOR 3
PRINT
PRINT "(+1 HP)"

HP = HP + 1

END IF

IF d1 = 2 THEN

DatFile$ = "pos2.dat"
LoadTXT
PrintLines

COLOR 3
PRINT
Pause
PRINT "(+5 HP) (+20 GOLD) (100% MANA pts)"

HP = HP + 5
GOLD = GOLD + 20
MANA = MaxMana
END IF

IF d1 = 3 THEN

line$(1) = "You see something shiny in the middle of the path."
line$(2) = "Some gold coins are spread all over the place!!!"

PrintLines

COLOR 3
PRINT
Pause
PRINT "(+10 GOLD)"

GOLD = GOLD + 10
END IF

IF d1 = 4 THEN

DatFile$ = "pos4.dat"
LoadTXT
PrintLines

COLOR 3
PRINT
PRINT "(+3 HP) (+0.5 AT) "

HP = HP + 3
AT = AT + .5

END IF

IF d1 = 5 THEN

Pause
PRINT "Street vendor by the road! He offers you the following items:"
PRINT

DatFile$ = "pos5.dat"
LoadTXT
PrintLines

PRINT

AskAgain78:

Pause
INPUT "Would you like to buy something sir?"; opcion

'===== NO MONEY TO BUY THAT =====

IF opcion = 1 AND GOLD < 25 OR opcion = 2 AND GOLD < 25 THEN
opcion = 1344
END IF

SELECT CASE opcion

	CASE 1 '===== MIX OF HERBS
	
	Pause
	PRINT "- Nice, MIX OF HERBS! Here you have!"
	WaitKey
	PRINT
	line$(1) = "YOU DRINK IT AND FEEL MUCH BETTER. YOU FEEL LESS TIRED, RELAXED, WITH"
	line$(2) = "LOTS OF NEW ENERGY. YOUR BODY DOESN'T HURT ANYMORE."

	PrintLines

	HP = HP + 5
	GOLD = GOLD - 25
	WaitKey
	GOTO PositiveEnd
	
	CASE 2 '===== ENERGETIC SOUP

	Pause
	PRINT "- Nice, ENERGETIC SOUP! Here you have!"
	WaitKey
	PRINT
	line$(1) = "YOU DRINK IT AND FEEL YOUR BODY MUCH STRONGER. YOU FEEL MORE CONFIDENT"
	line$(2) = "IS IT ACTUALLY SOUP? OR IS IT LIKE A DRUG OR SOMETHING? IT EVEN TASTES"
	line$(3) = "PRETTY GOOD."

	PrintLines

	MANA = MANA + 5
	GOLD = GOLD - 25

	WaitKey

	GOTO PositiveEnd

	CASE 3 '===== NO, THANKS
	Pause
	PRINT "- Oh, that's ok then..."
	WaitKey
	GOTO PositiveEnd
	
	CASE 1344 '===== NO MONEY TO BUY THAT
	Pause
	PRINT
	PRINT "- Mmmm... you don't have that money. I didn't say it was for free!"
	WaitKey
	GOTO PositiveEnd
	
	CASE ELSE '===== GO TO LINE 78 AND ASK AGAIN
	GOTO AskAgain78

END SELECT

END IF

IF d1 = 6 THEN

DatFile$ = "pos6.dat"
LoadTXT
PrintLines

COLOR 3
PRINT
PRINT "(+25 GOLD) (+10 HP) (+0.5 AT)"

GOLD = GOLD + 25
HP = HP + 10
AT = AT + .5

END IF

WaitKey

PositiveEnd:
END SUB

SUB PrintIMG

'Sub routine that prints ASCII IMAGES.

loopx = 0               '========= LOOP for printing the line$() ARRAY

DO UNTIL loopx = 30

	IF line$(loopx) = "WaitKey" THEN

		WaitKey
		GOTO SkipLineIMG

	END IF

	IF line$(loopx) = "" THEN

		GOTO SkipLineIMG

	END IF

	PRINT line$(loopx)

SkipLineIMG:

	loopx = loopx + 1

LOOP

'++++++++++++++++++++ CLEAR STRING VARIABLES ++++++++++++++++++++++++++++++++

loopx = 0

DO UNTIL loopx = 25

	line$(loopx) = ""
	loopx = loopx + 1

LOOP

END SUB

SUB PrintLines

'Sub routine that prints text lines and the story lines.

loopx = 0               '========= LOOP for printing the line$() ARRAY

DO UNTIL loopx = 25

 IF line$(loopx) = "****" THEN

	PRINT
	GOTO SkipLine

 END IF

 IF line$(loopx) = "WaitKey" THEN

	WaitKey
	GOTO SkipLine

 END IF

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

DO UNTIL loopx = 25
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

SUB showD6

D6DieX = 37       'CHANGE THIS TO MODIFY THE GENERAL X VALUE
D6DieY = 10       'CHANGE THIS TO MODIFY THE GENERAL Y VALUE


RANDOMIZE TIMER
xloop = 0

DO UNTIL INKEY$ = CHR$(32)     'LOOP UNTIL SPACE IS PRESSED

COLOR 15
repeatroll:
D6 = INT(RND * 6) + 1

IF D6 = rememberd6 THEN
GOTO repeatroll
END IF

rememberd6 = D6

SELECT CASE D6

	CASE 1
	LOCATE D6DieY, D6DieX
	PRINT "²²²²²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²²*²²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²²²²²"


	CASE 2
	LOCATE D6DieY, D6DieX
	PRINT "²²²²²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²*²*²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²²²²²"

	CASE 3
	LOCATE D6DieY, D6DieX
	PRINT "²*²²²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²²*²²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²²²*²"

	CASE 4
	LOCATE D6DieY, D6DieX
	PRINT "²*²*²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²²²²²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²*²*²"

	CASE 5
	LOCATE D6DieY, D6DieX
	PRINT "²*²*²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²²*²²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²*²*²"

	CASE 6
	LOCATE D6DieY, D6DieX
	PRINT "²*²*²"
	LOCATE D6DieY + 1, D6DieX
	PRINT "²*²*²"
	LOCATE D6DieY + 2, D6DieX
	PRINT "²*²*²"

END SELECT

COLOR 14
PRINT
LOCATE D6DieY + 4, D6DieX - 4
PRINT "[Press SPACE]"

xloop = xloop + 1

aloop = 0    ' PAUSE
DO UNTIL aloop = 2500
aloop = aloop + 1
LOOP

LOOP

d1 = D6

END SUB

SUB TalkToStrangers

CLS
d1 = rolld6

SELECT CASE d1

	CASE 1
	DatFile$ = "bar1.dat"
	LoadTXT

	CASE 2
	DatFile$ = "bar2.dat"
	LoadTXT

	CASE 3
	DatFile$ = "bar3.dat"
	LoadTXT

	CASE 4
	DatFile$ = "bar4.dat"
	LoadTXT
	
	CASE ELSE
	DatFile$ = "bar1.dat"
	LoadTXT


END SELECT

PRINT
PRINT

CALL PrintLines        '========= SUB for printing the line$() ARRAY

WaitKey

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

SUB Trans3 'LLUVIA ROJA INVERTIDA
yloop = 0

DO UNTIL yloop = 10000   'CHANGE IF YOU WANT TO CHANGE THE TIME OF TRANS3

RandomX = INT(RND * 75) + 1
RandomY = INT(RND * 24) + 1

LOCATE RandomY, RandomX
RandomChar = INT(RND * 3) + 1

SELECT CASE RandomChar

	CASE 1
	COLOR 4
	PRINT ":"

	CASE 2
	COLOR 4
	PRINT "."

	CASE 3
	COLOR 4
	PRINT "|"

END SELECT

SELECT CASE INKEY$
	CASE CHR$(27)
	END
END SELECT

yloop = yloop + 1

LOOP

END SUB

SUB WaitKey

DO WHILE INKEY$ = ""
LOOP

END SUB

