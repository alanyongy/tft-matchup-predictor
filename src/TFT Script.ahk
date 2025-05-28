#singleinstance force
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

gui, debug:Color, 0X130F13
gui, debug:+LastFound +AlwaysOnTop +ToolWindow +E0x20
WinSet, TransColor, 0X130F13
gui, debug:-Caption
gui, debug:Font, bold cFFFFFF S12, Arial
gui, debug:Add, Text, vl, l1:%l1% l2:%l2% l3:%l3% l4:%l4% l5:%l5% initializing
gui, debug:Add, Text, vmmcounter, mmcounter: initializing
gui, debug:Show, x30 y30 NoActivate

gui, history:Color, 0X130F13
gui, history:+LastFound +AlwaysOnTop +ToolWindow +E0x20 +Hwndhistoryhwnd
WinSet, TransColor, 0X130F13
gui, history:-Caption
gui, history:Font, bold cFFFFFF S12, Arialeee
gui, history:Add, Text, vhistory, History:
gui, history:Add, Text, v1, initializing
gui, history:Add, Text, v2, initializing
gui, history:Add, Text, v3, initializing
gui, history:Add, Text, v4, initializing
gui, history:Add, Text, v5, initializing
gui, history:Show, x150 y400 NoActivate

wingetpos, historyX, historyY, historyW, historyH, ahk_id %historyhwnd%
guicontrolget, controlPos, history:pos, 1
global history1X := % historyX + controlPosX
global history1Y := % historyY + controlPosY
global history1W := % controlPosW
global history1H := % controlPosH
guicontrolget, controlPos, history:pos, 2
global history2X := % historyX + controlPosX
global history2Y := % historyY + controlPosY
global history2W := % controlPosW
global history2H := % controlPosH
guicontrolget, controlPos, history:pos, 3
global history3X := % historyX + controlPosX
global history3Y := % historyY + controlPosY
global history3W := % controlPosW
global history3H := % controlPosH
guicontrolget, controlPos, history:pos, 4
global history4X := % historyX + controlPosX
global history4Y := % historyY + controlPosY
global history4W := % controlPosW
global history4H := % controlPosH
guicontrolget, controlPos, history:pos, 5
global history5X := % historyX + controlPosX
global history5Y := % historyY + controlPosY
global history5W := % controlPosW
global history5H := % controlPosH

gui, historyBox:Color, 0X130F13
gui, historyBox:+LastFound +AlwaysOnTop +ToolWindow +E0x20
WinSet, TransColor, 0X130F13
gui, historyBox:-Caption	
gui, historyBox:Show, noactivate x0 y0 w1920 h1080

global py = 700
global px = 30
global pyincrement = 40
global py1 := % py + pyincrement
global py2 := % py1 + pyincrement
global py3 := % py2 + pyincrement
global py4 := % py3 + pyincrement
global py5 := % py4 + pyincrement
global py6 := % py5 + pyincrement
global py7 := % py6 + pyincrement

global draggedPlayer = 0

gui, player:Color, 0x130F13
gui, player:+LastFound +AlwaysOnTop +ToolWindow 
WinSet, TransColor, 0x130F13
gui, player:-Caption
gui, player:Font, bold cFFFFFF S12, Arialeee
gui, player:Add, Text, vplayer, Players:
gui, player:Show, x%px% y%py% NoActivate

global p1UID, p2UID, p3UID, p4UID, p5UID, p6UID, p7UID

Loop, 7 {
    i := A_Index
    guiName := "p" . i
    varName := "pmain" . i
    hwndVar := "p" . i . "hwnd"
    yPos := py%i%

    Gui, %guiName%:Color, 292929
    Gui, %guiName%:+LastFound +AlwaysOnTop +ToolWindow -Caption +Hwnd%hwndVar%
    WinSet, Transparent, 200
    Gui, %guiName%:Margin, 10, 0
    Gui, %guiName%:Font, bold cFFFFFF S16, Arialeee
    Gui, %guiName%:Add, Text, v%varName%, initializing
    Gui, %guiName%:Show, y%yPos% x%px% w230 h30 
    WinGet, uid, ID, A

    ; assign using dynamic name
    uidVar := "p" . i . "UID"
    %uidVar% := uid
}



