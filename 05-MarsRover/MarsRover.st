!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:20:25'!
test01roverIsAtCorrectPositionAndOrientation
	| rover north |
	north := North new.
	rover := MarsRover at: 1@1 facing: north.
	
	self assert: (rover isAt: 1@1 facing: north).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:21:46'!
test02roverMovesForwardWestCorrectly
	| rover west |
	west := West new.
	rover := MarsRover at: 1@2 facing: west.
	
	rover executeCommands: 'f'.
	
	self assert: (rover isAt: 0@2 facing: west).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:22:41'!
test03roverMovesForwardEastCorrectly
	| rover east |
	east := East new.
	rover := MarsRover at: 1@2 facing: east.
	
	rover executeCommands: 'f'.
	
	self assert: (rover isAt: 2@2 facing: east).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:26:42'!
test04roverMovesForwardNorthCorrectly
	| rover north |
	north := North new.
	rover := MarsRover at: 1@2 facing: north.
	
	rover executeCommands: 'f'.
	
	self assert: (rover isAt: 1@3 facing: north).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:32:40'!
test05roverMovesForwardSouthCorrectly
	| rover south |
	south := South new.
	rover := MarsRover at: 1@2 facing: south.
	
	rover executeCommands: 'f'.
	
	self assert: (rover isAt: 1@1 facing: south).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:35:18'!
test06roverMovesBackwardsWestCorrectly
	| rover west |
	west := West new.
	rover := MarsRover at: 3@5 facing: west.
	
	rover executeCommands: 'b'.
	
	self assert: (rover isAt: 4@5 facing: west).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:41:03'!
test07roverMovesBackwardsEastCorrectly
	| rover cardinalPosition |
	cardinalPosition := East new.
	rover := MarsRover at: 3@5 facing: cardinalPosition.
	
	rover executeCommands: 'b'.
	
	self assert: (rover isAt: 2@5 facing: cardinalPosition).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:41:58'!
test08roverMovesBackwardsNorthCorrectly
	| rover cardinalPosition |
	cardinalPosition := North new.
	rover := MarsRover at: 3@5 facing: cardinalPosition.
	
	rover executeCommands: 'b'.
	
	self assert: (rover isAt: 3@4 facing: cardinalPosition).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSS 10/5/2022 20:42:47'!
test09roverMovesBackwardsSouthCorrectly
	| rover cardinalPosition |
	cardinalPosition := South new.
	rover := MarsRover at: 3@5 facing: cardinalPosition.
	
	rover executeCommands: 'b'.
	
	self assert: (rover isAt: 3@6 facing: cardinalPosition).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 20:48:55'!
test10roverTurnsLeftFacingWestCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := West new.
	finalCardinalDirection := South new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'l'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 20:55:21'!
test11roverTurnsLeftFacingEastCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := East new.
	finalCardinalDirection := North new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'l'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 20:56:29'!
test12roverTurnsLeftFacingNorthCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := North new.
	finalCardinalDirection := West new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'l'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 20:57:23'!
test13roverTurnsLeftFacingSouthCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := South new.
	finalCardinalDirection := East new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'l'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 20:58:40'!
test14roverTurnsRightFacingSouthCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := South new.
	finalCardinalDirection := West new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'r'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:00:19'!
test15roverTurnsRightFacingNorthCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := North new.
	finalCardinalDirection := East new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'r'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:00:56'!
test16roverTurnsRightFacingEastCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := East new.
	finalCardinalDirection := South new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'r'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:01:26'!
