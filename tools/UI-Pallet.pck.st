'From Cuis 6.0 [latest update: #5031] on 31 December 2021 at 12:43:55 pm'!
'Description I supply Pallets of selectable items.
E.g. see PickAIconPallet, PickAColorPallet'!
!provides: 'UI-Pallet' 1 10!
!requires: 'UI-Click-Select' 1 1 nil!
!requires: 'UI-Panel' 1 17 nil!
!requires: 'UI-DragAndDrop' 1 7 nil!
!requires: 'Color-Extras' 1 9 nil!
!requires: 'UI-Base-Morphs' 1 11 nil!
SystemOrganization addCategory: 'UI-Pallet'!


!classDefinition: #PalletLayoutMorph category: 'UI-Pallet'!
LayoutMorph subclass: #PalletLayoutMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'PalletLayoutMorph class' category: 'UI-Pallet'!
PalletLayoutMorph class
	instanceVariableNames: ''!

!classDefinition: #InnerPluggableImagePallet category: 'UI-Pallet'!
InnerPluggableMorph subclass: #InnerPluggableImagePallet
	instanceVariableNames: 'nameImageCollection imageFilter imageExtent calculatedExtent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'InnerPluggableImagePallet class' category: 'UI-Pallet'!
InnerPluggableImagePallet class
	instanceVariableNames: ''!

!classDefinition: #PluggableImagePallet category: 'UI-Pallet'!
PluggableScrollPane subclass: #PluggableImagePallet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'PluggableImagePallet class' category: 'UI-Pallet'!
PluggableImagePallet class
	instanceVariableNames: ''!

!classDefinition: #ImagePickerPanel category: 'UI-Pallet'!
Panel subclass: #ImagePickerPanel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'ImagePickerPanel class' category: 'UI-Pallet'!
ImagePickerPanel class
	instanceVariableNames: ''!

!classDefinition: #PickAColorPallet category: 'UI-Pallet'!
ImagePickerPanel subclass: #PickAColorPallet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'PickAColorPallet class' category: 'UI-Pallet'!
PickAColorPallet class
	instanceVariableNames: ''!

!classDefinition: #PickAIconPallet category: 'UI-Pallet'!
ImagePickerPanel subclass: #PickAIconPallet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'PickAIconPallet class' category: 'UI-Pallet'!
PickAIconPallet class
	instanceVariableNames: ''!

!classDefinition: #PickALargerIconPallet category: 'UI-Pallet'!
ImagePickerPanel subclass: #PickALargerIconPallet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Pallet'!
!classDefinition: 'PickALargerIconPallet class' category: 'UI-Pallet'!
PickALargerIconPallet class
	instanceVariableNames: ''!


!PalletLayoutMorph commentStamp: '<historical>' prior: 0!
I am a LayoutMorph which allows grabbing (cloning) my submorphs.!

!InnerPluggableImagePallet commentStamp: '<historical>' prior: 0!
I display pick/clone-able images in a PluggableImagePallet which is a PluggableScrollPane!

!ImagePickerPanel commentStamp: '<historical>' prior: 0!
I present a scrollable view of images to pick from. 
(Note PartsBinMorph and it parent, DragAndDropAreaMorph)
!

!PickAColorPallet commentStamp: '<historical>' prior: 0!
I am just a way of getting an initializedInstance from the New Morph.. menu..  

See my class side.!

!PickAIconPallet commentStamp: '<historical>' prior: 0!
I am just a way of getting an initializedInstance from the New Morph.. menu..  

See my class side.!

!PickALargerIconPallet commentStamp: '<historical>' prior: 0!
I am just a way of getting an initializedInstance from the New Morph.. menu..  

See my class side.!

!PickAColorPallet class methodsFor: 'instance creation' stamp: 'KenD 12/7/2016 08:24:49'!
initializedInstance

	^ super namedColors! !

!PickAIconPallet class methodsFor: 'instance creation' stamp: 'KenD 12/7/2016 08:27:02'!
initializedInstance

	^ super namedIcons ! !

!PickALargerIconPallet class methodsFor: 'instance creation' stamp: 'KenD 12/7/2016 08:27:27'!
initializedInstance

	^ super largerIcons ! !

!PalletLayoutMorph methodsFor: 'dropping/grabbing' stamp: 'KenD 5/11/2019 01:39:50'!
aboutToGrab: aMorph
	"submorph is being grabbed by a hand.
	Perform necessary adjustments (if any) and return the actual morph
	that should be added to the hand.
	Answer nil to reject the drag."

	^ aMorph copy   "Note PartsBinMorph>>aboutToGrab: "
	! !

