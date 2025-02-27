"
I have examples of barcharts
"
Class {
	#name : 'RSBarChartExample',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Chart-Examples',
	#package : 'Roassal-Chart-Examples'
}

{ #category : 'examples' }
RSBarChartExample >> example01TwoBars [

	<script: 'self new example01TwoBars open'>
	| c p p2 x y size |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSCompositeChart new.
	p := RSBarPlot new x: x y: y.
	size := 6.
	p barSize: size.
	p barOffset: size / 2.
	p2 := RSBarPlot new x: x y: y + 0.5.
	p2 barSize: size.
	p2 barOffset: size / -2.
	c add: p.
	c add: p2.
	c horizontalTick doNotUseNiceLabel;
			 numberOfTicks: x size - 1;
			 asFloat: 5;
			 useVerticalLabel.

	c build.
	p bars @ RSPopup.

	p2 bars
		when: RSMouseEnter
		do: [ :evt |
			| color |
			color := Color random.
			p2 bars do: [ :shape | shape color: color ].
			evt signalUpdate ]
		for: self.
	^ c canvas
]

{ #category : 'examples' }
RSBarChartExample >> example02TwoHorizontalBars [
	<script: 'self new example02TwoHorizontalBars open'>
	| c p p2 x y size lb |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSCompositeChart new.
	p := RSHorizontalBarPlot new x: y y: x.
	size := 5.
	p barSize: size.
	p barOffset: size / 2.
	p2 := RSHorizontalBarPlot new x: y +0.5 y: x.
	p2 barSize: size.
	p2 barOffset: size / -2.
	c add: p.
	c add: p2.
	c build.
	p bars , p2 bars @ RSPopup.
	lb := RSLegend new.
	lb container: c canvas.
	lb text: 'Series1' withBoxColor: p computeColor.
	lb text: 'Series2' withBoxColor: p2 computeColor.
	lb legendDo: [ :shape | shape withBorder; padding: 10; scaleBy: 0.5 ].
	lb location
		inner; bottom; right; offset: -30.
	lb build.
	^ c canvas
]

{ #category : 'examples' }
RSBarChartExample >> example03TilePaint [
	<script: 'self new example03TilePaint open'>

	| data x paintBlock c lb size labels |
	data := {
		{  10. 9 }.
		{ 20. 15 }.
		{ 11. 7 }.
		{ 30. 25 } }.
	x := 1 to: 2.

	paintBlock := [ :aColor |
		| tileCanvas e morph paint |
		tileCanvas := RSCanvas new.
		e := 10@10.

		tileCanvas add: (RSBox new color: aColor; extent: e; yourself).
		tileCanvas add: (RSEllipse new
			color: Color black;
			extent: e / 4;
			position: e / 4;
			yourself).
		tileCanvas add: (RSEllipse new
			color: Color black;
			extent: e / 4;
			position: e / -4;
			yourself).
		morph := tileCanvas createMorph.
		morph extent: e*(1@0.75).
		morph drawOnMockCanvas.
		paint := AthensCairoPatternSurfacePaint createForSurface: morph surface.
		paint repeat.
		paint ].

	c := RSCompositeChart new.
	c extent: 300@ 200.
	lb := RSLegend new.
	lb container: c canvas.
	size := 25.

	lb title: 'Nerd?'.
	lb text: 'Not nerd' withBoxColor: Color gray.
	lb text: 'Nerd' withBoxColor: (paintBlock value: Color gray).
	lb text: ' '.
	labels := #('<5' '5-10' '10-20' '>20').
	lb title: 'Study Time'.

	data doWithIndex: [ :serie :index |
		| plot color |
		c add: (plot := RSBarPlot new x: x y: serie).
		color := plot computeColor.
		index even
			ifTrue: [ plot color: (paintBlock value: color) ].
		plot barSize: size .
		plot barOffset: ((index-(data size +1/ 2)) * size).
		lb text: (labels at: index) withBoxColor: color.
		].

	c horizontalTick fromNames: #(Math Science); labelRotation: 0.
	c verticalTick numberOfTicks: 5.
	c ylabel: 'Number of students'.
	c xlabel: 'Class'.
	c build.
	lb legendDo: [ :shape | shape scaleBy: 0.6 ].
	lb location right; middle; offset: 10@0.
	lb build.

	^ c canvas
]

{ #category : 'examples' }
RSBarChartExample >> example04VerticalStack [
	<script: 'self new example04VerticalStack open'>
	| c menMeans womenMeans lb |
	c := RSCompositeChart new.
	c extent: 300@200.
	menMeans := #(20 35 30 35 27).
	womenMeans := #(25 32 34 20 25).
	c add: (RSAbstractChart barHeights: menMeans).
	c add: ((RSAbstractChart barHeights: womenMeans) bottom: menMeans).
	c horizontalTick fromNames: #(Day1 Day2 Day3 Day4 Day5).
	c verticalTick integer.
	c ylabel: 'Scores'.
	c title: 'Scores by group of gender'.
	c build.
	lb := RSLegend new.
	lb layout horizontal.
	#(Men Women) doWithIndex: [ :lbl :index |
		lb text: lbl withBoxColor: (c plots at:index) computeColor ].
	lb container: c canvas.
	lb build.
	^ c canvas
]

{ #category : 'examples' }
RSBarChartExample >> example05HorizontalStack [

	<script: 'self new example05HorizontalStack open'>
	| c menMeans womenMeans lb |
	c := RSCompositeChart new.
	c extent: 300 @ 200.
	menMeans := #( 20 35 30 35 27 ).
	womenMeans := #( 25 32 34 20 25 ).
	c add: (RSAbstractChart barWidths: menMeans).
	c add: ((RSAbstractChart barWidths: womenMeans) left: menMeans).
	c horizontalTick integer.
	c verticalTick fromNames: #( Day1 Day2 Day3 Day4 Day5 ).
	c xlabel: 'Scores'.
	c title: 'Scores by group of gender'.
	c build.
	lb := RSLegend new.
	lb layout horizontal.
	#( Men Women ) doWithIndex: [ :lbl :index |
		lb text: lbl withBoxColor: (c plots at: index) computeColor ].
	lb container: c canvas.
	lb build.
	^ c canvas
]

{ #category : 'examples' }
RSBarChartExample >> example06BarAnimation [
	<script: 'self new example06BarAnimation open'>
	| canvas bars |
	canvas := self example01TwoBars.
	bars := canvas shapes select: [ :shape | shape class = RSBox ].
	bars allButFirst doWithIndex: [ :shape :index |
		| rectangle from to |
		rectangle := shape encompassingRectangle.
		shape height: 0.
		shape model > 0 ifTrue: [
			from := rectangle corner y.
			to := rectangle origin y ]
		ifFalse: [
			to := rectangle corner y.
			from := rectangle origin y
			].

		canvas newAnimation
			easing: RSEasingInterpolator circleOut;
			delay: (index * 200) milliSeconds;
			duration: 1 second;
			from: from;
			to: to;
			onStepDo: [ :t |
				shape fromRectangle:
					(shape model > 0
						ifTrue: [ rectangle origin x @ t corner: rectangle corner ]
						ifFalse: [ rectangle origin corner: rectangle corner x @ t ]). ].
		 ].

	^ canvas
]

{ #category : 'examples' }
RSBarChartExample >> example07DoubleBar [

	<script: 'self new example07DoubleBar open'>
	| classes x1 x2 y plot title |
	classes := RSShape withAllSubclasses asOrderedCollection sorted: [
		           :a
		           :b | a name < b name ].
	x1 := classes collect: #numberOfMethods.
	x2 := classes collect: #numberOfVariables.
	y := 1 to: classes size.
	plot := RSDoubleBarPlot new x1: x1 x2: x2 y: y.

	plot horizontalTick
		numberOfTicks: 10;
		labelConversion: #asInteger.
	plot horizontalTopTick
		numberOfTicks: 10;
		labelConversion: #asInteger.

	plot xlabel: 'Number Of Methods'.
	plot xlabelTop: 'Number Of Variables'.

	plot verticalTick fromNames: (classes collect: #name).
	plot addDecoration: (RSVerticalRightTick new
			 values: (1 to: classes size);
			 numberOfTicks: 10;
			 fromNames: (classes collect: #linesOfCode)).

	plot ylabel: 'Classes'.
	plot ylabelRight: 'Number of lines Of code'.
	title := plot title: 'RSShape withAllSubclasses'.
	title shape
		bold;
		noPaint;
		withBorder.

	plot build.
	plot bars , plot bars2 @ RSPopup.
	title label
		addInteraction: (RSPopup text: 'Click to inspect');
		when: RSMouseClick do: [ :evt | classes inspect ] for: self.
	^ plot canvas
]
