extends Node2D

@onready var lines := $Lines
@onready var mouse := $Mouse/CollisionShape2D


var currLine : Line2D
var onBox = false
var drawing =  false
var currVertices = {}
var currVerticesList = []
var pointInterval = 5

var cursor = load("res://textures/RedDot.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:

	#if they hold down a mouse button, save that
	if event is InputEventMouseButton:
		if event.is_released():
			var poly = CollisionPolygon2D.new()
			var polyMesh = Polygon2D.new()
			poly.polygon = currVerticesList
			polyMesh.polygon = currVerticesList
			$Polys.add_child(poly)
			$Polys.add_child(polyMesh)
			currVerticesList.clear()
			drawing = false
		else:
			drawing = event.pressed
			
			#Add a line2d to Lines
			if drawing:
				currLine = Line2D.new()
				currLine.default_color = Color.WHITE
				lines.add_child(currLine)
	
	#draw when they move the mouse if holding
	if event is InputEventMouseMotion && drawing:
		var newPos = event.position
		#if mouse is off the drawing board, move the line to the border of it
		if event.position.x < 280:
			newPos += Vector2((280 - event.position.x), 0)
			currLine.add_point(newPos)
			currVerticesList.append(newPos)
		elif event.position.x > 1000:
			newPos += Vector2(-(event.position.x - 1000), 0)
			currLine.add_point(newPos)
			currVerticesList.append(newPos)

		else:
			currLine.add_point(event.position)
			currVerticesList.append(event.position)
		
func _on_area_2d_mouse_entered() -> void:
	onBox = true


func _on_area_2d_mouse_exited() -> void:
	onBox = false
	
