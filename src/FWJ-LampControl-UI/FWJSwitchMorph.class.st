"
I am a Morph for FWJ-LampControl-UI, I represent a Switch.

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
	#name : #FWJSwitchMorph,
	#superclass : #Morph,
	#instVars : [
		'mouseDownAction',
		'mouseUpAction',
		'state',
		'colorOfStateDict',
		'labelMorph'
	],
	#category : #'FWJ-LampControl-UI'
}

{ #category : #'instance creation' }
FWJSwitchMorph class >> newLabeled: aString [
	
	^self basicNew
		label: aString;
		initialize;
		yourself
	
]

{ #category : #'instance creation' }
FWJSwitchMorph class >> open [
	
	"self open"
	| aMorph aPresenter |
	aMorph := self newLabeled: 'Power Switch'.
	aMorph mouseDownAction: [ Transcript crTrace: 'mouse down' ].
	aMorph mouseUpAction: [ Transcript crTrace: 'mouse up' ].
	aPresenter := SpMorphPresenter new morph: aMorph.
	aPresenter open.
	^aMorph
]

{ #category : #switching }
FWJSwitchMorph >> colorOfState [
	
	^colorOfStateDict at: state
]

{ #category : #drawing }
FWJSwitchMorph >> drawOn: aCanvas [
	
	super drawOn: aCanvas.
	aCanvas fillRectangle: self bounds color: self colorOfState.
	
]

{ #category : #'event handling' }
FWJSwitchMorph >> handlesMouseDown: evt [

	^true
]

{ #category : #initialization }
FWJSwitchMorph >> initialize [
	
	super initialize.
	mouseDownAction := [ ].
	mouseUpAction := [ ].
	state := #OFF.
	colorOfStateDict := Dictionary newFrom: { #OFF->Color gray . #ON->Color lightGray }.
	self
		layoutPolicy: TableLayout new;
		wrapCentering: #center;
		listCentering: #center.
	self addMorph: labelMorph.
	
]

{ #category : #accessing }
FWJSwitchMorph >> label: aString [
	
	labelMorph := StringMorph contents: aString.
	labelMorph
		color: Color white;
		emphasis: 2r1.
]

{ #category : #'event handling' }
FWJSwitchMorph >> mouseDown: evt [
	
	mouseDownAction value.
	state := #ON.
	self changed.
]

{ #category : #accessing }
FWJSwitchMorph >> mouseDownAction: aBlock [

	mouseDownAction := aBlock
]

{ #category : #'event handling' }
FWJSwitchMorph >> mouseUp: evt [
	
	mouseUpAction value.
	state := #OFF.
	self changed.
]

{ #category : #accessing }
FWJSwitchMorph >> mouseUpAction: aBlock [

	mouseUpAction := aBlock
]
