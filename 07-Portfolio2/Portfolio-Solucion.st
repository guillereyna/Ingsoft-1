!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:18:07'!
test16emptyPortfolioHasEmptySummary
	| portfolio |
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio summary size! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:19:53'!
test17portfolioWithEmptyAccountHasEmptySummary
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self assert: 0 equals: portfolio summary size! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:21:57'!
test18portfolioWithOneAccountHasSameSummary
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	self assert: account summary size equals: portfolio summary size.
	self assert: account summary equals: portfolio summary.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:36:24'!
test19portfolioWithMultipleAccountsHasCorrectSummary
	| portfolio account1 account2 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	Withdraw register: 20 on: account2.
	
	Deposit register: 100 on: account1.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: account1 summary, account2 summary equals: portfolio summary.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:39:27'!
test20composedPortfolioHasCorrectSummary
	| portfolio1 portfolio2 account1 account2 |
	account1 := ReceptiveAccount new.
	portfolio1 := Portfolio with: account1.
	
	account2 := ReceptiveAccount new.
	portfolio2 := Portfolio with: account2.
	
	portfolio1 add: portfolio2.
	
	Transfer from: account1 to: account2 for: 100.
	Deposit register: 50 on: account2.
	Withdraw register: 70 on: account1.
	
	self assert: account1 summary, portfolio2 summary equals: portfolio1 summary.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:11:10'!
test21emptyPortfolioHasTransferNetZero
	
	self assert: 0 equals: Portfolio new transferNet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:16:44'!
test22portfolioWithOneAccountHasCorrectTransferNet
	| portfolio account1 account2 amount |
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio add: account1.
	
	amount _ 120.
	
	Transfer from: account2 to: account1 for: amount.
	
	self assert: amount equals: portfolio transferNet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:17:40'!
test23portfolioWithManyAccountsHasCorrectTransferNet
	| portfolio account1 account2 amount |
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio add: account1.
	portfolio add: account2.
	
	amount _ 120.
	
	Transfer from: account2 to: account1 for: amount.
	Transfer from: account1 to: account2 for: amount.
	
	self assert: 0 equals: portfolio transferNet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:21:52'!
test24composedPortfolioHasCorrectTransferNet
	| portfolio1 portfolio2 account1 account2 account3 |
	
	account1 _ ReceptiveAccount new.
	portfolio1 _ Portfolio with: account1.
	
	account2 _ ReceptiveAccount new.
	portfolio2 _ Portfolio with: account2.
	
	account3 _ ReceptiveAccount new.
	
	portfolio1 add: portfolio2.
	
	Transfer from: account3 to: account1 for: 120.
	Transfer from: account2 to: account3 for: 90.
	Transfer from: account1 to: account2 for: 20.
	
	
	self assert: (120 - 90 + 20 - 20) equals: portfolio1 transferNet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:36:14'!
test25emptyPortfolioTreeHasOwnNameOnly
	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: (OrderedCollection with: portfolio assetName) equals: portfolio tree.! !

!PortfolioTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:54:15'!
test26composedPortfolioHasCorrectNameTree
	| portfolio1 portfolio2 portfolio3 account1 account2 nameTree |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	portfolio2 add: account2.
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio1 add: portfolio3.
	
	nameTree _ 
		(OrderedCollection with: (portfolio1 assetName)),
		account1 assetTree,
		portfolio2 assetTree,
		portfolio3 assetTree.
	
	self assert: nameTree equals: portfolio1 tree.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'internal' stamp: 'grm 10/19/2022 18:59:49'!
foreignAccountErrorCheck: aBlockOfInsecureCode
	|  transfer origin destination |
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	
	
	transfer := self transferenciaFor100From: destination to: origin.
	
	[aBlockOfInsecureCode value: transfer.]
	on: Error - MessageNotUnderstood
	do: [:error | 
		self assert: transfer class accountIsNotPartOfTransactionErrorDescription equals: error messageText.
		^self].
		
	self fail.! !

