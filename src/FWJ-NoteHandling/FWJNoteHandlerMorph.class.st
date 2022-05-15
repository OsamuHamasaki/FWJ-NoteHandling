"
I am a Morph for FWJNoteHandler.

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
	#name : #FWJNoteHandlerMorph,
	#superclass : #Morph,
	#instVars : [
		'model'
	],
	#category : #'FWJ-NoteHandling'
}

{ #category : #initialization }
FWJNoteHandlerMorph >> defaultColor [
	
	^Color white
]

{ #category : #drawing }
FWJNoteHandlerMorph >> drawNote: note offset: aPoint On: aCanvas [
	
	| aRectangle |
	aRectangle := (note position @ 0 extent: 10@10) translateBy: aPoint.
	aCanvas fillRectangle: aRectangle color: Color black.

]

{ #category : #drawing }
FWJNoteHandlerMorph >> drawOn: aCanvas [
	
	| offset |
	super drawOn: aCanvas.
	
	offset := self bounds origin + (50 @ (self extent y / 2)).
	model doAllNotes: [ :note | self drawNote: note offset: offset On: aCanvas]
]

{ #category : #accessing }
FWJNoteHandlerMorph >> model: aModel [
	
	model := aModel
]

{ #category : #updating }
FWJNoteHandlerMorph >> update [

	self changed
]
