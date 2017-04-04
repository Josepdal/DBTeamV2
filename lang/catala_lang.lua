--------------------------------------------------
--      ____  ____ _____                        --
--     |    \|  _ )_   _|___ ____   __  __      --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |     --
--     |____/|____/ |_|\____/\_____|_/\/\_|v2   --
--                                              --
--   _____________________________________      --
--  |                                     |     --
--  |        Traduït per @gtrabal         |     --
--  |_____________________________________|     --
--                                              --
--------------------------------------------------

local LANG = 'cat'

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "lang_install") then

		-------------------------
		-- Translation version --
		-------------------------
		set_text(LANG, 'version', '1.0')
		set_text(LANG, 'versionExtended', 'Versió de la traducció 1.0')

		-------------
		-- Plugins --
		-------------

		-- global plugins --
		set_text(LANG, 'require_sudo', 'Aquest plugin requereix de permissos sudo.')
		set_text(LANG, 'require_admin', 'Aquest plugin requereix permissos admin o superior.')
		set_text(LANG, 'require_mod', 'Aquest plugin requereix permissos mod o superior.')

		-- welcome.lua
		set_text(LANG, 'weloff', 'Benvinguda activada.')
		set_text(LANG, 'welon', 'Benvinguda desactivada.')
		set_text(LANG, 'weldefault', 'La benvinguda activada és la que està per defecte.')
		set_text(LANG, 'welnew', 'La nova benvinguda assignada és')
		set_text(LANG, 'defaultWelcome', 'Benvingut/s $users al grup!')


		-- stats.lua
		set_text(LANG, 'stats', '*Estadistiques del grup*')
		set_text(LANG, 'statsCommand', 'stats')

		-- settings.lua --
		set_text(LANG, 'user', 'Usuari')
		set_text(LANG, 'isFlooding', '*està fent flood.*')
		set_text(LANG, 'isSpamming', '*està fent spam.*')

		set_text(LANG, 'welcomeT', '> Els *missatges de benvinguda* estan ara *activats* en aquest grup.')
		set_text(LANG, 'noWelcomeT', '> Els *missatges de benvinguda* estan *desactivats* en aquest grup.')

		set_text(LANG, 'noStickersT', '`>` Els *Stickers* no estan permesos en aquest xat.')
		set_text(LANG, 'stickersT', '`>` Els *Stickers* estan permesos en aquest xat.')

		set_text(LANG, 'noTgservicesT', '`>` Els *Serveis de Telegram* estan *silenciats* en aquest grup.')
		set_text(LANG, 'tgservicesT', '`>` Els *Serveis de Telegram* són *visibles* en aquest grup.')

		set_text(LANG, 'gifsT', '`>` Els *Gifs* estan *permesos* en aquest grup.')
		set_text(LANG, 'noGifsT', '`>` Els *Gifs* *no* estan *permesos* en aquest grup.')

		set_text(LANG, 'photosT', '`>` Les *Fotos* estan *permeses* en aquest grup.')
		set_text(LANG, 'noPhotosT', '`>` Les *Fotos* *no* estan *permeses* en aquest grup.')

		set_text(LANG, 'botsT', '`>` Els *Bots* estan *permesos* en aquest grup.')
		set_text(LANG, 'noBotsT', '`>` Els *Bots no* estan *permesos* en aquest grup.')

		set_text(LANG, 'arabicT', '`>` L\'*àrab* està *permès* en aquest grup.')
		set_text(LANG, 'noArabicT', '`>` L\'*àrab no* està *permès* en aquest grup.')

		set_text(LANG, 'audiosT', '`>` Els *Àudios* estan *permesos* en aquest grup')
		set_text(LANG, 'noAudiosT', '`>` Els *Àudios no* estan *permesos* en aquest grup.')

		set_text(LANG, 'documentsT', '`>` Els *Documents* estan *permesos* en aquest grup.')
		set_text(LANG, 'noDocumentsT', '`>` Els *Documents no* estan *permesos* en aquest grup.')

		set_text(LANG, 'videosT', '`>` Els *Vídeos* estan *permesos* en aquest grup.')
		set_text(LANG, 'noVideosT', '`>`  Els *Vídeos no* estan *permesos* en aquest grup.')

		set_text(LANG, 'locationT', '`>` La *Ubicació* està *permesa* en aquest grup.')
		set_text(LANG, 'noLocationT', '`>`  La *Ubicació no* està *permesa* en aquest grup.')

		set_text(LANG, 'emojisT', '`>` Els *Emojis* estan *permesos* en aquest grup.')
		set_text(LANG, 'noEmojisT', '`>`  Els *Emojis no* estan *permesos* en aquest grup.')

		set_text(LANG, 'englishT', '`>` El *Anglès* està *permès* en aquest grup.')
		set_text(LANG, 'noEnglishT', '`>` El *Anglès* no està *permès* en aquest grup.')

		set_text(LANG, 'inviteT', '`>` Les *Invitacions* estan *permeses* en aquest grup.')
		set_text(LANG, 'noInviteT', '`>`  Les *Invitacions no* estan *permeses* en aquest grup.')

		set_text(LANG, 'voiceT', '`>` La *Veu* està *permesa* en aquest grup.')
		set_text(LANG, 'noVoiceT', '`>`  La *Veu no* està *permesa* en aquest grup.')

		set_text(LANG, 'infoT', '`>` Les *Fotos/Títols* estan *permesos* en aquest grup.')
		set_text(LANG, 'noInfoT', '`>` Les *Fotos/Títols no* estan *permesos* en aquest grup.')

		set_text(LANG, 'gamesT', '`>` Els *Jocs* estan *permesos* en aquest grup.')
		set_text(LANG, 'noGamesT', '`>` Els *Jocs no* estan *permesos* en aquest grup.')

		set_text(LANG, 'spamT', '`>` L\'*Spam* està *permès* en aquest grup.')
		set_text(LANG, 'noSpamT', '`>` L\'*Spam no* està *permès* en aquest grup.')
		set_text(LANG, 'setSpam', '`>` La llista negra ha estat canviada a ')

		set_text(LANG, 'forwardT', '`>` *Reenviar missatges* està *permès* en aquest grup.')
		set_text(LANG, 'noForwardT', '`>` *Reenviar missatges no* està *permès* en aquest grup.')

		set_text(LANG, 'floodT', '`>` El *Flood* està *permès* en aquest grup.')
		set_text(LANG, 'noFloodT', '`>` El *Flood no* està *permès* en aquest grup.')

		set_text(LANG, 'floodTime', '`>` El *Temps màxim* de flood ha estat establert en ')
		set_text(LANG, 'floodMax', '`>` El *màxim número* de missatges amb flood ha estat establert en ')

		set_text(LANG, 'gSettings', 'Configuració del grup')

		set_text(LANG, 'allowed', 'permès')
		set_text(LANG, 'noAllowed', 'no permès')
		set_text(LANG, 'noSet', 'no establert')

		set_text(LANG, 'stickers', 'Stickers')
		set_text(LANG, 'tgservices', 'Serveis de Telegram')
		set_text(LANG, 'links', 'Enllaços')
		set_text(LANG, 'arabic', 'Àrab')
		set_text(LANG, 'bots', 'Bots')
		set_text(LANG, 'gifs', 'Gifs')
		set_text(LANG, 'photos', 'Fotos')
		set_text(LANG, 'audios', 'Àudios')
		set_text(LANG, 'kickme', 'Autoexpulsió')
		set_text(LANG, 'spam', 'Spam')
		set_text(LANG, 'gName', 'Nom del grup')
		set_text(LANG, 'flood', 'Flood')
		set_text(LANG, 'language', 'Idioma')
		set_text(LANG, 'mFlood', 'Límit de flood')
		set_text(LANG, 'tFlood', 'Temps de flood')
		set_text(LANG, 'setphoto', 'Establir foto')

		set_text(LANG, 'forward', 'Reenviar')
		set_text(LANG, 'videos', 'Vídeos')
		set_text(LANG, 'invite', 'Invitació')
		set_text(LANG, 'games', 'Jocs')
		set_text(LANG, 'documents', 'Documents')
		set_text(LANG, 'location', 'Ubicació')
		set_text(LANG, 'voice', 'Veu')
		set_text(LANG, 'icontitle', 'Canviar icona/títol')
		set_text(LANG, 'english', 'Anglès')
		set_text(LANG, 'emojis', 'Emojis')
		--Made with @TgTextBot by @iicc1
		set_text(LANG, 'groupSettings', 'Configuració del grup')
		set_text(LANG, 'allowedMedia', 'Multimèdia Permesa')
		set_text(LANG, 'settingsText', 'T̲e̲x̲t̲')

		set_text(LANG, 'langUpdated', 'El seu idioma ha estat actualitzat a: ')

		set_text(LANG, 'linkSet', '`>` El *Nou link* ha estat *establert*')
		set_text(LANG, 'linkError', '`>` Necessita els *permíssos de creador* per a exportar el link d\'invitació del grup.')

		set_text(LANG, 'newRules', '`>` Les *Noves normes* han estat *creades.*')
		set_text(LANG, 'rulesDefault', '`>` Les *anteriors normes* han estat *eliminades.*')
		set_text(LANG, 'noRules', '`>` *No hi ha normes* en aquest grup.')
		set_text(LANG, 'defaultRules', '*Normes del grup:*\n`>` No fer flood.\n`>` No fer spam.\n`>` Intenti romandre en aquest tema.\n`>` Prohibit qualsevol contingut racista, pornogràfic, gore...\n\n_L\'incompliment de les normes establertes poden comportar el ban del grup ._')

		set_text(LANG, 'delAll', '`>` Tots els missatges han estat *eliminats*.')

		-- export_gban.lua --
		set_text(LANG, 'accountsGban', 'comptes globalment banejades.')

		-- promote.lua --
		set_text(LANG, 'alreadyAdmin', 'Aquest usuari ja és *admin.*')
		set_text(LANG, 'alreadyMod', 'Aquest usuari ja és *mod.*')

		set_text(LANG, 'newAdmin', '<code>></code> <b>Nou admin</b>')
		set_text(LANG, 'newMod', '<code>></code> <b>Nou mod</b>')
		set_text(LANG, 'nowUser', ' <b>ara és un usuari.</b>')

		set_text(LANG, 'modList', '`>` *Llista de Mods*')
		set_text(LANG, 'adminList', '`>` *Llista d\'Admins')
		set_text(LANG, 'modEmpty', '*La llista de mods està buida* en aquest grup.')
		set_text(LANG, 'adminEmpty', '*La lista d\'admins està buida*.')
		set_text(LANG, 'error1', '<b>Error:</b> ha de ser un supergrup.')
		set_text(LANG, 'error2', '<b>Error:</b> ha de ser un supergrup i admin del grup.')
		set_text(LANG, 'banall', '<b>Probant de banejar tots els usuaris...</b>')
		set_text(LANG, 'setAbout', '<b>Sobre el grup ha estat canviat a: </b>')
		set_text(LANG, 'leave', '<b>Adeu!</b>')
		
		
		-- gban.lua --
		set_text(LANG, 'gbans', '<b>Usuaris bannejats globalment (</b>')
		set_text(LANG, 'gbanLua', ' usuaris globalment bannejats de l\'arxiu LUA!')
		set_text(LANG, 'gbanJson', ' usuaris globalment bannejats de l\'arxiu JSON!')
		set_text(LANG, 'gbanDel', 'Base de dades dels Gbans eliminats.')

		-- id.lua --
		set_text(LANG, 'user', 'Usuari')
		set_text(LANG, 'chatName', 'Nom del grup')
		set_text(LANG, 'chat', 'Xat')
		set_text(LANG, 'userID', '*User ID:*')
		set_text(LANG, 'ChatID', '*Chat ID:*')

		-- moderation.lua --
		set_text(LANG, 'kickUser', '`>` L\'usuari ha estat *expulsat.*')
		set_text(LANG, 'banUser', '`>` L\'usuari ha estat *bannejat.*')
		set_text(LANG, 'unbanUser', '`>` L\'usuari ha estat *eliminat* de la llista de *bannejats.*')
		set_text(LANG, 'gbanUser', '`>` L\'usuari ha estat *globalment bannejat*.')
		set_text(LANG, 'ungbanUser', '`>` L\'usuari ha estat *eliminat* de la *llista de bannejats globalment.*')
		set_text(LANG, 'muteUser', '`>` L\'usuari ha estat *sil·lenciat.*')
		set_text(LANG, 'muteChat', '`>` El grup ha estat *sil·lenciat.*')
		set_text(LANG, 'muteChatSec', '`>` El chat ha estat *sil·lenciat* durant ')
		set_text(LANG, 'muteUserSec', '`>` L\'usuari ha estat *sil·lenciat* per ')
		set_text(LANG, 'unmuteUser', '`>` L\'usuari *pot parlar ara.*')
		set_text(LANG, 'unmuteChat', '`>` Els usuaris *poden parlar ara.*')

		set_text(LANG, 'delXMsg', '`>` A l\'usuari $user se li *ha eliminat* `$num messages`.')

		-- commands.lua --
		set_text(LANG, 'commandsT', 'Ordres')
		set_text(LANG, 'errorNoPlug', 'Aquest plugin no existeix o no té ordres.')

		-- plugins.lua --

		set_text(LANG, 'pluginsActivated', '*Plugins activats:*\n')
		set_text(LANG, 'pluginNoExist', '`>`  El *Plugin* $name *no existeix*.')
		set_text(LANG, 'pluginIsEnabled', '`>` El *plugin* està *actualment activat*.')
		set_text(LANG, 'pluginNoEnabled', '`>` El *plugin* està *actualment desactivat*.')
		set_text(LANG, 'pluginsReload', '`>` *Plugins recarregats!*')

		set_text(LANG, 'pluginEnabled', '`>` El *plugin* ha estat *activat*.')
		set_text(LANG, 'pluginDisabled', '`>` El *plugin* ha estat *desactivat*.')

		-- private.lua--
	
		set_text(LANG, 'privateMSG', '`>` Perdona, aquesta ordre només funciona *en un xat privat amb el bot.*')
		set_text(LANG, 'privateError', '`>` Hi ha hagut un error.')
		set_text(LANG, 'privateSuper', '`>` Grup creat, emigrat a supergrup i promogut a admin!')
		
		------------
		-- Usages --
		------------

		-- commands.lua --
		set_text(LANG, 'commands:0', 2)
		set_text(LANG, 'commands:1', '#commands: Mostra les ordres de tots els plugins.')
		set_text(LANG, 'commands:2', '#commands [plugin]: Ordres d\'aquest plugin.')

		-- export_gban.lua --
	--	set_text(LANG, 'export_gban:0', 2)
	--	set_text(LANG, 'export_gban:1', '#gbans installer: Devuelve un archivo lua instalador para compartir gbans y añadirlos en otro bot con un único comando.')
	--	set_text(LANG, 'export_gban:2', '#gbans list: Devuelve un archivo con la lista de gbans.')

		-- gban_installer.lua --
	--	set_text(LANG, 'gban_installer:0', 1)
	--	set_text(LANG, 'gban_installer:1', '#install gbans: añade una lista de gbans en tu base de datos redis.')

		-- welcome.lua --
        set_text(LANG, 'welcome:0', 3)
        set_text(LANG, 'welcome:1', '#setwelcome [Text de benvinguda]. Pot realitzar una benvinguda personalitzada per aquest grup. Posa-hi un "0" per establir la benvinguda predeterminada.')
        set_text(LANG, 'welcome:2', '#getwelcome - Retorna la benvinguda actual en aquest grup')
        set_text(LANG, 'welcome:3', '#welcome on/off - Activar/desactivar la benvinguda en aquest grup')

		-- giverank.lua --
		set_text(LANG, 'promote:0', 6)
		set_text(LANG, 'promote:1', '#admin (reply): Afegeix la persona a la que respons en admin')
		set_text(LANG, 'promote:2', '#admin <user_id>/<user_name>: Afegeix un admin amb el seu ID/Usuari.')
		set_text(LANG, 'promote:3', '#mod (reply): Afegeix la persona a la que respons en mod.')
		set_text(LANG, 'promote:4', '#mod <user_id>/<user_name>: Afegeix un mod amb el seu ID/Usuari.')
		set_text(LANG, 'promote:5', '#user (reply): Converteix a la persona a la que respons en usuari.')
		set_text(LANG, 'promote:6', '#user <user_id>/<user_name>: Converteix un usuari mitjançant el seu ID/Usuari a usuari normal.')

		-- id.lua --
		set_text(LANG, 'id:0', 1)
		set_text(LANG, 'id:1', '#id (or reply): retorna la teva id i la del grup si estas a dins d\'un.')

		-- moderation.lua --
		set_text(LANG, 'moderation:0', 7)
		set_text(LANG, 'moderation:1', '#kick <reply>/<id>/<username>: L\'usuari serà eliminat del grup actual.')
		set_text(LANG, 'moderation:2', '#ban <reply>/<id>/<username>: L\'usuari serà bloquejat del grup actual i no podrà tornar.')
		set_text(LANG, 'moderation:3', '#unban <reply>/<id>/<username>: L\'usuari quedarà desbloquejat al grup actual.')
		set_text(LANG, 'moderation:4', '#gban <reply>/<id>/<username>: L\'usuari serà bloquejat de tots els xats i no podrà entrar.')
		set_text(LANG, 'moderation:5', '#ungban <reply>/<id>/<username>: L\'usuari serà desbloquejat de tots els grups.')
		set_text(LANG, 'moderation:6', '#mute <reply>/<id>/<username>: L\'usuari se sil·lenciarà del grup actual, borrant tots els seus missatges.')
		set_text(LANG, 'moderation:7', '#unmute <reply>/<id>/<username>: L\'usuari podrà parlar al grup actual.')

		-- settings.lua --
	    set_text(LANG, 'settings:0', 20)
		set_text(LANG, 'settings:1', '#tgservices on/off: Quan estigui inhabilitat, s\'esborrarà tots els missatges dels serveis de Telegram.')
		set_text(LANG, 'settings:2', '#invite on/off: Quan estigui inhabilitat, tots els nous membres convidats estaran eliminats.')
		set_text(LANG, 'settings:3', '#lang <language (en, es...)>: Canvia el idioma del bot.')
		set_text(LANG, 'settings:4', '#photos on/off: Quan s\'inhabilita, es borraran totes les fotos.')
		set_text(LANG, 'settings:5', '#videos on/off: Quan estigui inhabilitat, tots els vídeos s\'esborraran.')
		set_text(LANG, 'settings:6', '#stickers on/off: Quan estigui inhabilitat, tots els stickers s\'esborraran.')
		set_text(LANG, 'settings:7', '#gifs on/off: Quan estigui inhabilitat, tots els gifs s\'esborraran.')
	   	set_text(LANG, 'settings:8', '#voice on/off: Quan estigui inhabilitat, tots els missatges de veu s\'esborraran.')
	    set_text(LANG, 'settings:9', '#audios on/off: Quan estigui inhabilitat, tots els àudios s\'esborraran.')
		set_text(LANG, 'settings:10', '#documents on/off: Quan estigui inhabilitat, tots els documents s\'esborraran.')
		set_text(LANG, 'settings:11', '#location on/off: Quan estigui inhabilitat, totes les ubicacions s\'esborraran.')
		set_text(LANG, 'settings:12', '#games on/off: Quan estigui inhabilitat, tots els jocs s\'esborraran.')
	    set_text(LANG, 'settings:13', '#spam on/off: Quan estigui inhabilitat, tots l\'spam s\'esborrarà.')
		set_text(LANG, 'settings:14', '#forward on/off: Quan estigui inhabilitat, tots els missatges reenviats s\'esborraran.')
		set_text(LANG, 'settings:15', '#floodtime <secs>: Estableix el temps que el bot utilitza per a comprovar el flood. Escriu 0 per a desactivar.')
	    set_text(LANG, 'settings:16', '#maxflood <msgs>: Estableix el màxim nombre de missatges en un temps de flood per a ser considerat com a tal. Escriu 0 per a desactivar.')
	    set_text(LANG, 'settings:17', '#links on/off: Quan estigui inhabilitat, tots els enllaços s\'esborraran.')
	    set_text(LANG, 'settings:18', '#arabic on/off: Quan estigui inhabilitat, tots els missatges escrits en àrab/persa s\'esborraran.')
		set_text(LANG, 'settings:19', '#english on/off: Quan estigui inhabilitat, tots els missatges escrits en anglès s\'esborraran.')
	    set_text(LANG, 'settings:20', '#emoji on/off: Quan estigui inhabilitat, tots els missatges amb emojis s\'esborraran.')
	    -- set_text(LANG, 'settings:5', '#bots on/off: Cuando está inhabilitado, si alguien añade un bot, se pateará.')

		if matches[1] == 'install' then
			return '`>` L\'idioma *català* ha estat instal·lat a la seva base de dates.'
		elseif matches[1] == 'update' then
			return '`>` L\'idioma *català* ha estat actualitzat a la seva base de dates.'
		end
	else
		return "`>` Aquest plugin *requereix de permissos sudo*."
	end
end

return {
	patterns = {
		'[!/#](install) (catala_lang)$',
		'[!/#](update) (catala_lang)$'
	},
	run = run
}
