extends Node2D


# Declare member variables here. Examples:

var rng = RandomNumberGenerator.new()
var playerHand: = 0
var dealerHand: = 0
var dealerShownHand = 0
var playerCard1 = 0
var playerCard2 = 0
var playerCard3 = 0
var playerCard4 = 0
var playerCard5 = 0
var playerCard6 = 0
var playerCard7 = 0
var playerCard8 = 0
var dealerCard1 = 0
var dealerCard2 = 0
var dealerCard3 = 0
var dealerCard4 = 0
var gameEnded = false


onready var hudPlayer = $GUI/HUD/MarginContainer/Data/playerHand
onready var hudDealer = $GUI/HUD/MarginContainer/Data/dealerHand
onready var hit_or_stand = $GUI/HUD/Controls/HBoxContainer
onready var restartGame = $GUI/HUD/Restart
onready var GameEndBox = $GUI/HUD/GameEndScenario
onready var hudWL = $GUI/HUD/GameEndScenario/Control/winOrLose


# Called when the node enters the scene tree for the first time.
func _ready():
	playerCard1 = get_new_card()
	playerCard2 = get_new_card()
	dealerCard1 = get_new_card()
	dealerCard2 = get_new_card()
	playerHand = playerCard1 + playerCard2
	dealerHand = dealerCard1 + dealerCard2
	dealerShownHand = dealerHand - dealerCard1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_hud_data()
	screenshot()


func display_hud_data():
	hudPlayer.text = "Your Hand: " + str(playerHand)
	if dealerShownHand != dealerHand:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand) + " + ?"
	else:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand)


# Deals a new card
func get_new_card():
	var card: int
	rng.randomize()
	card = 1 + rng.randi_range(1, 13)
	
	# Ace card logic
	if card == 1: return 11
	
	# Face card logic
	if card >= 10: return 10
	
	return card


func play_dealer_hand():
	if dealerHand < 17:
		dealerHand = dealerHand + get_new_card()
		# This can definitely be simplified
		if dealerCard3 == 0:
			dealerCard3 = dealerHand - dealerCard1 - dealerCard2
			dealerShownHand = dealerHand - dealerCard1
		else:
			dealerCard4 = dealerHand - dealerCard1 - dealerCard2 - dealerCard3
			dealerShownHand = dealerHand - dealerCard1
	#print("dCard1: " + str(dealerCard1))
	#print("dCard2: " + str(dealerCard2))
	#print("dCard3: " + str(dealerCard3))
	#print("dCard4: " + str(dealerCard4))
	return dealerHand


func determine_winner():
	hit_or_stand.visible = false
	dealerShownHand = dealerHand
	GameEndBox.visible = true
	if playerHand > 21:
		hudWL.text = ("You lose! You have gone bust!")
		gameEnded = true
	
	if playerHand == dealerHand and gameEnded == false:
		hudWL.text = ("Tie!")
		gameEnded = true
	
	if dealerHand > 21 and playerHand <= 21 and gameEnded == false:
		hudWL.text = ("You win! The dealer has gone bust!")
		gameEnded = true
	
	if playerHand > dealerHand and playerHand <= 21 and gameEnded == false:
		hudWL.text = ("You win! You beat the dealer!")
		gameEnded = true
	
	if playerHand < dealerHand and dealerHand <= 21 and gameEnded == false:
		hudWL.text = ("You lose! The dealer beat you!")
		gameEnded = true
	
	restartGame.visible = true


func _on_Hit_pressed():
	playerHand = playerHand + get_new_card()
	if playerHand > 21:
		determine_winner()
	elif playerHand >= 21 and dealerHand > 17:
		determine_winner()
	
	play_dealer_hand()
	if dealerHand >= 21:
		determine_winner()


func _on_Stand_pressed():
	while dealerHand < 17:
		play_dealer_hand()
	
	determine_winner()


func _on_playAgain_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = not get_tree().paused


func screenshot():
	if Input.is_action_pressed("ui_page_up"):
		var sysTime = OS.get_unix_time()
		var screenshot = get_viewport().get_texture().get_data()
		screenshot.flip_y()
		screenshot.save_png("res://Screenshots/screenshot-" + str(sysTime) + ".png")
