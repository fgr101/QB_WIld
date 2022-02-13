
DECLARE FUNCTION rolld6()
DECLARE SUB displayweather(d6)
DECLARE SUB mainloop()
DECLARE SUB displaymenu()

'=======================================================

RANDOMIZE TIMER
mainloop
END


'=======================================================

SUB mainloop()
    stillplaying = 1
    
    WHILE stillplaying = 1
        CLS
        displayweather rolld6
        displaymenu
        COLOR 3
        INPUT "Where to go? ", direction
        IF direction = 10 THEN
            stillplaying = 0
        END IF
    WEND
END SUB



SUB displaymenu()
    COLOR 2
    PRINT
    PRINT "1- North"
    PRINT "2- South"
    PRINT "3- East"
    PRINT "4- West"
    PRINT
    PRINT "10- Exit"
    PRINT
END SUB



FUNCTION rolld6()
    rolld6 = INT(RND * 6) + 1
END FUNCTION



SUB displayweather(d6)
    COLOR 3
    PRINT "Die:"; d6;
    COLOR 2

    SELECT CASE d6
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




