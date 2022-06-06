"
I am a Morph represent motor movement virtically.

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
	#name : #FWJVirticalMotorMorph,
	#superclass : #FWJHorizontalMotorMorph,
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #examples }
FWJVirticalMotorMorph class >> example [

	"self example"
	^super example
]

{ #category : #drawing }
FWJVirticalMotorMorph >> drawOn: aCanvas [
	
	| fillRect fillColor	|
	fillColor := model isMoving ifTrue: [Color red] ifFalse: [Color gray].
	aCanvas fillRectangle: self bounds color: fillColor.
	
	fillRect := (self bounds origin x @ (self bounds origin y + (self height * (1 - model rate)))) corner: self bounds corner.
	fillColor := model isMoving ifTrue: [Color green] ifFalse: [Color orange].
	aCanvas fillRectangle: fillRect color: fillColor.


]
