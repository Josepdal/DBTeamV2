--------------------------------------------------
--      ____  ____ _____                        --
--     |    \|  _ )_   _|___ ____   __  __      --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |     --
--     |____/|____/ |_|\____/\_____|_/\/\_|v2   --
--                                              --
--   _____________________________________      --
--  |                                     |     --
--  |Traducido por la @comunidadtelebots  |     --
--  |_____________________________________|     --
--                                              --
--------------------------------------------------

local LANG = 'es'

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "lang_install") then

		-------------------------
		-- Translation version --
		-------------------------
		set_text(LANG, 'version', '1.0')
		set_text(LANG, 'versionExtended', 'Versión de la traducción 1.0')

		-------------
		-- Plugins --
		-------------

		-- global plugins --
		set_text(LANG, 'require_sudo', 'Este plugin requiere privilegios sudo.')
		set_text(LANG, 'require_admin', 'Este plugin requiere privilegios admin o superior.')
		set_text(LANG, 'require_mod', 'Este plugin requiere privilegios mod o superior.')

		-- welcome.lua
		set_text(LANG, 'weloff', 'Bienvenida activada.')
		set_text(LANG, 'welon', 'Bienvenida desactivada.')
		set_text(LANG, 'weldefault', 'La bienvenida actual es la default.')
		set_text(LANG, 'welnew', 'La nueva bienvenida asignada es')
		set_text(LANG, 'defaultWelcome', 'Bienvenido/s $users al chat!')


		-- stats.lua
		set_text(LANG, 'stats', '*Estadísticas del chat*')
		set_text(LANG, 'statsCommand', 'stats')


		-- settings.lua --
		set_text(LANG, 'user', 'El usuario')
		set_text(LANG, 'isFlooding', '*está haciendo flood.*')
		set_text(LANG, 'isSpamming', '*está haciendo spam.*')

		set_text(LANG, 'welcomeT', '> *Mensajes de bienvenida activados* en este chat.')
		set_text(LANG, 'noWelcomeT', '> *Mensajes de bienvenida desactivados* en este chat.')

		set_text(LANG, 'noStickersT', '`>` *Stickers* no permitidos en este chat.')
		set_text(LANG, 'stickersT', '`>` *Stickers* permitidos en este chat.')

		set_text(LANG, 'noTgservicesT', '`>` *Servicios de Telegram silenciados* en este chat.')
		set_text(LANG, 'tgservicesT', '`>` *Servicios de Telegram visibles* en este chat.')

		set_text(LANG, 'gifsT', '`>` *Gifs permitidos* en este chat.')
		set_text(LANG, 'noGifsT', '`>` *Gifs no permitidos* en este chat.')

		set_text(LANG, 'photosT', '`>` *Fotos permitidas* en este chat.')
		set_text(LANG, 'noPhotosT', '`>` *Fotos no permitidas* en este chat.')

		set_text(LANG, 'botsT', '`>` *Bots permitidos* en este chat.')
		set_text(LANG, 'noBotsT', '`>` *Bots no permitidos* en este chat.')

		set_text(LANG, 'arabicT', '`>` El *árabe* está *permitido* en este chat.')
		set_text(LANG, 'noArabicT', '`>` El *árabe* *no está permitido* en este chat.')

		set_text(LANG, 'audiosT', '`>` *Audios permitidos* en este chat')
		set_text(LANG, 'noAudiosT', '`>` *Audios no permitidos* en este chat.')

		set_text(LANG, 'documentsT', '`>` *Documentos permitidos* en este chat.')
		set_text(LANG, 'noDocumentsT', '`>` *Documentos no permitidos* en este chat.')

		set_text(LANG, 'videosT', '`>` *Videos permitidos* en este chat.')
		set_text(LANG, 'noVideosT', '`>`  *Videos no permitidos* en este chat.')

		set_text(LANG, 'locationT', '`>` *Ubicaciones permitidas* en este chat.')
		set_text(LANG, 'noLocationT', '`>`  *Ubicaciones no permitidas* en este chat.')

		set_text(LANG, 'emojisT', '`>` *Emojis permitidos* en este chat.')
		set_text(LANG, 'noEmojisT', '`>`  *Emojis no permitidos* en este chat.')

		set_text(LANG, 'englishT', '`>` *Inglés permitido* en este chat.')
		set_text(LANG, 'noEnglishT', '`>` *Inglés no permitido* en este chat.')

		set_text(LANG, 'inviteT', '`>` *Invitaciones permitidas* en este chat.')
		set_text(LANG, 'noInviteT', '`>`  *Invitaciones no permitidas* en este chat.')

		set_text(LANG, 'voiceT', '`>` *Audios de voz permitidos* en este chat.')
		set_text(LANG, 'noVoiceT', '`>` *Audios de voz no permitidos* en este chat.')

		set_text(LANG, 'infoT', '`>` *La foto/título* se puede cambiar en este chat.')
		set_text(LANG, 'noInfoT', '`>` *La foto/título* no se puede cambiar en este chat.')

		set_text(LANG, 'gamesT', '`>` *Juegos permitidos* en este chat.')
		set_text(LANG, 'noGamesT', '`>` *Juegos no permitidos* en este chat.')

		set_text(LANG, 'spamT', '`>` *Spam permitido* en este chat.')
		set_text(LANG, 'noSpamT', '`>` *Spam no permitido* en este chat.')
		set_text(LANG, 'setSpam', '`>` Se cambió la lista negra a ')

		set_text(LANG, 'forwardT', '`>` *Reenviar mensajes está permitido* en este chat.')
		set_text(LANG, 'noForwardT', '`>` *Reenviar mensajes no está permitido* en este chat.')

		set_text(LANG, 'floodT', '`>` *Flood permitido* en este chat.')
		set_text(LANG, 'noFloodT', '`>` *Flood no permitido* en este chat.')

		set_text(LANG, 'floodTime', '`>` *Tiempo máximo de flood* establecido a  ')
		set_text(LANG, 'floodMax', '`>` *Número máximo de mensajes* para flood establecido a ')

		set_text(LANG, 'gSettings', 'Ajustes del grupo')

		set_text(LANG, 'allowed', 'permitido')
		set_text(LANG, 'noAllowed', 'no permitido')
		set_text(LANG, 'noSet', 'no establecido')

		set_text(LANG, 'stickers', 'Stickers')
		set_text(LANG, 'tgservices', 'Servicios de Telegram')
		set_text(LANG, 'links', 'Enlaces')
		set_text(LANG, 'arabic', 'Árabe')
		set_text(LANG, 'bots', 'Bots')
		set_text(LANG, 'gifs', 'Gifs')
		set_text(LANG, 'photos', 'Fotos')
		set_text(LANG, 'audios', 'Audios')
		set_text(LANG, 'spam', 'Spam')
		set_text(LANG, 'gName', 'Nombre del grupo')
		set_text(LANG, 'flood', 'Flood')
		set_text(LANG, 'language', 'Idioma')
		set_text(LANG, 'mFlood', 'Límite de flood')
		set_text(LANG, 'tFlood', 'Tiempo de flood')
		set_text(LANG, 'setphoto', 'Establecer foto')

		set_text(LANG, 'forward', 'Reenviar')
		set_text(LANG, 'videos', 'Videos')
		set_text(LANG, 'invite', 'Invitación')
		set_text(LANG, 'games', 'Juegos')
		set_text(LANG, 'documents', 'Documentos')
		set_text(LANG, 'location', 'Ubicación')
		set_text(LANG, 'voice', 'Voz')
		set_text(LANG, 'icontitle', 'Cambiar icono/título')
		set_text(LANG, 'english', 'Inglés')
		set_text(LANG, 'emojis', 'Emojis')
		--Made with @TgTextBot by @iicc1
		set_text(LANG, 'groupSettings', 'Configuración del grupo')
		set_text(LANG, 'allowedMedia', 'Multimedia Permitidos')
		set_text(LANG, 'settingsText', 'T̲e̲x̲t̲o')

		set_text(LANG, 'langUpdated', 'Su idioma ha sido actualizado a: ')

		set_text(LANG, 'linkSet', '`>` Un *nuevo link* ha sido *establecido*')
		set_text(LANG, 'linkError', '`>` Se necesita *permisos de creador* para exportar el link de invitación del chat.')

		set_text(LANG, 'newRules', '`>` *Nuevas normas creadas.*')
		set_text(LANG, 'rulesDefault', '`>` Tus anteriores *normas han sido eliminadas.*')
		set_text(LANG, 'noRules', '`>` *No hay normas visibles* en este grupo.')
		set_text(LANG, 'defaultRules', '*Normas del chat:*\n`>` No hacer Flood.\n`>` No hacer Spam.\n`>` Intenta permanecer en el tema.\n`>` Prohibido cualquier contenido racista, sexual, gore......\n\n_El incumplimiento reiterado de estas normas puede comportar el ban._')

		set_text(LANG, 'delAll', '`>` Todos los mensajes han sido *eliminados*.')

		-- export_gban.lua --
		set_text(LANG, 'accountsGban', 'cuentas globalmente baneadas.')

		-- promote.lua --
		set_text(LANG, 'alreadyAdmin', 'Este usuario ya es *admin.*')
		set_text(LANG, 'alreadyMod', 'Este usuario ya es *mod.*')

		set_text(LANG, 'newAdmin', '<code>></code> <b>Nuevo admin</b>')
		set_text(LANG, 'newMod', '<code>></code> <b>Nuevo mod</b>')
		set_text(LANG, 'nowUser', ' <b>es ahora un usuario.</b>')

		set_text(LANG, 'modList', '`>` *Lista de Mods*')
		set_text(LANG, 'adminList', '`>` *Lista de Admins')
		set_text(LANG, 'modEmpty', '*La lista de mods está vacia* en este chat.')
		set_text(LANG, 'adminEmpty', '*La lista de admins está vacia*.')
		set_text(LANG, 'error1', '<b>Error:</b> tiene que ser un supergrupo.')
		set_text(LANG, 'error2', '<b>Error:</b> tiene que ser un supergrupo y admin del chat.')
		set_text(LANG, 'banall', '<b>Intentando banear a todos los usuarios...</b>')
		set_text(LANG, 'setAbout', '<b>Bio del bot cambiada a: </b>')
		set_text(LANG, 'leave', '<b>Adiós!</b>')
		
		
		-- gban.lua --
		set_text(LANG, 'gbans', '<b>Usuarios baneados globalmente (</b>')
		set_text(LANG, 'gbanLua', ' usuarios baneados globalmente del archivo LUA!')
		set_text(LANG, 'gbanJson', ' usuarios baneados globalmente del archivo JSON!')
		set_text(LANG, 'gbanDel', 'Base de datos de los Gbans eliminado.')

		-- id.lua --
		set_text(LANG, 'user', 'Usuario')
		set_text(LANG, 'chatName', 'Nombre del Chat')
		set_text(LANG, 'chat', 'Chat')
		set_text(LANG, 'userID', '*User ID:*')
		set_text(LANG, 'ChatID', '*Chat ID:*')

		-- moderation.lua --
		set_text(LANG, 'kickUser', '`>` El usuario ha sido *expulsado.*')
		set_text(LANG, 'banUser', '`>` El usuario ha sido *baneado.*')
		set_text(LANG, 'unbanUser', '`>` El usuario ha sido *borrado* de la lista *baneados.*')
		set_text(LANG, 'gbanUser', '`>` EL usuario ha sido *baneado globalmente*.')
		set_text(LANG, 'ungbanUser', '`>` El usuario ha sido *borrado* de la *lista de baneados globales. *')
		set_text(LANG, 'muteUser', '`>` El usuario ha sido *silenciado.*')
		set_text(LANG, 'muteChat', '`>` El chat ha sido *silenciado.*')
		set_text(LANG, 'muteChatSec', '`>` EL chat ha sido *silenciado* durante ')
		set_text(LANG, 'muteUserSec', '`>` El usuario ha sido *silenciado* durante ')
		set_text(LANG, 'unmuteUser', '`>` El usuario *puede hablar ahora.*')
		set_text(LANG, 'unmuteChat', '`>` Los usuarios *pueden hablar ahora.*')

		set_text(LANG, 'delXMsg', '`>` Al usuario $user *se le ha eliminado* `$num mensajes`.')

		-- commands.lua --
		set_text(LANG, 'commandsT', 'Comandos')
		set_text(LANG, 'errorNoPlug', 'Este plugin no existe o no tiene comandos.')

		-- plugins.lua --

		set_text(LANG, 'pluginsActivated', '*Plugins activados:*\n')
		set_text(LANG, 'pluginNoExist', '`>` *El plugin* $name *no existe*.')
		set_text(LANG, 'pluginIsEnabled', '`>` *El plugin* está *actualmente activado*.')
		set_text(LANG, 'pluginNoEnabled', '`>` *El plugin* está *actualmente desactivado*.')
		set_text(LANG, 'pluginsReload', '`>` *Plugin recargados!*')

		set_text(LANG, 'pluginEnabled', '`>` El *plugin* ha sido *activado*.')
		set_text(LANG, 'pluginDisabled', '`>` El *plugin* ha sido *desactivado*.')

		
				-- private.lua--
	
		set_text(LANG, 'privateMSG', '`>` Perdona, este comando solo funciona *en un chat privado con el bot.*')
		set_text(LANG, 'privateError', '`>` Ha habido un error.')
		set_text(LANG, 'privateSuper', '`>` Grupo creado, migrado a supergrupo y promoteado a admin!')
		
		
		
		------------
		-- Usages --
		------------

		-- commands.lua --
		set_text(LANG, 'commands:0', 2)
		set_text(LANG, 'commands:1', '#commands: Muestra los comandos para todos los plugins.')
		set_text(LANG, 'commands:2', '#commands [plugin]: Comandos para ese plugin.')

		-- export_gban.lua --
	--	set_text(LANG, 'export_gban:0', 2)
	--	set_text(LANG, 'export_gban:1', '#gbans installer: Devuelve un archivo lua instalador para compartir gbans y añadirlos en otro bot con un único comando.')
	--	set_text(LANG, 'export_gban:2', '#gbans list: Devuelve un archivo con la lista de gbans.')

		-- gban_installer.lua --
	--	set_text(LANG, 'gban_installer:0', 1)
	--	set_text(LANG, 'gban_installer:1', '#install gbans: añade una lista de gbans en tu base de datos redis.')

		-- welcome.lua --
        set_text(LANG, 'welcome:0', 3)
        set_text(LANG, 'welcome:1', '#setwelcome [Texto para bienvenida]. Puede realizar una bienvenida personalizada para este chat. Ponga un "0" para establecer la recepción predeterminada.')
        set_text(LANG, 'welcome:2', '#getwelcome - Devuelve la bienvenida actual en este chat')
        set_text(LANG, 'welcome:3', '#welcome on/off - Activar/desactivar la bienvenida en este chat')

		-- giverank.lua --
		set_text(LANG, 'promote:0', 6)
		set_text(LANG, 'promote:1', '#admin (reply): Convierte la persona a la que respondes en admin')
		set_text(LANG, 'promote:2', '#admin <user_id>/<user_name>: Añade un admin mediante su ID/Username.')
		set_text(LANG, 'promote:3', '#mod (reply): Convierte la persona a la que respondes en mod.')
		set_text(LANG, 'promote:4', '#mod <user_id>/<user_name>: Añade un mod mediante su ID/Username.')
		set_text(LANG, 'promote:5', '#user (reply): Convierte a la persona a la que respondes en usuario.')
		set_text(LANG, 'promote:6', '#user <user_id>/<user_name>: Convierte un usuario mediante su ID/Usuario a usuario normal.')

		-- id.lua --
		set_text(LANG, 'id:0', 1)
		set_text(LANG, 'id:1', '#id (or reply): devuelve tu id y la del chat si estás en alguno.')

		-- moderation.lua --
		set_text(LANG, 'moderation:0', 7)
		set_text(LANG, 'moderation:1', '#kick <reply>/<id>/<username>: El usuario será eliminado en el chat actual.')
		set_text(LANG, 'moderation:2', '#ban <reply>/<id>/<username>: El usuario será bloqueado en el chat actual y no será capaz de volver.')
		set_text(LANG, 'moderation:3', '#unban <reply>/<id>/<username>: El usuario quedará desbloqueado en el chat actual.')
		set_text(LANG, 'moderation:4', '#gban <reply>/<id>/<username>: El usuario será bloqueado de todos los chats y no será capaz de entrar.')
		set_text(LANG, 'moderation:5', '#ungban <reply>/<id>/<username>: El usuario será desbloqueado de todos los chats.')
		set_text(LANG, 'moderation:6', '#mute <reply>/<id>/<username>: El usuario se silenciará en el chat actual, borrando todos sus mensajes.')
		set_text(LANG, 'moderation:7', '#unmute <reply>/<id>/<username>: el usuario puede hablar en el chat actual.')

		-- settings.lua --
	    set_text(LANG, 'settings:0', 20)
		set_text(LANG, 'settings:1', '#tgservices on/off: Cuando está inhabilitado, se borrarán todos los mensajes de los servicios de telegram.')
		set_text(LANG, 'settings:2', '#invite on/off: Cuando está inhabilitado, todos los nuevos participantes invitados serán eliminados.')
		set_text(LANG, 'settings:3', '#lang <language (en, es...)>: Cambia el idioma del bot.')
		set_text(LANG, 'settings:4', '#photos on/off: Cuando se inhabilita, se borrarán todas las fotos.')
		set_text(LANG, 'settings:5', '#videos on/off: Cuando está inhabilitado, todos los videos se borrarán.')
		set_text(LANG, 'settings:6', '#stickers on/off: Cuando está inhabilitado, todos las stickers serán borradas.')
		set_text(LANG, 'settings:7', '#gifs on/off: Cuando está deshabilitado, todos los gifs se borrarán.')
	   	set_text(LANG, 'settings:8', '#voice on/off: Cuando está deshabilitado, todos los mensajes de voz serán borrados.')
	    set_text(LANG, 'settings:9', '#audios on/off: Cuando está inhabilitado, todos los audios serán borrados.')
		set_text(LANG, 'settings:10', '#documents on/off: Cuando está inhabilitado, todos los documentos serán borrados.')
		set_text(LANG, 'settings:11', '#location on/off: Cuando está inhabilitado, todas las ubicaciones serán borradas.')
		set_text(LANG, 'settings:12', '#games on/off: Cuando está inhabilitado, todos los juegos serán borrados.')
	    set_text(LANG, 'settings:13', '#spam on/off: Cuando está deshabilitado, todos los mensajes de spam se borrarán.')
		set_text(LANG, 'settings:14', '#forward on/off: Cuando está deshabilitado, se borrarán todos los mensajes reenviados.')
		set_text(LANG, 'settings:15', '#floodtime <secs>: Establecer el tiempo que bot utiliza para comprobar el flood. Ajuste 0 para desactivar.')
	    set_text(LANG, 'settings:16', '#maxflood <msgs>: Establecer el máximo de mensajes en un tiempo de flood para ser considerado como flood. Ajuste 0 para desactivarlo.')
	    set_text(LANG, 'settings:17', '#links on/off: Cuando está deshabilitado, todos los enlaces se borrarán.')
	    set_text(LANG, 'settings:18', '#arabic on/off: Cuando está inhabilitado, todos los mensajes con árabe/persa serán borrados.')
		set_text(LANG, 'settings:19', '#english on/off: Cuando está deshabilitado, se borrarán todos los mensajes con letras en inglés.')
	    set_text(LANG, 'settings:20', '#emoji on/off: Cuando está inhabilitado, todos los mensajes con emoji serán borrados.')
	    -- set_text(LANG, 'settings:5', '#bots on/off: Cuando está inhabilitado, si alguien añade un bot, se pateará.')

		if matches[1] == 'install' then
			return '`>` El lenguaje *español* ha sido instalado en su base de datos.'
		elseif matches[1] == 'update' then
			return '`>` El lenguaje *español* ha sido actualizado en su base de datos.'
		end
	else
		return "`>` Este plugin *requiere permisos de sudo*."
	end
end

return {
	patterns = {
		'[!/#](install) (spanish_lang)$',
		'[!/#](update) (spanish_lang)$'
	},
	run = run
}