gui, searchPlayer:Color, 0X130F13
gui, searchPlayer:+LastFound +AlwaysOnTop +ToolWindow +E0x20
WinSet, TransColor, 0X130F13
gui, searchPlayer:-Caption	
gui, searchPlayer:Add, GroupBox, vplayerTag1 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag2 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag3 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag4 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag5 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag6 w38 h41
gui, searchPlayer:Add, GroupBox, vplayerTag7 w38 h41
gui, searchPlayer:Show, noactivate x0 y0 w1920 h1080
OnMessage(0x201, "WM_LBUTTONDOWN")


global p1 =
global p2 = 
global p3 =
global p4 =
global p5 =

global x1 =
global x2 = 
global x3 =
global x4 = 
global x5 =

global l1 =
global l2 =
global l3 =
global l4 =
global l5 =

global player1Name = 
global player2Name = 
global player3Name = 
global player4Name = 
global player5Name = 
global player6Name = 
global player7Name = 

global m1 =
global m2 =
global m3 =
global m4 =
global m5 =

global m1x =
global m2x =
global m3x =
global m4x =
global m5x =

global firstLetter = true
global widthOfImg = 94
global widthOfPreImg = 0
global textCursor = %widthOfImg%

global playerSearchStartY = 183
global mmCounter = 5

global stageNum = 1
global newStageNum = 1

global oldPlayerName = ""
global showGui := true

class player {
	__New(name){
		this.counter := 10
		this.name := name
		this.foundAtX := 0
	}
}

mainLoopSleepTimer = 0

Loop, 
{
	sleep, mainLoopSleepTimer

	checkStageNum()
	
	if (newStageNum > stageNum){
		stageNum = % newStageNum
		player1.foundAtX := 0
		player2.foundAtX := 0
		player3.foundAtX := 0
		player4.foundAtX := 0
		player5.foundAtX := 0
		player6.foundAtX := 0
		player7.foundAtX := 0
		ghost.foundAtX := 0
	}
	
	ImageSearch, tagFoundX, tagFoundY, 1790, playerSearchStartY, 1850, 900, *60 playerTag.png
	if errorlevel = 0
    {	
		playerSearchStartY = % tagFoundY+60
		deadSearchStartX = % tagFoundX-10
		deadSearchStartY = % tagFoundY-10
		deadSearchEndX = % tagFoundX+40
		deadSearchEndY = % tagFoundY+30
		ImageSearch, deadFoundX, deadFoundY, deadSearchStartX, deadSearchStartY, deadSearchEndX, deadSearchEndY, *80 deadperson.png
		if errorlevel = 0
		{
			deadPersonName = % searchLetterS(tagFoundX, tagFoundY)
			
			Loop, 7 {
				i := A_Index
				playerVar := "player" . i
				name := %playerVar%.name
				if (deadPersonName = name) {
					%playerVar%.name := "dead"
					GuiControl, p%i%:, pmain%i%, % i . ". DEAD"
					GuiControl, searchplayer:Hide, playerTag%i%
					mmCounter--
				}
			}
		} else {
			
			playerName := ""
			searchLetterS(tagFoundX, tagFoundY)
			playerName = % l1 l2 l3 l4 l5
			
			foundPlayer := retPlayerWithName(playerName)
			if(foundPlayer.counter>=mmCounter){
				guiShowX = % tagFoundX-6+50
				guiShowY = % tagFoundY-12
				Loop, 7 {
					i := A_Index
					if (foundPlayer.name = player%i%.name) {
						GuiControl, searchplayer:Show, playerTag%i%
						GuiControl, searchplayer:Move, playerTag%i%, x%guiShowX% y%guiShowY% NoActivate
						break
					}
				}
			} else {
				Loop, 7 {
					i := A_Index
					if (foundPlayer.name = player%i%.name) {
						GuiControl, searchplayer:Hide, playerTag%i%
						break 
					}
				}
			}
		}
	} else {
		playerSearchStartY = 183
	}
	
	foundMatch := false
	ImageSearch, FoundX, FoundY, 800, 57, 1316, 300, *80 opponent.png
	if errorlevel = 0
    {	
		widthOfImg = 94
		widthOfPreImg = 156
		addPlayer(FoundX,FoundY)
		foundMatch = true
	}
	if(foundMatch=false){
		ImageSearch, FoundX, FoundY, 800, 57, 1316, 300, *80 won against.png
		if errorlevel = 0
		{	
			widthOfImg = 116
			widthOfPreImg = 80
			addPlayer(FoundX,FoundY)
			foundMatch = true
		}
	}
	if(foundMatch=false){
		ImageSearch, FoundX, FoundY, 800, 57, 1316, 300, *80 lost against.png
		if errorlevel = 0
		{	
			widthOfImg = 107
			widthOfPreImg = 80
			addPlayer(FoundX,FoundY)
		}
	}
		
	MouseGetPos, xpos, ypos 
	;GuiControl, debug:, mousecoord, mouse coord x: %xpos% y: %ypos%
	GuiControl, debug:, mmcounter, mmcounter: %mmcounter%   stageNum: %stageNum%   oldPlayerName: %oldPlayerName%
	
	guicontrol, p1:, pmain1, % "1. " player1.name
	guicontrol, p2:, pmain2, % "2. " player2.name 
	guicontrol, p3:, pmain3, % "3. " player3.name 
	guicontrol, p4:, pmain4, % "4. " player4.name 
	guicontrol, p5:, pmain5, % "5. " player5.name 
	guicontrol, p6:, pmain6, % "6. " player6.name
	guicontrol, p7:, pmain7, % "7. " player7.name 

}
Return

