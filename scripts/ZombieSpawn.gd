extends ColorRect
class_name ZombieSpawn

export var spawn_timer: float = 1
export var spawn_chance: float = 50 # 100 = 100%

const ZOMBIE_PATH = "res://prefabs/ZombieBase.tscn"

var zombie_container: Node
var game_controller: Node

var zombies_spawned: int = 0

func _ready() -> void:
	zombie_container = $"/root".find_node("Zombies", true, false)
	game_controller = $"/root".find_node("GameController", true, false)


func start_spawning() -> void:
	randomize()
	print("Starting spawning")
	zombies_spawned = 0
	$SpawnTimer.wait_time = spawn_timer
	$SpawnTimer.start()


func stop_spawning() -> void:
	print("Stopping spawning")
	$SpawnTimer.stop()


func _on_SpawnTimer_timeout() -> void:
	var chance = 100 - (randf() * 100)
	if chance <= spawn_chance:
		spawn_zombie()


func spawn_zombie() -> void:
	var spawner_pos = get_position()
	var zombie: Zombie = load(ZOMBIE_PATH).instance()
	zombie_container.add_child(zombie)
	zombie.global_position = Vector2(
		spawner_pos.x,
		rand_range(spawner_pos.y, spawner_pos.y + get_size().y)
	)
