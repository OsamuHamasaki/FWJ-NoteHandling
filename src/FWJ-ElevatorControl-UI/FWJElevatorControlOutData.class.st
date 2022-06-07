"
I am a utility for decode outdata from FWJ-ElevatorControl application.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	data:		<Object>


    Implementation Points
"
Class {
	#name : #FWJElevatorControlOutData,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #accessing }
FWJElevatorControlOutData >> data: anInteger [
	
		data := anInteger
	
]

{ #category : #testing }
FWJElevatorControlOutData >> isDoorForwardOn [
	
	^ (data & 4) = 4
]

{ #category : #testing }
FWJElevatorControlOutData >> isDoorReverseOn [
	
	^ (data & 8) = 8
]

{ #category : #testing }
FWJElevatorControlOutData >> isDownstairCallButtonLampOn [
	
	^ (data & 32) = 32
]

{ #category : #testing }
FWJElevatorControlOutData >> isDownstairRequestButtonLampOn [
	
	^ (data & 128	) = 128
]

{ #category : #testing }
FWJElevatorControlOutData >> isLiftForwardOn [
	
	^ (data & 1) = 1
]

{ #category : #testing }
FWJElevatorControlOutData >> isLiftReverseOn [
	
	^ (data & 2) = 2
]

{ #category : #testing }
FWJElevatorControlOutData >> isUpstairCallButtonLampOn [
	
	^ (data & 16) = 16
]

{ #category : #testing }
FWJElevatorControlOutData >> isUpstairRequestButtonLampOn [
	
	^ (data & 64	) = 64
]