!ReceptiveAccountTest methodsFor: 'internal' stamp: 'grm 10/19/2022 20:00:13'!
transferenciaFor100From: origin to: destination

	^ Transfer from: origin to: destination for: 100! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 20:01:30'!
test08transferAffectsBalanceCorrectly
	| origin destination amount |
	
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	amount := 100 .
	
	Transfer from: origin to: destination for: amount.
	
	self assert: amount equals: destination balance.
	self assert: amount negated equals: origin balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 20:01:36'!
test09transferIsRegisteredCorrectly
	| origin destination transfer |
	
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	
	transfer := self transferenciaFor100From: origin to: destination.
	
	self assert: (origin hasRegistered: transfer).
	self assert: (destination hasRegistered: transfer).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:01:14'!
test10transferCanAnswerIfAccountIsOriginOrDestinationCorrectly
	| origin destination transfer |
	
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	
	transfer := self transferenciaFor100From: origin to: destination.
	
	self assert: (transfer isOrigin: origin).
	self assert: (transfer isDestination: destination).
	self deny: (transfer isOrigin: destination).
	self deny: (transfer isDestination: origin).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:01:25'!
test11transferCanAnswerOtherEndOfTransaction
	| origin destination transfer |
	
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	
	transfer := self transferenciaFor100From: origin to: destination.
	
	self assert: destination equals: (transfer otherEnd: origin).
	self assert: origin equals: (transfer otherEnd: destination).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 18:49:54'!
test12transferRaisesErrorIfAccountIsNotPartOfTransaction
	| foreignAccount |
	
	foreignAccount := ReceptiveAccount new.
	
	self foreignAccountErrorCheck: [:aTransfer | aTransfer otherEnd: foreignAccount.].

	self foreignAccountErrorCheck: [:aTransfer | aTransfer  affectsBalance: 100 of: foreignAccount.].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:19:42'!
test13emptyAccountSummaryIsEmpty
	| account summary |
	account := ReceptiveAccount new.
	
	summary := account summary.
	
	self assert: 0 equals: summary size.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:35:19'!
test14accountSummaryWithOneDeposit
	| account summary |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	summary := account summary.
	
	self assert: (OrderedCollection with: 'Depósito por 100.') equals: summary.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:36:10'!
test15accountSummaryWithMultipleDeposits
	| account summary |
	account := ReceptiveAccount new.
	Deposit register: 80 on: account.
	Deposit register: 25 on: account.
	
	
	summary := account summary.
	
	self assert: (OrderedCollection with: 'Depósito por 80.' with: 'Depósito por 25.') equals: summary.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:35:26'!
test16accountSummaryWithOneWithdraw
	| account summary |
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	summary := account summary.
	
	self assert: (OrderedCollection with: 'Extracción por 50.') equals: summary.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 19:43:16'!
test17accountSummaryWithMultipleWithdraw
	| account summary |
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	Withdraw register: 76 on: account.
	
	summary := account summary.
	
	self assert: (OrderedCollection with: 'Extracción por 50.' with: 'Extracción por 76.') equals: summary.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 20:01:22'!
test18accountSummaryWithOneTransfer
	| origin destination originSummary destinationSummary |
	origin := ReceptiveAccount new.
	destination := ReceptiveAccount new.
	Transfer from: origin to: destination for: 100.
	
	originSummary := origin summary.
	destinationSummary := destination summary.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 100.') equals: originSummary .
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100.') equals: destinationSummary .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 20:26:28'!
test19accountSummaryWithMultipleTransfers
	| account1 account2 summary1 summary2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to: account2 for: 100.
	Transfer from: account2 to: account1 for: 25.
	
	summary1 := account1 summary.
	summary2 := account2 summary.
	
	self assert: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Entrada por transferencia de 25.') equals: summary1 .
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Salida por transferencia de 25.') equals: summary2 .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:09:00'!
test20accountSummaryWithMultipleTransactions
	| account1 account2 account3 summary1 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Transfer from: account2 to: account1 for: 200.
	Deposit register: 100 on: account1.
	Transfer from: account1 to: account3 for: 140.
	Withdraw register: 23 on: account1.
	
	summary1 := account1 summary.
	
	self assert: (OrderedCollection
		with: 'Entrada por transferencia de 200.'
		with: 'Depósito por 100.'
		with: 'Salida por transferencia de 140.'
		with: 'Extracción por 23.')
		equals: summary1 .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 22:48:13'!
