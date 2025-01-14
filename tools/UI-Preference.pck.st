'From Cuis 6.0 [latest update: #5173] on 25 May 2022 at 11:17:40 pm'!
'Description '!
!provides: 'UI-Preference' 1 13!
!requires: 'UI-Click-Select' 1 31 nil!
SystemOrganization addCategory: 'UI-Preference'!


!classDefinition: #PreferenceBrowser category: 'UI-Preference'!
DialogPanel subclass: #PreferenceBrowser
	instanceVariableNames: 'categoriesListMorph preferencesGroup categories category pane'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Preference'!
!classDefinition: 'PreferenceBrowser class' category: 'UI-Preference'!
PreferenceBrowser class
	instanceVariableNames: ''!

!classDefinition: #PreferenceType category: 'UI-Preference'!
Object subclass: #PreferenceType
	instanceVariableNames: 'preference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Preference'!
!classDefinition: 'PreferenceType class' category: 'UI-Preference'!
PreferenceType class
	instanceVariableNames: ''!

!classDefinition: #PreferenceTypeClosure category: 'UI-Preference'!
PreferenceType subclass: #PreferenceTypeClosure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Preference'!
!classDefinition: 'PreferenceTypeClosure class' category: 'UI-Preference'!
PreferenceTypeClosure class
	instanceVariableNames: ''!

!classDefinition: #PreferenceVisitor category: 'UI-Preference'!
Object subclass: #PreferenceVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Preference'!
!classDefinition: 'PreferenceVisitor class' category: 'UI-Preference'!
PreferenceVisitor class
	instanceVariableNames: ''!

!classDefinition: #PreferenceBrowserVisitor category: 'UI-Preference'!
PreferenceVisitor subclass: #PreferenceBrowserVisitor
	instanceVariableNames: 'views'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'UI-Preference'!
!classDefinition: 'PreferenceBrowserVisitor class' category: 'UI-Preference'!
PreferenceBrowserVisitor class
	instanceVariableNames: ''!


!PreferenceBrowser commentStamp: 'hlsf 5/14/2022 10:24:23' prior: 0!
I browse a selected set of preference categories. The user can edit the preferences
	- model : an array of preference categories (symbols) to browse. 
	If nil, I browse all the preferences in the system!

!PreferenceType commentStamp: '<historical>' prior: 0!
An abstract class to manipulate the type of a given preference.!

!PreferenceBrowserVisitor commentStamp: '<historical>' prior: 0!
I visit a preference to provide its morphic view
- views: dictionary of labels and activable morph to edit the preference!

!PreferenceBrowser methodsFor: 'GUI building' stamp: 'hlsf 4/26/2022 00:17:32'!
buildMorphicWindow
	super buildMorphicWindow.
	titleMorph showButtonsNamed: #(close expand).! !

!PreferenceBrowser methodsFor: 'GUI building' stamp: 'hlsf 4/25/2022 17:55:24'!
newButtonArea
	^ nil! !

!PreferenceBrowser methodsFor: 'GUI building' stamp: 'hlsf 4/26/2022 00:23:53'!
newPane
	^ pane  _ LayoutMorph newRow ::
		addMorph: categoriesListMorph proportionalWidth: 0.3;
		addAdjusterMorph;
		addMorph: preferencesGroup ;
		yourself! !

!PreferenceBrowser methodsFor: 'initialization' stamp: 'hlsf 5/14/2022 10:25:12'!
initialize
	super initialize.
	categoriesListMorph _ PluggableListMorph 
		model: self listGetter: #categoryNames indexGetter: #categoryIndex indexSetter: #categoryIndex: ::
		autoDeselect: false ;
		yourself.
	preferencesGroup _  PluggableScrollPane new ::
		color: self color;
		layoutSpec: LayoutSpec useAll! !

!PreferenceBrowser methodsFor: 'initialization' stamp: 'hlsf 5/14/2022 10:21:47'!
model: selectedCategories
	selectedCategories 
		ifNil:  [model _ PreferenceNG categories sorted]
		ifNotNil: [	model _ selectedCategories sorted]! !

!PreferenceBrowser methodsFor: 'accessing' stamp: 'hlsf 5/14/2022 10:20:09'!
categoryIndex
	^ model indexOf: category! !

!PreferenceBrowser methodsFor: 'accessing' stamp: 'hlsf 5/18/2022 16:35:28'!
categoryIndex: anIndex
	| group visitor |
	category _ model at: anIndex.
	visitor _ PreferenceBrowserVisitor new.
	(PreferenceNG selectCategory: category) do: [:preference | preference accept: visitor].	
	visitor views do: [:view | view adoptWidgetsColor: widgetsColor ].
	group _ LabelGroup with: visitor views associations.
	preferencesGroup 	scroller: group.
	self redrawNeeded 
	 ! !

!PreferenceBrowser methodsFor: 'accessing' stamp: 'hlsf 5/14/2022 10:19:17'!
categoryNames
	^ model collect: [:aSymbol | aSymbol asString capitalized ]! !

