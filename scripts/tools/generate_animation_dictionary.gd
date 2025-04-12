@tool
extends EditorScript

var BASE = "res://sprites/dinos"
var dict = {}

# This script generates the entire text for animation_dictionary.gd
# Ensure you wipe console output before usage
# I am working on the file save solution (likely just need more research) but for now just copy it from the console
# Please note the debug print statements were left in very intentionally
# This is to help debugging if a different user has issues with the project

func _run() -> void:
	#print("generating animation_dictionary.gd")
	
	var final_file_string = \
"extends Resource

class_name Animation_Dictionary

const character_animations_paths = "
	
	# Open and walk the res directory
	var dir = DirAccess.open(BASE)
	if dir:
		#print("found dinos directory")
		
		walk_directory(dir)
		#print(str(dict))
		
		final_file_string += str(dict)
		
		final_file_string += "\n\n"
		
		final_file_string+= \
"var character_animations = {}

func _init():
	# male/female
	for mf in character_animations_paths:
		# names
		character_animations[mf] = {}
		for name in character_animations_paths[mf]:
			# animation subsections
			character_animations[mf][name] = {}
			for subanim in character_animations_paths[mf][name]:
				# resource names available at this level
				character_animations[mf][name][subanim] = {}
				for resname in character_animations_paths[mf][name][subanim]:
					character_animations[mf][name][subanim][resname] = load(character_animations_paths[mf][name][subanim][resname])
	# print(character_animations) # for debugging
	
func get_animations():
	return character_animations"

		print(final_file_string)

func walk_directory(dir: DirAccess):
	# Iterate through the contents of the directory
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			# If it's a subdirectory, recursively walk it
			if file_name != "." and file_name != "..":  # Skip the current and parent directory markers
				var sub_dir = DirAccess.open(dir.get_current_dir() + '/' + file_name)
				walk_directory(sub_dir)
			else:
				print("?????")
		else:
			# If it's a file, get its UID (if available)
			var file_path = dir.get_current_dir() + '/' + file_name
			if ResourceLoader.exists(file_path):  # Check if it's a valid resource
				# if you need the UID you can grab it now
				#var uid = ResourceLoader.get_resource_uid(file_path)
				#print("File:", file_path, "		UID: uid://", uid)
				var accesses = file_path.split('/')
				for i in range(0,4):
					accesses.remove_at(0)
				var looking = dict
				for access in accesses:
					if access.ends_with(".png"):
						# everything should already be there for images - otherwise we would not have gotten here
						looking[access] = dir.get_current_dir() + '/' + file_name
					else:
						# This is another directory we have to go deeper in
						if access not in looking:
							looking[access] = {}
						looking = looking[access]
				#print(accesses)
		file_name = dir.get_next()
	dir.list_dir_end()
