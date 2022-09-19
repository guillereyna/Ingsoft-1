!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MSS 9/19/2022 00:25:19'!
test01FindReturnsSingleSentenceWithPrefix
	| sentencesStartingWithWint wSentences wSentenceFinder |
	wSentences := OrderedCollection with: 'winter is coming' 
									with: 'winning is everything'
									with: 'The winds of Winter'
									with: 'Winter is here'.
	wSentenceFinder := SentenceFinderByPrefix with: wSentences.
	sentencesStartingWithWint := OrderedCollection with: 'Winter is here'.
	self assert: (wSentenceFinder find: 'Wint') = sentencesStartingWithWint.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'grm 9/19/2022 01:35:06'!
test02EmptyPrefixRaisesError
	self 
		should: [ |  wSentenceFinder |
				wSentenceFinder := SentenceFinderByPrefix with: (OrderedCollection with: 'hello').
				(wSentenceFinder find: '') = OrderedCollection new. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixCannotBeEmptyError ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MSS 9/19/2022 00:45:04'!
test03EmptyFinderReturnsEmptyCollection
	| wSentences wSentenceFinder |
	wSentences := OrderedCollection new.
	wSentenceFinder := SentenceFinderByPrefix with: wSentences.
	self assert: (wSentenceFinder find: 'Wint') = OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'grm 9/19/2022 02:10:11'!
test04StackIsPreservedAfterFind
	| originalSentenceFinder wSentences wSentenceFinder |
	wSentences := OrderedCollection with: 'winter is coming' 
									with: 'winning is everything'
									with: 'The winds of Winter'
									with: 'Winter is here'.
	wSentenceFinder := SentenceFinderByPrefix with: wSentences.
	originalSentenceFinder  := SentenceFinderByPrefix with: wSentences.
	wSentenceFinder find: 'Wint'.
	self assert: (wSentenceFinder = originalSentenceFinder) .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'grm 9/19/2022 01:44:37'!
test05FindReturnsMultipleSentencesWithPrefix
| sentencesStartingWithwin wSentences wSentenceFinder |
	wSentences := OrderedCollection with: 'winter is coming' 
									with: 'winning is everything'
									with: 'The winds of Winter'
									with: 'Winter is here'.
	wSentenceFinder := SentenceFinderByPrefix with: wSentences.
	sentencesStartingWithwin := OrderedCollection with: 'winning is everything' with: 'winter is coming'.
	self assert: (wSentenceFinder find: 'win') = sentencesStartingWithwin.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'grm 9/18/2022 17:12:31'!
isEmpty
	^topElement isBase.! !

!OOStack methodsFor: 'accessing' stamp: 'grm 9/18/2022 17:22:42'!
size
	^size.! !


!OOStack methodsFor: 'private' stamp: 'grm 9/18/2022 17:45:39'!
newTopElement: aStackElement
	topElement := aStackElement.
	size := size - 1.! !


!OOStack methodsFor: 'operations' stamp: 'grm 9/18/2022 17:47:22'!
pop
	^topElement popFromStack: self.
	"| oldTop |
	oldTop := topElement returnValue.
	topElement := topElement next.
	size := size - 1.
	^oldTop."! !

!OOStack methodsFor: 'operations' stamp: 'grm 9/18/2022 17:26:38'!
push: aValue
	topElement := StackElement new initializeWith: aValue withNext: topElement.
	size := size + 1.
	
	! !

!OOStack methodsFor: 'operations' stamp: 'grm 9/18/2022 17:19:33'!
top
	^topElement returnValue.! !


!OOStack methodsFor: 'initialization' stamp: 'grm 9/18/2022 17:27:16'!
initialize
	topElement := StackBase new.
	size := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'MSS 9/19/2022 00:31:17'!
initializeWith: anOrderedCollection
	stack := OOStack new initialize .
	anOrderedCollection do: [:sentence | stack push: sentence.].
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'MSS 9/19/2022 01:14:06'!
showStack
	^stack
	! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'grm 9/18/2022 19:28:40'!
addSentence: aStringSentence
	stack push: aStringSentence.
	! !


!SentenceFinderByPrefix methodsFor: 'comparing' stamp: 'grm 9/19/2022 02:23:53'!
= aSentenceFinder
	|otherStack result|
	result := true.
	otherStack := aSentenceFinder showStack.
	[stack isEmpty] whileFalse: [result := result and: [stack pop = otherStack pop].].
	^result.
	! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'MSS 9/19/2022 15:46:43'!
find: aPrefixString
	|backupCollection collectionOfAllSentencesWithPrefix|
	aPrefixString isEmpty ifTrue:[self error: self class prefixCannotBeEmptyError]."los colaboradores no son del mismo dominio aca"
	collectionOfAllSentencesWithPrefix  := OrderedCollection new.
	
	backupCollection := OrderedCollection new.
	[stack isEmpty] whileFalse: [backupCollection addFirst: stack pop.
						   (backupCollection first beginsWith: aPrefixString)
							ifTrue:[collectionOfAllSentencesWithPrefix addLast: backupCollection first.]].
	backupCollection do: [:sentence| stack push: sentence].
	^collectionOfAllSentencesWithPrefix .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'MSS 9/19/2022 00:58:33'!
prefixCannotBeEmptyError
	^'Prefix cannot be empty!!'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'MSS 9/19/2022 00:40:37'!
with: anOrderedCollection 
	^self new initializeWith: anOrderedCollection.! !


!classDefinition: #StackBase category: 'Stack-Exercise'!
Object subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'private' stamp: 'grm 9/18/2022 17:58:38'!
popFromStack: aStack
	self error: OOStack stackEmptyErrorDescription.! !

!StackBase methodsFor: 'private' stamp: 'grm 9/18/2022 17:09:45'!
returnValue
	self error: OOStack stackEmptyErrorDescription.! !


!StackBase methodsFor: 'testing' stamp: 'grm 9/18/2022 17:12:44'!
isBase
	^true.! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'next value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'testing' stamp: 'grm 9/18/2022 17:12:56'!
isBase
	^false.! !


!StackElement methodsFor: 'accessing' stamp: 'grm 9/18/2022 17:16:13'!
next
	^next! !


!StackElement methodsFor: 'private' stamp: 'grm 9/18/2022 17:47:44'!
popFromStack: aStack
	aStack newTopElement: next.
	^value.! !

!StackElement methodsFor: 'private' stamp: 'grm 9/18/2022 17:10:42'!
returnValue
	^value.! !


!StackElement methodsFor: 'initialization' stamp: 'grm 9/18/2022 17:08:11'!
initializeWith: aValue withNext: aNextStackElement
	value := aValue.
	next := aNextStackElement.! !
