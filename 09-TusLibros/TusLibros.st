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


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

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

!CashierTest methodsFor: 'support' stamp: 'grm 10/31/2022 19:58:50'!
createCart

	^ Cart acceptingItemsOf: (Array with: 'validbook')! !


!CashierTest methodsFor: 'tests' stamp: 'grm 10/31/2022 20:31:00'!
test01cannotCheckoutEmptyCart
	| cart card cashier |
	cart _ self createCart.
	card _ CreditCard new.
	cashier _ Cashier new.
	
	self
		should: [cashier checkout: cart withCreditCard: card]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: error messageText. ]! !


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


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

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

!Cashier methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 20:35:05'!
checkout: aCart withCreditCard: aCard
	aCart isEmpty ifTrue: [self error: self class cannotCheckoutEmptyCartErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'grm 10/31/2022 20:33:58'!
cannotCheckoutEmptyCartErrorDescription
	^'Cart cannot be empty at checkout'! !


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