!PreferenceBrowser methodsFor: 'menus' stamp: 'hlsf 4/26/2022 00:34:44'!
expand
	super expand.
	self fullScreen ! !

!PreferenceBrowser methodsFor: 'geometry' stamp: 'hlsf 5/18/2022 16:36:34'!
minimumExtent
	^ 900@600! !

!PreferenceType methodsFor: 'accessing' stamp: 'hlsf 5/15/2022 10:51:34'!
preference: aPref
	preference _ aPref ! !

!PreferenceType class methodsFor: 'instance creation' stamp: 'hlsf 5/15/2022 10:51:41'!
with: aPref
	^ self new ::
		preference: aPref;
		yourself! !

!PreferenceTypeClosure methodsFor: 'accessing' stamp: 'hlsf 5/15/2022 10:58:17'!
sourceCode
" decompile the closure and answer it as string "
	^ (preference instVarNamed: #value) decompile decompileString! !

!PreferenceTypeClosure methodsFor: 'accessing' stamp: 'hlsf 5/15/2022 10:59:58'!
sourceCode: aString
	"Compile and adjust the value of the preference"! !

!PreferenceVisitor methodsFor: 'as yet unclassified' stamp: 'hlsf 5/14/2022 23:53:39'!
visitBooleanPreference: aPref
	self subclassResponsibility ! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/15/2022 12:04:08'!
visitAbstractFontPreference: aPref
	
	views at: aPref name capitalized put: (LabelMorph contents: aPref value asString)! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/15/2022 12:03:02'!
visitArrayClassPreference: aPref
"My type is an Array Class, I have no selection"
	
	views at: aPref name capitalized put: (LabelMorph contents: aPref value asString)! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/25/2022 23:01:42'!
visitArrayPreference: aPref
	| list listMorph |
	aPref isTypeAClass ifTrue: [^ self visitArrayClassPreference: aPref].
	listMorph  _ DropDownListMorph 
		model: (list _ ListModel with: aPref type) 
		listGetter: #list 
		indexGetter: #listIndex 
		indexSetter: #listIndex: ::
		autoDeselect: false;
		setBalloonText: aPref description.
	list listIndex: (aPref type indexOf: aPref value).
	list when: #listSelectionChanged send: #changedList:for: to: self withArguments: {list. aPref}.
	list actionMap inspect.
	views at: aPref name capitalized put: listMorph! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/15/2022 12:03:47'!
visitBlockClosurePreference: aPref
	| codeView typeModel |
	typeModel _ PreferenceTypeClosure with: aPref.
	codeView _ TextModelMorph textProvider: typeModel textGetter: #sourceCode textSetter: #sourceCode:.
	codeView setBalloonText: aPref description.
	views at: aPref name capitalized put: codeView
	! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/15/2022 12:26:29'!
visitBooleanPreference: aPref
	| check |
	check _ CheckButtonMorph new ::
		selected: aPref value;
		setBalloonText: aPref description;
		yourself.
	check when: #checkSelection send: #changedCheck:for:  to: self withArguments: {check. aPref} .
	views at: aPref name capitalized put: check! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/18/2022 15:46:56'!
visitSmallIntegerPreference: aPref
	| entry |
	entry _ SimpleNumberEntryMorph 
		integerDefault: aPref value maxNumChars: SmallInteger maxVal asString size ::
		valueUpdator: [:newValue | aPref value: newValue];
		setBalloonText: aPref description.
	views at: aPref name capitalized put: entry.
! !

!PreferenceBrowserVisitor methodsFor: 'visitors type' stamp: 'hlsf 5/18/2022 15:47:59'!
visitStringPreference: aPref
	| entry |
	entry _ TextEntryMorph contents: aPref value ::
		setBalloonText: aPref description;
		yourself.
	entry crAction: [aPref value: entry value].
	views at: aPref name capitalized put: entry.
! !

!PreferenceBrowserVisitor methodsFor: 'events-handling' stamp: 'hlsf 5/15/2022 12:24:13'!
changedCheck: checkButton for: aPref
	aPref value: checkButton isSelected! !

!PreferenceBrowserVisitor methodsFor: 'events-handling' stamp: 'hlsf 5/15/2022 12:24:37'!
changedList: listModel for: aPref
	aPref value: listModel selectedItem ! !

!PreferenceBrowserVisitor methodsFor: 'morphic' stamp: 'hlsf 5/15/2022 11:20:53'!
rowWithLabel: aPref
	^ LayoutMorph newRow ::
		color: Color transparent ;
		addMorph: (LabelMorph contents: aPref name capitalized);
		yourself! !

!PreferenceBrowserVisitor methodsFor: 'accessing' stamp: 'hlsf 5/15/2022 12:04:54'!
views
	^ views! !

!PreferenceBrowserVisitor methodsFor: 'initialization' stamp: 'hlsf 5/15/2022 12:08:03'!
initialize
	super initialize.
	views _ Dictionary new.! !
