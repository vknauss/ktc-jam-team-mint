class_name BodySlot
extends Node

signal statusChanged

var heldItem: Item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func insert_item(item: Item) -> bool:
	if heldItem != null || item == null:
		return false
	heldItem = item
	for effect in heldItem.effects:
		statusChanged.emit(effect.statusIndex, effect.statusDelta)
	return true

func remove_item() -> void:
	if heldItem != null:
		for effect in heldItem.effects:
			statusChanged.emit(effect.statusIndex, -effect.statusDelta) 
