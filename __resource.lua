fx_version 'adamant'
game 'gta5'
description 'Informational Logger'
version '0.1.0'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/main.lua",
}

client_scripts {
	"client/main.lua",
}