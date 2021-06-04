extends Node2D


# Declaring Variables

var rng = RandomNumberGenerator.new()
var suits = ['Clubs','Diamonds','Hearts', 'Spades']
var cardValues = {"A": 11, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 10, "J": 10, "Q": 10, "K": 10 }

var clubsCardsRemaining = ["A", 2, 3, 4, 5, 6, 7, 8 , 9, 10, "J", "Q", "K"]
var diamondsCardsRemaining = ["A", 2, 3, 4, 5, 6, 7, 8 , 9, 10, "J", "Q", "K"]
var heartsCardsRemaining = ["A", 2, 3, 4, 5, 6, 7, 8 , 9, 10, "J", "Q", "K"]
var spadesCardsRemaining = ["A", 2, 3, 4, 5, 6, 7, 8 , 9, 10, "J", "Q", "K"]

var playerCard = [] # Array that stores what value the players cards have
var dealerCard = [] # Array that stores what value the dealers cards have

var playerHand: = 0
var dealerHand: = 0
var dealerShownHand = 0
var currentCard = 2

export var playerChips = 200
export var buyInAmount = 100

var roundEnded = false
var playerVictory = false
var playerTurn = true


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

onready var Card6 = $Cards/Card6
onready var Card6Top = $Cards/Card6/NumberTop
onready var Card6Btm = $Cards/Card6/NumberBottom

onready var Card7 = $Cards/Card7
onready var Card7Top = $Cards/Card7/NumberTop
onready var Card7Btm = $Cards/Card7/NumberBottom

onready var Card8 = $Cards/Card8
onready var Card8Top = $Cards/Card8/NumberTop
onready var Card8Btm = $Cards/Card8/NumberBottom

onready var Card9 = $Cards/Card9
onready var Card9Top = $Cards/Card9/NumberTop
onready var Card9Btm = $Cards/Card9/NumberBottom

# ------ ------ ------ ------ Functions ------ ------ ------ ------
# Called when the node enters the scene tree for the first time.
func _ready():
	playerCard.append(get_new_card())
	playerCard.append(get_new_card())
	dealerCard.append(get_new_card())
	dealerCard.append(get_new_card())
	playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) # Matches card values with cards
	dealerHand = cardValues.get(dealerCard[0]) + cardValues.get(dealerCard[1]) # Matches card values with cards
	dealerShownHand = dealerHand - cardValues.get(dealerCard[0]) # Matches card values with cards
	check_for_natural()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_hud_data()
	display_card()
	screenshot()

# Deals a new card
func get_new_card():
	var card: int
	var rngType: float
	rng.randomize()
	
	# Modified RNG chances for better gameplay
	rngType = rng.randf_range(0,1)
	if rngType >.65:
		card = rng.randi_range(2, 7) 
	else:
		card = rng.randi_range(1, 13)
	
	# Ace card logic
	if card == 1: return "A"
	
	# Face card logic
	if card > 10:
		if card == 11: return "J"
		if card == 12: return "Q"
		if card == 13: return "K"
	
	return card

# Checks to see if there is a natural at the start (immediate blackjack)
func check_for_natural():
	if cardValues.get(playerCard[0]) == 11 and cardValues.get(playerCard[1]) == 10 or cardValues.get(playerCard[0]) == 10 and cardValues.get(playerCard[1]) == 11:
		if dealerHand != 21:
			hit_or_stand.visible = false
			display_hud_data()
			dealerShownHand = dealerHand
			GameEndBox.visible = true
			
			hudWL.text = ("Blackjack! You win!")
			roundEnded = true
			playerVictory = true
		else:
			hit_or_stand.visible = false
			display_hud_data()
			dealerShownHand = dealerHand
			GameEndBox.visible = true
			
			hudWL.text = ("Tie!")
			roundEnded = true

# Displays/updates HUD data
func display_hud_data():
	hudPlayer.text = "Your Hand: " + str(playerHand)
	if dealerShownHand != dealerHand:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand) + " + ?"
	else:
		hudDealer.text = "Dealer Hand: " + str(dealerShownHand)

# Displays card values on cards
func display_card():
	Card1Top.text = str(playerCard[0])
	Card1Btm.text = str(playerCard[0])
	
	Card2Top.text = str(playerCard[1])
	Card2Btm.text = str(playerCard[1])
	
	if playerCard.size() == 3:
		Card3.visible = true
		Card3Top.text = str(playerCard[2])
		Card3Btm.text = str(playerCard[2])
	
	if playerCard.size() == 4:
		Card4.visible = true
		Card4Top.text = str(playerCard[3])
		Card4Btm.text = str(playerCard[3])
	
	if playerCard.size() == 5:
		Card5.visible = true
		Card5Top.text = str(playerCard[4])
		Card5Btm.text = str(playerCard[4])
	
	if playerCard.size() == 6:
		Card6.visible = true
		Card6Top.text = str(playerCard[5])
		Card6Btm.text = str(playerCard[5])
	
	if playerCard.size() == 7:
		Card7.visible = true
		Card7Top.text = str(playerCard[6])
		Card7Btm.text = str(playerCard[6])
	
	if playerCard.size() == 8:
		Card8.visible = true
		Card8Top.text = str(playerCard[7])
		Card8Btm.text = str(playerCard[7])
	
	if playerCard.size() == 9:
		Card9.visible = true
		Card9Top.text = str(playerCard[8])
		Card9Btm.text = str(playerCard[8])


