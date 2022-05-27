"
I am a Presenter for FWJ-LampControl-UI.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	blinkSwitch:		<Object>
	blinkSwitchView:		<Object>
	brightnessSwitch:		<Object>
	brightnessSwitchView:		<Object>
	lamp:		<Object>
	lampView:		<Object>
	powerSwitch:		<Object>
	powerSwitchView:		<Object>


    Implementation Points
"
Class {
	#name : #FWJLampControlUIPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'lamp',
		'lampView',
		'powerSwitch',
		'powerSwitchView',
		'brightnessSwitch',
		'brightnessSwitchView',
		'blinkSwitch',
		'blinkSwitchView'
	],
	#category : #'FWJ-LampControl-UI'
}

{ #category : #'instance creation' }
FWJLampControlUIPresenter class >> example [
	
	"self example"
	^self new
		powerSwitchOnAction: [ 'Power Switch Pressed.' crTrace ];
		powerSwitchOffAction: [ 'Power Switch Released.' crTrace ];
		brightnessSwitchOnAction: [ 'Brightness Switch Pressed.' crTrace ];
		brightnessSwitchOffAction: [ 'Brightness Switch Released.' crTrace ];
		blinkSwitchOnAction: [ 'Blink Switch pressed.' crTrace ];
		blinkSwitchOffAction: [ 'Blink Switch Released.' crTrace ];
		open;
		yourself
]

{ #category : #accessing }
FWJLampControlUIPresenter >> blinkSwitchOffAction: aBlock [
	
	blinkSwitch mouseUpAction: aBlock
]

{ #category : #accessing }
FWJLampControlUIPresenter >> blinkSwitchOnAction: aBlock [
	
	blinkSwitch mouseDownAction: aBlock
]

{ #category : #accessing }
FWJLampControlUIPresenter >> brightnessSwitchOffAction: aBlock [
	
	brightnessSwitch mouseUpAction: aBlock
]

{ #category : #accessing }
FWJLampControlUIPresenter >> brightnessSwitchOnAction: aBlock [
	
	brightnessSwitch mouseDownAction: aBlock
]

{ #category : #layout }
FWJLampControlUIPresenter >> defaultLayout [
	
	^SpBoxLayout newTopToBottom
		add: #lampView;
		add: (SpBoxLayout newLeftToRight
					add: #powerSwitchView;
					add: #brightnessSwitchView;
					add: #blinkSwitchView;
					spacing: 2;
					yourself) expand: false;
		spacing: 2;
		yourself

]

{ #category : #initialization }
FWJLampControlUIPresenter >> initializePresenters [
	
	lamp := FWJLampMorph new.
	lampView := self newMorph
		morph: lamp;
		yourself.
	
	powerSwitch := FWJSwitchMorph newLabeled: 'Power Switch'.
	powerSwitchView := self newMorph
		morph: powerSwitch;
		yourself.
	
	brightnessSwitch := FWJSwitchMorph newLabeled: 'Brightness Switch'.
	brightnessSwitchView := self newMorph
		morph: brightnessSwitch;
		yourself.
		
	blinkSwitch := FWJSwitchMorph newLabeled: 'Blink Switch'.
	blinkSwitchView := self newMorph
		morph: blinkSwitch;
		yourself.
	
]

{ #category : #initialization }
FWJLampControlUIPresenter >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'FWJ-LampControl'.
]

{ #category : #'changing state' }
FWJLampControlUIPresenter >> lampOff [
	
	lamp turnOff
]

{ #category : #'changing state' }
FWJLampControlUIPresenter >> lampOnBright [
	
	lamp turnOnBright
]

{ #category : #'changing state' }
FWJLampControlUIPresenter >> lampOnDark [
	
	lamp turnOnDark
]

{ #category : #accessing }
FWJLampControlUIPresenter >> powerSwitchOffAction: aBlock [
	
	powerSwitch mouseUpAction: aBlock
]

{ #category : #accessing }
FWJLampControlUIPresenter >> powerSwitchOnAction: aBlock [
	
	powerSwitch mouseDownAction: aBlock
]