!PalletLayoutMorph methodsFor: 'dropping/grabbing' stamp: 'KenD 9/14/2013 15:59'!
allowsSubmorphDrag
	"Answer whether our morphs can just be grabbed with the hand, instead of requiring the use of the halo. Redefined to answer true."

	^ true! !

!PalletLayoutMorph methodsFor: 'layout' stamp: 'KenD 11/7/2021 14:14:42'!
shrinkWrap
	"Resize self to minimally contain submorphs with specified separation"
	
	| width height sep |
	((self direction) = #horizontal) "(a row)"
		ifTrue:  [
			sep := self xSeparation.
			width := sep + 
				(self submorphs 
					inject: 0 
					into: [ :subTotal :m |  subTotal + (m morphExtentInOwner x) + sep ]).
			sep := 2 * self ySeparation.
			height := 
				(self submorphs 
					inject: 10 
					into: [ :maxHeight :m |  maxHeight max: (m morphExtentInOwner y) + sep ]).
			self layoutSpec: 
					(LayoutSpec 
							fixedWidth: width
							fixedHeight: height
							offAxisEdgeWeight: #rowTop)
		]
		ifFalse: [ " vertical  (a column)"
			sep := 2 * self xSeparation.
			width := 
				(self submorphs 
					inject: 10 
					into: [ :maxWidth :m |  maxWidth max: (m morphExtentInOwner x) + sep ]).
			sep := self ySeparation.
			height := sep + 
				(self submorphs 
					inject: 0 
					into: [ :subTotal :m |  subTotal + (m morphExtentInOwner y) + sep ]).
			self layoutSpec: 
					(LayoutSpec 
							fixedWidth: width 
							fixedHeight: height
							offAxisEdgeWeight: #columnLeft)
		].

	self morphExtent: width @ height.
	self layoutSubmorphs.! !

!PalletLayoutMorph class methodsFor: 'new-morph participation' stamp: 'KenD 9/15/2013 16:40'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	^ false! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:42:54'!
adjustExtent
	
	"Nothing to do here"! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:37:56'!
getMenu

	^ nil! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:39:10'!
imageExtent
	"Answer extent of an image contained in me.
	Assume all images of same extent"
	^imageExtent ! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:38:18'!
imageExtent: aPointExtent

	imageExtent := aPointExtent ! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:39:16'!
imageHeight

	^ imageExtent y! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:39:21'!
imageWidth

	^ imageExtent x! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:37:45'!
minimumExtent

	^self calculatedExtent ! !

!InnerPluggableImagePallet methodsFor: 'accessing' stamp: 'KenD 9/15/2021 14:39:40'!
nameImageCollection

	^ nameImageCollection ! !

!InnerPluggableImagePallet methodsFor: 'initialization' stamp: 'KenD 11/7/2021 14:16:42'!
collection: aNameImageCollection filter: imageTransducer

	| numImages maxWidth numAcross numDown spacedExtent |
	nameImageCollection := aNameImageCollection.
	imageFilter := imageTransducer.
	
	numImages := aNameImageCollection size.
	numImages isZero 
		ifTrue: [Error signal: 'I require a non-empty collection to display!!'].
	numImages> 1000 
		ifTrue: [Error signal: 'Collection too large to display safely'].
	"@@FIXME: assumes all images same size@@"
	self imageExtent: 
		(self processImage: (aNameImageCollection anyOne value)) morphExtentInOwner.

	maxWidth := (DisplayScreen actualScreenSize x) // 1.2.
	spacedExtent := imageExtent + self spaceWidth.

	numAcross := (((maxWidth - self spaceWidth) // spacedExtent x) 
						max: 1) min: numImages.
	numDown := (numImages / numAcross) ceiling.
	((numDown < 3) and: [numAcross > 40])
		ifTrue: [ 
			numAcross := 40. 
			numDown := (numImages / numAcross) ceiling.
		].
"
Transcript show: 'numAcross: ', (numAcross asString), '  numDown: ', (numDown asString)
	; newLine.
"
	self calculatedExtent:  
			(((self imageWidth + self spaceWidth) * numAcross)
			@ ((self imageHeight + self spaceWidth) * numDown))
							+ (2 * self spaceWidth). "frame"
"
Transcript show: 'calculatedExtent: ', (self calculatedExtent asString)
	; newLine.
"
	"Answer LayoutMorph with images"
	^ self layoutImages: numAcross extent: self calculatedExtent.



! !

!InnerPluggableImagePallet methodsFor: 'initialization' stamp: 'KenD 9/16/2021 13:18:54'!
initialize

	super initialize.
	imageFilter := [:any| any].
	^ self 
		layoutSpec: LayoutSpec useAll;
		yourself! !

!InnerPluggableImagePallet methodsFor: 'initialization' stamp: 'KenD 9/16/2021 13:11:57'!
layoutImages: numAcross extent: layoutExtent
	"Lay out images in a LayoutMorph and return it."
	
	| column nextRow count rowLayoutSpec |
	rowLayoutSpec := LayoutSpec 
							fixedWidth: layoutExtent x  
							fixedHeight: self imageHeight
							offAxisEdgeWeight: #columnLeft.
							
	column := LayoutMorph newColumn.
	column 
		separation:    self spaceWidth;
		morphExtent: self calculatedExtent;
		axisEdgeWeight: #columnTop.

	count := -1.
	self nameImageCollection do: [ :nameImageAssoc |
			| name image imageMorph |
		     name  := nameImageAssoc key.
			image := nameImageAssoc value.
			count := count + 1.  "Image count"
			(count \\ numAcross) isZero ifTrue: [ "Start a new Row"
				nextRow := PalletLayoutMorph newRow 
							separation: (self spaceWidth @ 0).
				nextRow layoutSpec: rowLayoutSpec.
				column addMorph: nextRow.
			].
			imageMorph := self processImage: image.
			imageMorph setBalloonText: name asString.
			nextRow addMorph: imageMorph.
	].
	"Don't spread out morphs in the last row"
	((nextRow submorphs size) > 0) ifTrue: [ nextRow shrinkWrap.].
	column 
		color: `Color orange`;
		addMorph: nextRow; "add last row"
		layoutSpec: (LayoutSpec
							fixedWidth: self imageWidth
							fixedHeight: layoutExtent y). 
	^ column
! !

!InnerPluggableImagePallet methodsFor: 'private' stamp: 'KenD 9/15/2021 14:37:02'!
calculatedExtent

	^ calculatedExtent! !

!InnerPluggableImagePallet methodsFor: 'private' stamp: 'KenD 9/15/2021 14:36:55'!
calculatedExtent: aPointExtent

	calculatedExtent := aPointExtent.
	self morphExtent: calculatedExtent ! !

!InnerPluggableImagePallet methodsFor: 'private' stamp: 'KenD 9/15/2021 14:37:10'!
processImage: anImage

	^ imageFilter value: anImage
! !

!InnerPluggableImagePallet methodsFor: 'private' stamp: 'KenD 9/15/2021 14:37:16'!
spaceWidth
	"Answer the space in pixels between images"
	
	^ 2! !

!InnerPluggableImagePallet class methodsFor: 'instance creation' stamp: 'KenD 9/16/2021 11:58:06'!
fromCollection: sortedColors imageFilter: colorTransducer

		^ self basicNew initialize 
			collection: sortedColors 
			filter: colorTransducer ! !

!PluggableImagePallet methodsFor: 'initialization' stamp: 'KenD 9/15/2021 08:31:54'!
innerMorphClass

	^ InnerPluggableImagePallet! !

!ImagePickerPanel methodsFor: 'initialization' stamp: 'KenD 9/15/2021 14:29:33'!
initialize

	super initialize.
	"imageFilter := [:any| any].
	(self scroller)
		color: Theme current background;
		layoutSpec: LayoutSpec useAll."
	^ self 
		layoutSpec: LayoutSpec useAll;
		yourself! !

!ImagePickerPanel class methodsFor: 'instance creation' stamp: 'KenD 11/5/2021 13:44:04'!
clickSelectColorsFor: aMorph
	"Click-Select from a ClickColorPallet"
"Change Color Dictionary:
	ImagePickerPanel useCSS3ColorDict.                  
	ImagePickerPanel useXKCDColorDict.
	ImagePickerPanel useSmallColorDict.
	ImagePickerPanel useCrayonColorDict.
"
	| sortedColors |
	sortedColors := SortedCollection sortBlock: 
		 [ :aAssoc :bAssoc | | a b |
			a := aAssoc value.
			b := bAssoc value.
			(a hue < b hue) 
				or: [(a hue = b hue) 
				and: [a saturation < b saturation ]]
		].
	Color colorNamesDict associationsDo: [ :assoc | 
		sortedColors add: assoc
	].
	
	^ self
		privateBuildPanelLabel:  'Click-Select a Color' 
		collection: sortedColors
		transducer: [:color | | clickColorMorph |
					clickColorMorph := ClickColorMorph fromColor: color forTarget: aMorph.
					clickColorMorph image: (color icon "magnifyTo: 20 @ 20");
					color: color;
					yourself
		] 
! !

!ImagePickerPanel class methodsFor: 'instance creation' stamp: 'KenD 10/26/2021 06:59:50'!
largerIcons
"
	ImagePickerPanel largerIcons openInHand.
	   @@@ NB: openInWorld resets morphExtent @@@
	[|m x| m := ImagePickerPanel largerIcons. x := m morphExtent. m openInWorld. m morphExtent: x] value. 
"
	| iconsCollection sortedCollection |
	iconsCollection := OrderedCollection new. 
	{ 'actions'. 'apps'. 'categories'. 'devices'. 'emblems'. 'emotes'.
	  'mimetypes'. 'places'. 'smalltalk'. 'status'. } do: [ :category |
		iconsCollection addAll: (Theme content from: 'Theme' get: {'16x16'. category}) array.
	].
	sortedCollection := SortedCollection sortBlock: [ :a :b | a key < b key].
	sortedCollection addAll: (iconsCollection select: [ :assoc | assoc isNil not]).
	
	^ self
		privateBuildPanelLabel:  'Pick an Icon' 
		collection: sortedCollection
		transducer:  [:form | ImageMorph new 
			image: (form magnifyTo: 32@32)
		]

! !

!ImagePickerPanel class methodsFor: 'instance creation' stamp: 'KenD 9/20/2021 07:09:04'!
namedColors
"	'Pick a ColorPallet'
	ImagePickerPanel useCSS3ColorDict.                  
	ImagePickerPanel useXKCDColorDict.
	ImagePickerPanel useSmallColorDict.
	ImagePickerPanel useCrayonColorDict.
	'Open a view on it'
	ImagePickerPanel namedColors openInHand.
	   @@@ NB: openInWorld resets morphExtent @@@
[|m x| m := ImagePickerPanel namedColors. x := m morphExtent. m openInWorld. m morphExtent: x] value. 
"
	| sortedColors |
	sortedColors := SortedCollection sortBlock: 
		 [ :aAssoc :bAssoc | | a b |
			a := aAssoc value.
			b := bAssoc value.
			(a hue < b hue) 
				or: [(a hue = b hue) 
				and: [a saturation < b saturation ]]
		].
	Color colorNamesDict associationsDo: [ :assoc | 
		sortedColors add: assoc
	].
	
	^ self
		privateBuildPanelLabel:  'Pick a Color' 
		collection: sortedColors
		transducer: [:color | | dropColorMorph |
					dropColorMorph := DropColorMorph new.
					dropColorMorph image: (color icon "magnifyTo: 20 @ 20");
					color: color.
		] 
! !

!ImagePickerPanel class methodsFor: 'instance creation' stamp: 'KenD 10/26/2021 06:59:32'!
namedIcons
"
	ImagePickerPanel namedIcons openInHand.
	   @@@ NB: openInWorld resets morphExtent @@@
[|m x| m := ImagePickerPanel namedIcons. x := m morphExtent. m openInWorld. m morphExtent: x] value. 
"
	| iconsCollection sortedCollection |
	iconsCollection := OrderedCollection new. 
	{ 'actions'. 'apps'. 'categories'. 'devices'. 'emblems'. 'emotes'.
	  'mimetypes'. 'places'. 'smalltalk'. 'status'. } do: [ :category |
		iconsCollection addAll: (Theme content from: 'Theme' get: {'16x16'. category}) array.
	].
	sortedCollection := SortedCollection sortBlock: [ :a :b | a key < b key].
	sortedCollection addAll: (iconsCollection select: [ :assoc | assoc isNil not]).
	
	^ self
		privateBuildPanelLabel:  'Pick an Icon' 
		collection: sortedCollection
		transducer:  [:form | ImageMorph new image: form]
! !

!ImagePickerPanel class methodsFor: 'instance creation' stamp: 'KenD 9/20/2021 07:10:26'!
systemFonts
"
	ImagePickerPanel systemFonts 	 openInHand.
	   @@@ NB: openInWorld resets morphExtent @@@
[|m x| m := ImagePickerPanel systemFonts. x := m morphExtent. m openInWorld. m morphExtent: x] value. 
"
	| fontsCollection maxExtent |
	fontsCollection := OrderedCollection new. 
	FontFamily familyNames do: [ :familyName |
		fontsCollection add: 
			(Association 
				key: familyName
				value: (FontMorph 
						font: (FontFamily familyName: familyName 
								  pointSize: FontFamily defaultPointSize)))
		
	].

	maxExtent := 0@0.
	fontsCollection do: [ :assoc | maxExtent := maxExtent max: assoc value minimumExtent ].
	fontsCollection do: [ :assoc | |m | 
		m := assoc value. 
		m  morphExtent: maxExtent "(maxExtent x) @ (m morphExtent y)"
	].

	
	^ self
		privateBuildPanelLabel:  'Pick a Font' 
		collection: fontsCollection
		transducer:  [:form | form]
! !

!ImagePickerPanel class methodsFor: 'new-morph participation' stamp: 'KenD 9/16/2021 14:05:33'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	^ false! !

!ImagePickerPanel class methodsFor: 'utility' stamp: 'KenD 9/16/2021 13:49:40'!
useCSS3ColorDict
"
	ImagePickerPanel useCSS3ColorDict.
"
	Feature require: 'CSS3-NamedColors'.
	Color setColorNamesDict: Color css3ColorDictionary.! !

!ImagePickerPanel class methodsFor: 'utility' stamp: 'KenD 9/16/2021 13:48:35'!
useCrayonColorDict
"
	ImagePickerPanel useCrayonColorDict.
"
	Feature require: 'Crayon-NamedColors'.
	Color setColorNamesDict: Color crayonColorDictionary.! !

!ImagePickerPanel class methodsFor: 'utility' stamp: 'KenD 9/16/2021 13:51:38'!
useNBSISCCColorDict
"
	self useNBSISCCColorDict.
"
	Feature require: 'NBSISCC-NamedColors'.
	Color setColorNamesDict: Color nbsisccColorDictionary.! !

!ImagePickerPanel class methodsFor: 'utility' stamp: 'KenD 9/16/2021 13:51:54'!
useXKCDColorDict
"
	self useXKCDColorDict.
"

	Feature require: 'XKCD-NamedColors'.
	Color setColorNamesDict: Color xkcdColorDictionary.! !

!ImagePickerPanel class methodsFor: 'private' stamp: 'KenD 11/7/2021 14:18:18'!
privateBuildPanelLabel: aStringLabel 
collection: sortedNameImageCollection
transducer: imageProcessor
	"Common code for ImagePickerPanels"
	
	| picker scrollPane  |
	picker := Panel new.
	picker 
		color: Panel windowColor paler;
		setLabel: aStringLabel;
		showButtonsNamed: #( close collapse ).

	"Panel contains scroll-pane containes image selections"
	
	scrollPane := PluggableImagePallet new.
	"scrollPane 		model: scrollPane scroller."
	scrollPane 
		color: `Color orange` ;
		layoutSpec: LayoutSpec useAll;
		addToScroller: "set up pickable images"
			(scrollPane scroller 
				collection: sortedNameImageCollection
				filter: imageProcessor ) .
	scrollPane scroller borderWidth: 0.
	
		picker  layoutMorph 
		addMorph: scrollPane;
		color: `Color orange`.

	^ picker 
		morphExtent: scrollPane scroller morphExtentInOwner 
			+ (0 @ picker titleMorph morphExtentInOwner y)
			+ (8@4); "interior border"
		yourself
		! !

!PickAColorPallet class methodsFor: 'new-morph participation' stamp: 'KenD 12/7/2016 08:28:49'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	
	^ true! !

!PickAIconPallet class methodsFor: 'new-morph participation' stamp: 'KenD 12/7/2016 08:29:03'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	
	^ true! !

!PickALargerIconPallet class methodsFor: 'new-morph participation' stamp: 'KenD 12/7/2016 08:29:12'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	
	^ true! !

!Morph methodsFor: '*ui-pallet' stamp: 'KenD 11/5/2021 13:48:39'!
changeColor
	"Change the color of the receiver -- triggered, e.g. from a menu"

	"Override default method"
	(ImagePickerPanel clickSelectColorsFor: self) openInHand.! !

!SystemWindow methodsFor: '*ui-pallet' stamp: 'KenD 11/5/2021 14:06:04'!
changeColor
	"Change the color of the receiver -- triggered, e.g. from a menu.  This variant allows the recolor triggered from the window's halo recolor handle to have the same result as choosing change-window-color from the window-title menu"

	"ColorPickerMorph new
		choseModalityFromPreference;
		sourceHand: self world activeHand;
		target: self;
		selector: #setWindowColor:;
		originalColor: self color;
		putUpFor: self near: self morphFullBoundsInWorld"
	(ImagePickerPanel clickSelectColorsFor: self) openInHand.! !

!SystemWindow methodsFor: '*ui-pallet' stamp: 'KenD 11/5/2021 14:02:02'!
setWindowColor

	"Override to add click-color select"
	(ImagePickerPanel clickSelectColorsFor: self) openInHand.! !