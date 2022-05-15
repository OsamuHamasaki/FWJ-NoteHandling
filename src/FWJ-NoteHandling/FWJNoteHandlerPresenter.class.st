"
I am a SpPresenter for FWJNoteHandler.

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
	#name : #FWJNoteHandlerPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'morph',
		'noteHandlerView',
		'startButton',
		'stopButton'
	],
	#category : #'FWJ-NoteHandling'
}

{ #category : #layout }
FWJNoteHandlerPresenter class >> defaultLayout [
	
	^SpBoxLayout newTopToBottom
		yourself
]

{ #category : #initialization }
FWJNoteHandlerPresenter >> connectPresenters [ 
	
	startButton action: [ stopButton enable. startButton disable. self application noteHandler start. ].
	stopButton action: [ startButton enable. stopButton disable. self application noteHandler stop.]
]

{ #category : #layout }
FWJNoteHandlerPresenter >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: #noteHandlerView;
		add: (SpBoxLayout newLeftToRight
				add: #startButton;
				add: #stopButton;
				yourself) expand: false;
		yourself
]

{ #category : #initialization }
FWJNoteHandlerPresenter >> initializePresenters [ 
	
	morph := FWJNoteHandlerMorph new
			model: self model;
			yourself.
	noteHandlerView := self newMorph
			morph: morph;
			yourself.
	startButton := self newButton
			label: 'Start!';
			yourself.
	stopButton := self newButton
			label: 'Stop!';
			disable;
			yourself
			
]

{ #category : #initialization }
FWJNoteHandlerPresenter >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'FWJNoteHandling';
		initialExtent: 600@400
]

{ #category : #initialization }
FWJNoteHandlerPresenter >> modelChanged [ 

	morph update
]
