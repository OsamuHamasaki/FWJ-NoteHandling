"
I am a SpPresenterWithModel for FWJ-ElevatorControl-UI.

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
	#name : #FWJElevatorControlUIPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'downstairCallButton',
		'downstairRequestButton',
		'upstairCallButton',
		'upstairRequestButton',
		'door',
		'doorMotor',
		'doorOpenSensor',
		'doorCloseSensor',
		'lift',
		'liftMotor',
		'liftUpstairSensor',
		'liftDownstairSensor',
		'downstairCallButtonView',
		'downstairRequestButtonView',
		'upstairCallButtonView',
		'upstairRequestButtonView',
		'doorMotorView',
		'doorOpenSensorView',
		'doorCloseSensorView',
		'liftMotorView',
		'liftUpstairSensorView',
		'liftDownstairSensorView'
	],
	#category : #'FWJ-ElevatorControl-UI'
}

{ #category : #'instance creation' }
FWJElevatorControlUIPresenter class >> example [
	"self example"	
	
	| aPresenter |
	aPresenter := self new.
	aPresenter
		upstairCallButtonOnAction: [ aPresenter upstairCallButtonLampOn ];
		upstairCallButtonOffAction: [ aPresenter upstairCallButtonLampOff ];
		upstairRequestButtonOnAction: [ aPresenter upstairRequestButtonLampOn ];
		upstairRequestButtonOffAction: [ aPresenter upstairRequestButtonLampOff ];
		downstairCallButtonOnAction: [ aPresenter downstairCallButtonLampOn ];
		downstairCallButtonOffAction: [ aPresenter downstairCallButtonLampOff ];
		downstairRequestButtonOnAction: [ aPresenter downstairRequestButtonLampOn ];
		downstairRequestButtonOffAction: [ aPresenter downstairRequestButtonLampOff ];
		open.
	^aPresenter
]

{ #category : #layout }
FWJElevatorControlUIPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: (SpBoxLayout newTopToBottom
					add: #upstairCallButtonView expand: false;
					add: #liftUpstairSensorView expand: false;
					add: #liftMotorView expand: true;
					add: #liftDownstairSensorView expand: false;
					add: #downstairCallButtonView expand: false;
					spacing: 3;
					yourself) expand: false;
		add: (SpBoxLayout newTopToBottom
					add: #upstairRequestButtonView;
					add: #downstairRequestButtonView;
					spacing: 3;
					yourself) expand: false;
		add: #doorCloseSensorView expand: false;
		add: #doorMotorView expand: true;
		add: #doorOpenSensorView expand: false;
		spacing: 3;
		yourself
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> doorClose [
	
	door goBackward
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> doorOpen [
	
	door goForward
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> doorStop [
	
	door stop
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> downstairCallButtonLampOff [

	downstairCallButton lampOff
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> downstairCallButtonLampOn [

	downstairCallButton lampOn
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> downstairCallButtonOffAction: aBlock [

	downstairCallButton mouseUpAction: aBlock
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> downstairCallButtonOnAction: aBlock [

	downstairCallButton mouseDownAction: aBlock
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> downstairRequestButtonLampOff [

	downstairRequestButton lampOff
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> downstairRequestButtonLampOn [

	downstairRequestButton lampOn
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> downstairRequestButtonOffAction: aBlock [

	downstairRequestButton mouseUpAction: aBlock
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> downstairRequestButtonOnAction: aBlock [

	downstairRequestButton mouseDownAction: aBlock
]

{ #category : #initialization }
FWJElevatorControlUIPresenter >> initializePresenters [

	self initializePresentersForButtons.
	self initializePresentersForDoor.
	self initializePresentersForLift.

]

{ #category : #'private - initialization' }
FWJElevatorControlUIPresenter >> initializePresentersForButtons [

	downstairCallButton := FWJButtonMorph newLabeled: '1st Call'.
	downstairCallButtonView := self newMorph
		morph: downstairCallButton;
		yourself.
		
	downstairRequestButton := FWJButtonMorph newLabeled: '1st Req.'.
	downstairRequestButtonView := self newMorph 
		morph: downstairRequestButton;
		yourself.
		
	upstairCallButton := FWJButtonMorph newLabeled: '2nd Call'.
	upstairCallButtonView := self newMorph 
		morph: upstairCallButton;
		yourself.
		
	upstairRequestButton := FWJButtonMorph newLabeled: '2nd Req.'.
	upstairRequestButtonView := self newMorph 
		morph: upstairRequestButton;
		yourself.

]

{ #category : #'private - initialization' }
FWJElevatorControlUIPresenter >> initializePresentersForDoor [

	door := FWJMotorWithLimit new.
	doorMotor := FWJHorizontalMotorMorph new
		model: door;
		yourself.
	doorMotorView := self newMorph
		morph: doorMotor;
		yourself.
	doorOpenSensor := FWJSensorMorph new
		model: door aspect: #isOnForwardLimit;
		yourself.
	doorOpenSensorView := self newMorph
		morph: doorOpenSensor;
		yourself.
	doorCloseSensor := FWJSensorMorph new
		model: door aspect: #isOnBackwardLimit;
		yourself.
	doorCloseSensorView := self newMorph
		morph: doorCloseSensor;
		yourself.

]

{ #category : #'private - initialization' }
FWJElevatorControlUIPresenter >> initializePresentersForLift [

	lift := FWJMotorWithLimit new.
	liftMotor := FWJVirticalMotorMorph new
		model: lift;
		yourself.
	liftMotorView := self newMorph
		morph: liftMotor;
		yourself.
	liftUpstairSensor := FWJSensorMorph new
		model: lift aspect: #isOnForwardLimit;
		yourself.
	liftUpstairSensorView := self newMorph
		morph: liftUpstairSensor;
		yourself.
	liftDownstairSensor := FWJSensorMorph new
		model: lift aspect: #isOnBackwardLimit;
		yourself.
	liftDownstairSensorView := self newMorph
		morph: liftDownstairSensor;
		yourself.
		
]

{ #category : #initialization }
FWJElevatorControlUIPresenter >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter title: 'FWJ Elevator Control'.
]

{ #category : #testing }
FWJElevatorControlUIPresenter >> isDoorClosed [
	
	^door isOnBackwardLimit 
]

{ #category : #testing }
FWJElevatorControlUIPresenter >> isDoorOpened [
	
	^door isOnForwardLimit 
]

{ #category : #testing }
FWJElevatorControlUIPresenter >> isLiftOnDownstair [
	
	^lift isOnBackwardLimit 
]

{ #category : #testing }
FWJElevatorControlUIPresenter >> isLiftOnUpstair [
	
	^lift isOnForwardLimit 
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> liftGoDown [
	
	lift goBackward
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> liftGoUp [
	
	lift goForward
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> liftStop [
	
	lift stop
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> tick [
	
	lift tick.
	door tick.
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> upstairCallButtonLampOff [

	upstairCallButton lampOff
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> upstairCallButtonLampOn [

	upstairCallButton lampOn
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> upstairCallButtonOffAction: aBlock [

	upstairCallButton mouseUpAction: aBlock
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> upstairCallButtonOnAction: aBlock [

	upstairCallButton mouseDownAction: aBlock
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> upstairRequestButtonLampOff [

	upstairRequestButton lampOff
]

{ #category : #'changing state' }
FWJElevatorControlUIPresenter >> upstairRequestButtonLampOn [

	upstairRequestButton lampOn
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> upstairRequestButtonOffAction: aBlock [

	upstairRequestButton mouseUpAction: aBlock
]

{ #category : #accessing }
FWJElevatorControlUIPresenter >> upstairRequestButtonOnAction: aBlock [

	upstairRequestButton mouseDownAction: aBlock
]
