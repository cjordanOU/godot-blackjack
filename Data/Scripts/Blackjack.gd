extends Node2D


# Declaring Variables

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
var playerCard9 = 0
var dealerCard1 = 0
var dealerCard2 = 0
var dealerCard3 = 0
var dealerCard4 = 0
var dealerCard5 = 0
var dealerCard6 = 0
var dealerCard7 = 0
var currentCard = 2 # What card the player is currently on
var gameEnded = false
var playerVictory = false
var playerHasAce = false
var dealerHasAce = false
var playerHas2Aces = false
var dealerHas2Aces = false
var playerHas3Aces = false
var dealerHas3Aces = false
var playerHas4Aces = false
var dealerHas4Aces = false


onready var hudPlayer = $GUI/HUD/MarginContainer/Data/playerHand
onready var hudDealer = $GUI/HUD/MarginContainer/Data/dealerHand
onready var hit_or_stand = $GUI/HUD/Controls/HBoxContainer
onready var restartGame = $GUI/HUD/Restart
onready var GameEndBox = $GUI/HUD/GameEndScenario
onready var hudWL = $GUI/HUD/GameEndScenario/Control/winOrLose

onready var Card1 = $Cards/Card1
onready var Card1Top = $Cards/Card1/NumberTop
onready var Card1Btm = $Cards/Card1/NumberBottom

onready var Card2 = $Cards/Card2
onready var Card2Top = $Cards/Card2/NumberTop
onready var Card2Btm = $Cards/Card2/NumberBottom

onready var Card3 = $Cards/Card3
onready var Card3Top = $Cards/Card3/NumberTop
onready var Card3Btm = $Cards/Card3/NumberBottom

onready var Card4 = $Cards/Card4
onready var Card4Top = $Cards/Card4/NumberTop
onready var Card4Btm = $Cards/Card4/NumberBottom

onready var Card5 = $Cards/Card5
onready var Card5Top = $Cards/Card5/NumberTop
onready var Card5Btm = $Cards/Card5/NumberBottom


# Called when the node enters the scene tree for the first time.
func _ready():
	playerCard1 = get_new_card()
	playerCard2 = get_new_card()
	dealerCard1 = get_new_card()
	dealerCard2 = get_new_card()
	playerHand = playerCard1 + playerCard2
	dealerHand = dealerCard1 + dealerCard2
	dealerShownHand = dealerHand - dealerCard1
	check_for_natural()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_hud_data()
	display_card()
	screenshot()


func check_for_natural():
	if playerCard1 == 11 and playerCard2 == 10 or playerCard1 == 10 and playerCard2 == 11:
		if dealerHand != 21:
			hit_or_stand.visible = false
			display_hud_data()
			dealerShownHand = dealerHand
			GameEndBox.visible = true
			
			hudWL.text = ("Blackjack! You win!")
			gameEnded = true
			playerVictory = true
		else:
			hit_or_stand.visible = false
			display_hud_data()
			dealerShownHand = dealerHand
			GameEndBox.visible = true
			
			hudWL.text = ("Tie!")
			gameEnded = true


func display_hud_data():
	hudPlayer.text = "Your Hand: " + str(playerHand)
	if dealerShownHand != dealerHand:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand) + " + ?"
	else:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand)


func display_card():
	if playerCard1 == 1 or playerCard1 == 11:
		Card1Top.text = "A"
		Card1Btm.text = "A"
		playerHasAce = true
	else:
		Card1Top.text = str(playerCard1)
		Card1Btm.text = str(playerCard1)
	
	if playerCard2 == 1 or playerCard2 == 11:
		Card2Top.text = "A"
		Card2Btm.text = "A"
		playerHasAce = true
	else:
		Card2Top.text = str(playerCard2)
		Card2Btm.text = str(playerCard2)
	
	if playerCard3 != 0:
		Card3.visible = true
		if playerCard3 == 1 or playerCard3 == 11:
			Card3Top.text = "A"
			Card3Btm.text = "A"
			playerHasAce = true
		else:
			Card3Top.text = str(playerCard3)
			Card3Btm.text = str(playerCard3)
	
	if playerCard4 != 0:
		Card4.visible = true
		if playerCard4 == 1 or playerCard4 == 11:
			Card4Top.text = "A"
			Card4Btm.text = "A"
			playerHasAce = true
		else:
			Card4Top.text = str(playerCard4)
			Card4Btm.text = str(playerCard4)
	
	if playerCard5 != 0:
		Card5.visible = true
		if playerCard5 == 1 or playerCard5 == 11:
			Card5Top.text = "A"
			Card5Btm.text = "A"
			playerHasAce = true
		else:
			Card5Top.text = str(playerCard5)
			Card5Btm.text = str(playerCard5)

# Deals a new card
func get_new_card():
	var card: int
	var rngType: float
	rng.randomize()
	
	# Modified RNG chances for better gameplay
	rngType = rng.randf_range(0,1)
	if rngType >.65:
		card = rng.randi_range(1, 7)
	else:
		card = rng.randi_range(1, 13)
	
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
	display_hud_data()
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
		playerVictory = true
	
	if playerHand > dealerHand and playerHand <= 21 and gameEnded == false:
		hudWL.text = ("You win! You beat the dealer!")
		gameEnded = true
		playerVictory = true
	
	if playerHand < dealerHand and dealerHand <= 21 and gameEnded == false:
		hudWL.text = ("You lose! The dealer beat you!")
		gameEnded = true
	
	restartGame.visible = true


func _on_Hit_pressed():
	currentCard += 1
	if currentCard == 3:
		playerCard3 = get_new_card()
		playerHand = playerHand + playerCard3
		# Ace Logic
		if playerCard3 == 11:
			if playerHand > 21:
				playerCard3 = 1
				playerHand = playerCard1 + playerCard2 + playerCard3
	if currentCard == 4:
		playerCard4 = get_new_card()
		playerHand = playerHand + playerCard4
		# Ace Logic
		if playerCard4 == 11:
			if playerHand > 21:
				playerCard4 = 1
				playerHand = playerCard1 + playerCard2 + playerCard3 + playerCard4
	if currentCard == 5:
		playerCard5 = get_new_card()
		playerHand = playerHand + playerCard5
		# Ace Logic
		if playerCard5 == 11:
			if playerHand > 21:
				playerCard5 = 1
				playerHand = playerCard1 + playerCard2 + playerCard3 + playerCard4 + playerCard5
	
	if playerHand > 21:
		determine_winner()
	elif playerHand >= 21 and dealerHand > 17:
		determine_winner()
	
	#play_dealer_hand()
	#if dealerHand >= 21:
	#	determine_winner()


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
