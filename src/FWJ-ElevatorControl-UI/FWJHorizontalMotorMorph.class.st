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
	#superclass : #FWJMotorMorph,
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
FWJHorizontalMotorMorph >> fillRectForForground: rate [
	
	^self bounds origin extent: (self bounds extent x * rate) @ (self bounds extent y).

]
