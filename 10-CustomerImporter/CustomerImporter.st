!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'MSS 11/10/2022 20:25:39'!
test01ImportImportsCorrectCustomers
	| pepe juan |
	self importCustomers: (self inputFilestream: 'input.txt'). 
	
	pepe := self getCustomerNamed: 'Pepe' withLastName: 'Sanchez'.
	juan := self getCustomerNamed: 'Juan' withLastName: 'Perez'.
	
	self assertCustomer: pepe idTypeShouldBe: 'D' idNumberShouldBe: 22333444 .
	
	self assertAddress: pepe addresses first hasStreetname: 'San Martin' hasStreetnumber: 3322 hasTown: 'Olivos' hasZipCode: 1636 hasProvince: 'BsAs' .
	self assertAddress: pepe addresses second hasStreetname: 'Maipu' hasStreetnumber: 888 hasTown: 'Florida' hasZipCode: 1122 hasProvince: 'Buenos Aires' .
	
	self assertCustomer: juan idTypeShouldBe: 'C' idNumberShouldBe: '23-25666777-9'. 
	self assertAddress: juan addresses first hasStreetname: 'Alem' hasStreetnumber: 1122 hasTown: 'CABA' hasZipCode: 1001 hasProvince: 'CABA' .
! !


!ImportTest methodsFor: 'setUp' stamp: 'MSS 11/10/2022 17:53:51'!
setUp

	session1 := DataBaseSession for: (Array with: Address with: Customer).
	session1 beginTransaction! !


!ImportTest methodsFor: 'support' stamp: 'MSS 11/10/2022 19:03:44'!
getCustomerNamed: aCustomerName withLastName: aCustomerLastName

	|customers customer|
	
	"^hago que se pueda hacer con self (inline method - extract a self)
	puedo usar lo anterior para guardar variables internas de importCustomers como variables de instancia de self y poder testearlas
	pongo la inicializacion de la sesion con la DB en setUp
	"
	
	customers := session1 selectAllOfType: Customer.
	customer := customers detect:[:aCustomer| aCustomer firstName = aCustomerName and: [aCustomer lastName = aCustomerLastName]].
	^customer.! !

!ImportTest methodsFor: 'support' stamp: 'MSS 11/10/2022 19:59:00'!
importCustomers: anInputStream
	(CustomerImporter onDbSession: session1 fromInputStream: anInputStream) value! !

!ImportTest methodsFor: 'support' stamp: 'MSS 11/10/2022 19:51:26'!
inputFilestream: aFilename

	^ StandardFileStream new open: aFilename forWrite: false! !


!ImportTest methodsFor: 'assert' stamp: 'MSS 11/10/2022 19:37:50'!
assertAddress: firstAddress hasStreetname: aStreetname hasStreetnumber: aStreetNumber hasTown: aTownName hasZipCode: aZipCode hasProvince: aProvinceName     

	self assert: aStreetname equals: firstAddress streetName .
	self assert: aStreetNumber equals: firstAddress streetNumber.
	self assert: aTownName equals: firstAddress town.
	self assert: aZipCode equals: firstAddress zipCode.
	self assert: aProvinceName equals: firstAddress province.
	^true! !

!ImportTest methodsFor: 'assert' stamp: 'MSS 11/10/2022 20:25:39'!
assertCustomer: aCustomer idTypeShouldBe: anIdType idNumberShouldBe: anIdNumber 
	
	self assert: anIdType  equals: aCustomer identificationType.

	self assert: anIdNumber asString equals: aCustomer identificationNumber! !


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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'MSS 11/10/2022 20:18:02'!
initializeOnDbSession: aDbSession fromInputStream: anAnInputStream
	session := aDbSession.
	stream := anAnInputStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'MSS 11/10/2022 19:59:00'!
value

	| inputStream newCustomer line |
	inputStream := stream.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].
	session commit.
	session close.
	inputStream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'MSS 11/10/2022 19:59:00'!
onDbSession: aDbSession fromInputStream: anAnInputStream
	^self new initializeOnDbSession: aDbSession fromInputStream: anAnInputStream! !


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
