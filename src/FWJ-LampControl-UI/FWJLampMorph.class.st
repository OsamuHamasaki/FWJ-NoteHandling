"
I am a Morph for FWJ-LampControl-UI, I represent a Lamp.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #FWJLampMorph,
	#superclass : #Morph,
	#instVars : [
		'state',
		'colorOfStateDict'
	],
	#category : #'FWJ-LampControl-UI'
}

{ #category : #'instance creation' }
FWJLampMorph class >> open [
	
	"self open"
	| aMorph aPresenter |
	aMorph := self new.
	aPresenter := SpMorphPresenter new morph: aMorph.
	aPresenter open.
	^aMorph
]

{ #category : #switching }
FWJLampMorph >> colorOfState [
	
	^colorOfStateDict at: state
]

{ #category : #drawing }
FWJLampMorph >> drawOn: aCanvas [

	super drawOn: aCanvas.
	aCanvas fillRectangle: self bounds color: self colorOfState.

	
]

{ #category : #initialization }
FWJLampMorph >> initialize [
	
	super initialize.
	state := #OFF.
	colorOfStateDict := Dictionary newFrom: { #OFF->Color black . #BRIGHT->Color white . #DARK->Color lightGray }.

]

{ #category : #switching }
FWJLampMorph >> turnOff [
	
	state := #OFF.
	self changed.
]

{ #category : #switching }
FWJLampMorph >> turnOnBright [
	
	state := #BRIGHT.
	self changed
]

{ #category : #switching }
FWJLampMorph >> turnOnDark [

	state := #DARK.
	self changed
]
