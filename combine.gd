extends TileSet
# "tool" makes this also apply when placing tiles by hand in the tilemap editor too.
tool
const wall = 0
const color = 3
var binds = {

	wall: [color],
	color: [wall],
}
func _is_tile_bound(id, neighbour_id):
	if id in binds:
		return neighbour_id in binds[id]
	return false