;move players down (p1->p2, p5->deleted)
;record first three letters, add to p1

retPlayerWithName(n) {
    Loop, 7 {
        i := A_Index
        if (n = player%i%.name)
            return player%i%
    }

    if (n = ghost.name)
        return ghost
    return
}


addPlayer(x, y){
	resetXL()
	
	searchLetter(x,y)
	
	playerName = % l1 l2 l3 l4 l5
	foundPlayer := retPlayerWithName(playerName)
	if(foundPlayer.name != oldPlayerName and foundplayer.foundAtX != x){
		if(foundPlayer.name != ""){
			Loop, 5 {
				i := A_Index
				if (x > retPlayerWithCounter(i).foundAtX) {
					advancePlayerCounter(foundPlayer, i, x, false)
					break
				}
			}
		}
	}
	Loop, 5 {
		i := A_Index
		name := retPlayerWithCounter(i).name
		GuiControl, history:, %i%, %name%
	}
	return
}

advancePlayerCounter(player, c, x, manual){
	i = 5
	while (i>=c){
		retPlayerWithCounter(i).counter++
		i--
	}
	
	if (!manual){
		if(player.counter - c < mmCounter){
			;ghost detected
			ghost.counter := c
			ghost.foundAtX := x-widthOfPreImg
			ghost.name := "ghost (" + player.name ")"
		} else {
			player.counter := c
			player.foundAtX := x-widthOfPreImg
		}
	} else {
		if(player.counter - c < mmCounter){
			;ghost detected
			ghost.counter := c
			ghost.foundAtX := retPlayerWithCounter(c+1).foundAtX+1
			if(ghost.foundAtX=""){
				ghost.foundAtX := 0
			}
			ghost.name := "ghost (" + player.name ")"
		} else { ;nonghost manual
			player.counter := c
			player.foundAtX := retPlayerWithCounter(c+1).foundAtX+1
			if(player.foundAtX=""){
				player.foundAtX := 0
			}
		}
	}
	oldPlayerName = % player.name
}

