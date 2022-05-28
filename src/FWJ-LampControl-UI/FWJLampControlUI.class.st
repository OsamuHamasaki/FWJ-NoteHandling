"
I am a SpApplication for FWJ-LampControl-UI.

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
	#name : #FWJLampControlUI,
	#superclass : #SpApplication,
	#instVars : [
		'presenter',
		'socketServer',
		'isPowerSwitchOn',
		'isBrightnessSwitchOn',
		'isBlinkSwitchOn'
	],
	#category : #'FWJ-LampControl-UI'
}

{ #category : #'event handling - private' }
FWJLampControlUI >> blinkSwitchPressed [

	isBlinkSwitchOn := true.

]

{ #category : #'event handling - private' }
FWJLampControlUI >> blinkSwitchReleased [

	isBlinkSwitchOn := false.

]

{ #category : #'event handling - private' }
FWJLampControlUI >> brightnessSwitchPressed [

	isBrightnessSwitchOn := true.

]

{ #category : #'event handling - private' }
FWJLampControlUI >> brightnessSwitchReleased [

	isBrightnessSwitchOn := false.

]

{ #category : #initialization }
FWJLampControlUI >> initialize [
	
	super initialize.
	
	isPowerSwitchOn := false.
	isBrightnessSwitchOn := false.
	isBlinkSwitchOn := false.
	
	presenter := FWJLampControlUIPresenter newApplication: self.
	presenter
		powerSwitchOnAction: [ self powerSwitchPressed ];
		powerSwitchOffAction: [ self powerSwitchReleased ];
		brightnessSwitchOnAction: [ self brightnessSwitchPressed ];
		brightnessSwitchOffAction: [ self brightnessSwitchReleased ];
		blinkSwitchOnAction: [ self blinkSwitchPressed ];
		blinkSwitchOffAction: [ self blinkSwitchReleased ].
		
	socketServer := SimpleTCPServer new
		listeningPort: 3000;
		onDataReceive: [ :socket :receivedData | socket sendData: (self onDataReceived: receivedData) ];
		yourself
		
	

]

{ #category : #'event handling - private' }
FWJLampControlUI >> onDataReceived: aString [
	
	| outdata indata isLampOn isLampBright |
	outdata := aString asInteger.
	isLampOn := (outdata & 1) == 1.
	isLampBright := (outdata & 2) == 2.
	isLampOn 
		ifTrue: [ 
			isLampBright ifTrue: [ presenter lampOnBright ] ifFalse: [ presenter lampOnDark ] ]
		ifFalse: [ presenter lampOff. ].
	
	indata := 0.
	indata := indata | (isPowerSwitchOn ifTrue: [1] ifFalse: [0]).
	indata := indata | (isBrightnessSwitchOn ifTrue: [ 2 ] ifFalse: [0]).
	indata := indata | (isBlinkSwitchOn ifTrue: [ 4 ] ifFalse: [0]).
	^indata printString.
]

{ #category : #initialization }
FWJLampControlUI >> open [
	
	"FWJLampControlUI new open"
	socketServer start.
	^presenter
		open;
		yourself
]

{ #category : #'event handling - private' }
FWJLampControlUI >> powerSwitchPressed [

	isPowerSwitchOn := true.

]

{ #category : #'event handling - private' }
FWJLampControlUI >> powerSwitchReleased [

	isPowerSwitchOn := false.

]

{ #category : #windows }
FWJLampControlUI >> windowClosed: aWindowPresenter [
	
	super windowClosed: aWindowPresenter.
	socketServer stop.

]
