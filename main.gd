extends Spatial

onready var ball = $RoomList/MainRoom/ParentA/Ball
onready var parent_a = $RoomList/MainRoom/ParentA
onready var parent_b = $RoomList/MainRoom/ParentB
onready var next_parent = parent_b

var portals_on = false


func _ready():
	toggle_portals()


func _unhandled_input(event):
	if event.is_action_pressed("reparent_ball"):
		reparent_ball()

	if event.is_action_pressed("toggle_portals"):
		toggle_portals()


func toggle_portals():
	if portals_on:
		$RoomManager.rooms_clear()
		$VBoxContainer/PortalLabel.text = "Portals OFF"
	else:
		$RoomManager.rooms_convert()
		$VBoxContainer/PortalLabel.text = "Portals ON"

	portals_on = not portals_on


func reparent_ball():
	# Change the ball's parent
	var curr_parent = ball.get_parent()
	curr_parent.remove_child(ball)
	next_parent.add_child(ball)
	next_parent = curr_parent

	# This casues the ball to disappear
	ball.global_transform = parent_a.global_transform
