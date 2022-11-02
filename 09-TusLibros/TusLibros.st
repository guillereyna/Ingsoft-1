!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'grm 11/2/2022 17:53:01'!
test09CartKnowsRunningPrice

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: 40 equals: cart runningPrice.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'grm 11/2/2022 18:02:42'!
defaultCatalog
	|catalog|
	catalog _ Dictionary new.
	catalog at: self itemSellByTheStore put: 20.
	^catalog.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'grm 11/2/2022 17:46:50'!
cartWithOneBook
	| cart |
	cart _ self createCart.
	cart add: 'validbook'.
	^cart! !

!CashierTest methodsFor: 'support' stamp: 'grm 11/2/2022 18:04:15'!
createCart

	^ Cart acceptingItemsOf: self createCatalog! !

!CashierTest methodsFor: 'support' stamp: 'grm 11/2/2022 18:04:04'!
createCatalog
	| catalog |
	catalog _ Dictionary new.
	catalog at: 'validbook' put: 20.
	^catalog! !

!CashierTest methodsFor: 'support' stamp: 'grm 11/2/2022 17:32:40'!
expiredCreditCard
	| expiration |
	expiration _ FixedGregorianDate yearNumber: 2020 monthNumber: 8 dayNumber: 1.
	^CreditCard withNumber: 11111111111 expirationDate: expiration owner: 'validName'.! !

!CashierTest methodsFor: 'support' stamp: 'grm 11/2/2022 17:28:17'!
validCreditCard
	| expiration |
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	^CreditCard withNumber: 11111111111 expirationDate: expiration owner: 'validName'.! !


!CashierTest methodsFor: 'tests' stamp: 'grm 11/2/2022 17:29:09'!
test01cannotCheckoutEmptyCart
	| cart cashier card |
	
	cart _ self createCart.
	cashier _ Cashier new.
	card _ self validCreditCard.
	
	self
		should: [cashier checkout: cart withCreditCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: error messageText. ]! !

!CashierTest methodsFor: 'tests' stamp: 'grm 11/2/2022 17:32:06'!
test02cannotCheckoutWithExpiredCard
	| cart cashier card |
	
	cart _ self createCart.
	cart add: 'validbook'.
	cashier _ Cashier new.
	card _ self expiredCreditCard.
	
	self
		should: [cashier checkout: cart withCreditCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: Cashier cannotCheckoutWithExpiredCardErrorDescription equals: error messageText. ]! !

!CashierTest methodsFor: 'tests' stamp: 'grm 11/2/2022 17:46:58'!
test03canCheckoutCartWithOneBook
	| cart cashier card |
	
	cart _ self cartWithOneBook.
	cashier _ Cashier new.
	card _ self validCreditCard.
	
	cashier checkout: cart withCreditCard: card.
	
	self assert: cart isEmpty.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:32:40'!
test01cannotCreateCardWithNonIntegerNumber
	| expiration |
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	self
		should: [CreditCard withNumber: '' expirationDate: expiration owner: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: CreditCard invalidCardNumberErrorDescription equals: error messageText]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:37:36'!
test02cannotCreateCardWithNonStrictlyPositiveNumber
	| expiration |
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	self
		should: [CreditCard withNumber: 0 expirationDate: expiration owner: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: CreditCard invalidCardNumberErrorDescription equals: error messageText].
		
	self
		should: [CreditCard withNumber: -1 expirationDate: expiration owner: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: CreditCard invalidCardNumberErrorDescription equals: error messageText]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:35:30'!
test03cannotCreateCardWithInvalidDate
	self
		should: [CreditCard withNumber: 11111111111 expirationDate: '' owner: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: CreditCard invalidExpirationDateErrorDescription equals: error messageText]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:42:27'!
test04cannotCreateCardWithOwnerNameOver30Characters
	| expiration |
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	self
		should: [CreditCard withNumber: 11111111111 expirationDate: expiration owner: 'unNombreDeMasDeTreintaCharacters']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: CreditCard invalidOwnerNameErrorDescription equals: error messageText]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:48:12'!
