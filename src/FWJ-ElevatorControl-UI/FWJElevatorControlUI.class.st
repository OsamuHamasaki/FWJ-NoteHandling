"
I am a SpApplication for FWJ-ElevatorControl-UI.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	isDownstairCallButtonOn:		<Object>
	isDownstairRequestButtonOn:		<Object>
	isUpstairCallButtonOn:		<Object>
	isUpstairRequestButtonOn:		<Object>
	presenter:		<Object>
	socketServer:		<Object>


    Implementation Points
"
Class {
	#name : #FWJElevatorControlUI,
	#superclass : #SpApplication,
	#instVars : [
		'presenter',
		'socketServer',
		'isUpstairCallButtonOn',
		'isUpstairRequestButtonOn',
		'isDownstairCallButtonOn',
		'isDownstairRequestButtonOn'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #'instance creation' }
FWJElevatorControlUI class >> open [
	"self open"
	
	^self new
		open;
		yourself
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> downstairCallButtonPressed [

	isDownstairCallButtonOn := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> downstairCallButtonReleased [

	isDownstairCallButtonOn := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> downstairRequestButtonPressed [

	isDownstairRequestButtonOn := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> downstairRequestButtonReleased [

	isDownstairRequestButtonOn := false.
]

{ #category : #initialization }
FWJElevatorControlUI >> initialize [

	super initialize.
	isUpstairCallButtonOn := false.
	isUpstairRequestButtonOn := false.
	isDownstairCallButtonOn := false.
	isDownstairRequestButtonOn := false.
	
	presenter := FWJElevatorControlUIPresenter newApplication: self.
	presenter
		upstairCallButtonOnAction: [ self upstairCallButtonPressed ];
		upstairCallButtonOffAction: [ self upstairCallButtonReleased ];
		upstairRequestButtonOnAction: [ self upstairRequestButtonPressed ];
		upstairRequestButtonOffAction: [ self upstairRequestButtonReleased ];
		downstairCallButtonOnAction: [ self downstairCallButtonPressed ];
		downstairCallButtonOffAction: [ self downstairCallButtonReleased ];
		downstairRequestButtonOnAction: [ self downstairRequestButtonPressed ];
		downstairRequestButtonOffAction: [ self downstairRequestButtonReleased ].
		
	socketServer := SimpleTCPServer new
		listeningPort: 3000;
		onDataReceive: [ :socket :receivedData | socket sendData: (self onDataReceived: receivedData) ];
		yourself


]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> onDataReceived: aString [

	| outdata indata isDoorForwardOn isDoorReverseOn isLiftForwardOn isLiftReverseOn isUpstairCallButtonLampOn isUpstairRequestButtonLampOn isDownstairCallButtonLampOn isDownstairRequestButtonLampOn |
	outdata := aString asInteger.
	
	isLiftForwardOn := (outdata & 1) = 1.
	isLiftReverseOn := (outdata & 2) = 2.
	isDoorForwardOn := (outdata & 4) = 4.
	isDoorReverseOn := (outdata & 8) = 8.
	isUpstairCallButtonLampOn := (outdata & 16) = 16.
	isDownstairCallButtonLampOn := (outdata & 32) = 32.
	isUpstairRequestButtonLampOn := (outdata & 64) = 64.
	isDownstairRequestButtonLampOn := (outdata & 128) = 128.
	
	isLiftForwardOn
		ifTrue: [ presenter liftGoUp ]
		ifFalse: [ 
			isLiftReverseOn
				ifTrue: [ presenter liftGoDown ]
				ifFalse: [ presenter liftStop ] ].
			
	isDoorForwardOn
		ifTrue: [ presenter doorOpen ]
		ifFalse: [ 
			isDoorReverseOn
				ifTrue: [ presenter doorClose ]
				ifFalse: [ presenter doorStop ] ].
	
	isUpstairCallButtonLampOn ifTrue: [ presenter upstairCallButtonLampOn ] ifFalse: [ presenter upstairCallButtonLampOff ].
	isUpstairRequestButtonLampOn ifTrue: [ presenter upstairRequestButtonLampOn ] ifFalse: [ presenter upstairRequestButtonLampOff ].
	isDownstairCallButtonLampOn ifTrue: [ presenter downstairCallButtonLampOn ] ifFalse: [ presenter downstairCallButtonLampOff ].
	isDownstairRequestButtonLampOn ifTrue: [ presenter downstairRequestButtonLampOn ] ifFalse: [ presenter downstairRequestButtonLampOff ].
	
	presenter tick.
	
	indata := 0.
	indata := indata | (presenter isLiftOnUpstair ifTrue: [1] ifFalse: [0]).
	indata := indata | (presenter isLiftOnDownstair ifTrue: [2] ifFalse: [0]).
	indata := indata | (presenter isDoorOpened ifTrue: [4] ifFalse: [0]).
	indata := indata | (presenter isDoorClosed ifTrue: [8] ifFalse: [0]).
	indata := indata | (isUpstairCallButtonOn ifTrue: [16] ifFalse: [0]).
	indata := indata | (isDownstairCallButtonOn ifTrue: [32] ifFalse: [0]).
	indata := indata | (isUpstairRequestButtonOn ifTrue: [64] ifFalse: [0]).
	indata := indata | (isDownstairRequestButtonOn ifTrue: [128] ifFalse: [0]).

	^ indata printString
]

{ #category : #'open/close' }
FWJElevatorControlUI >> open [
	"FWJElevatorControlUI new open"	
			
	socketServer start.
	^presenter
		open;
		yourself
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> tick [

	presenter tick
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> upstairCallButtonPressed [

	isUpstairCallButtonOn := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> upstairCallButtonReleased [

	isUpstairCallButtonOn := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> upstairRequestButtonPressed [

	isUpstairRequestButtonOn := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> upstairRequestButtonReleased [

	isUpstairRequestButtonOn := false.
]

{ #category : #windows }
FWJElevatorControlUI >> windowClosed: aWindowPresenter [

	super windowClosed: aWindowPresenter.
	socketServer stop.
]