func play_dealer_hand():
	if dealerHand < 17:
		dealerCard.append(get_new_card())
		dealerHand = dealerHand + cardValues.get(dealerCard.back())
		# This can definitely be simplified
		if dealerCard.size() == 3:
			dealerCard[2] = dealerHand - cardValues.get(dealerCard[0]) - cardValues.get(dealerCard[1])
			dealerShownHand = dealerHand - cardValues.get(dealerCard[0])
		else:
			dealerCard[3] = dealerHand - cardValues.get(dealerCard[0]) - cardValues.get(dealerCard[1]) - cardValues.get(dealerCard[2])
			dealerShownHand = dealerHand - cardValues.get(dealerCard[0])
	return dealerHand


func determine_winner():
	hit_or_stand.visible = false
	display_hud_data()
	dealerShownHand = dealerHand
	
	GameEndBox.visible = true
	if playerHand > 21:
		hudWL.text = ("You lose! You have gone bust!")
		roundEnded = true
	
	if playerHand == dealerHand and roundEnded == false:
		hudWL.text = ("Tie!")
		roundEnded = true
	
	if dealerHand > 21 and playerHand <= 21 and roundEnded == false:
		hudWL.text = ("You win! The dealer has gone bust!")
		roundEnded = true
		playerVictory = true
	
	if playerHand > dealerHand and playerHand <= 21 and roundEnded == false:
		hudWL.text = ("You win! You beat the dealer!")
		roundEnded = true
		playerVictory = true
	
	if playerHand < dealerHand and dealerHand <= 21 and roundEnded == false:
		hudWL.text = ("You lose! The dealer beat you!")
		roundEnded = true
	
	restartGame.visible = true


func _on_Hit_pressed():
	currentCard += 1
	if currentCard == 3:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[2])
		# Ace Logic
		if str(playerCard[2]) == "A":
			if playerHand > 21:
				playerCard.remove(3)
				playerCard.append(1)
				playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2])
	if currentCard == 4:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[3])
		# Ace Logic
		if str(playerCard[3]) == "A":
			if playerHand > 21:
				playerCard.remove(4)
				playerCard.append(1)
				playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3])
	if currentCard == 5:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[4])
		# Ace Logic
		if str(playerCard[4]) == "A":
			if playerHand > 21:
				playerCard.remove(5)
				playerCard.append(1)
				playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3]) + cardValues.get(playerCard[4])
	if currentCard == 6:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[5])
		# Ace Logic
		if str(playerCard[5]) == "A":
			if playerHand > 21:
				if playerHand > 21:
					playerCard.remove(6)
					playerCard.append(1)
					playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3]) + cardValues.get(playerCard[4]) + cardValues.get(playerCard[5])
	if currentCard == 7:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[6])
		# Ace Logic
		if str(playerCard[6]) == "A":
			if playerHand > 21:
				if playerHand > 21:
					playerCard.remove(7)
					playerCard.append(1)
					playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3]) + cardValues.get(playerCard[4]) + cardValues.get(playerCard[5]) + cardValues.get(playerCard[6])
	if currentCard == 8:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[7])
		# Ace Logic
		if str(playerCard[7]) == "A":
			if playerHand > 21:
				if playerHand > 21:
					playerCard.remove(8)
					playerCard.append(1)
					playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3]) + cardValues.get(playerCard[4]) + cardValues.get(playerCard[5]) + cardValues.get(playerCard[6]) + cardValues.get(playerCard[7])
	if currentCard == 9:
		playerCard.append(get_new_card())
		playerHand = playerHand + cardValues.get(playerCard[8])
		# Ace Logic
		if str(playerCard[8]) == "A":
			if playerHand > 21:
				if playerHand > 21:
					playerCard.remove(9)
					playerCard.append(1)
					playerHand = cardValues.get(playerCard[0]) + cardValues.get(playerCard[1]) + cardValues.get(playerCard[2]) + cardValues.get(playerCard[3]) + cardValues.get(playerCard[4]) + cardValues.get(playerCard[5]) + cardValues.get(playerCard[6]) + cardValues.get(playerCard[7]) + cardValues.get(playerCard[8])
	
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
