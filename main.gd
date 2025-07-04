extends Node

var save_path = 'user://variables.save'
var theNumber: int = 0

func _ready():
	load_data()


func _process(delta):
	$Music.volume_db = -$VolumeSlider.value 
	$THE_NUMBER.text = '$'+str(theNumber)
	$ClickMultiplierDisplay.text = "CLICK MULTIPLIER: " + "x" +str($Shop.clickMult) + '\nAUTO MULTIPLIER: ' + 'x' + str($Shop.autoMult) 

func _on_button_pressed():
	theNumber += 1 * $Shop.clickMult
	$THE_BUTTON/ButtonClick.pitch_scale = randf_range(1.0,1.1)
	$THE_BUTTON/ButtonClick.play()
	save()


func _on_timer_timeout():
	$Timer.start(1)
	if $Shop.isAutoOn == true:
		theNumber += 1 * $Shop.autoMult
		save()

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(theNumber)
	file.store_var($Shop.clickMult)
	file.store_var($Shop.autoMult)
	file.store_var($Shop.isAutoOn)
	print('Saved...')

func load_data():
	if FileAccess.file_exists(save_path):
		var file_load = FileAccess.open(save_path, FileAccess.READ)
		
		theNumber = file_load.get_var(theNumber)
		$Shop.clickMult = file_load.get_var($Shop.clickMult)
		$Shop.autoMult = file_load.get_var($Shop.autoMult)
		$Shop.isAutoOn = file_load.get_var($Shop.isAutoOn)
	else:
		print('No Save Data found.')


func _on_shop_save():
	save()


func _on_delete_save_button_pressed():
	theNumber = 0
	$Shop.clickMult = 1
	$Shop.autoMult = 1
	$Shop.isAutoOn = false
	get_tree().call_group('upgrade', 'show')
	$THE_BUTTON/ButtonClick.play()
