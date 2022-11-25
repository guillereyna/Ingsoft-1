!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RESTInterfaceTest category: 'TusLibros'!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: 'aMerchantProcessor aClock usersAndPasswords1 api1 catalog1 creditCard1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 15:33:05'!
setUp
	
	usersAndPasswords1 := (Dictionary new) add: 1->'password1';yourself .
	usersAndPasswords1 add: 2->'password2';yourself .
	catalog1:= Dictionary new.
	catalog1 add: 1->10; add: 2->15;yourself.
	api1 := RESTInterface createWithCatalog: catalog1 withHistoryOfSales: OrderedCollection new processedBy: aMerchantProcessor timedby: aClock withUsersAndPasswords: usersAndPasswords1.
	
	creditCard1 := CreditCard initializeExpiringOn: 2. 
	! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 13:51:13'!
test01createCartReturnsSuccessCodeAndCartId
	|  response |
	
	
	response := api1 createCartFor: 1 password: 'password1'.
	
	self assert: '0|1' equals: response.! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 13:56:03'!
test02createCartWithInvalidUserReturnsError
	
	self 
	should: [api1 createCartFor: #Invalid password: 'pass'.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: (api1 class wrongPasswordOrIdErrorDescription) equals: anError messageText.]! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 13:56:37'!
test03createCartWithInvalidPasswordReturnsError
	
	self 
	should: [api1 createCartFor: 1 password: #invalid]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: (api1 class wrongPasswordOrIdErrorDescription) equals: anError messageText.]! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:17:23'!
test04addValidItemToCartReturnsSuccessCode
	| response |
	api1 createCartFor: 1 password: 'password1'. 
	response := api1 addToCart: 1 bookIsbn: 1 quantityOf: 1.
	
	self assert: '0|OK' equals: response.! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:21:40'!
test05addInvalidItemToCartRaisesError
	
	
	api1 createCartFor: 1 password: 'password1'. 
	
	
	self 
	should: [api1 addToCart: 1 bookIsbn: 1000 quantityOf: 1.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: ((api1 getCarts at:1) invalidItemErrorMessage) 
		equals: anError messageText.]! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:54:31'!
test06validCartListCartReturnsCorrectOutput
	
	
	
	api1 createCartFor: 1 password: 'password1'. 
	api1 addToCart: 1 bookIsbn: 1 quantityOf: 2.
	api1 addToCart: 1 bookIsbn: 2 quantityOf: 1.
	
	self assert: '0|1|2|2|1' equals: (api1 listCartWithId: 1).
	! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 15:03:15'!
test07invalidCartIdListRaisesException
	
	
	api1 createCartFor: 1 password: 'password1'. 

	
	self 
	should: [api1 listCartWithId: 3]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: ((api1 class) cartNotCreatedErrorDescription) 
		equals: anError messageText.]! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 15:08:10'!
test08emptyCartListCartReturnsCorrectOutput
	
	
	
	api1 createCartFor: 1 password: 'password1'. 
	
	self assert: '0' equals: (api1 listCartWithId: 1).
	! !

!RESTInterfaceTest methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 15:31:09'!
test09checkoutWithValidCreditCardReturnsCorrectTransactionId
	
		
	api1 createCartFor: 1 password: 'password1'. 
	api1 addToCart: 1 bookIsbn: 1 quantityOf: 2.
	api1 addToCart: 1 bookIsbn: 2 quantityOf: 1.
	
	
	api1 checkOutCartWithId: 1 ccn: 1 cced: 1 cco: 'asd'.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'MSS 11/7/2022 14:36:39'!
list
	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RESTInterface category: 'TusLibros'!
Object subclass: #RESTInterface
	instanceVariableNames: 'idsAndPasswords catalog salesHistory processor clock cartsByUser carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:05:04'!
addCartForClientId: aClientId 
	cartsByUser add: aClientId-> cartsByUser size.
	carts add: (Cart acceptingItemsOf: catalog).
	^ (cartsByUser size printString) .! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:14:09'!
addToCart: cartId bookIsbn: bookId quantityOf: quantity 
	|cart|
	cart := carts at: cartId.
	cart add: quantity of: bookId.
	^'0|OK'.! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 13:43:37'!
createCartFor: aClientId password: aPassword
	|cartId|
	(self hasId: aClientId withPassword: aPassword)
		ifFalse: [^'1|' , self class invalidParameterErrorDescription ].
	cartId := self addCartForClientId: aClientId.
	^('0|',cartId).! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:21:08'!
getCarts
	^carts copy.! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 13:40:40'!
hasId: anId withPassword: aPassword 
	|password|
	password:= idsAndPasswords at:anId ifAbsent:[self error: self class wrongPasswordOrIdErrorDescription	].
	(password=aPassword) ifFalse: [self error: self class wrongPasswordOrIdErrorDescription].
	
	^true.
! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 14:04:50'!
initializeWithCatalog: aCatalog withHistoryOfSales: aSalesHistory processedBy: aMerchantProcessor timedby: aClock withUsersAndPasswords:aDictionaryOfUsersAndPasswords  
	idsAndPasswords := aDictionaryOfUsersAndPasswords.
	catalog := aCatalog.
	salesHistory := aSalesHistory.
	processor := aMerchantProcessor.
	clock:= aClock.
	cartsByUser := Dictionary new.
	carts := OrderedCollection new.! !

!RESTInterface methodsFor: 'as yet unclassified' stamp: 'MSS 11/7/2022 15:08:04'!
listCartWithId: aString 
	|cart bookIds response list|
	((carts size) < (aString asInteger)) ifTrue: [self error: self class cartNotCreatedErrorDescription].
	cart := carts at: (aString asInteger).
	
	list:=cart list.
	bookIds := cart list asSet asSortedCollection.
	
	response := '0'.
	
	bookIds do: [:id| response := response,'|' ,(id storeString),'|' , (((list occurrencesOf: id) storeString))].
	
	^response.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: 'TusLibros'!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'error description' stamp: 'MSS 11/7/2022 15:03:48'!
cartNotCreatedErrorDescription
	^'This cart was not created'! !

!RESTInterface class methodsFor: 'error description' stamp: 'MSS 11/7/2022 13:34:57'!
createWithCatalog: aCatalog withHistoryOfSales: aSalesHistory processedBy: aMerchantProcessor timedby: aClock withUsersAndPasswords: aDictionaryOfUsersAndPasswords
	^self new initializeWithCatalog: aCatalog withHistoryOfSales: aSalesHistory  processedBy: aMerchantProcessor  timedby: aClock withUsersAndPasswords: aDictionaryOfUsersAndPasswords! !

!RESTInterface class methodsFor: 'error description' stamp: 'grm 11/3/2022 20:09:19'!
invalidParameterErrorDescription
	^'Invalid parameter'! !

!RESTInterface class methodsFor: 'error description' stamp: 'MSS 11/7/2022 01:39:19'!
wrongPasswordOrIdErrorDescription
	^'wrong password or Id'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
