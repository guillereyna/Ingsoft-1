!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:42:44'!
test01roverIsAtCorrectPositionAndOrientation
	| rover |
	
	rover := MarsRover at: 1@1 facing: #N.
	
	self assert: (rover isAt: 1@1 facing: #N).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 22:01:43'!
test02roverMovesForwardWestCorrectly
	| rover |
	
	rover := MarsRover at: 1@2 facing: #W.
	
	rover executeCommands: 'f'.
	
	self assert: (rover isAt: 0@2 facing: #W).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:40:04'!
initializeAtPosition: aPosition facing: aCardinalDirection
	position := aPosition.
	direction := aCardinalDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:41:27'!
isAt: aPosition facing: aCardinalDirection
	^(position = aPosition) and: [direction = aCardinalDirection].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:52:46'!
moveForward
	position := 0@2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'grm 10/3/2022 21:40:04'!
at: aPosition facing: aCardinalDirection
	^MarsRover new initializeAtPosition: aPosition facing: aCardinalDirection.! !
