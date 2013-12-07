# Author: Emiliano Daddario
#github: emiliano183
#license: LGPL 3
global.x = 0
global.y = 0
global.click = false

global.childProcess = require('child_process')
terminal = global.childProcess.spawn 'bash'

terminal.stdout.on 'data', (data) ->
    console.log 'stdout: ' + data

terminal.on 'exit', (code) ->
	console.log 'child process exited with code ' + code

setInterval(
	()->
		console.log 'Sending stdin to terminal'
		command = ''
		if global.click
			command = 'xdotool click 1'
		else
			command = 'xdotool mousemove ' + global.x + ' ' + global.y
		terminal.stdin.write command
		terminal.stdin.end()
		terminal = global.childProcess.spawn 'bash'
	1000
)

@onSkeletonUpdate = (data) ->
	$("#rightHand").css "font-size", "100px"
	xLeft = data.skeleton[Joints.LEFT_HAND].x
	yLeft = data.skeleton[Joints.LEFT_HAND].y
	yRight = data.skeleton[Joints.RIGHT_HAND].y
	$("#rightHand").text yRight
	global.x = Math.min Math.max(0, (-xLeft+500)*2), 1980
	global.y = Math.min Math.max(0, (-yLeft+500)), 1020
	global.click = yRight > 500
	return
boilerplate.call @
