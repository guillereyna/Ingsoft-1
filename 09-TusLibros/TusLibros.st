!classDefinition: #BookCartTest category: 'TusLibros'!
TestCase subclass: #BookCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:54:23'!
test01newCartIsEmpty
	| cart |
	cart _ BookCart with: Set new.
	
	self assert: cart isEmpty.! !

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:20:11'!
test02cartIsNotEmptyAfterAddingBook
	| cart catalog |
	catalog _ Set new.
	catalog add: #Book.
	
	cart _ BookCart withCatalog: catalog.
	cart add: #Book.
	
	self deny: cart isEmpty.! !

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:20:54'!
test03cannotAddBookNotIncludedInCatalog
	| cart catalog |
	catalog _ Set new.
	cart _ BookCart withCatalog: catalog.
	
	self
		should: [cart add: #Book]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error |
			self assert: cart class cannotAddBookNotInCatalogErrorDescription equals: error messageText.
			self assert: cart isEmpty.]
	
	! !

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:53:49'!
test04booksAddedAreInCartAndNothingElse
	| cart catalog |
	catalog _ Set with: #BookISBN1 with: #BookISBN2 with: #BookISBN3.
	cart _ BookCart withCatalog: catalog.
	
	cart add: #BookISBN1.
	cart add: #BookISBN2.
	cart add: #BookISBN3.
		
	self assert: (OrderedCollection with: #BookISBN1 with: #BookISBN2 with: #BookISBN3) equals: cart list.! !

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:53:49'!
test05booksAddedAndDeletedAreConsistentWithBooksInCart
	| cart catalog |
	catalog _ Set with: #BookISBN1 with: #BookISBN2 with: #BookISBN3.
	cart _ BookCart withCatalog: catalog.
	
	cart add: #BookISBN1.
	cart add: #BookISBN2.
	cart add: #BookISBN3.
	cart remove: #BookISBN2.
	
	self assert: (OrderedCollection with: #BookISBN1 with: #BookISBN3)  
		equals: cart list.! !

!BookCartTest methodsFor: 'test' stamp: 'grm 10/27/2022 21:53:49'!
test06canAddSameBookMultipleTimes
	| cart catalog |
	catalog _ Set with: #BookISBN1.
	cart _ BookCart withCatalog: catalog.
	
	cart add: #BookISBN1.
	cart add: #BookISBN1.
	
	self assert: (OrderedCollection with: #BookISBN1 with: #BookISBN1)  
		equals: cart list.! !


!classDefinition: #BookCart category: 'TusLibros'!
Object subclass: #BookCart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCart methodsFor: 'as yet unclassified' stamp: 'grm 10/27/2022 21:13:50'!
add: aBook 
	(catalog includes: aBook) ifFalse: [self error: self class cannotAddBookNotInCatalogErrorDescription].
	books add: aBook! !

!BookCart methodsFor: 'as yet unclassified' stamp: 'grm 10/27/2022 20:55:13'!
isEmpty
	^books isEmpty! !

!BookCart methodsFor: 'as yet unclassified' stamp: 'grm 10/27/2022 21:32:12'!
numberOfBooks
	^books size! !

!BookCart methodsFor: 'as yet unclassified' stamp: 'grm 10/27/2022 21:31:55'!
remove: aBook 
	books remove: aBook.! !


!BookCart methodsFor: 'initialization' stamp: 'grm 10/27/2022 21:09:56'!
initializeWithCatalog: aBookCatalog 
	books _ OrderedCollection new.
	catalog := aBookCatalog.! !


!BookCart methodsFor: 'accessing' stamp: 'grm 10/27/2022 21:53:49'!
list
	^books copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookCart class' category: 'TusLibros'!
BookCart class
	instanceVariableNames: ''!

!BookCart class methodsFor: 'instance creation' stamp: 'grm 10/27/2022 21:14:18'!
cannotAddBookNotInCatalogErrorDescription
	^'Cannot add book because it does not exist in the catalog'! !

!BookCart class methodsFor: 'instance creation' stamp: 'grm 10/27/2022 21:01:42'!
withCatalog: aBookCatalog 
	^self new initializeWithCatalog: aBookCatalog ! !
