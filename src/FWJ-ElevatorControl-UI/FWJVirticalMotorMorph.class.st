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
	#superclass : #FWJMotorMorph,
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #examples }
FWJVirticalMotorMorph class >> example [

	"self example"
	^super example
]

{ #category : #drawing }
FWJVirticalMotorMorph >> fillRectForForground: rate [
	
	^(self bounds origin x @ (self bounds origin y + (self height * (1 - rate)))) corner: self bounds corner.

]
