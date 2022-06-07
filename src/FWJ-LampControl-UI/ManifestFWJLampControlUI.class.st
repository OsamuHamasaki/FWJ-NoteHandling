"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFWJLampControlUI,
	#superclass : #PackageManifest,
	#category : #'FWJ-LampControl-UI-Manifest'
}

{ #category : #'code-critics' }
ManifestFWJLampControlUI class >> ruleBooleanPrecedenceRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'FWJ-LampControl-UI')) #'2022-06-07T11:24:37.17+09:00') )
]
