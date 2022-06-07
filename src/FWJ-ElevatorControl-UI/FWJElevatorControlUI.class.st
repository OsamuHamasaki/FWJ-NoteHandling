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
		'isDownstairRequestButtonOn',
		'isDoorOpen',
		'isDoorClose',
		'isLiftOnUpstair',
		'isLiftOnDownstair'
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
FWJElevatorControlUI >> doorClosed [

	isDoorClose := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> doorNotClosed [

	isDoorClose := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> doorNotOpened [

	isDoorOpen := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> doorOpened [

	isDoorOpen := true.
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
	self initializeVariables.
	self initializePresenter.
	self initializeSocketServer.

]

{ #category : #'private - initialization' }
FWJElevatorControlUI >> initializePresenter [

	presenter := FWJElevatorControlUIPresenter newApplication: self.
	presenter
		upstairCallButtonOnAction: [ self upstairCallButtonPressed ];
		upstairCallButtonOffAction: [ self upstairCallButtonReleased ];
		upstairRequestButtonOnAction: [ self upstairRequestButtonPressed ];
		upstairRequestButtonOffAction: [ self upstairRequestButtonReleased ];
		downstairCallButtonOnAction: [ self downstairCallButtonPressed ];
		downstairCallButtonOffAction: [ self downstairCallButtonReleased ];
		downstairRequestButtonOnAction: [ self downstairRequestButtonPressed ];
		downstairRequestButtonOffAction: [ self downstairRequestButtonReleased ];
		doorOpenedAction: [ self doorOpened ];
		doorNotOpenedAction: [ self doorNotOpened ];
		doorClosedAction: [ self doorClosed ];
		doorNotClosedAction: [ self doorNotClosed ];
		liftOnUpstairAction: [ self liftOnUpstair ];
		liftNotOnUpstairOAction: [ self liftNotOnUpstair ];
		liftOnDownstairAction: [ self liftOnDownstair ];
		liftNotOnDownstairAction: [ self liftNotOnDownstair ].

]

{ #category : #'private - initialization' }
FWJElevatorControlUI >> initializeSocketServer [

	socketServer := SimpleTCPServer new
		listeningPort: 3000;
		onDataReceive: [ :socket :receivedData | socket sendData: (self onDataReceived: receivedData) ];
		yourself


]

{ #category : #'private - initialization' }
FWJElevatorControlUI >> initializeVariables [

	isUpstairCallButtonOn := false.
	isUpstairRequestButtonOn := false.
	isDownstairCallButtonOn := false.
	isDownstairRequestButtonOn := false.
	isDoorOpen := false.
	isDoorClose := true.
	isLiftOnUpstair := false.
	isLiftOnDownstair := true.

]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> liftNotOnDownstair [

	isLiftOnDownstair := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> liftNotOnUpstair [

	isLiftOnUpstair := false.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> liftOnDownstair [

	isLiftOnDownstair := true.
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> liftOnUpstair [

	isLiftOnUpstair := true.
]

{ #category : #private }
FWJElevatorControlUI >> makeIndata [

	| indata |	
	indata := 0.
	isLiftOnUpstair ifTrue: [indata := indata + 1].
	isLiftOnDownstair ifTrue: [indata := indata + 2].
	isDoorOpen ifTrue: [indata := indata + 4].
	isDoorClose ifTrue: [indata := indata + 8].
	isUpstairCallButtonOn ifTrue: [indata := indata + 16].
	isDownstairCallButtonOn ifTrue: [indata := indata + 32].
	isUpstairRequestButtonOn ifTrue: [indata := indata + 64].
	isDownstairRequestButtonOn ifTrue: [indata := indata + 128].

	^ indata
]

{ #category : #'event handling - private' }
FWJElevatorControlUI >> onDataReceived: aString [

	self reflectOutData: (FWJElevatorControlOutData new data: aString asInteger).	
	self tick.
	^ self makeIndata printString
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
