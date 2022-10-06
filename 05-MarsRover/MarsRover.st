!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north1 rover1 south1 east1 west1 rover2 rover1at1 rover1at2 rover1at1n rover1at2w testGeneric'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/5/2022 23:59:23'!
test01roverIsAtCorrectPositionAndOrientation
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: ''
		endsAtPosition: 1@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:00:57'!
test02roverMovesForwardWestCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'f'
		endsAtPosition: 0@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:01:36'!
test03roverMovesForwardEastCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: East new
		executes: 'f'
		endsAtPosition: 2@2
		endsFacingDirection: East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:02:45'!
test04roverMovesForwardNorthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: North new
		executes: 'f'
		endsAtPosition: 1@3
		endsFacingDirection: North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:03:09'!
test05roverMovesForwardSouthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: South new
		executes: 'f'
		endsAtPosition: 1@1
		endsFacingDirection: South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:03:40'!
test06roverMovesBackwardsWestCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'b'
		endsAtPosition: 2@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:05:10'!
test07roverMovesBackwardsEastCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: East new
		executes: 'b'
		endsAtPosition: 0@2
		endsFacingDirection: East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:05:38'!
test08roverMovesBackwardsNorthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: North new
		executes: 'b'
		endsAtPosition: 1@1
		endsFacingDirection: North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:06:36'!
test09roverMovesBackwardsSouthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: South new
		executes: 'b'
		endsAtPosition: 1@3
		endsFacingDirection: South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:07:20'!
test10roverTurnsLeftFacingWestCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'l'
		endsAtPosition: 1@2
		endsFacingDirection: South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:07:59'!
test11roverTurnsLeftFacingEastCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: East new
		executes: 'l'
		endsAtPosition: 1@2
		endsFacingDirection: North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:08:33'!
test12roverTurnsLeftFacingNorthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: North new
		executes: 'l'
		endsAtPosition: 1@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:08:49'!
test13roverTurnsLeftFacingSouthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: South new
		executes: 'l'
		endsAtPosition: 1@2
		endsFacingDirection: East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:09:23'!
test14roverTurnsRightFacingSouthCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: South new
		executes: 'r'
		endsAtPosition: 1@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:09:50'!
test15roverTurnsRightFacingNorthCorrectly
		self testRoverStartsAtPosition: 1@2
		startsFacingDirection: North new
		executes: 'r'
		endsAtPosition: 1@2
		endsFacingDirection: East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:10:12'!
test16roverTurnsRightFacingEastCorrectly
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: East new
		executes: 'r'
		endsAtPosition: 1@2
		endsFacingDirection: South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:10:26'!
test17roverTurnsRightFacingWestCorrectly
		self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'r'
		endsAtPosition: 1@2
		endsFacingDirection: North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:10:40'!
test18invalidCommandDoesNothing
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: '{'
		endsAtPosition: 1@2
		endsFacingDirection: West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:11:08'!
test19multipleValidCommandsWork
		self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'fflbrr'
		endsAtPosition: (-1)@3
		endsFacingDirection: North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'grm 10/6/2022 00:11:56'!
test20invalidCommandStopsExecution
	self testRoverStartsAtPosition: 1@2
		startsFacingDirection: West new
		executes: 'ffl?brr'
		endsAtPosition: (-1)@2
		endsFacingDirection: South new.! !


!MarsRoverTest methodsFor: 'internal' stamp: 'grm 10/6/2022 00:04:23'!
testRoverStartsAtPosition: anInitialPosition startsFacingDirection: anInitialCardinalDirection executes: aCommandsString endsAtPosition: aFinalPositiion endsFacingDirection: aFinalCardinalDirection
	| rover |
	
	rover := MarsRover at: anInitialPosition facing: anInitialCardinalDirection.
	
	rover executeCommands: aCommandsString.
	
	self assert: (rover isAt: aFinalPositiion facing: aFinalCardinalDirection).! !


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

!MarsRover methodsFor: 'controls' stamp: 'grm 10/6/2022 00:12:56'!
executeCommands: aCommandsString 
	aCommandsString do: [:command | [self executeSingleCommand: command] on: Error do: [^self] ].
	
	! !


!MarsRover methodsFor: 'initialization' stamp: 'grm 10/3/2022 21:40:04'!
initializeAtPosition: aPosition facing: aCardinalDirection
	position := aPosition.
	direction := aCardinalDirection.! !


!MarsRover methodsFor: 'evaluating' stamp: 'grm 10/3/2022 21:41:27'!
isAt: aPosition facing: aCardinalDirection
	^(position = aPosition) and: [direction = aCardinalDirection].! !


!MarsRover methodsFor: 'privateControls' stamp: 'MSSW 10/5/2022 21:32:11'!
executeSingleCommand: aCommand 
	(aCommand = $f) ifTrue:[^direction moveForward: self].
	(aCommand = $b) ifTrue:[^direction moveBackward: self].
	(aCommand = $l) ifTrue: [^direction turnLeft: self].
	(aCommand = $r) ifTrue: [^direction turnRight: self].
	self error: self class invalidCommandError.! !

!MarsRover methodsFor: 'privateControls' stamp: 'MSS 10/5/2022 20:25:51'!
moveEast
	position := position x + 1@position y.! !

!MarsRover methodsFor: 'privateControls' stamp: 'MSS 10/5/2022 20:30:22'!
moveNorth
	position := position x@(position y+1).! !

!MarsRover methodsFor: 'privateControls' stamp: 'MSS 10/5/2022 20:33:47'!
moveSouth
	position := position x @ (position y - 1) .! !

!MarsRover methodsFor: 'privateControls' stamp: 'MSS 10/5/2022 20:24:52'!
moveWest
	position := position x - 1@position y.
	! !

!MarsRover methodsFor: 'privateControls' stamp: 'grm 10/5/2022 20:58:08'!
turnEast
	direction := East new.! !

!MarsRover methodsFor: 'privateControls' stamp: 'grm 10/5/2022 20:56:10'!
turnNorth
	direction := North new.! !

!MarsRover methodsFor: 'privateControls' stamp: 'grm 10/5/2022 20:50:50'!
turnSouth
	direction := South new.! !

!MarsRover methodsFor: 'privateControls' stamp: 'grm 10/5/2022 20:57:01'!
turnWest
	direction := West new.! !

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