retPlayerWithCounter(x) {
    Loop, 7 {
        i := A_Index
        if (player%i%.counter = x)
            return player%i%
    }

    if (ghost.counter = x)
        return ghost
		
    return 
}


resetXL(){
	 x1 = 9999
	 x2 = 9999
	 x3 = 9999
	 x4 = 9999
	 x5 = 9999
	 l1 := ""
	 l2 := ""
	 l3 := ""
	 l4 := ""
	 l5 := ""
}

addLetter(x, l, s){
	
	;GuiControl, debug:, x, x1:%x1% x2:%x2% x3:%x3% x4:%x4% x5:%x5%
	GuiControl, debug:, l, l1:%l1% l2:%l2% l3:%l3% l4:%l4% l5:%l5% 
	
	if(%firstLetter% = true){
	 x1 = 9999
	 x2 = 9999
	 x3 = 9999
	 x4 = 9999
	 x5 = 9999
	 l1 := ""
	 l2 := ""
	 l3 := ""
	 l4 := ""
	 l5 := ""
	 firstLetter = false
	}
	
	;distance difference in letter find x coordinate that should be ignored
	if(s="small"){
		if(l="n" or l="m"){
			buffer = 4
		} else {
			buffer = 2
		}
	} else {
		if(l="n" or l="m"){
			buffer = 6
		} else {
			buffer = 3
		}
	}
	sbuffer = 1
	
	if(counter=4){
		;msgbox, %l% at %x%, %buffer%
	}
	
	if(x<=x1+buffer and x+buffer>=x1){
		if (x<=x2+sbuffer and x+sbuffer>=x2){
			x2 = %x%
			l2 = %l%
		} else {
			x1 = %x%
			l1 = %l%
		}
		return
	} else if (x<=x2+buffer and x+buffer>=x2){
		if (x<=x3+sbuffer and x+sbuffer>=x3){
			x3 = %x%
			l3 = %l%
		} else {
			x2 = %x%
			l2 = %l%
		}
		return
	} else if (x<=x3+buffer and x+buffer>=x3){
		if (x<=x3+sbuffer and x+sbuffer>=x3){
			x3 = %x%
			l3 = %l%
		} else {
			x3 = %x%
			l3 = %l%
		}
		return
	} else if (x<=x4+buffer and x+buffer>=x4){
		if (x<=x3+sbuffer and x+sbuffer>=x3){
			x3 = %x%
			l3 = %l%
		} else {
			x4 = %x%
			l4 = %l%
		}
		return
	} else if (x<=x5+buffer and x+buffer>=x5){
		if (x<=x3+sbuffer and x+sbuffer>=x3){
			x3 = %x%
			l3 = %l%
		} else {
			x5 = %x%
			l5 = %l%
		}
		return
	}
	

	if(x<x1){
	 x5 = %x4%
	 l5 = %l4%
	 x4 = %x3%
	 l4 = %l3%
	 x3 = %x2%
	 l3 = %l2%
	 x2 = %x1%
	 l2 = %l1%
	 l1 = %l%
	 x1 = %x%
	} else if (x<x2){
	 x5 = %x4%
	 l5 = %l4%
	 x4 = %x3%
	 l4 = %l3%
	 x3 = %x2%
	 l3 = %l2%
	 x2 = %x%
	 l2 = %l%
	} else if (x<x3){
	 x5 = %x4%
	 l5 = %l4%
	 x4 = %x3%
	 l4 = %l3%
	 x3 = %x%
	 l3 = %l%
	} else if (x<x4){
	 x5 = %x4%
	 l5 = %l4%
	 x4 = %x%
	 l4 = %l%
	} else if (x<x5){
	 x5 = %x%
	 l5 = %l%
	}
}

