"
I am a SpApplication for Note Handling excersise in FWJ.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	noteHandler:		<Object>


    Implementation Points
"
Class {
	#name : #FWJNoteHandling,
	#superclass : #SpApplication,
	#instVars : [
		'noteHandler'
	],
	#category : #'FWJ-NoteHandling'
}

{ #category : #running }
FWJNoteHandling class >> run [

	"self run"
	
	self new run
]

{ #category : #initialization }
FWJNoteHandling >> initialize [ 
	
	noteHandler := FWJNoteHandler new.
]

{ #category : #accessing }
FWJNoteHandling >> noteHandler [
	
	^noteHandler
]

{ #category : #running }
FWJNoteHandling >> start [

	(FWJNoteHandlerPresenter newApplication: self model: noteHandler) open
]

{ #category : #windows }
FWJNoteHandling >> windowClosed: aWindowPresenter [
	
	super windowClosed: aWindowPresenter.
	self windows ifEmpty: [ noteHandler stop ].

]