test21accountWithNoTransfersHasTransferNetZero
	| account |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Withdraw register: 29 on: account.
	
	self assert: 0 equals: account transferNet.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:01:04'!
test22accountWithOneTransferHasCorrectTransferNet
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self transferenciaFor100From: account2 to: account1. 
	
	self assert: 100 equals: account1 transferNet.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:02:15'!
test23accountWithManyTransfersHasCorrectTransferNet
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 200.
	Transfer from: account2 to: account1 for: 90.
	
	self assert: -110 equals: account1 transferNet.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'grm 10/19/2022 23:10:24'!
test24emptyAccountHasTransferNetZero
	
	self assert: 0 equals: ReceptiveAccount new transferNet.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'grm 10/19/2022 23:30:11'!
initializeNamed: aName

	name := aName .! !


!Account methodsFor: 'report' stamp: 'grm 10/19/2022 22:11:33'!
summary
	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'names' stamp: 'grm 10/19/2022 23:42:17'!
assetName
	self subclassResponsibility ! !

!Account methodsFor: 'names' stamp: 'grm 10/19/2022 23:42:21'!
assetTree
	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'grm 10/19/2022 23:30:26'!
named: aName

	^self new initializeNamed: aName.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'grm 10/19/2022 23:27:02'!
initialize
	
	name := 'Portfolio'.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'report' stamp: 'grm 10/19/2022 22:15:25'!
summary
	| summary |
	
	summary := OrderedCollection new.
	accounts do: [ :anAccount | summary addAll: anAccount summary ].
	
	^summary ! !

!Portfolio methodsFor: 'report' stamp: 'grm 10/19/2022 23:12:21'!
transferNet
	
	^accounts inject: 0 into: [:currentNet :anAccount | currentNet + anAccount transferNet]! !

!Portfolio methodsFor: 'report' stamp: 'grm 10/19/2022 23:41:29'!
tree
	^self assetTree.! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'names' stamp: 'grm 10/19/2022 23:35:48'!
assetName
	^name.! !

!Portfolio methodsFor: 'names' stamp: 'grm 10/19/2022 23:52:13'!
assetTree
	| nameTree |
	nameTree _ OrderedCollection with: self assetName.
	
	accounts do: [ :anAccount | nameTree addAll: anAccount assetTree ].
	
	^nameTree! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'grm 10/19/2022 19:59:06'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectsBalance: currentBalance of: self]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'grm 10/19/2022 23:27:14'!
initialize

	super initialize.
	name := 'Cuenta'.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'grm 10/19/2022 20:04:09'!
summary
	^transactions collect: [:transaction | transaction report: self].! !

