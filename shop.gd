extends Control

signal save

@export var isAutoOn: bool = false






var clickMult: int = 1
var autoMult: int = 1

@export_category("Upgrade Cost")
@export var autoUnclockCost: int = 250 # 250

@export var click1Cost: int = 100 #100
@export var click2Cost: int = 500 #500
@export var click3Cost: int = 1000 #1000

@export var auto1Cost: int = 200 #200
@export var auto2Cost: int = 1000 #1000
@export var auto3Cost: int = 10000 #10000

func _ready():
	
	checkButton($AutoUnlock, 'AUTOCLICKER', autoUnclockCost)
	checkButton($ClickUpgrade1, '2x', click1Cost)
	checkButton($ClickUpgrade2, '5x', click2Cost)
	checkButton($ClickUpgrade3, '10x', click3Cost)
	checkButton($AutoUpgrade1, '2x', auto1Cost)
	checkButton($AutoUpgrade2, '5x', auto2Cost)
	checkButton($AutoUpgrade3, '10x', auto3Cost)

func _process(delta):
	if isAutoOn == true:
		$AutoUnlock.disabled = true
	else:
		$AutoUnlock.disabled = false
	match clickMult:
		10:
			$ClickUpgrade1.disabled = true
			$ClickUpgrade2.disabled = true
			$ClickUpgrade3.disabled = true
		5:
			$ClickUpgrade1.disabled = true
			$ClickUpgrade2.disabled = true
		2:
			$ClickUpgrade1.disabled = true
		1:
			$ClickUpgrade1.disabled = false
			$ClickUpgrade2.disabled = false
			$ClickUpgrade3.disabled = false
	match autoMult:
		10:
			$AutoUpgrade1.disabled = true
			$AutoUpgrade2.disabled = true
			$AutoUpgrade3.disabled = true
		5:
			$AutoUpgrade1.disabled = true
			$AutoUpgrade2.disabled = true
		2:
			$AutoUpgrade1.disabled = true
		1:
			$AutoUpgrade1.disabled = false
			$AutoUpgrade2.disabled = false
			$AutoUpgrade3.disabled = false
func _on_auto_unlock_pressed():
	if get_parent().theNumber >= autoUnclockCost:
		get_parent().theNumber -= autoUnclockCost
		isAutoOn = true
		$AutoUnlock.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()


func _on_click_upgrade_1_pressed():
	if get_parent().theNumber >= click1Cost:
		get_parent().theNumber -= click1Cost
		clickMult = 2
		$ClickUpgrade1.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()
func _on_click_upgrade_2_pressed():
	if get_parent().theNumber >= click2Cost:
		get_parent().theNumber -= click2Cost
		clickMult = 5
		$ClickUpgrade2.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()
func _on_click_upgrade_3_pressed():
	if get_parent().theNumber >= click3Cost:
		get_parent().theNumber -= click3Cost
		clickMult = 10
		$ClickUpgrade3.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()


func _on_auto_upgrade_1_pressed():
	if get_parent().theNumber >= auto1Cost:
		get_parent().theNumber -= auto1Cost
		autoMult = 2
		$AutoUpgrade1.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()
func _on_auto_upgrade_2_pressed():
	if get_parent().theNumber >= auto2Cost:
		get_parent().theNumber -= auto2Cost
		autoMult = 5
		$AutoUpgrade2.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()
func _on_auto_upgrade_3_pressed():
	if get_parent().theNumber >= auto3Cost:
		get_parent().theNumber -= auto3Cost
		autoMult = 10
		$AutoUpgrade3.disabled = true
		save.emit()
		$UpgradeClick.play()
	else:
		$IncorrectBuzzer.play()

func checkButton(button, multiplier:String, cost:int):
	if button.disabled == false:
		button.text = multiplier + '\n$' + str(cost)
	else:
		pass