test17roverTurnsRightFacingWestCorrectly
	| rover initialCardinalDirection finalCardinalDirection |
	initialCardinalDirection := West new.
	finalCardinalDirection := North new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'r'.
	
	self assert: (rover isAt: 3@5 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:04:26'!
test18invalidCommandDoesNothing
	| rover initialCardinalDirection  |
	initialCardinalDirection := West new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: '{'.
	
	self assert: (rover isAt: 3@5 facing: initialCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:14:50'!
test19multipleValidCommandsWork
	| rover initialCardinalDirection finalCardinalDirection  |
	
	initialCardinalDirection := West new.
	finalCardinalDirection := North new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'fflbrr'.
	
	self assert: (rover isAt: 1@6 facing: finalCardinalDirection).! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 21:15:52'!
test20invalidCommandStopsExecution
	| rover initialCardinalDirection finalCardinalDirection  |
	
	initialCardinalDirection := West new.
	finalCardinalDirection := South new.
	
	rover := MarsRover at: 3@5 facing: initialCardinalDirection.
	
	rover executeCommands: 'ffl?brr'.
	
	self assert: (rover isAt: 1@5 facing: finalCardinalDirection).! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'turn' stamp: 'grm 10/5/2022 20:53:45'!
turnLeft
	self subclassResponsibility .! !

!CardinalDirection methodsFor: 'turn' stamp: 'grm 10/5/2022 20:53:51'!
turnRight
	self subclassResponsibility .! !


!CardinalDirection methodsFor: 'move' stamp: 'grm 10/5/2022 20:53:38'!
moveBackward
	self subclassResponsibility .! !

!CardinalDirection methodsFor: 'move' stamp: 'MSS 10/5/2022 20:27:01'!
moveForward
	self subclassResponsibility .! !


!CardinalDirection methodsFor: 'comparing' stamp: 'grm 10/5/2022 20:54:35'!
= aCardinalDirection
	^self class = aCardinalDirection class.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'move' stamp: 'MSS 10/5/2022 20:41:31'!
moveBackward: aMarsRover 
	aMarsRover  moveWest.! !

!East methodsFor: 'move' stamp: 'MSS 10/5/2022 20:25:30'!
moveForward: aMarsRover 
	aMarsRover moveEast.! !


!East methodsFor: 'turn' stamp: 'grm 10/5/2022 20:55:52'!
turnLeft: aMarsRover 
	aMarsRover turnNorth.! !

!East methodsFor: 'turn' stamp: 'grm 10/5/2022 21:01:09'!
turnRight: aMarsRover 
	aMarsRover turnSouth.! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'move' stamp: 'MSS 10/5/2022 20:42:18'!
moveBackward: aMarsRover 
	aMarsRover moveSouth .! !

!North methodsFor: 'move' stamp: 'MSS 10/5/2022 20:27:47'!
moveForward: aMarsRover 
	aMarsRover moveNorth.! !


!North methodsFor: 'turn' stamp: 'grm 10/5/2022 20:56:43'!
turnLeft: aMarsRover 
	aMarsRover turnWest.! !

!North methodsFor: 'turn' stamp: 'grm 10/5/2022 21:00:37'!
turnRight: aMarsRover 
	aMarsRover turnEast .! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'move' stamp: 'MSS 10/5/2022 20:43:22'!
moveBackward: aMarsRover 
	aMarsRover moveNorth.! !

!South methodsFor: 'move' stamp: 'MSS 10/5/2022 20:33:03'!
moveForward: aMarsRover 
	aMarsRover moveSouth.! !


!South methodsFor: 'turn' stamp: 'grm 10/5/2022 20:57:51'!
turnLeft: aMarsRover 
	aMarsRover turnEast.! !

!South methodsFor: 'turn' stamp: 'grm 10/5/2022 20:59:44'!
turnRight: aMarsRover 
	aMarsRover turnWest.! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'move' stamp: 'MSS 10/5/2022 20:37:17'!
moveBackward: aMarsRover 
	aMarsRover moveEast.! !

!West methodsFor: 'move' stamp: 'MSS 10/5/2022 20:24:28'!
moveForward: aMarsRover 
	aMarsRover moveWest.! !


!West methodsFor: 'turn' stamp: 'grm 10/5/2022 20:50:32'!
turnLeft: aMarsRover 
	aMarsRover turnSouth.! !

!West methodsFor: 'turn' stamp: 'grm 10/5/2022 21:01:42'!
turnRight: aMarsRover 
	aMarsRover turnNorth.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'controls' stamp: 'MSSW 10/5/2022 21:34:26'!
executeCommands: aString 
	aString do: [:char | [self executeSingleCommand: char] on: Error do: [^self] ].
	
	! !

!MarsRover methodsFor: 'controls' stamp: 'MSSW 10/5/2022 21:32:11'!
executeSingleCommand: aCommand 
	(aCommand = $f) ifTrue:[^direction moveForward: self].
	(aCommand = $b) ifTrue:[^direction moveBackward: self].
	(aCommand = $l) ifTrue: [^direction turnLeft: self].
	(aCommand = $r) ifTrue: [^direction turnRight: self].
	self error: self class invalidCommandError.! !

!MarsRover methodsFor: 'controls' stamp: 'MSS 10/5/2022 20:25:51'!
moveEast
	position := position x + 1@position y.! !

!MarsRover methodsFor: 'controls' stamp: 'MSS 10/5/2022 20:30:22'!
moveNorth
	position := position x@(position y+1).! !

!MarsRover methodsFor: 'controls' stamp: 'MSS 10/5/2022 20:33:47'!
moveSouth
	position := position x @ (position y - 1) .! !

!MarsRover methodsFor: 'controls' stamp: 'MSS 10/5/2022 20:24:52'!
moveWest
	position := position x - 1@position y.
	! !

!MarsRover methodsFor: 'controls' stamp: 'grm 10/5/2022 20:58:08'!
turnEast
	direction := East new.! !

!MarsRover methodsFor: 'controls' stamp: 'grm 10/5/2022 20:56:10'!
turnNorth
	direction := North new.! !

!MarsRover methodsFor: 'controls' stamp: 'grm 10/5/2022 20:50:50'!
turnSouth
	direction := South new.! !

!MarsRover methodsFor: 'controls' stamp: 'grm 10/5/2022 20:57:01'!
turnWest
	direction := West new.! !


!MarsRover methodsFor: 'initialization' stamp: 'grm 10/3/2022 21:40:04'!
initializeAtPosition: aPosition facing: aCardinalDirection
	position := aPosition.
	direction := aCardinalDirection.! !


!MarsRover methodsFor: 'evaluating' stamp: 'grm 10/3/2022 21:41:27'!
isAt: aPosition facing: aCardinalDirection
	^(position = aPosition) and: [direction = aCardinalDirection].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:40:04'!
at: aPosition facing: aCardinalDirection
	^MarsRover new initializeAtPosition: aPosition facing: aCardinalDirection.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'MSSW 10/5/2022 21:33:17'!
invalidCommandError
	^'Execution interruption due to invalid command'.! !