!ReceptiveAccount methodsFor: 'report' stamp: 'grm 10/19/2022 22:52:13'!
transferNet
	^transactions inject: 0 into: [:currentNet :aTransaction | aTransaction affectsTransferNet: currentNet of: self ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'names' stamp: 'grm 10/19/2022 23:42:58'!
assetName
	^name! !

!ReceptiveAccount methodsFor: 'names' stamp: 'grm 10/19/2022 23:43:32'!
assetTree
	^OrderedCollection with: self assetName .! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'affects' stamp: 'grm 10/19/2022 19:56:26'!
affectsBalance: aBalance of: anAccount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'affects' stamp: 'grm 10/19/2022 22:57:29'!
affectsTransferNet: aCurrentNet of: anAccount

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'grm 10/19/2022 20:04:09'!
report: anAccount
	self subclassResponsibility! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'affects' stamp: 'grm 10/19/2022 19:56:39'!
affectsBalance: aBalance of: anAccount

	^aBalance + value ! !

!Deposit methodsFor: 'affects' stamp: 'grm 10/19/2022 22:56:01'!
affectsTransferNet: aTransferNet of: anAccount
	^aTransferNet! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'report' stamp: 'grm 10/19/2022 20:04:09'!
report: anAccount
	^'Depósito por ' , value asString , '.'! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'value originAccount destinationAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'account' stamp: 'grm 10/19/2022 20:13:50'!
otherEnd: anAccount

	(self isOrigin: anAccount) ifTrue: [^destinationAccount].
	(self isDestination: anAccount) ifTrue: [^originAccount].
	self raiseForeignAccountError.! !


!Transfer methodsFor: 'account - private' stamp: 'grm 10/18/2022 21:06:17'!
isDestination: anAccount
	^anAccount = destinationAccount ! !

!Transfer methodsFor: 'account - private' stamp: 'grm 10/18/2022 21:06:08'!
isOrigin: anAccount
	^anAccount = originAccount ! !

!Transfer methodsFor: 'account - private' stamp: 'grm 10/19/2022 20:13:22'!
raiseForeignAccountError

	^ self error: self class accountIsNotPartOfTransactionErrorDescription! !


!Transfer methodsFor: 'affects' stamp: 'grm 10/19/2022 22:54:48'!
affectsAmount: aCurrentAmount of: anAccount

	(self isOrigin: anAccount) ifTrue: [^aCurrentAmount - value].
	(self isDestination: anAccount) ifTrue: [^aCurrentAmount + value].
	self raiseForeignAccountError.! !

!Transfer methodsFor: 'affects' stamp: 'grm 10/19/2022 22:55:10'!
affectsBalance: aBalance of: anAccount

	^self affectsAmount: aBalance of: anAccount .! !

!Transfer methodsFor: 'affects' stamp: 'grm 10/19/2022 22:55:20'!
affectsTransferNet: aCurrentNet of: anAccount

	^self affectsAmount: aCurrentNet of: anAccount .! !


!Transfer methodsFor: 'initialization' stamp: 'grm 10/18/2022 20:47:32'!
initializeFrom: anOriginAccount to: aDestinationAccount for: anAmountOfMoney 
	originAccount := anOriginAccount.
	destinationAccount := aDestinationAccount.
	value := anAmountOfMoney.
	
	anOriginAccount register: self.
	aDestinationAccount register: self.
	
	! !


!Transfer methodsFor: 'report' stamp: 'grm 10/19/2022 20:13:22'!
report: anAccount
	(self isOrigin: anAccount) ifTrue: [^'Salida por transferencia de ' , value asString , '.'].
	(self isDestination: anAccount) ifTrue: [^'Entrada por transferencia de ', value asString , '.'].
	self raiseForeignAccountError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error message' stamp: 'grm 10/18/2022 21:15:17'!
accountIsNotPartOfTransactionErrorDescription
	^'That account is not a part of this transaction!!!!!!'! !


!Transfer class methodsFor: 'instance creation' stamp: 'grm 10/18/2022 20:46:23'!
from: anOriginAccount to: aDestinationAccount for: anAmountOfMoney 
	^self new initializeFrom: anOriginAccount to: aDestinationAccount for: anAmountOfMoney ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'affects' stamp: 'grm 10/19/2022 19:59:30'!
affectsBalance: aBalance of: anAccount 

	^aBalance - value! !

!Withdraw methodsFor: 'affects' stamp: 'grm 10/19/2022 22:56:29'!
affectsTransferNet: aTransferNet of: anAccount 
	^aTransferNet! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'report' stamp: 'grm 10/19/2022 20:04:09'!
report: anAccount
	^'Extracción por ' , value asString , '.'! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
