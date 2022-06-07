"
I am a abstruct super class of FWJHorizontalMotorMorph & FWJVirticalMotorMorph.

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
	#name : #FWJMotorMorph,
	#superclass : #Morph,
	#instVars : [
		'model'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #drawing }
FWJMotorMorph >> drawBackgroundOn:  aCanvas [
	
	| fillColor |
	fillColor := model isMoving ifTrue: [Color red] ifFalse: [Color gray].
	aCanvas fillRectangle: self bounds color: fillColor.

]

{ #category : #drawing }
FWJMotorMorph >> drawForgroundOn: aCanvas [
	
	| fillColor fillRect	|	
	fillColor := model isMoving ifTrue: [Color green] ifFalse: [Color orange].
	fillRect := self fillRectForForground: model rate.
	aCanvas fillRectangle: fillRect color: fillColor.


]

{ #category : #drawing }
FWJMotorMorph >> drawOn: aCanvas [
	
	self drawBackgroundOn: aCanvas.
	self drawForgroundOn: aCanvas.

]

{ #category : #drawing }
FWJMotorMorph >> fillRectForForground: rate [

	self subclassResponsibility 
]

{ #category : #accessing }
FWJMotorMorph >> model: aMotorWithLimit [
	
	model := aMotorWithLimit.
	model addDependent: self.
]

{ #category : #updating }
FWJMotorMorph >> update: aParameter [
	
	self changed.
]
