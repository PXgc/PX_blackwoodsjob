fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

client_scripts {
    "@es_extended/locale.lua",
    "client/cl_menu.lua",
    "client/cl_coffre.lua",
    "client/cl_shop.lua",
    "client/cl_patron.lua",
    "client/cl_vestiaire.lua",
    "config.lua"
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    "server/server.lua",
}
