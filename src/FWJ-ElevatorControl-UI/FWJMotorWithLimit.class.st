"
I represent a motor with limit switch for FWJ-ElevatorControl.

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
	#name : #FWJMotorWithLimit,
	#superclass : #Model,
	#instVars : [
		'position',
		'direction',
		'maxValueOfPosition'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #private }
FWJMotorWithLimit >> backward [

	position == 0 ifTrue: [ ^self ].
	position := position - 1.
	self changed.
]

{ #category : #private }
FWJMotorWithLimit >> forward [

	position == maxValueOfPosition  ifTrue: [ ^self ].
	position := position + 1.
	self changed

]

{ #category : #'changing state' }
FWJMotorWithLimit >> goBackward [
	
	direction := #backward.
	self changed.
]

{ #category : #'changing state' }
FWJMotorWithLimit >> goForward [
	
	direction := #forward.
	self changed.
]

{ #category : #initialization }
FWJMotorWithLimit >> initialize [

	super initialize.
	position := 0.
	direction := #noMove.
	maxValueOfPosition := 100.
]

{ #category : #testing }
FWJMotorWithLimit >> isMoving [
	
	^ direction ~= #noMove
]

{ #category : #testing }
FWJMotorWithLimit >> isOnBackwardLimit [
	
	^ position == 0.
]

{ #category : #testing }
FWJMotorWithLimit >> isOnForwardLimit [
	
	^ position == maxValueOfPosition .
]

{ #category : #private }
FWJMotorWithLimit >> noMove [

]

{ #category : #accessing }
FWJMotorWithLimit >> rate [

	^position / maxValueOfPosition 
]

{ #category : #'changing state' }
FWJMotorWithLimit >> stop [
	
	direction := #noMove.
	self changed.
]

{ #category : #'update cycle' }
FWJMotorWithLimit >> tick [
	
	self perform: direction
]
