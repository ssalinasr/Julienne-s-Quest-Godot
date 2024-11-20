extends Node2D

@onready var label_ranking : Label = $Control/LabelRanking
@onready var label_title_notas : Label = $Control/LabelTitleNotas
@onready var label_ending : Label = $Control/LabelEnding

func rankingValues() -> void:
	var total_loot = CountableVars.curr_loot + CountableVars.curr_treasures
	if total_loot == 45:
		label_ranking.text = str(total_loot)+"/45: Rank S"
	elif total_loot < 45 and total_loot >= 35:
		label_ranking.text = str(total_loot)+"/45: Rank A"
	elif total_loot < 35 and total_loot >= 25:
		label_ranking.text = str(total_loot)+"/45: Rank B"
	elif total_loot < 25 and total_loot >= 15:
		label_ranking.text = str(total_loot)+"/45: Rank C"
	elif total_loot < 15:
		label_ranking.text = str(total_loot)+"/45: Rank D"

func loreRanking() -> void:
	var total_notes = CountableVars.curr_qnotes + CountableVars.curr_notes
	if total_notes == 8:
		label_title_notas.text = str(total_notes)+"/8: Cazador de lore"
	else:
		label_title_notas.text = str(total_notes)+"/8: Notas insuficientes"

func endingSetter() -> void:
	var lore_ending = [DialogSignals.level1_int_sucess[0], DialogSignals.level1_int_sucess[1],
	 DialogSignals.level2_int_sucess[0], DialogSignals.level3_int_sucess[0], DialogSignals.level4_int_sucess[0],
	 DialogSignals.level4_int_sucess[1], DialogSignals.level5_int_sucess[0]]
	
	var bad_ending = [DialogSignals.level2_int_sucess[1], DialogSignals.level3_int_sucess[1], DialogSignals.level4_int_sucess[2],
	DialogSignals.level5_int_sucess[1]]
	
	var easter_egg_ending = [DialogSignals.level2_int_sucess[2], DialogSignals.level3_int_sucess[2], DialogSignals.level4_int_sucess[3]]
	
	if lore_ending.all(func allTrue(element): return element == true):
		label_ending.text = "Good Ending: \n Julienne ha salido del castillo y ha avisado \n de su riesgo a los poblados más cercanos..."
	elif bad_ending.all(func allTrue(element): return element == true):
		label_ending.text = "Bad Ending: \n Julienne no ha podido escapar y ha enloquecido \n producto de esos raros entes que la seguían..."
	elif easter_egg_ending.all(func allTrue(element): return element == true):
		label_ending.text = "Easter Egg Ending: \n Esto no debería verse pero el desarrollador lo ha \n decidido mostrar, así que ... Hola XD"
	else:
		label_ending.text = "No Ending: \n No hay suficientes secretos desbloqueados para generar \n un final especial, juega de nuevo para encontrar alguno de estos \n finales."
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rankingValues()
	loreRanking()
	endingSetter()

func _process(delta: float) -> void:
	if Input.is_action_pressed("reset"):
		SceneChange.scene_to_switch("Level 0")
		