;toggles visibility of leftside debug gui
^[::
showGui := !showGui
if(showGui){
		gui, debug:hide
	} else {
		gui, debug:show
	}
return

;hides->reloads script
^]::
if(hideScript){
	Reload
}
hideScript = true
	gui, history:hide
	gui, debug:hide
	gui, player:hide
	gui, historybox:hide
	gui, p1:hide
	gui, p2:hide
	gui, p3:hide
	gui, p4:hide
	gui, p5:hide
	gui, p6:hide
	gui, p7:hide
	gui, searchplayer:hide
	
return

;initializes player names in lobby
^p::
global counter = % 1
playerSearchStartY = 183
Loop, 
{
	ImageSearch, tagFoundX, tagFoundY, 1790, playerSearchStartY, 1850, 900, *80 playerTag.png
	if errorlevel = 0
    {	;found a player tag
		;mousemove, %tagFoundX%, %tagfoundY%
		;msgbox, tag found at %tagFoundX% , %tagfoundY%

		playerSearchStartY= % tagFoundY+60
		
		playerName := ""
		searchLetterS(tagFoundX, tagFoundY)
		playerName = % l1 l2 l3 l4 l5

		
		if(counter=1){
			global player1 := new player(playerName)
			guicontrol, p1:,pmain1,  % "1. " player1.name
			counter++
		} else if (counter=2){
			global player2 := new player(playerName)
			guicontrol, p2:,pmain2, % "2. "player2.name
			counter++
		} else if (counter=3){
			global player3 := new player(playerName)
			guicontrol, p3:,pmain3,  % "3. "player3.name
			counter++
		} else if (counter=4){
			global player4 := new player(playerName)
			guicontrol, p4:,pmain4, % "4. "player4.name
			counter++
		} else if (counter=5){
			global player5 := new player(playerName)
			guicontrol, p5:,pmain5,  % "5. "player5.name
			counter++
		} else if (counter=6){
			global player6 := new player(playerName)
			guicontrol, p6:,pmain6,  % "6. "player6.name
			counter++
		} else if (counter=7){
			global player7 := new player(playerName)
			guicontrol, p7:,pmain7,  % "7. "player7.name
			counter++
			global ghost = new player("ghost")
		} 
	} else {
		counter = % 1
		return
	}
}

WM_LBUTTONDOWN()
{
	PostMessage, 0xA1, 2
	sleep, 0
	MouseGetPos, mouseX, mouseY, mouseWin,
	;msgbox, %mouseX%, %mouseY%, %mouseWin%, h1x:%history1X%, h1y:%history1Y%, h1w:%history1W%, h1H:%history1H%
	
	yBuffer = 10
	if(mouseX>history1X and mouseX<(history1X+history1W) and (mouseY+yBuffer)>history1Y and mouseY<(history1Y+history1H+yBuffer)){
		addPlayerManual(mouseWin, 1)
	} else if(mouseX>history2X and mouseX<(history2X+history2W) and mouseY+yBuffer>history1Y and mouseY<(history2Y+history2H+yBuffer)){
		addPlayerManual(mouseWin, 2)
	} else if(mouseX>history3X and mouseX<(history3X+history3W) and mouseY+yBuffer>history1Y and mouseY<(history3Y+history3H+yBuffer)){
		addPlayerManual(mouseWin, 3)
	} else if(mouseX>history4X and mouseX<(history4X+history4W) and mouseY+yBuffer>history1Y and mouseY<(history4Y+history4H+yBuffer)){
		addPlayerManual(mouseWin, 4)
	} else if(mouseX>history5X and mouseX<(history5X+history5W) and mouseY+yBuffer>history1Y and mouseY<(history5Y+history5H+yBuffer)){
		addPlayerManual(mouseWin, 5)
	} 
}

