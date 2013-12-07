# Author: Emiliano Daddario
#github: emiliano183
#license: LGPL 3
nuimotion = require "nuimotion"
@Joints = nuimotion.Joints
@boilerplate = () ->
	Events = nuimotion.Events
	swipe = Events.Gestures.Swipe.types
	wave = Events.Gestures.Wave.types
	nuimotion.startSkeletonListener([
			Joints.LEFT_HAND
			Joints.RIGHT_HAND
		]
		@onSkeletonUpdate
		33
	)
	nuimotion.addListener([
			Events.SKELETON_TRACKING
			Events.SKELETON_STOPPED_TRACKING
		]
		@onUserEvent
	)
	nuimotion.addGesture([
			swipe.up
			swipe.down
			swipe.left
			swipe.right
			wave.hand
		]
		@onGesture
	)
	nuimotion.init()
	process.on "exit", ->
		nuimotion.close()
	return
