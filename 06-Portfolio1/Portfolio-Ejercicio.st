!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 20:08:13'!
test01emptyPortfolioHasBalanceZero
	|portfolio|
	portfolio := Portfolio new.
	
	self assert: (portfolio balance = 0).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 20:15:33'!
test02oneAccountAffectsPortfolioBalance
	|portfolio |
	portfolio := self portfolioWithOneAccount.
	
	self assert: (portfolio balance = 100).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 20:23:39'!
test03nestedPortfolioAffectsBalance
	|portfolio |
	portfolio := self portfolioWithOnePortfolio .
	
	self assert: (portfolio balance = 200).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:36:06'!
test04canDetectRepeatedChildAccount
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	
	portfolio addPortfolioItem: account.
	
	self assert: (portfolio alreadyHasAccount: account) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:40:29'!
test05notAddedChildAccountIsNotIncludedInPortfolio
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	
	self deny: (portfolio alreadyHasAccount: account) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:35:15'!
test06cannotAddNonNestedChildAccountTwice
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	portfolio addPortfolioItem: account .
	
	[portfolio addPortfolioItem: account .
		] on: Error
	  do: [:error | 
				self assert: (error messageText = Portfolio cannotAddAccountTwiceErrorDescription).
				self assert: (portfolio balance = 100).
				^self].

	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:35:24'!
test07cannotAddNestedChildAccountTwice
	| portfolio1 portfolio2 account |
	portfolio1 := Portfolio new.
	account := self accountWithOneTransaction .
	portfolio2 := Portfolio new.
	portfolio2 addPortfolioItem: account .
	portfolio1 addPortfolioItem: portfolio2.
	[portfolio1 addPortfolioItem: account.
		] on: Error
	  do: [:error | 
				self assert: (error messageText = Portfolio cannotAddAccountTwiceErrorDescription).
				self assert: (portfolio1 balance = 100).
				^self].

	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:31:33'!
test08cannotAddNonNestedChildPortfolioTwice
	| portfolio1 portfolio2  |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio1 addPortfolioItem: portfolio2.
	[portfolio1 addPortfolioItem: portfolio2.
		] on: Error
	  do: [:error | 
				self assert: (error messageText = Portfolio cannotAddPortfolioTwiceErrorDescription).
		
				^self].

	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/15/2022 19:41:35'!
test09cannotAddNestedDescendingPortfolioTwice
	| portfolio1 portfolio2 portfolio3 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio1 addPortfolioItem: portfolio2.
	portfolio2 addPortfolioItem: portfolio3.
	[portfolio1 addPortfolioItem: portfolio3.
		] on: Error
	  do: [:error | 
				self assert: (error messageText = Portfolio cannotAddPortfolioTwiceErrorDescription).
		
				^self].

	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/15/2022 20:10:00'!
test10portfolioHasNonNestedRegisteredAccount
	| portfolio account transaction |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	
	portfolio addPortfolioItem: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/15/2022 20:11:46'!
