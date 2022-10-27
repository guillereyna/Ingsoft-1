!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test01positionLoggerHasStartingPositionLoggedAfterEmptyCommands
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: ''.
	
	self assert: (OrderedCollection with: '0,0') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test02positionLoggerHasUpdatedPositionAfterMovingForward
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'f'.
	
	self assert: (OrderedCollection with: '0,0' with: '0,1') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test03positionLoggerHasUpdatedPositionAfterMovingBackward
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'b'.
	
	self assert: (OrderedCollection with: '0,0' with: '0,-1') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test04positionLoggerLogsMultiplesMoveForwardAndBackwards
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'bbff'.
	
	self assert: (OrderedCollection with: '0,0'
								with: '0,-1'
								with: '0,-2'
								with: '0,-1'
								with: '0,0') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test05headingLoggerHasStartingHeadingAfterEmptyCommands
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: ''.
	
	self assert: (OrderedCollection with: 'North') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test06headingLoggerHasHeadingWestAfterTurningLeftNorth
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: 'l'.
	
	self assert: (OrderedCollection with: 'North' with: 'West') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test07headingLoggerHasHeadingEastAfterTurningLeftNorth
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: 'r'.
	
	self assert: (OrderedCollection with: 'North' with: 'East') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test08headingLoggerLogsMultipleHeadingsAfterTurningRightRightLeftLeftFromNorth
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: 'rrll'.
	
	self assert: (OrderedCollection with: 'North'
								with: 'East'
								with: 'South'
								with: 'East'
								with: 'North') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test09positionLoggerKnowsCurrentPositionAfterMovingOnce
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'lf'.
	
	self assert: '-1,0' equals: logger currentPosition.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test10positionLoggerKnowsCurrentPositionAfterMovingManyTimes
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'lfffrbrf'.
	
	self assert: '-2,-1' equals: logger currentPosition.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 20:59:50'!
test11positionLoggerDoesNotLogPositionRepeatedlyIfItDoesNotChange
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self positionLoggerOn: rover.
	
	rover process: 'lllll'.
	
	self assert: (OrderedCollection with: '0,0') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test12headingLoggerKnowsCurrentHeadingAfterMovingOnce
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: 'lf'.
	
	self assert: 'West' equals: logger currentHeading.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:11'!
test13headingLoggerKnowsCurrentHeadingAfterMovingManyTimes
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self headingLoggerOn: rover.
	
	rover process: 'lfffrbrf'.
	
	self assert: 'East' equals: logger currentHeading.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:36'!
test14loggerControllerHasStartingHeadAndPosAfterEmptyCommands
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self loggerControllerOn: rover.
	
	rover process: ''.
	
	self assert: (OrderedCollection with: '0,0 North') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:36'!
test15loggerControllerLogsMultipleCommands
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self loggerControllerOn: rover.
	
	rover process: 'flbbl'.
	
	self assert: (OrderedCollection with: '0,0 North'
								with: '0,1 North'
								with: '0,1 West'
								with: '1,1 West'
								with: '2,1 West'
								with: '2,1 South') equals: logger printLogs.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:36'!
test16loggerControllerKnowsCurrentHeading
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self loggerControllerOn: rover.
	
	rover process: 'flbbl'.
	
	self assert: 'South' equals: logger currentHeading.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:36'!
test17loggerControllerKnowsCurrentPosition
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self loggerControllerOn: rover.
	
	rover process: 'flbbl'.
	
	self assert: '2,1' equals: logger currentPosition.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'guille 10/26/2022 21:00:36'!
test18loggerControllerKnowsCurrentPositionAndHeading
	| rover logger |
	rover _ self roverAtOriginHeadingNorth.
	logger _ self loggerControllerOn: rover.
	
	rover process: 'flbbl'.
	
	self assert: '2,1 South' equals: logger currentPositionAndHeading .! !


!MarsRoverLoggerTest methodsFor: 'internal' stamp: 'guille 10/26/2022 21:00:11'!
headingLoggerOn: rover

	^ MarsRoverHeadingLogger attachedTo: rover! !

!MarsRoverLoggerTest methodsFor: 'internal' stamp: 'guille 10/26/2022 21:00:36'!
loggerControllerOn: rover

	^ MarsRoverLoggerController attachedTo: rover! !

!MarsRoverLoggerTest methodsFor: 'internal' stamp: 'guille 10/26/2022 20:59:50'!
positionLoggerOn: rover

	^ MarsRoverPositionLogger attachedTo: rover! !

!MarsRoverLoggerTest methodsFor: 'internal' stamp: 'guille 10/26/2022 20:59:05'!
roverAtOriginHeadingNorth

	^ MarsRover at: 0@0 heading: MarsRoverHeadingNorth! !


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
	instanceVariableNames: 'position head logger loggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'guille 10/26/2022 19:01:19'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	loggers := OrderedCollection new.! !


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

!MarsRover methodsFor: 'heading' stamp: 'guille 10/26/2022 21:12:41'!
rotateLeft
	
	head rotateLeft.
	self updateLoggers.! !

!MarsRover methodsFor: 'heading' stamp: 'guille 10/26/2022 21:12:41'!
rotateRight
	
	head rotateRight.
	self updateLoggers.! !


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


!MarsRover methodsFor: 'moving' stamp: 'guille 10/26/2022 21:12:41'!
moveBackward
	
	head moveBackward.
	self updateLoggers.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'guille 10/26/2022 21:12:41'!
