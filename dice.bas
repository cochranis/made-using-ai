10 PRINT "WELCOME TO THE DICE GAME!"
20 PRINT "--------------------------"
30 PRINT "INSTRUCTIONS: ROLL TWO DICE. IF THE SUM IS 7 OR 11, YOU WIN!"
40 PRINT "PRESS ANY KEY TO ROLL THE DICE..."
50 INPUT A$
60 D1 = INT(RND(1)*6) + 1
70 D2 = INT(RND(1)*6) + 1
80 PRINT "YOU ROLLED:", D1, "AND", D2
90 SUM = D1 + D2
100 IF SUM = 7 OR SUM = 11 THEN
110     PRINT "Congratulations! You win!"
120 ELSE
130     PRINT "Sorry, you lose."
140 END IF
150 PRINT "Do you want to play again? (Y/N)"
160 INPUT B$
170 IF B$ = "Y" THEN
180     GOTO 50
190 ELSE
200     PRINT "Thanks for playing! Goodbye."
210 END IF
