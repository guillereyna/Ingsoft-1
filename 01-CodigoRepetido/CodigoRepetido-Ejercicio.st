!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/7/2022 12:07:32'!
assertThat: aCustomerBook hasActiveCustomers: aNumberOfActiveCustomers
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/7/2022 12:10:32'!
assertThat: aCustomerBook hasActiveCustomers: aNumberOfActiveCustomers hasSuspendedCustomers: aNumberOfSuspendedCustomers hasCustomers: aNumberOfCustomers
	self assertThat: aCustomerBook hasActiveCustomers: aNumberOfActiveCustomers .
	self assertThat: aCustomerBook hasSuspendedCustomers: aNumberOfSuspendedCustomers .
	self assertThat: aCustomerBook hasCustomers: aNumberOfCustomers .
	! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/7/2022 12:10:04'!
assertThat: aCustomerBook hasCustomers: aNumberOfCustomers
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.
	! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/7/2022 12:09:01'!
assertThat: aCustomerBook hasSuspendedCustomers: aNumberOfSuspendedCustomers
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/6/2022 21:51:09'!
createCustomerBookAndAddAndSuspendCustomer: aCustomerName
	|customerBook|
	customerBook := self createCustomerBookAndAddCustomer: aCustomerName .
	customerBook suspendCustomerNamed: aCustomerName.
	^customerBook
! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/6/2022 21:47:46'!
createCustomerBookAndAddCustomer: aCustomerName
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook
! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'grm 9/6/2022 21:13:35'!
shouldThrowException: aBlockClosure withException: anException andAssert: anErrorHandler

	[aBlockClosure value.
	self fail] 
		on: anException 
		do: anErrorHandler! !


!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/6/2022 20:27:00'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook executionTime |
	
	customerBook := CustomerBook new.
	
	executionTime := [customerBook addCustomerNamed: 'John Lennon'.] millisecondsToRun .
	
	self assert: executionTime < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/6/2022 21:49:40'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney executionTime |
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self createCustomerBookAndAddCustomer: paulMcCartney .
	  
	executionTime := [customerBook removeCustomerNamed: paulMcCartney.] millisecondsToRun .
		
	self assert: executionTime < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/6/2022 21:13:35'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self shouldThrowException: [ customerBook addCustomerNamed: '' ]
		withException: Error 
		andAssert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/7/2022 12:12:41'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
			
	customerBook := self createCustomerBookAndAddCustomer: johnLennon .
	
	self shouldThrowException: [ customerBook removeCustomerNamed: 'Paul McCartney']
		withException: NotFound 
		andAssert: [ :anError | 
			self assertThat: customerBook hasCustomers: 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/6/2022 21:52:46'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self createCustomerBookAndAddAndSuspendCustomer: paulMcCartney .
	
	self assertThat: customerBook
		hasActiveCustomers: 0
		hasSuspendedCustomers: 1 
		hasCustomers: 1.

	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/6/2022 21:53:07'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self createCustomerBookAndAddAndSuspendCustomer: paulMcCartney.
	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook
		hasActiveCustomers: 0
		hasSuspendedCustomers: 0 
		hasCustomers: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/7/2022 12:12:21'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	
	customerBook := self createCustomerBookAndAddCustomer: johnLennon .
	
	self shouldThrowException: [ customerBook suspendCustomerNamed: 'George Harrison' ]
		withException: CantSuspend
		andAssert: [ :anError | 
			self assertThat: customerBook hasCustomers: 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'grm 9/7/2022 12:11:17'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.

	customerBook := self createCustomerBookAndAddAndSuspendCustomer: johnLennon .
	
	self shouldThrowException: [ customerBook suspendCustomerNamed: johnLennon. ]
		withException: CantSuspend
		andAssert: [ :anError | 
			self assertThat: customerBook hasCustomers: 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MSS 9/7/2022 21:17:30'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MSS 9/7/2022 20:24:42'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MSS 9/7/2022 20:57:10'!
removeCustomerNamed: aName 
 	
	active remove: aName ifAbsent:
					[suspended remove: aName 
						ifAbsent: [^ NotFound signal].
					].
	^aName.

! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