test05cardCanAnswerCorrectNumber
	| number expiration card |
	number _ 11111111111.
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	card _ CreditCard withNumber: number expirationDate: expiration owner: 'validName'.
	
	self assert: card number equals: number.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:52:54'!
test06cardCanAnswerCorrectExpirationDate
	| expiration card |
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	card _ CreditCard withNumber: 11111111111 expirationDate: expiration owner: 'validName'.
	
	self assert: card expiration equals: expiration.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:53:51'!
test07cardCanAnswerCorrectOwnerName
	| expiration card owner |
	owner _ 'validName'.
	expiration _ FixedGregorianDate yearNumber: 2023 monthNumber: 8 dayNumber: 1.
	card _ CreditCard withNumber: 11111111111 expirationDate: expiration owner: owner.
	
	self assert: card owner equals: owner.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 11/2/2022 17:40:02'!
test08expiredCreditCardKnowsItIsExpired
	| expiration card owner |
	owner _ 'validName'.
	expiration _ FixedGregorianDate yearNumber: 2020 monthNumber: 8 dayNumber: 1.
	card _ CreditCard withNumber: 11111111111 expirationDate: expiration owner: owner.
	
	self assert: card isExpired.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'grm 11/2/2022 17:41:03'!
test09validCreditCardKnowsItIsNotExpired
	| expiration card owner |
	owner _ 'validName'.
	expiration _ FixedGregorianDate yearNumber: 2024 monthNumber: 8 dayNumber: 1.
	card _ CreditCard withNumber: 11111111111 expirationDate: expiration owner: owner.
	
	self deny: card isExpired.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'assertions' stamp: 'grm 11/2/2022 18:02:27'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'grm 11/2/2022 17:59:42'!
runningPrice
	^items inject: 0 into: [:priceTotal :item | priceTotal + (catalog at: item) ]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'private' stamp: 'grm 11/2/2022 17:48:25'!
emptyBooks
	
	items _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'grm 11/2/2022 17:47:38'!
checkout: aCart withCreditCard: aCard
	aCart isEmpty ifTrue: [self error: self class cannotCheckoutEmptyCartErrorDescription ].
	aCard isExpired ifTrue: [self error: self class cannotCheckoutWithExpiredCardErrorDescription].
	
	aCart emptyBooks.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 20:33:58'!
cannotCheckoutEmptyCartErrorDescription
	^'Cart cannot be empty at checkout'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'grm 11/2/2022 17:35:00'!
cannotCheckoutWithExpiredCardErrorDescription
	^'Card must not be expired'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:53:08'!
expiration
	^expiration copy! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:50:43'!
initializeWithNumber: aCardNumber expirationDate: anExpirationDate owner: anOwnerName
	number _ aCardNumber.
	expiration _ anExpirationDate.
	owner _ anOwnerName.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'grm 11/2/2022 17:40:34'!
isExpired
	^expiration < expiration class today! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:51:16'!
number
	^number copy! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:54:04'!
owner
	^owner copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:41:52'!
invalidCardNumberErrorDescription
	^'Card number must be strictly positive integer'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:21:58'!
invalidExpirationDateErrorDescription
	^'Expiration date must be Fixed Gregorian Date'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:41:35'!
invalidOwnerNameErrorDescription
	^'Owner name must be string with length under 31 characters.'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 21:49:43'!
withNumber: aCardNumber expirationDate: anExpirationDate owner: anOwnerName 
	((aCardNumber isKindOf: SmallInteger) and: [aCardNumber strictlyPositive])
		ifFalse: [self error: self invalidCardNumberErrorDescription ].
	(anExpirationDate isKindOf: FixedGregorianDate)
		ifFalse: [self error: self invalidExpirationDateErrorDescription ].
	((anOwnerName isKindOf: String) and: [anOwnerName size <= 30])
		ifFalse: [self error: self invalidOwnerNameErrorDescription ].
		
	^self new initializeWithNumber: aCardNumber expirationDate: anExpirationDate owner: anOwnerName.! !