test11portfolioHasNestedRegisteredAccount
	| portfolio1 portfolio2 account transaction |
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	portfolio2 addPortfolioItem: account.
	
	portfolio1 addPortfolioItem: portfolio2.
	
	self assert: (portfolio1 hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/15/2022 20:24:11'!
test12portfolioKnowsItsTransactions
	| portfolio account transaction transactions |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	portfolio addPortfolioItem: account.
	
	transactions := portfolio transactions.
	
	self assert: 1 equals: transactions size.
	self assert: (transactions includes: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/15/2022 20:27:20'!
test13portfolioKnowsItsNestedTransactions
	| portfolio1 portfolio2 account1 account2 transaction1 transaction2 transactions |
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	transaction1 := Withdraw register: 20 on: account1.
	portfolio1 addPortfolioItem: account1.
	
	portfolio2 := Portfolio new.
	account2 := ReceptiveAccount new.
	transaction2 := Deposit register: 100 on: account2.
	portfolio2 addPortfolioItem: account2.
	
	portfolio1 addPortfolioItem: portfolio2.
	
	transactions := portfolio1 transactions.
	
	self assert: 2 equals: transactions size.
	self assert: (transactions includes: transaction1).
	self assert: (transactions includes: transaction2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/16/2022 18:56:34'!
test14parentAddedToChildPortfolioCorrectly
	| parentPortfolio childPortfolio parents |
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	parentPortfolio addPortfolioItem: childPortfolio.
	
	parents := childPortfolio parents.
	
	self assert: 1 equals: parents size.
	self assert: (parents includes: parentPortfolio).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/16/2022 18:57:33'!
test15parentAddedToChildReceptiveAccountCorrectly
	| parentPortfolio childAccount parents |
	parentPortfolio := Portfolio new.
	childAccount := ReceptiveAccount new.
	
	parentPortfolio addPortfolioItem: childAccount.
	
	parents := childAccount parents.
	
	self assert: 1 equals: parents size.
	self assert: (parents includes: parentPortfolio).! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/16/2022 20:31:47'!
test16cannotAddAccountIfParentHasIt
	| portfolio1 portfolio2 account |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := self accountWithOneTransaction .
	
	portfolio1 addPortfolioItem: account.
	portfolio1 addPortfolioItem: portfolio2.
	
	[portfolio2 addPortfolioItem: account.]
	on: Error
	do: [:error |
			self assert: Portfolio cannotAddAccountTwiceErrorDescription equals: error messageText.
			self assert: 100 equals: portfolio1 balance.
			^self
		].
	
	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/16/2022 20:36:37'!
test17cannotAddPortfolioIfParentHasIt
	| portfolio1 portfolio2 portfolio3 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolioItem: portfolio2.
	portfolio1 addPortfolioItem: portfolio3.
	
	[portfolio2 addPortfolioItem: portfolio3.]
	on: Error
	do: [:error |
			self assert: Portfolio cannotAddPortfolioTwiceErrorDescription equals: error messageText.
			^self
		].
	
	self fail.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 12:59:36'!
test18getRootPortfoliosOfRootPortfolioReturnsHimself
	| portfolio1 portfolio2 account |
	portfolio1 := Portfolio new.
	account := self accountWithOneTransaction .
	portfolio1 addPortfolioItem: account .
	
	portfolio2 := Portfolio new.
	portfolio2 addPortfolioItem: account.
	
	self assert: (OrderedCollection with: portfolio1) equals: portfolio1 getRootPortFolios .! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 12:59:56'!
test19getRootPortfoliosOfDirectChildAccount
	| portfolio1 portfolio2 account |
	portfolio1 := Portfolio new.
	account := self accountWithOneTransaction .
	portfolio1 addPortfolioItem: account .
	
	portfolio2 := Portfolio new.
	portfolio2 addPortfolioItem: account.
	
	self assert:  (OrderedCollection with: portfolio1 with: portfolio2) equals: account getRootPortFolios.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 13:04:24'!
test20getRootPortfoliosOfANestedPortfolioItem
	| portfolio1 portfolio2 portfolio3 portfolio4 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new .
	
	portfolio1 addPortfolioItem: portfolio3 .
	portfolio2 addPortfolioItem: portfolio3 .
	portfolio4 := Portfolio new.
	
	portfolio3 addPortfolioItem: portfolio4 .
	
	
	self assert:  (OrderedCollection with: portfolio1 with: portfolio2) equals: portfolio4 getRootPortFolios.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 16:11:53'!
test21checkNoCommonPortfoliosWithDescendantsOfWorksCorrectly
	| portfolio1 portfolio2 portfolio3 portfolio4 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new .
	portfolio4 := Portfolio new.
	account := self accountWithOneTransaction .
	
	portfolio1 addPortfolioItem: portfolio2 .
	portfolio2 addPortfolioItem: portfolio3 .
	portfolio3 addPortfolioItem: account.
	account := self accountWithOneTransaction .
	
	
	[portfolio4 checkNoCommonPortfoliosWithDescendantsOf: portfolio1]
	on: Error
	do: [:error |
			self fail.
		].
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 16:12:14'!
test22checkPortfoliosWithCommonDescendantAccountCannotBeAdded
	| portfolio1 portfolio2 portfolio3 portfolio4 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new .
	portfolio4 := Portfolio new.
	account := self accountWithOneTransaction .
	
	portfolio1 addPortfolioItem: portfolio2 .
	portfolio2 addPortfolioItem: portfolio3 .
	portfolio3 addPortfolioItem: account.
	
	
	
	[	portfolio4 addPortfolioItem: account.
		portfolio4 checkNoCommonPortfoliosWithDescendantsOf: portfolio1]
	on: Error
	do: [:error |
			self assert: Portfolio cannotAddAccountTwiceErrorDescription equals: error messageText.
			^self
		].
	
	self fail.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MSS 10/17/2022 16:12:43'!
test23checkPortfoliosWithCommonDescendantPortfolioCannotBeAdded
	| portfolio1 portfolio2 portfolio3 portfolio4 portfolio5 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new .
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	portfolio1 addPortfolioItem: portfolio2 .
	portfolio2 addPortfolioItem: portfolio3 .
	portfolio3 addPortfolioItem: portfolio5.
	
	
	
	[	portfolio4 addPortfolioItem: portfolio5.
		portfolio4 checkNoCommonPortfoliosWithDescendantsOf: portfolio1]
	on: Error
	do: [:error |
			self assert: Portfolio cannotAddPortfolioTwiceErrorDescription equals: error messageText.
			^self
		].
	
	self fail.
	
	! !


!PortfolioTest methodsFor: 'internal' stamp: 'grm 10/13/2022 20:59:07'!
accountWithOneTransaction
	| account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	^account! !

!PortfolioTest methodsFor: 'internal' stamp: 'grm 10/13/2022 20:59:23'!
portfolioWithOneAccount
	|portfolio account|
	
	portfolio := Portfolio new.
	
	account := self accountWithOneTransaction .
	
	portfolio addPortfolioItem: account.
	
	^portfolio! !

!PortfolioTest methodsFor: 'internal' stamp: 'grm 10/13/2022 20:30:18'!
portfolioWithOnePortfolio
	|portfolio nestedPortfolio |
	portfolio := self portfolioWithOneAccount .
	nestedPortfolio := self portfolioWithOneAccount.
	
	portfolio addPortfolioItem: nestedPortfolio.
	
	^portfolio.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'grm 10/6/2022 20:58:56'!
balance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'balance' stamp: 'grm 10/6/2022 21:19:13'!
affectsCurrentBalance: aBalance
	^aBalance + self value! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'grm 10/6/2022 21:15:56'!
affectsCurrentBalance: aBalance 
	^aBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'grm 10/6/2022 20:55:54'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #PortfolioItem category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioItem
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioItem methodsFor: 'balance' stamp: 'MSS 10/15/2022 19:17:34'!
balance
	self subclassResponsibility .! !


!PortfolioItem methodsFor: 'initialization' stamp: 'MSS 10/15/2022 19:18:16'!
initialize
	self subclassResponsibility.! !


!PortfolioItem methodsFor: 'transactions' stamp: 'grm 10/15/2022 20:07:07'!
hasRegistered: anAccountTransaction
	self subclassResponsibility.! !

!PortfolioItem methodsFor: 'transactions' stamp: 'grm 10/15/2022 20:28:32'!
transactions
	self subclassResponsibility.! !


!PortfolioItem methodsFor: 'validation' stamp: 'grm 10/16/2022 18:54:31'!
addParent: aPortfolio 
	parents add: aPortfolio.! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/15/2022 19:17:12'!
alreadyHasAccount: aPortfolioItem
	self subclassResponsibility .! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/15/2022 19:17:27'!
alreadyHasPortfolio: aPortfolioItem
	self subclassResponsibility .! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/17/2022 13:56:34'!
checkNoCommonPortfoliosWithDescendantsOf: aPortfolioItem
	self checkNotInParents: aPortfolioItem.
	aPortfolioItem getItems do:[:item | self checkNoCommonPortfoliosWithDescendantsOf: item].! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/17/2022 13:45:15'!
checkNoRelatingPortfolioItemsWith: aPortfolioItem 
	|portFolioItemRoots|
	portFolioItemRoots := aPortfolioItem getRootPortFolios .
	
	
	portFolioItemRoots do:[:rootPortfolio | self checkNoCommonPortfoliosWithDescendantsOf: rootPortfolio].! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/15/2022 19:17:58'!
checkNotInto
	self subclassResponsibility.! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/17/2022 13:57:02'!
getItems
	self subclassResponsibility .! !

!PortfolioItem methodsFor: 'validation' stamp: 'MSS 10/17/2022 12:58:22'!
getRootPortFolios
	|rootPortfolios|
	parents isEmpty ifTrue:[^OrderedCollection with: self].
	
	rootPortfolios := OrderedCollection new.
	parents do:[:parentt | rootPortfolios := rootPortfolios addAll: parentt getRootPortFolios ; yourself].
	^rootPortfolios .! !

!PortfolioItem methodsFor: 'validation' stamp: 'grm 10/16/2022 18:57:18'!
parents
	^parents copy! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #Portfolio
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'MSS 10/17/2022 00:38:23'!
addPortfolioItem: aPortfolioItem

	"self checkNoRelatingPortfolioItemsWith: aPortfolioItem."
	self checkNotInParents: aPortfolioItem.
	
	items add: aPortfolioItem .
	aPortfolioItem addParent: self.! !

!Portfolio methodsFor: 'add' stamp: 'grm 10/16/2022 20:29:44'!
checkNotInParents: aPortfolioItem
	parents ifEmpty: [aPortfolioItem checkNotInto: self].
	parents do: [:portfolio | portfolio checkNotInParents: aPortfolioItem].! !


!Portfolio methodsFor: 'balance' stamp: 'grm 10/13/2022 20:28:21'!
balance
	^items inject: 0 into: [:balance :item | balance + item balance].! !


!Portfolio methodsFor: 'initialization' stamp: 'grm 10/16/2022 18:55:45'!
initialize
	parents := OrderedCollection new.
	items := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'MSS 10/17/2022 13:57:27'!
getItems
	^items copy.! !

!Portfolio methodsFor: 'transactions' stamp: 'grm 10/15/2022 20:08:12'!
hasRegistered: anAccountTransaction
	^items anySatisfy: [:item | item hasRegistered: anAccountTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'grm 10/15/2022 20:23:32'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	items do: [:item | transactions addAll: (item transactions)].
	^transactions.! !


!Portfolio methodsFor: 'validation' stamp: 'MSS 10/15/2022 18:40:10'!
alreadyHasAccount: aPortfolioItem
	^items anySatisfy: [:item | item alreadyHasAccount: aPortfolioItem ].! !

!Portfolio methodsFor: 'validation' stamp: 'MSS 10/15/2022 18:51:38'!
alreadyHasPortfolio: aPortfolio 
	^items anySatisfy: [:item | (item = aPortfolio) or: [item alreadyHasPortfolio: aPortfolio ]].! !

!Portfolio methodsFor: 'validation' stamp: 'grm 10/16/2022 20:28:53'!
checkNotInto: aPortfolio 
	(aPortfolio alreadyHasPortfolio: self) ifTrue: [ self error: self class cannotAddPortfolioTwiceErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'grm 10/13/2022 21:15:51'!
cannotAddAccountTwiceErrorDescription
	^'Portfolio cannot have repeated acccounts!!'! !

!Portfolio class methodsFor: 'error message' stamp: 'MSS 10/15/2022 18:52:47'!
cannotAddPortfolioTwiceErrorDescription
	^'Cannot add porfolio twice'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'grm 10/6/2022 21:18:19'!
balance
	^transactions inject: 0 into: [:aBalance :aTransaction | aTransaction affectsCurrentBalance: aBalance].! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'grm 10/16/2022 18:55:57'!
initialize
	parents := OrderedCollection new.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MSS 10/17/2022 13:57:54'!
getItems 

	^OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'validation' stamp: 'MSS 10/17/2022 14:15:31'!
alreadyHasAccount: aPortfolioItem
	^self = aPortfolioItem.! !

!ReceptiveAccount methodsFor: 'validation' stamp: 'MSS 10/15/2022 18:46:59'!
alreadyHasPortfolio: aPortfolioItem
	^false.! !

!ReceptiveAccount methodsFor: 'validation' stamp: 'MSS 10/15/2022 18:44:06'!
checkNotInto: aPortfolio
	(aPortfolio alreadyHasAccount: self) ifTrue: [self error: aPortfolio class cannotAddAccountTwiceErrorDescription ].
	! !
