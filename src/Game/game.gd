class_name Game
extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/entities/actors/entity_definition_player.tres")
const goblin_definition: EntityDefinition = preload("res://assets/definitions/entities/actors/entity_definition_goblin.tres")

@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities
@onready var map: Map = $Map

func _ready() -> void:
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	player = Entity.new(player_start_pos, player_definition)
	entities.add_child(player)
	var npc := Entity.new(player_start_pos + Vector2i.RIGHT, goblin_definition)
	entities.add_child(npc)


func get_map_data() -> MapData:
	return map.map_data


func _physics_process(_delta: float) -> void:
	var action: Action = event_handler.get_action()
	if action:
		action.perform(self, player)
