!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'internal' stamp: 'grm 8/25/2022 20:44:29'!
next
	^II! !

!I class methodsFor: 'internal' stamp: 'grm 8/29/2022 21:07:57'!
previous
	self shouldBeImplemented.! !


!I class methodsFor: 'auxiliary' stamp: 'grm 9/4/2022 21:45:21'!
negativeNumbersNotSupportedErrorDescription
	^'natural numbers cannot be divided in natural division by a larger natural number'! !

!I class methodsFor: 'auxiliary' stamp: 'grm 8/29/2022 20:53:49'!
substractFrom: aMinuend 
	^aMinuend previous.! !


!I class methodsFor: 'operation' stamp: 'grm 8/29/2022 21:10:35'!
* aMultiplier 
	^aMultiplier .! !

!I class methodsFor: 'operation' stamp: 'grm 8/25/2022 21:11:47'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'operation' stamp: 'grm 9/2/2022 20:17:07'!
- aMinuend
	self error: I negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operation' stamp: 'grm 9/4/2022 21:46:52'!
/ aDenominator
	aDenominator = I ifTrue: [^I]
		ifFalse: [self error: II canNotDivideByBiggerNumberErrorDescription.].! !

!I class methodsFor: 'operation' stamp: 'grm 9/4/2022 18:56:26'!
> aComparer
	^false.! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operation' stamp: 'grm 8/29/2022 21:14:57'!
* aMultiplier
	^aMultiplier + (self previous * aMultiplier) .! !

!II class methodsFor: 'operation' stamp: 'grm 8/25/2022 21:18:40'!
+ anAdder 
	^self previous + anAdder next .! !

!II class methodsFor: 'operation' stamp: 'grm 8/29/2022 20:50:07'!
- aRestand
	^aRestand substractFrom: self .! !

!II class methodsFor: 'operation' stamp: 'grm 9/4/2022 21:41:54'!
/ aDenominator
	aDenominator = I ifTrue: [^self].
	self = aDenominator ifTrue: [^I].
	self > aDenominator ifTrue: [^I + (self - aDenominator / aDenominator).]
		ifFalse: [self error: self canNotDivideByBiggerNumberErrorDescription].! !

!II class methodsFor: 'operation' stamp: 'grm 9/4/2022 21:02:49'!
> aComparer
	(aComparer isEqualTo: I) ifTrue: [^true].
	(self isEqualTo: aComparer) ifTrue: [^false].
	^self previous > aComparer previous.
	! !


!II class methodsFor: 'auxiliary' stamp: 'grm 9/4/2022 21:45:15'!
canNotDivideByBiggerNumberErrorDescription
	^'natural numbers cannot be divided in natural division by a larger natural number'! !

!II class methodsFor: 'auxiliary' stamp: 'grm 8/29/2022 20:54:22'!
substractFrom: aMinuend
	^aMinuend previous - self previous .! !


!II class methodsFor: 'internal' stamp: 'grm 8/29/2022 21:34:32'!
nameOfNext
	(self name endsWith: 'CMXCIX') ifTrue: [^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^ self name , 'I'.! !

!II class methodsFor: 'internal' stamp: 'grm 8/29/2022 21:17:36'!
next
	next ifNil: [
		next := II createChildNamed: self nameOfNext.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'internal' stamp: 'grm 8/25/2022 21:19:54'!
previous
	^previous! !

!II class methodsFor: 'internal' stamp: 'grm 8/25/2022 21:25:15'!
previous: aNumber
	previous := aNumber! !

!II class methodsFor: 'internal' stamp: 'grm 8/25/2022 21:37:45'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil
	].! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'grm 9/4/2022 21:47:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'grm 9/4/2022 21:47:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NumerosNaturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NumerosNaturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'grm 9/4/2022 21:47:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!