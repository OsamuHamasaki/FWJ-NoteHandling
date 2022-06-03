"
I am a Morph represent a sensor state for FWJ-ElevatorControl.

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
	#name : #FWJSensorMorph,
	#superclass : #Morph,
	#instVars : [
		'model',
		'aspect'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #examples }
FWJSensorMorph class >> example [

	"self example"
	| motor aMorph aPresenter |
	motor := FWJMotorWithLimit new.
	aMorph := self new
					model: motor aspect: #isOnBackwardLimit;
					yourself.
	motor addDependent: aMorph.
	aPresenter := SpMorphPresenter new morph: aMorph.
	aPresenter open.

	^aMorph
]

{ #category : #drawing }
FWJSensorMorph >> drawOn: aCanvas [

	| fillColor |
	super drawOn: aCanvas.
	fillColor := (model perform: aspect) ifTrue: [ Color white ] ifFalse: [ Color darkGray ].
	aCanvas fillRectangle: self bounds color: fillColor.

]

{ #category : #accessing }
FWJSensorMorph >> model: aModel aspect: aSymbol [
	
	model := aModel.
	aspect := aSymbol
]

{ #category : #updating }
FWJSensorMorph >> update: aParameter [

	self changed.
]
