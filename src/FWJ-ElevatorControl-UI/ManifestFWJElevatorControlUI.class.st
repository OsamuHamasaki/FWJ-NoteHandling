"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFWJElevatorControlUI,
	#superclass : #PackageManifest,
	#category : #'FWJ-ElevatorControl-UI-Manifest'
}

{ #category : #'code-critics' }
ManifestFWJElevatorControlUI class >> ruleBooleanPrecedenceRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#FWJElevatorControlOutData)) #'2022-06-07T11:24:19.013+09:00') )
]
