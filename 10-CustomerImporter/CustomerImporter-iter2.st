!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 18:17:51'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/14/2022 19:58:28'!
test02ImportInvalidLineTypeRaisesError

	

	self should:[CustomerImporter valueFrom: self invalidLineTypeData into: session.]
	raise:Error - MessageNotUnderstood 
	withExceptionDo: [:error| self assert: CustomerImporter InvalidLineTypeErrorMessage equals: error messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/14/2022 20:10:41'!
test03ImportInvalidLineTypeSOFE

	
	
	self should:[ CustomerImporter valueFrom: self invalidLineTypeData into: session.]
	raise:Error - MessageNotUnderstood 
	withExceptionDo: [:error|self assert: 1 equals: (session selectAllOfType: Customer) size.
				    self assertPepeSanchezWasImportedCorrecty ].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 20:40:42'!
test04firstLineIsAnAddressRaisesError
	
	
	self should:[ CustomerImporter valueFrom: self firstLineIsAnAddress into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: CustomerImporter addressWithNoClientError equals: error messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 20:46:53'!
test05firstLineIsAnAddressShouldNotImportNothing
	
	
	self should:[ CustomerImporter valueFrom: self firstLineIsAnAddress into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: 0  equals:(session selectAllOfType: Address) size].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 21:11:30'!
test06missingClientParameterRaisesError
	
	
	self should:[ CustomerImporter valueFrom: self dataWithMissingCustomerParameter into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: CustomerImporter missingParameterErrorMessage equals: error messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 21:12:37'!
test07missingCustomerParameterDoesNotImportCustomer
	
	
	self should:[ CustomerImporter valueFrom: self dataWithMissingCustomerParameter into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: 0 equals: (session selectAllOfType: Customer) size].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 21:13:22'!
test08missingAddressParameterRaisesError
	
	
	self should:[ CustomerImporter valueFrom: self dataWithMissingAddressParameter into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: CustomerImporter missingParameterErrorMessage equals: error messageText].! !

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/15/2022 21:06:40'!
testXXXdoubleCommaShouldRaiseError
	
	
	self should:[ CustomerImporter valueFrom: self doubleCommaData into: session.]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:  [:error| self assert: CustomerImporter doubleCommaNotSupported equals: error messageText ].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 21:01:07'!
dataWithMissingAddressParameter

	^ ReadStream on:
'C,Pepe,Sanchez,D,2500
A,San Martin,3322,Olivos,1636,
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 21:11:21'!
dataWithMissingCustomerParameter

	^ ReadStream on:
'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 20:53:00'!
doubleCommaData

	^ ReadStream on:
'C, ,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/14/2022 20:35:53'!
emptyLineInMiddleOfData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires

C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 20:27:49'!
emptyString

	^ ReadStream on:
'


'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 20:32:57'!
firstLineIsAnAddress

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'MSS 11/15/2022 20:16:38'!
invalidLineTypeData
		^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
D,San Martin,3322,Olivos,1636,BsAs
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'session readStream line newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'evaluating' stamp: 'MSS 11/14/2022 19:29:05'!
importLine
	self subclassResponsibility .! !

!CSVImporter methodsFor: 'evaluating' stamp: 'MSS 11/14/2022 19:28:27'!
value
	[line := readStream nextLine. 
		line notNil ] whileTrue: [ 	self importLine ].

	! !


!CSVImporter methodsFor: 'initialization' stamp: 'MSS 11/14/2022 19:28:42'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'instance creation' stamp: 'MSS 11/14/2022 19:29:32'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CSVImporter class methodsFor: 'importing' stamp: 'MSS 11/14/2022 19:29:39'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newAddress record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/15/2022 21:13:52'!
importLine
	record := line findTokens: $,.
	 (line beginsWith: 'C') ifTrue: [ 
		(record size = 5) ifFalse: [self error: self class missingParameterErrorMessage .].
		self initializeCustomer.
		session persist: newCustomer. ^self].
	 (line beginsWith: 'A') ifTrue: [ 
		(record size = 6) ifFalse: [self error: self class missingParameterErrorMessage .].
		self initializeAddress. ^self
		].
	self error: self class InvalidLineTypeErrorMessage .
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/15/2022 20:38:41'!
initializeAddress
	newCustomer ifNil:[self error: self class addressWithNoClientError].
	newAddress := Address new.
	newCustomer addAddress: newAddress.
		newAddress streetName: record second.
		newAddress streetNumber: record third asNumber .
		newAddress town: record fourth.
		newAddress zipCode: record fifth asNumber .
		newAddress province: record sixth.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/14/2022 19:22:30'!
initializeCustomer
	newCustomer := Customer new.
		newCustomer firstName: record second.
		newCustomer lastName: record third.
		newCustomer identificationType: record fourth.
		newCustomer identificationNumber: record fifth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/14/2022 19:21:59'!
processIfAddressLine

	^ (line beginsWith: 'A') ifTrue: [ self initializeAddress ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/14/2022 19:20:43'!
processIfClientLine

	^ (line beginsWith: 'C') ifTrue: [ 
		self initializeCustomer.
		session persist: newCustomer ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'importing' stamp: 'MSS 11/14/2022 19:48:45'!
InvalidLineTypeErrorMessage
	^'This line type is not supported by CustomerImporter'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'MSS 11/15/2022 20:37:05'!
addressWithNoClientError
	^'There is no client for this address'! !

!CustomerImporter class methodsFor: 'importing' stamp: 'MSS 11/15/2022 20:49:06'!
doubleCommaNotSupportedErrorMessage
	^'Cannot have empty parameters'! !


!CustomerImporter class methodsFor: 'as yet unclassified' stamp: 'MSS 11/14/2022 20:49:20'!
missingParameterErrorMessage
	^'CSV line lacks parameters'! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
