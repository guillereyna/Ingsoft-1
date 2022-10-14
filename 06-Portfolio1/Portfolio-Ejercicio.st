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

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 21:34:46'!
test04canDetectRepeatedAccount
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	
	portfolio addPortfolioItem: account.
	
	self assert: (portfolio alreadyHas: account) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 21:36:19'!
test05canDetectRepeatedAccount
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	
	self deny: (portfolio alreadyHas: account) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/13/2022 21:41:27'!
test06cannotAddNonNestedAccountTwice
	| portfolio account |
	portfolio := Portfolio new.
	account := self accountWithOneTransaction .
	
	[portfolio addPortfolioItem: account .
	 portfolio addPortfolioItem: account .
		] on: Error
	  do: [:error | 
				self assert: (error messageText = Portfolio cannotAddAccountTwiceErrorDescription).
				self assert: (portfolio balance = 100).
				^self].

	self fail.! !


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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'grm 10/13/2022 20:28:21'!
balance
	^items inject: 0 into: [:balance :item | balance + item balance].! !


!Portfolio methodsFor: 'add' stamp: 'grm 10/13/2022 21:29:18'!
addPortfolioItem: aPortfolioItem
	(self alreadyHas: aPortfolioItem) ifTrue: [ Error signal: self class cannotAddAccountTwiceErrorDescription ].
	items add: aPortfolioItem .! !

!Portfolio methodsFor: 'add' stamp: 'grm 10/13/2022 21:25:42'!
alreadyHas: aPortfolioItem
	^items anySatisfy: [:item | item = aPortfolioItem ].! !


!Portfolio methodsFor: 'initialization' stamp: 'grm 10/13/2022 20:30:37'!
initialize
	items := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'grm 10/13/2022 21:15:51'!
cannotAddAccountTwiceErrorDescription
	^'Portfolio cannot have repeated acccounts!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'grm 10/6/2022 21:18:19'!
balance
	^transactions inject: 0 into: [:aBalance :aTransaction | aTransaction affectsCurrentBalance: aBalance].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
