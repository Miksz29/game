extends Node

signal quest_added(quest: Quest)
signal quest_completed(quest: Quest)

var activeQuests: Dictionary = {}

func add_quest(questResource: Quest):
	if activeQuests.has(questResource.id):
		return
	activeQuests[questResource.id] = questResource
	quest_added.emit(questResource)

func complete_quest(questID: String):
	if not activeQuests.has(questID) and activeQuests[questID].is_completed == true:
		return
	activeQuests[questID].is_completed = true
	quest_completed.emit(questID)

	
