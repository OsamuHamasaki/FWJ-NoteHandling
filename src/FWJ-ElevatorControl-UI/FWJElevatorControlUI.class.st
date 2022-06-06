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
FWJElevatorControlUI >> makeIndata [

	| indata |	
	indata := 0.
	presenter isLiftOnUpstair ifTrue: [indata + 1].
	presenter isLiftOnDownstair ifTrue: [indata + 2].
	presenter isDoorOpened ifTrue: [indata + 4].
	presenter isDoorClosed ifTrue: [indata + 8].
	isUpstairCallButtonOn ifTrue: [indata + 16].
	isDownstairCallButtonOn ifTrue: [indata + 32].
	isUpstairRequestButtonOn ifTrue: [indata + 64].
	isDownstairRequestButtonOn ifTrue: [indata + 128].

	^ indata
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> onDataReceived: aString [

	| indata |
	self reflectOutData: (FWJElevatorControlOutData new data: aString asInteger).	
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

{ #category : #private }
FWJElevatorControlUI >> reflectOutData: outdata [

	self reflectOutDataForLift: outdata.
	self reflectOutDataForDoor: outdata.
	self reflectOutDataForButtonLamp: outdata.
]

{ #category : #private }
FWJElevatorControlUI >> reflectOutDataForButtonLamp: outdata [

	outdata isUpstairCallButtonLampOn ifTrue: [ presenter upstairCallButtonLampOn ] ifFalse: [ presenter upstairCallButtonLampOff ].
	outdata isUpstairRequestButtonLampOn ifTrue: [ presenter upstairRequestButtonLampOn ] ifFalse: [ presenter upstairRequestButtonLampOff ].
	outdata isDownstairCallButtonLampOn ifTrue: [ presenter downstairCallButtonLampOn ] ifFalse: [ presenter downstairCallButtonLampOff ].
	outdata isDownstairRequestButtonLampOn ifTrue: [ presenter downstairRequestButtonLampOn ] ifFalse: [ presenter downstairRequestButtonLampOff ].

]

{ #category : #private }
FWJElevatorControlUI >> reflectOutDataForDoor: outdata [

	outdata isDoorForwardOn
		ifTrue: [ presenter doorOpen ]
		ifFalse: [ 
			outdata isDoorReverseOn
				ifTrue: [ presenter doorClose ]
				ifFalse: [ presenter doorStop ] ].

]

{ #category : #private }
FWJElevatorControlUI >> reflectOutDataForLift: outdata [

	outdata isLiftForwardOn
		ifTrue: [ presenter liftGoUp ]
		ifFalse: [ 
			outdata isLiftReverseOn
				ifTrue: [ presenter liftGoDown ]
				ifFalse: [ presenter liftStop ] ].

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
