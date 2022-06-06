"
I am a Morph represent motor movement for FWJ-ElevatorControl.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	model:		<Object>


    Implementation Points
"
Class {
	#name : #FWJHorizontalMotorMorph,
	#superclass : #Morph,
	#instVars : [
		'model'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #examples }
FWJHorizontalMotorMorph class >> example [

	"self example"
	| motor aMorph aPresenter |
	motor := FWJMotorWithLimit new.
	aMorph := self new
					model: motor;
					yourself.
	motor addDependent: aMorph.
	aPresenter := SpMorphPresenter new morph: aMorph.
	aPresenter open.

	^aMorph
]

{ #category : #drawing }
FWJHorizontalMotorMorph >> drawOn: aCanvas [
	
	| fillColor fillRect |
	fillColor := model isMoving ifTrue: [Color red] ifFalse: [Color gray].
	aCanvas fillRectangle: self bounds color: fillColor.
	
	fillRect := self bounds origin extent: (self bounds extent x * model rate) @ (self bounds extent y).
	fillColor := model isMoving ifTrue: [Color green] ifFalse: [Color orange].
	aCanvas fillRectangle: fillRect color: fillColor.


]

{ #category : #accessing }
FWJHorizontalMotorMorph >> model: aMotorWithLimit [
	
	model := aMotorWithLimit.
	model addDependent: self.
]

{ #category : #updating }
FWJHorizontalMotorMorph >> update: aParameter [
	
	self changed.
]
