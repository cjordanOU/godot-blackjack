extends Node2D


# Declare member variables here. Examples:

var rng = RandomNumberGenerator.new()
var playerHand: int
var dealerHand: int
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


# Called when the node enters the scene tree for the first time.
func _ready():
	playerHand = get_new_card()
	dealerHand = get_new_card()
	playerCard1 = playerHand
	dealerCard1 = dealerHand

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_hud_data()


func display_hud_data():
	$GUI/HUD/MarginContainer/Data/playerHand.text = "Your Hand: " + str(playerHand)
	$GUI/HUD/MarginContainer/Data/dealerHand.text = "Dealer Hand: " + str(dealerHand) + " + ?"

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
		if dealerCard1 != 0:
			if dealerCard2 == 0:
				dealerCard2 = dealerHand - dealerCard1
			else:
				if dealerCard3 == 0:
					dealerCard3 = dealerHand - dealerCard1 - dealerCard2
				else:
					dealerCard4 = dealerHand - dealerCard1 - dealerCard2 -dealerCard3
	print("dCard1: " + str(dealerCard1))
	print("dCard2: " + str(dealerCard2))
	print("dCard3: " + str(dealerCard3))
	print("dCard4: " + str(dealerCard4))
	return dealerHand

func determine_winner():	
	if playerHand > 21:
		print("You lose! You have gone bust!")
	
	if playerHand == dealerHand:
		print("Tie!")
	
	if dealerHand > 21:
		print("You win! The dealer has gone bust!")
	
	if playerHand > dealerHand:
		print("You win! You beat the dealer!")
	
	if playerHand < dealerHand:
		print("You lose! The dealer beat you!")


func _on_Hit_pressed():
	playerHand = playerHand + get_new_card()
	if playerHand >= 21 and dealerHand > 17:
		determine_winner()
	play_dealer_hand()
	if dealerHand >= 21:
		determine_winner()

func _on_Stand_pressed():
	pass # Replace with function body.
