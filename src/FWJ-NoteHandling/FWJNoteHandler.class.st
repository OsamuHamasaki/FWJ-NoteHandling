"
I am a Model for Note Handling exercize in FWJ.

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
	#name : #FWJNoteHandler,
	#superclass : #Model,
	#instVars : [
		'running',
		'notes',
		'tickCount'
	],
	#category : #'FWJ-NoteHandling'
}

{ #category : #enumerating }
FWJNoteHandler >> doAllNotes: aBlock [
	
	notes do: [:note | aBlock value: note]
]

{ #category : #initialization }
FWJNoteHandler >> initialize [
	
	running := false.
	notes := OrderedCollection new.
	tickCount := 0.
]

{ #category : #running }
FWJNoteHandler >> start [

	| aProcess |
	
	aProcess := [
		[running] 
			whileTrue: [
				self tick.
				self valueChanged.
				(Delay forMilliseconds: 5) wait ] ] newProcess.
	running := true.
	notes := OrderedCollection new.
	tickCount := 0.
	aProcess resume.
]

{ #category : #running }
FWJNoteHandler >> stop [

	running := false.
]

{ #category : #running }
FWJNoteHandler >> tick [
	
	notes do: [ :note | note moveForward. ].
	(tickCount \\ 50) = 0 ifTrue: [ notes addLast: FWJNote new. ]. 

	notes isEmpty ifFalse: [
		notes first position = 500 ifTrue: [ notes removeFirst ]]. 
	
	tickCount := tickCount + 1.

]
