"
I am a Morph represents Button for FWJ-ElevatorControl.

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
	#name : #FWJButtonMorph,
	#superclass : #FWJSwitchMorph,
	#instVars : [
		'isLampOn'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #switching }
FWJButtonMorph >> colorOfState [
	
	^isLampOn 
		ifTrue: [Color lightOrange]
		ifFalse: [super colorOfState]
]

{ #category : #initialization }
FWJButtonMorph >> initialize [
	
	super initialize.
	isLampOn := false.
]

{ #category : #'changing state' }
FWJButtonMorph >> lampOff [
	
	isLampOn := false.
	self changed.
]

{ #category : #'changing state' }
FWJButtonMorph >> lampOn [
	
	isLampOn := true.
	self changed.
]
