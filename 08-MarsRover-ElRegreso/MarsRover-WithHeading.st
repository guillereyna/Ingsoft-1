!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:39:17'!
test01loggerHasEmptyPositionLogAfterEmptyCommands
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: ''.
	
	self assert: OrderedCollection new equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:10:51'!
test02loggerHasUpdatedPositionAfterMovingForward
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'f'.
	
	self assert: (OrderedCollection with: '0,1') equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:20:33'!
test03loggerHasUpdatedPositionAfterMovingBackward
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'b'.
	
	self assert: (OrderedCollection with: '0,-1') equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:28:42'!
test04loggerLogsMultiplesMoveForwardAndBackwards
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'bbff'.
	
	self assert: (OrderedCollection with: '0,-1'
									with: '0,-2'
									with: '0,-1'
									with: '0,0') equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:29:30'!
test05loggerDoesNotLogPositionAfterTurningLeft
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'l'.
	
	self assert: (OrderedCollection new) equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:29:47'!
test06loggerDoesNotLogPositionAfterTurningRight
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'r'.
	
	self assert: (OrderedCollection new) equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:38:11'!
test07loggerLogsPositionProcessingForwardLeftBackwardRightForward
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'flbrf'.
	
	self assert: (OrderedCollection with: '0,1'
									with: '1,1'
									with: '1,2') equals: logger positionLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:39:08'!
test08loggerHasEmptyHeadingLogAfterEmptyCommands
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: ''.
	
	self assert: (OrderedCollection new) equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:42:53'!
test09loggerHasHeadingWestAfterTurningLeftNorth
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:46:01'!
test10loggerHasHeadingEastAfterTurningLeftNorth
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:50:53'!
test11loggerLogsMultipleHeadingsAfterTurningRightRightLeftLeftFromNorth
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'rrll'.
	
	self assert: (OrderedCollection with: 'East'
									with: 'South'
									with: 'East'
									with: 'North') equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:59:23'!
test12loggerDoesNotLogHeadingAfterMovingForward
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'f'.
	
	self assert: (OrderedCollection new) equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 21:59:30'!
test13loggerDoesNotLogHeadingAfterMovingForward
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'b'.
	
	self assert: (OrderedCollection new) equals: logger headingLog.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'grm 10/24/2022 22:00:57'!
test13loggerLogsHeadingProcessingLeftBackwardRightForwardRight
	| rover logger |
	rover _ MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger _ MarsRoverLogger attachedTo: rover.
	
	rover process: 'lbrfr'.
	
	self assert: (OrderedCollection with: 'West'
									with: 'North'
									with: 'East') equals: logger headingLog.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'grm 10/24/2022 21:44:28'!
rotateLeft
	
	head rotateLeft.
	logger ifNotNil: [logger logHeading: head]! !

!MarsRover methodsFor: 'heading' stamp: 'grm 10/24/2022 21:46:21'!
rotateRight
	
	head rotateRight.
	logger ifNotNil: [logger logHeading: head]! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'grm 10/24/2022 21:19:18'!
moveBackward
	
	head moveBackward.
	logger ifNotNil: [logger logPosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'grm 10/24/2022 21:18:43'!
moveForward
	
	head moveForward.
	logger ifNotNil: [logger logPosition: position]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:05:28'!
attachLogger: aMarsRoverLogger
	
	logger _ aMarsRoverLogger .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:48:10'!
asHeadingString
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:48:21'!
asHeadingString
	^'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:48:32'!
asHeadingString
	^'North' ! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:48:43'!
asHeadingString
	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:48:52'!
asHeadingString
	^'West'! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'rover headingLog positionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:40:11'!
headingLog
	^headingLog copy.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:40:47'!
initializeAttachedTo: aMarsRover
	rover _ aMarsRover.
	positionLog _ OrderedCollection new.
	headingLog _ OrderedCollection new.
	rover attachLogger: self.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:47:28'!
logHeading: aHeading
	headingLog add: aHeading asHeadingString.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:41:09'!
logPosition: aPosition
	positionLog add: (aPosition x asString , ',' , aPosition y asString)! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:40:22'!
positionLog
	^positionLog copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'as yet unclassified' stamp: 'grm 10/24/2022 21:03:41'!
attachedTo: aMarsRover
	^MarsRoverLogger new initializeAttachedTo: aMarsRover.! !
