extends Area2D

signal jumped

func _on_body_entered(_body: Node2D) -> void:
	print("EMIT JUMP")
	jumped.emit()
