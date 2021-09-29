pharmacie             = {}

--marker
pharmacie.DrawDistance = 100
pharmacie.Size         = {x = 1.0, y = 1.0, z = 1.0}
pharmacie.Color        = {r = 255, g = 0, b = 100}
pharmacie.Type         = 20

--les items au bar
pharmacie.baritem = {
        {nom = "Eau", prix = 8, item = "water"},    
}

--position des menus et marker
pharmacie.pos = {
	coffre = {
		position = {x = 375.64, y = 334.24, z = 103.57}
	},

	garage = {
		position = {x = 381.68, y = 316.39, z = 103.3}
	},

	spawnvoiture = {
		position = {x = 370.81, y = 302.71, z = 102.15, h = 346.900}
	},

	boss = {
		position = {x = 380.17, y = 332.72, z = 103.57}
	}

}
