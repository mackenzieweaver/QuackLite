extends Area3D


func enable_hitbox():
	GameUtils.toggle_area3d(self, true, true)


func disable_hitbox():
	GameUtils.toggle_area3d(self, false, false)