moveForward
	
	head moveForward.
	self updateLoggers.! !

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


!MarsRover methodsFor: 'logging' stamp: 'guille 10/26/2022 21:12:41'!
addLogger: aLoggerClosure

	loggers add: aLoggerClosure.
	self updateLoggers.! !

!MarsRover methodsFor: 'logging' stamp: 'guille 10/26/2022 21:12:41'!
updateLoggers
	loggers do: [:aLogger | aLogger value: position copy value: head copy].! !

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
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'guille 10/26/2022 20:12:03'!
initializeAttachedTo: aMarsRover
	self subclassResponsibility ! !


!MarsRoverLogger methodsFor: 'print' stamp: 'guille 10/26/2022 21:39:03'!
printLogs
	^log copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'guille 10/26/2022 18:51:12'!
attachedTo: aMarsRover
	^self new initializeAttachedTo: aMarsRover.! !


!classDefinition: #MarsRoverHeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverHeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLogger methodsFor: 'current state' stamp: 'guille 10/26/2022 20:09:16'!
currentHeading
	log isEmpty ifTrue: [^nil].
	^log last! !


!MarsRoverHeadingLogger methodsFor: 'initialization' stamp: 'guille 10/26/2022 20:29:53'!
initializeAttachedTo: aMarsRover
	log _ OrderedCollection new.

	aMarsRover addLogger: [:aPosition :aHeading | self log: aHeading].! !


!MarsRoverHeadingLogger methodsFor: 'logging' stamp: 'guille 10/26/2022 19:09:50'!
log: aHeading
	log add: aHeading asHeadingString ! !


!classDefinition: #MarsRoverLoggerController category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerController
	instanceVariableNames: 'positionLogger headingLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerController methodsFor: 'current state' stamp: 'guille 10/26/2022 20:51:00'!
currentHeading
	^headingLogger currentHeading! !

!MarsRoverLoggerController methodsFor: 'current state' stamp: 'guille 10/26/2022 20:50:50'!
currentPosition
	^positionLogger currentPosition! !

!MarsRoverLoggerController methodsFor: 'current state' stamp: 'guille 10/26/2022 20:51:28'!
currentPositionAndHeading
	^self currentPosition, ' ', self currentHeading! !


!MarsRoverLoggerController methodsFor: 'initialization' stamp: 'guille 10/26/2022 20:46:54'!
initializeAttachedTo: aMarsRover
	log _ OrderedCollection new.
	
	positionLogger _ MarsRoverPositionLogger attachedTo: aMarsRover.
	headingLogger _ MarsRoverHeadingLogger attachedTo: aMarsRover.
	aMarsRover addLogger: [:aPosition :aHeading | self logCurrentPositionAndHeading].! !


!MarsRoverLoggerController methodsFor: 'logging' stamp: 'guille 10/26/2022 20:51:40'!
logCurrentPositionAndHeading
	log add: self currentPositionAndHeading ! !


!classDefinition: #MarsRoverPositionLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverPositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLogger methodsFor: 'current state' stamp: 'guille 10/26/2022 19:41:51'!
currentPosition
	log isEmpty ifTrue: [^nil].
	^log last! !


!MarsRoverPositionLogger methodsFor: 'initialization' stamp: 'guille 10/26/2022 20:30:05'!
initializeAttachedTo: aMarsRover
	log _ OrderedCollection new.

	aMarsRover addLogger: [:aPosition :aHeading | self log: aPosition].! !


!MarsRoverPositionLogger methodsFor: 'logging' stamp: 'guille 10/26/2022 19:48:52'!
log: aPosition
	| positionLog |
	positionLog _ aPosition x asString , ',' , aPosition y asString.
	(positionLog ~= self currentPosition) ifTrue: [log add: positionLog]! !


!classDefinition: #MarsRoverTranscript category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverTranscript
	instanceVariableNames: 'loggerController tracked'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTranscript methodsFor: 'initialization' stamp: 'guille 10/26/2022 21:35:15'!
initializeAttachedTo: aMarsRover
	loggerController _ MarsRoverLoggerController attachedTo: aMarsRover.
	tracked _ [loggerController currentPositionAndHeading ].
	aMarsRover addLogger: [:aPosition :aHeading | self updateTranscript].
	
	TranscriptWindow openTranscript.! !


!MarsRoverTranscript methodsFor: 'transcript' stamp: 'guille 10/26/2022 21:34:58'!
updateTranscript
	Transcript clear.
	Transcript show: tracked value.! !


!MarsRoverTranscript methodsFor: 'tracking' stamp: 'guille 10/26/2022 21:36:34'!
trackHeading
	tracked _ [loggerController currentHeading].
	self updateTranscript .! !

!MarsRoverTranscript methodsFor: 'tracking' stamp: 'guille 10/26/2022 21:36:47'!
trackPosition
	tracked _ [loggerController currentPosition].
	self updateTranscript .! !

!MarsRoverTranscript methodsFor: 'tracking' stamp: 'guille 10/26/2022 21:36:54'!
trackPositionAndHeading
	tracked _ [loggerController currentPositionAndHeading ].
	self updateTranscript .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverTranscript class' category: 'MarsRover-WithHeading'!
MarsRoverTranscript class
	instanceVariableNames: ''!

!MarsRoverTranscript class methodsFor: 'as yet unclassified' stamp: 'guille 10/26/2022 21:15:49'!
attachedTo: aMarsRover
	^self new initializeAttachedTo: aMarsRover! !