addPlayerManual(window, draggedOn) {
    player := checkDraggedPlayer(window)
    
    ; Advance player counter directly with draggedOn
    if (draggedOn >= 1 && draggedOn <= 5) {
        advancePlayerCounter(player, draggedOn, "", true)
    }
    
    ; Map players to their y positions
    pyPositions := [py1, py2, py3, py4, py5, py6, py7]
    
    ; Find player index (1-based) by checking against player variables
    players := [player1, player2, player3, player4, player5, player6, player7]
    playerIndex := 0
    Loop, % players.MaxIndex() {
        if (player = players[A_Index]) {
            playerIndex := A_Index
            break
        }
    }
    
    if (playerIndex > 0) {
        WinMove, ahk_id %window%,, %px%, % pyPositions[playerIndex]
    }
    
    ; Update GUI controls with player names
    Loop, 5 {
        name := retPlayerWithCounter(A_Index).name
        GuiControl, history:, %A_Index%, %name%
    }
}

checkDraggedPlayer(window){
	if(window = p1UID){
		return player1
	} else if (window = p2UID){
		return player2
	} else if (window = p3UID){
		return player3
	} else if (window = p4UID){
		return player4
	} else if (window = p5UID){
		return player5
	} else if (window = p6UID){
		return player6
	} else if (window = p7UID){
		return player7
	}
}
	
checkStageNum(){
	xStart = 754
	yStart = 8
	xEnd = 790
	yEnd = 30

	Loop, 6 {
		num := A_Index + 1
		file := "b" . num . ".png"
		ImageSearch, numFoundX, numFoundY, xStart, yStart, xEnd, yEnd, *80, %file%
		if (ErrorLevel = 0) {
			newStageNum := num
			break
		}
	}

}

searchLetter(x, y){
	firstLetter = true
	letterSearchHeight = 45
	letterSearchNegativeY = 15
	letterSearchStartX = % x+widthOfImg
	letterSearchWidth = 200
	shadeVariation = % 100
	size = % "big"
	
	letters := ["u", "a", "b", "c", "e", "f", "g", "k", "i", "j", "o", "p", "n", "h", "q", "s", "t", "v", "w", "x", "y", "z", "d", "m", "U", "L", "A", "B", "C", "E", "F", "G", "J", "K", "O", "R", "P", "Y", "N", "H", "Q", "S", "T", "V", "W", "X", "Y", "Z", "D", "M", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    for index, letter in letters {
        ascVal := Asc(letter)
        if (ascVal >= 65 && ascVal <= 90)  ; ASCII A-Z uppercase range
            file := "c" . letter . ".png"
        else
            file := letter . ".png"

        ImageSearch, LetterFoundX, LetterFoundY,  letterSearchStartX, y-letterSearchNegativeY, letterSearchStartX+letterSearchWidth, y+letterSearchHeight, *%shadeVariation% %file%
		if (ErrorLevel = 0) {
            addLetter(letterFoundX, letter, size)
        }
    }
	
}

searchLetterS(x, y){
	firstLetter = true
	nameSearchLeft = 200
	nameSearchDown = 30
	shadeVariation = 90
	shadeVariationLoose = 110
	size = % "small"
	
	letters := ["u", "a", "b", "c", "e", "f", "g", "k", "i", "j", "o", "p", "n", "h", "q", "s", "t", "v", "w", "x", "y", "z", "d", "m", "U", "L", "A", "B", "C", "E", "F", "G", "J", "K", "O", "R", "P", "Y", "N", "H", "Q", "S", "T", "V", "W", "X", "Y", "Z", "D", "M", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    for index, letter in letters {
        ascVal := Asc(letter)
        if (ascVal >= 65 && ascVal <= 90)  ; ASCII A-Z uppercase range
            file := "sc" . letter . ".png"
        else
            file := "s" . letter . ".png"
        
        ImageSearch, letterFoundX, letterFoundY, x - nameSearchLeft, y, x, y + nameSearchDown, *%shadeVariation% *TransBlack %file%
        if (ErrorLevel = 0) {
            addLetter(letterFoundX, letter, size)
        }
    }

	return % l1 l2 l3 l4 l5
}