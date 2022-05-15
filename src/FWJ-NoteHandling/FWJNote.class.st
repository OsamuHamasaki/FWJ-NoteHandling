"
I represent a note for FWJNoteHandler.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	position:		<Object>


    Implementation Points
"
Class {
	#name : #FWJNote,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'FWJ-NoteHandling'
}

{ #category : #initialization }
FWJNote >> initialize [
	
	position := 0
]

{ #category : #moving }
FWJNote >> moveForward [
	
	position := position + 1
]

{ #category : #accessing }
FWJNote >> position [
	
	^position
]
