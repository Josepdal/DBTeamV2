---------------------------------------------------
--      ____  ____ _____                         --
--     |    \|  _ )_   _|___ ____   __  __       --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |      --
--     |____/|____/ |_|\____/\_____|_/\/\_|v2    --
--                                               --
--   _____________________________________       --
--  |                                     |      --
--  |Traduït per la @comunidadtelebots    |      --
--  |_____________________________________|      --
--                                               --
---------------------------------------------------

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
		set_text(LANG, 'require_sudo', 'Aquest plugin requereix permissos de sudo.')
		set_text(LANG, 'require_admin', 'Aquest plugin requereix permissos administrador o superior.')
		set_text(LANG, 'require_mod', 'Aquest plugin requereix permissos mod o superior.')
		
		-- welcome.lua
		set_text(LANG, 'weloff', 'Benvinguda activada.')
		set_text(LANG, 'welon', 'Benvinguda desactivada.')
		set_text(LANG, 'weldefault', 'La benvinguda activada és la que està per defecte.')
		set_text(LANG, 'welnew', 'La nova benvinguda assignada és')
		set_text(LANG, 'defaultWelcome', 'Benvingut/s $users al xat!')

		-- settings.lua --
		set_text(LANG, 'user', 'Usuario')
		set_text(LANG, 'isFlooding', '*està fent flood.*')
		set_text(LANG, 'isSpamming', '*està fent spam.*')

		set_text(LANG, 'welcomeT', '> Els *missatges de benvinguda* estan ara *activats* en aquest xat.')
		set_text(LANG, 'noWelcomeT', '> Els *missatges de benvinguda* estan *desactivats* en aquest xat.')

		set_text(LANG, 'noStickersT', '`>` *Stickers* no permitidos en este chat.')
		set_text(LANG, 'stickersT', '`>` *Stickers* permesos en aquest xat.')
		
		set_text(LANG, 'noTgservicesT', '`>` *Serveis de Telegram silenciats* en aquest grup')
		set_text(LANG, 'tgservicesT', '`>` *Serveis de Telegram visibles en aquest chat.')

		set_text(LANG, 'gifsT', '`>` *Gifs* *permesos* en aquest xat.')
		set_text(LANG, 'noGifsT', '`>` *Gifs* *no permesos* en aquest xat.')

		set_text(LANG, 'photosT', '`>` *Fotos* `permeses` en aquest xat.')
		set_text(LANG, 'noPhotosT', '`>` *Fotos* *no permeses* en aquest xat.')

		set_text(LANG, 'botsT', '`>` *Bots* permesos en aquest xat.')
		set_text(LANG, 'noBotsT', '`>` *Bots* no permesos en aquest xat.')

		set_text(LANG, 'arabicT', '`>` *L'Àrab* *permès* en aquest grup.')
		set_text(LANG, 'noArabicT', '`>` *L'Àrab* *no permès* en aquest grup.')

		set_text(LANG, 'audiosT', '`>` *Àudios* *permesos* en aquest grup.')
		set_text(LANG, 'noAudiosT', '`>` *Àudios* *no permesos* en aquest grup.')
		
		set_text(LANG, 'documentsT', '`>` *Documents* *permesos* en aquest grup.')
		set_text(LANG, 'noDocumentsT', '`>` *Documents* *no permesos* en aquest grup.')
		
		set_text(LANG, 'videosT', '`>` *Vídeos*  *permesos* en aquest xat.')
		set_text(LANG, 'noVideosT', '`>`  *Vídeos* *no permesos* en aquest xat.')
		
		set_text(LANG, 'locationT', '`>` *Ubicació* *permesa* en aquest xat')
		set_text(LANG, 'noLocationT', '`>`  *Ubicació* *no permesa* en aquest xat.')
		
		set_text(LANG, 'emojisT', '`>` *Emojis* *permesos* en aquest xat.')
		set_text(LANG, 'noEmojisT', '`>`  *Emojis* *no permesos* en aquest xat.')

		set_text(LANG, 'englishT', '`>` *Anglès* *permès* en aquest xat.')
		set_text(LANG, 'noEnglishT', '`>` *Anglès* *no permès* en aquest xat.')

		set_text(LANG, 'inviteT', '`>` *Invitació* *permèsa* en aquest xat.')
		set_text(LANG, 'noInviteT', '`>`  *Invitació* *no permesa* en aquest xat.')

		set_text(LANG, 'voiceT', '`>` *Veu* *permesa* en aquest xat.')
		set_text(LANG, 'noVoiceT', '`>`  *Veu* *no permesa* en aquest xat.')
		
		set_text(LANG, 'infoT', '`>` *Foto/títol* es pot canviar en aquest xat.')
		set_text(LANG, 'noInfoT', '`>` *Foto/títol* no es pot canviar en aquest xat.')
		
		set_text(LANG, 'gamesT', '`>` * *Jocs* *permesos* en aquest xat.')
		set_text(LANG, 'noGamesT', '`>` *Jocs* *no permesos* en aquest xat')
		
		set_text(LANG, 'spamT', '`>` *Spam* *permès* en aquest xat.')
		set_text(LANG, 'noSpamT', '`>` *Spam* *no permès* en aquest xat')
		set_text(LANG, 'setSpam', '`>` s'ha canviat la llista negra a ')
		
		set_text(LANG, 'forwardT', '`>` *Reenviar missatges* *permès* en aquest xat.')
		set_text(LANG, 'noForwardT', '`>` *Reenviar missatges* *no permès* en aquest xat.')
	
		set_text(LANG, 'floodT', '`>` *Flood* *permès* en aquest xat.')
		set_text(LANG, 'noFloodT', '`>` *Flood* *no permès* en aquest xat.')

		set_text(LANG, 'floodTime', '`>` *Temps màxim* de flood establert a  ')
		set_text(LANG, 'floodMax', '`>` *Número màxim* de missatges flood establert a ')

		set_text(LANG, 'gSettings', 'Configuració del grup')

		set_text(LANG, 'allowed', 'permès')
		set_text(LANG, 'noAllowed', 'no permès')
		set_text(LANG, 'noSet', 'no establert')

		set_text(LANG, 'stickers', 'Stickers')
		set_text(LANG, 'tgservices', 'Serveis de Tg')
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
		set_text(LANG, 'allowedMedia', 'multimèdia permesa')
		set_text(LANG, 'settingsText', 'T̲e̲x̲t̲')

		set_text(LANG, 'langUpdated', 'El seu idioma ha estat actualitzat a: ')

		-- export_gban.lua --
		set_text(LANG, 'accountsGban', 'comptes globalment banejades.')

		-- promote.lua --
		set_text(LANG, 'alreadyAdmin', 'Aquest usuari ja és *admin.*')
		set_text(LANG, 'alreadyMod', 'Aquest usuari ja és *mod.*')

		set_text(LANG, 'newAdmin', '`>` *Nou admin*')
		set_text(LANG, 'newMod', '`>` *Nou mod*')
		set_text(LANG, 'nowUser', '`>` *ara és un usuari.*')

		set_text(LANG, 'modList', '`>` *Llista de Mods*')
		set_text(LANG, 'adminList', '`>` *Llista d'Admins')
		set_text(LANG, 'modEmpty', '*La llista de mods està buida* en aquest xat.')
		set_text(LANG, 'adminEmpty', '*La llista d'admintradors està buida* en aquest xat.*')

		-- id.lua --
		set_text(LANG, 'user', 'Usuari')
		set_text(LANG, 'chatName', 'Nom del xat')
		set_text(LANG, 'chat', 'xat')

		-- moderation.lua --
		set_text(LANG, 'kickUser', '`>` L'usuari ha estat *expulsat.*')
		set_text(LANG, 'banUser', '`>` L'usuari ha estat *banejat.*')
		set_text(LANG, 'unbanUser', '`>` L'usuari ha estat *eliminat* de la llista *banejats.*')
		set_text(LANG, 'gbanUser', '`>` L'usuari ha estat *globalment banejat*.')
		set_text(LANG, 'ungbanUser', '`>` L'usuari ha estat *eliminat* de *lista de *')
		set_text(LANG, 'muteUser', '`>` L'usuari ha estat *silenciat.*')
		set_text(LANG, 'muteChat', '`>` El xat ha estat *silenciat.*')
		set_text(LANG, 'unmuteUser', '`>` L'usuari *pot parlar ara.*')
		set_text(LANG, 'unmuteChat', '`>` Els usuaris *poden parlar ara.*')
		
		
		-- commands.lua --
		set_text(LANG, 'commandsT', 'Ordres')
		set_text(LANG, 'errorNoPlug', 'Aquest plugin no existeix o no té ordres.')

	
		------------
		-- Usages --
		------------

	
		-- commands.lua --
		set_text(LANG, 'commands:0', 2)
		set_text(LANG, 'commands:1', '#commands: Mostra les ordres per a tots els plugins.')
		set_text(LANG, 'commands:2', '#commands [plugin]: Ordres per aquest plugin.')

		-- export_gban.lua --
	--	set_text(LANG, 'export_gban:0', 2)
	--	set_text(LANG, 'export_gban:1', '#gbans installer: Retorna un arxiu lua instalador per a compartir gbans i afegir-ho a un altre bot amb una única ordre.')
	--	set_text(LANG, 'export_gban:2', '#gbans list: Retorna un arxiu amb la llista de gbans.')

		-- gban_installer.lua --
	--	set_text(LANG, 'gban_installer:0', 1)
	--	set_text(LANG, 'gban_installer:1', '#install gbans: Afegeix una llista de gbans a la teva base de dates redis.')
		
		-- welcome.lua --
        set_text(LANG, 'welcome:0', 3)
        set_text(LANG, 'welcome:1', '#setwelcome [Text per benvinguda]. Podeu fer una benvinguda personalitzada per a aquest xat. Posi un "0" per establir la recepció per defecte.')
        set_text(LANG, 'welcome:2', '#getwelcome - Retorna la benvinguda actual en aquest xat')     
        set_text(LANG, 'welcome:3', '#welcome on/off - Activar/desactivar la benvinguda en aquest xat')
       
		-- giverank.lua --
		set_text(LANG, 'promote:0', 6)
		set_text(LANG, 'promote:1', '#admin (reply): Converteix la persona a qui respons a administador')
		set_text(LANG, 'promote:2', '#admin <user_id>/<user_name>: Afegeix un administador mitjançant la seva ID/Usuari.')
		set_text(LANG, 'promote:3', '#mod (reply): Converteix la persona a qui respons a moderador.')
		set_text(LANG, 'promote:4', '#mod <user_id>/<user_name>: Afegeix un moderador mitjançant la seva ID/Usuari.')
		set_text(LANG, 'promote:5', '#user (reply): Eliminar admin per resposta.')
		set_text(LANG, 'promote:6', '#user <user_id>/<user_name>: Afegeix un moderador mitjançant la ID/Usuari.')		

		-- id.lua --
		set_text(LANG, 'id:0', 1)
		set_text(LANG, 'id:1', '#id (or reply): Retorna la teva id i la del xat si estas en algun.')

		-- moderation.lua --
		set_text(LANG, 'moderation:0', 7)		
		set_text(LANG, 'moderation:1', '#kick <reply>/<id>/<username>: L'usuari serà eliminat al xat actual.')
		set_text(LANG, 'moderation:2', '#ban <reply>/<id>/<username>: L'usuari serà bloquejat al xat actual i no serà capaç de tornar.')
		set_text(LANG, 'moderation:3', '#unban <reply>/<id>/<username>: L'usuari quedarà desbloquejat al xat actual.')
		set_text(LANG, 'moderation:4', '#gban <reply>/<id>/<username>: L'usuari serà bloquejat de tots els xats i no serà capaç d'entrar.')
		set_text(LANG, 'moderation:5', '#ungban <reply>/<id>/<username>: L'usuari serà desbloquejat de tots els xats.')
		set_text(LANG, 'moderation:6', '#mute <reply>/<id>/<username>: L'usuari es silenciarà al xat actual, esborrant tots els seus missatges.')
		set_text(LANG, 'moderation:7', '#unmute <reply>/<id>/<username>: L'usuari pot parlar al xat actual.')
		
		-- settings.lua --
	    set_text(LANG, 'settings:0', 20)
		set_text(LANG, 'settings:1', '#tgservices on/off: Quan està inhabilitat, s'esborraran tots els missatges dels serveis de Telegram.')
		set_text(LANG, 'settings:2', '#invite on/off: Quan està inhabilitat, tots els nous participants convidats seran eliminats.')
		set_text(LANG, 'settings:3', '#lang <language (en, es...)>: Canvia l'idioma del bot.')
		set_text(LANG, 'settings:4', '#photos on/off: Quan s'inhabilita, s'esborraran totes les fotos.')
		set_text(LANG, 'settings:5', '#videos on/off: Quan està inhabilitat, tots els vídeos s'esborraran.')
		set_text(LANG, 'settings:6', '#stickers on/off: Quan està inhabilitat, tots els stickers seran esborrats.')
		set_text(LANG, 'settings:7', '#gifs on/off: Quan està deshabilitat, tots els gifs s'esborraran.')
	   	set_text(LANG, 'settings:8', '#voice on/off: Quan està deshabilitat, tots els missatges de veu seran esborrats.')
	    set_text(LANG, 'settings:9', '#audios on/off: Quan està inhabilitat, tots els àudios 'esborraran.')
		set_text(LANG, 'settings:10', '#documents on/off: Quan està inhabilitat, tots els documents seran esborrats.')
		set_text(LANG, 'settings:11', '#location on/off: Quan està inhabilitat, totes les ubicacions seran esborrades.')
		set_text(LANG, 'settings:12', '#games on/off: Quan està inhabilitat, tots els jocs seran esborrats.')
	    set_text(LANG, 'settings:13', '#spam on/off: Quan està deshabilitat, tots els missatges d'spam s'esborraran.')
		set_text(LANG, 'settings:14', '#forward on/off: Quan està deshabilitat, s'esborraran tots els missatges reenviats.')
		set_text(LANG, 'settings:15', '#floodtime <secs>: Establir el temps que el bot utilitza per comprovar el flood. Ajust 0 per desactivar.')
	    set_text(LANG, 'settings:16', '#maxflood <msgs>: Establir el màxim de missatges en un temps de flood per ser considerat com flood. Ajust 0 per desactivar-lo.')
	    set_text(LANG, 'settings:17', '#links on/off: Quan està deshabilitat, tots els enllaços s'esborraran.')
	    set_text(LANG, 'settings:18', '#arabic on/off: Quan està inhabilitat, tots els missatges amb àrab/persa seran esborrats.')
		set_text(LANG, 'settings:19', '#english on/off:Quan està deshabilitat, s'esborraran tots els missatges amb lletres en anglès.')
	    set_text(LANG, 'settings:20', '#emoji on/off: Quan està inhabilitat, tots els missatges amb emoji seran esborrats.')
	    -- set_text(LANG, 'settings:5', '#bots on/off: Quan està inhabilitat, si algú afegeix un bot, s'eliminara.')

		if matches[1] == 'install' then
			return '`>` El llenguatge *català* ha estat instal·lat a la base de dades.'
		elseif matches[1] == 'update' then
			return '`>` El llenguatge *català* ha estat actualitzat a la base de dades.'
		end
	else
		return "`>` Aquest plugin *requereix permisos de sudo*."
	end
end

return {
	patterns = {
		'[!/#](install) (catalan_lang)$',
		'[!/#](update) (catalan_lang)$'
	},
	run = run
}