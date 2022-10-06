!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north1 rover1 south1 east1 west1 rover2 rover1at1 rover1at2 rover1at1n rover1at2w testGeneric'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:20:34'!
setUp
! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:20:50'!
test01roverIsAtCorrectPositionAndOrientation
	self testGenericMethod value: West new value:'' value:1@2 value:West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:47:40'!
test02roverMovesForwardWestCorrectly
	
	self testGenericMethod value: West new value:'f' value:0@2 value:West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:52:03'!
test03roverMovesForwardEastCorrectly
	
	self testGenericMethod value: East new value:'f' value:2@2 value:East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:52:47'!
test04roverMovesForwardNorthCorrectly
	
	self testGenericMethod value: North new value:'f' value:1@3 value:North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:53:41'!
test05roverMovesForwardSouthCorrectly
	
	self testGenericMethod value: South new value:'f' value:1@1 value:South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:55:53'!
test06roverMovesBackwardsWestCorrectly
	
	self testGenericMethod value: West new value:'b' value:2@2 value:West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:57:13'!
test07roverMovesBackwardsEastCorrectly
	self testGenericMethod value: East new value:'b' value:0@2 value:East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 22:58:52'!
test08roverMovesBackwardsNorthCorrectly
	
	self testGenericMethod value: North new value:'b' value:1@1 value:North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:01:47'!
test09roverMovesBackwardsSouthCorrectly
	
	self testGenericMethod value: South new value:'b' value:1@3 value:South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:04:16'!
test10roverTurnsLeftFacingWestCorrectly
	
	
	self testGenericMethod value: West new value:'l' value:1@2 value:South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:08:37'!
test11roverTurnsLeftFacingEastCorrectly
	
	self testGenericMethod value: East new value:'l' value:1@2 value:North new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:10:29'!
test12roverTurnsLeftFacingNorthCorrectly
	
	self testGenericMethod value: North new value:'l' value:1@2 value:West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:10:57'!
test13roverTurnsLeftFacingSouthCorrectly
	
	self testGenericMethod value: South new value:'l' value:1@2 value:East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:11:27'!
test14roverTurnsRightFacingSouthCorrectly
	
	self testGenericMethod value: South new value:'r' value:1@2 value:West new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:11:53'!
test15roverTurnsRightFacingNorthCorrectly
	
	self testGenericMethod value: North new value:'r' value:1@2 value:East new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:12:36'!
test16roverTurnsRightFacingEastCorrectly

	self testGenericMethod value: East new value:'r' value:1@2 value:South new.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:14:06'!
test17roverTurnsRightFacingWestCorrectly
	
	self testGenericMethod value: West new value:'r' value:1@2 value:North new! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:14:47'!
test18invalidCommandDoesNothing
	self testGenericMethod value: West new value:'{' value:1@2 value:West new! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:18:11'!
test19multipleValidCommandsWork
	
	self testGenericMethod value: West new value:'fflbrr' value:(-1)@3 value:North new! !

!MarsRoverTest methodsFor: 'test' stamp: 'MSSW 10/5/2022 23:19:10'!
test20invalidCommandStopsExecution
	self testGenericMethod value: West new value:'ffl?brr' value:(-1)@2 value:South new! !


!MarsRoverTest methodsFor: 'genericTest' stamp: 'MSSW 10/5/2022 23:03:58'!
testGenericMethod
	^ [:initialOrientation :commands :finalPosition :finalOrientation | | rover |

	rover := MarsRover at: 1@2 facing: initialOrientation.
	
	rover executeCommands: commands.
	
	self assert: (rover isAt: finalPosition facing: finalOrientation).
	]! !


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
