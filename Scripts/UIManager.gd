extends CanvasLayer

@onready var treasure_label : Label = $TreasureLabel
@onready var loot_label : Label = $LootbagLabel
@onready var note_label : Label = $NoteLabel
@onready var quest_note_label : Label = $QuestNoteLabel

func _ready() -> void:
	CountableVars.GotTreasure.connect(updateTreasureDisplay)
	CountableVars.GotLoot.connect(updateLootDisplay)
	CountableVars.GotNote.connect(updateNotesDisplay)
	CountableVars.GotQuestNote.connect(updateQuestNotesDisplay)
	
func updateTreasureDisplay() -> void:
	treasure_label.text = str(CountableVars.curr_treasures)
	
func updateLootDisplay() -> void:
	loot_label.text = str(CountableVars.curr_loot)
	
func updateNotesDisplay() -> void:
	note_label.text = str(CountableVars.curr_notes)
	
func updateQuestNotesDisplay() -> void:
	quest_note_label.text = str(CountableVars.curr_qnotes)
