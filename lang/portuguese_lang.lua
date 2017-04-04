--------------------------------------------------
--      ____  ____ _____                        --
--     |    \|  _ )_   _|___ ____   __  __      --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |     --
--     |____/|____/ |_|\____/\_____|_/\/\_|v2   --
--   _____________________________________      --
--  |                                     |     --
--  | Traduzido por @Wesley_Henr          |     --
--  |_____________________________________|     --
--                                              --
--------------------------------------------------

local LANG = 'pt'

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "lang_install") then

		-------------------------
		-- Translation version --
		-------------------------
		set_text(LANG, 'version', '1.0')
		set_text(LANG, 'versionExtended', 'Versão da tradução 1.0')

		-------------
		-- Plugins --
		-------------

		-- global plugins --
		set_text(LANG, 'require_sudo', 'Este plugin requer privilégios de sudo.')
		set_text(LANG, 'require_admin', 'Este plugin requer privilégios de administrador ou superior.')
		set_text(LANG, 'require_mod', 'Este plugin requer privilégios de moderador ou superior.')

		-- welcome.lua
		set_text(LANG, 'weloff', 'Bem-vindo ativado.')
		set_text(LANG, 'welon', 'Bem-vindo desativado.')
		set_text(LANG, 'weldefault', 'O bem-vindo é o padrão.')
		set_text(LANG, 'welnew', 'Bem-vindo salvo! é')
		set_text(LANG, 'defaultWelcome', 'Bem-vindo $users ao grupo!')



		-- stats.lua
		set_text(LANG, 'stats', '*Chat stats*')
		set_text(LANG, 'statsCommand', 'stats')


		-- settings.lua --
		set_text(LANG, 'user', 'User')
		set_text(LANG, 'isFlooding', '*is flooding.*')
		set_text(LANG, 'isSpamming', '*is spamming.*')

		set_text(LANG, 'welcomeT', '> *Welcome messages* are now *enabled* in this chat.')
		set_text(LANG, 'noWelcomeT', '> *Welcome messages* are *disabled* in this chat.')

		set_text(LANG, 'noStickersT', '`>` *Stickers* are *not allowed* in this chat.')
		set_text(LANG, 'stickersT', '`>` *Stickers* are now *allowed* in this chat.')

		set_text(LANG, 'noTgservicesT', '`>` *Telegram services disabled* in this chat.')
		set_text(LANG, 'tgservicesT', '`>` *Telegram services enabled* in this chat.')

		set_text(LANG, 'gifsT', '`>` *Gifs* are now *allowed* in this chat.')
		set_text(LANG, 'noGifsT', '`>` *Gifs* are *not allowed* in this chat.')

		set_text(LANG, 'photosT', '`>` *Photos* are now `allowed` in this chat.')
		set_text(LANG, 'noPhotosT', '`>` *Photos* are *not allowed* in this chat.')

		set_text(LANG, 'botsT', '`>` *Bots* are now allowed in this chat.')
		set_text(LANG, 'noBotsT', '`>` Bots are not allowed in this chat.')

		set_text(LANG, 'arabicT', '`>` *Arabic* is now *allowed* in this chat.')
		set_text(LANG, 'noArabicT', '`>` *Arabic* is *not allowed* in this chat.')

		set_text(LANG, 'audiosT', '`>` *Audios* are now *allowed* in this chat.')
		set_text(LANG, 'noAudiosT', '`>` *Audios* are *not allowed* in this chat.')

		set_text(LANG, 'documentsT', '`>` *Documents* are now *allowed* in this chat.')
		set_text(LANG, 'noDocumentsT', '`>` *Documents* are *not allowed* in this chat.')

		set_text(LANG, 'videosT', '`>` *Videos* are now *allowed* in this chat.')
		set_text(LANG, 'noVideosT', '`>` *Videos* are *not allowed* in this chat.')

		set_text(LANG, 'locationT', '`>` *Location* is now *allowed* in this chat.')
		set_text(LANG, 'noLocationT', '`>` *Location* is *not allowed* in this chat.')

		set_text(LANG, 'emojisT', '`>` *Emojis* are now *allowed* in this chat.')
		set_text(LANG, 'noEmojisT', '`>` *Emojis* are *not allowed* in this chat.')

		set_text(LANG, 'englishT', '`>` *English* is now *allowed* in this chat.')
		set_text(LANG, 'noEnglishT', '`>` *English* is *not allowed* in this chat.')

		set_text(LANG, 'inviteT', '`>` *Invite* is now *allowed* in this chat.')
		set_text(LANG, 'noInviteT', '`>` *Invite* is *not allowed* in this chat.')

		set_text(LANG, 'voiceT', '`>` *Voice messages* are now *allowed* in this chat.')
		set_text(LANG, 'noVoiceT', '`>` *Voice messages* are *not allowed* in this chat.')

		set_text(LANG, 'infoT', '`>` *Photo/title* can be changed in this chat.')
		set_text(LANG, 'noInfoT', '`>` *Photo/title* can\'t be changed in this chat.')

		set_text(LANG, 'gamesT', '`>` *Games* are now *allowed* in this chat.')
		set_text(LANG, 'noGamesT', '`>` *Games* are *not allowed* in this chat.')

		set_text(LANG, 'spamT', '`>` *Spam* is now *allowed* in this chat.')
		set_text(LANG, 'noSpamT', '`>` *Spam* is *not allowed* in this chat.')
		set_text(LANG, 'setSpam', '`>` Changed blacklist to ')

		set_text(LANG, 'forwardT', '`>` *Forward messages* is now *allowed* in this chat.')
		set_text(LANG, 'noForwardT', '`>` *Forward messages* is not *allowed* in this chat.')

		set_text(LANG, 'floodT', '`>` *Flood* is now *allowed* in this chat.')
		set_text(LANG, 'noFloodT', '`>` *Flood* is *not allowed* in this chat.')

		set_text(LANG, 'floodTime', '`>` *Flood time* check has been set to ')
		set_text(LANG, 'floodMax', '`>` *Max flood* messages have been set to ')

		set_text(LANG, 'gSettings', 'chat settings')

		set_text(LANG, 'allowed', 'allowed')
		set_text(LANG, 'noAllowed', 'not allowed')
		set_text(LANG, 'noSet', 'not set')

		set_text(LANG, 'stickers', 'Stickers')
		set_text(LANG, 'tgservices', 'Tg services')
		set_text(LANG, 'links', 'Links')
		set_text(LANG, 'arabic', 'Arabic')
		set_text(LANG, 'bots', 'Bots')
		set_text(LANG, 'gifs', 'Gifs')
		set_text(LANG, 'photos', 'Photos')
		set_text(LANG, 'audios', 'Audios')
		set_text(LANG, 'kickme', 'Kickme')
		set_text(LANG, 'spam', 'Spam')
		set_text(LANG, 'gName', 'Group Name')
		set_text(LANG, 'flood', 'Flood')
		set_text(LANG, 'language', 'Language')
		set_text(LANG, 'mFlood', 'Max flood')
		set_text(LANG, 'tFlood', 'Flood time')
		set_text(LANG, 'setphoto', 'Set photo')

		set_text(LANG, 'forward', 'Forward')
		set_text(LANG, 'videos', 'Videos')
		set_text(LANG, 'invite', 'Invite')
		set_text(LANG, 'games', 'Games')
		set_text(LANG, 'documents', 'Documents')
		set_text(LANG, 'location', 'Location')
		set_text(LANG, 'voice', 'Voice')
		set_text(LANG, 'icontitle', 'Change icon/title')
		set_text(LANG, 'english', 'English')
		set_text(LANG, 'emojis', 'Emojis')
		--Made with @TgTextBot by @iicc1
		set_text(LANG, 'groupSettings', 'G̲r̲o̲u̲p̲ s̲e̲t̲t̲i̲n̲g̲s̲')
		set_text(LANG, 'allowedMedia', 'A̲l̲l̲o̲w̲e̲d̲ m̲e̲d̲i̲a̲')
		set_text(LANG, 'settingsText', 'T̲e̲x̲t̲')

		set_text(LANG, 'langUpdated', 'Your language has been updated to: ')

		set_text(LANG, 'linkSet', '`>` *New link* has been *set*')
		set_text(LANG, 'linkError', '`>` Need *creator rights* to export chat invite link.')

		set_text(LANG, 'newRules', '`>` *New rules* have been *created.*')
		set_text(LANG, 'rulesDefault', '`>` Your previous *rules have been removed.*')
		set_text(LANG, 'noRules', '`>` *There are no visible rules* in this group.')
		set_text(LANG, 'defaultRules', '*Chat rules:*\n`>` No Flood.\n`>` No Spam.\n`>` Try to stay on topic.\n`>` Forbidden any racist, sexual, gore content...\n\n_Repeated failure to comply with these rules will cause ban._')

		set_text(LANG, 'delAll', '`>` All messages *cleared*.')

		-- export_gban.lua --
		set_text(LANG, 'accountsGban', 'accounts globally banned.')

		-- promote.lua --
		set_text(LANG, 'alreadyAdmin', 'Este usuário já é um *admin.*')
		set_text(LANG, 'alreadyMod', 'Este usuário já é um *mod.*')

		set_text(LANG, 'newAdmin', '<code>></code> <b>New admin</b>')
		set_text(LANG, 'newMod', '<code>></code> <b>New mod</b>')
		set_text(LANG, 'nowUser', ' <b>is now an user.</b>')

		set_text(LANG, 'modList', '`>` *Lista de Moderadores*')
		set_text(LANG, 'adminList', '`>` *Lista de Administradores')
		set_text(LANG, 'modEmpty', '*Lista de moderadores está vazia* neste grupo.')
		set_text(LANG, 'adminEmpty', '*Lista de administradores vazia.*')
		set_text(LANG, 'error1', '<b>Error:</b> must be a supergroup.')
		set_text(LANG, 'error2', '<b>Error:</b> must be a supergroup and admin of the chat.')
		set_text(LANG, 'banall', '<b>Trying to ban all users...</b>')
		set_text(LANG, 'setAbout', '<b>About changed to: </b>')
		set_text(LANG, 'leave', '<b>Bye!</b>')
		-- gban.lua --
		set_text(LANG, 'gbans', '<b>Globally banned users (</b>')
		set_text(LANG, 'gbanLua', ' users globally banned from LUA file!')
		set_text(LANG, 'gbanJson', ' users globally banned from JSON file!')
		set_text(LANG, 'gbanJson', ' users globally banned from JSON file!')
		set_text(LANG, 'gbanDel', 'Gbans database removed.')

		-- id.lua --
		set_text(LANG, 'user', 'Usuário')
		set_text(LANG, 'chatName', 'Nome do Grupo')
		set_text(LANG, 'chat', 'Grupo')
		set_text(LANG, 'userID', '*User ID:*')
		set_text(LANG, 'ChatID', '*Chat ID:*')

		-- moderation.lua --
		set_text(LANG, 'kickUser', '`>` The user has been *kicked out.*')
		set_text(LANG, 'banUser', '`>` The user has been *banned.*')
		set_text(LANG, 'unbanUser', '`>` The user has been *removed* from *ban list.*')
		set_text(LANG, 'gbanUser', '`>` The user has been *globally banned*.')
		set_text(LANG, 'ungbanUser', '`>` The user has been *removed* from *global ban list.*')
		set_text(LANG, 'muteUser', '`>` The user has been *muted.*')
		set_text(LANG, 'muteChat', '`>` The chat has been *muted.*')
		set_text(LANG, 'muteChatSec', '`>` The chat has been *muted* for ')
		set_text(LANG, 'muteUserSec', '`>` The user has been *muted* for ')
		set_text(LANG, 'unmuteUser', '`>` The user *can talk now.*')
		set_text(LANG, 'unmuteChat', '`>` The users *can talk now.*')

		set_text(LANG, 'delXMsg', '`>` User $user *has deleted* `$num messages`.')

		-- commands.lua --
		set_text(LANG, 'commandsT', 'Comando')
		set_text(LANG, 'errorNoPlug', 'Este plugin não existe ou não tem comandos.')

		-- plugins.lua --

		set_text(LANG, 'pluginsActivated', '*Plugins enabled:*\n')
		set_text(LANG, 'pluginNoExist', '`>` *Plugin* $name does *not exist*.')
		set_text(LANG, 'pluginIsEnabled', '`>` The *plugin* is *already enabled*.')
		set_text(LANG, 'pluginNoEnabled', '`>` The *plugin* is *already disabled*.')
		set_text(LANG, 'pluginsReload', '`>` *Plugins reloaded!*')

		set_text(LANG, 'pluginEnabled', '`>` The *plugin* has been *enabled*.')
		set_text(LANG, 'pluginDisabled', '`>` The *plugin* has been *disabled*.')

				-- private.lua--
	
		set_text(LANG, 'privateMSG', '`>` Sorry, this command only works *in a private chat with the bot.*')
		set_text(LANG, 'privateError', '`>` An error occuried.')
		set_text(LANG, 'privateSuper', '`>` Group created, migrated to supergroup and promoted to admin!')
		
		
		------------
		-- Usages --
		------------


		-- commands.lua --
		set_text(LANG, 'commands:0', 2)
		set_text(LANG, 'commands:1', '#commands: Show all commands for every plugin.')
		set_text(LANG, 'commands:2', '#commands [plugin]: Commands for that plugin.')

		-- export_gban.lua --
	--	set_text(LANG, 'export_gban:0', 2)
	--	set_text(LANG, 'export_gban:1', '#gbans installer: Return a lua file installer to share gbans and add those in another bot in just one command.')
	--	set_text(LANG, 'export_gban:2', '#gbans list: Return an archive with a list of gbans.')

		-- gban_installer.lua --
	--	set_text(LANG, 'gban_installer:0', 1)
	--	set_text(LANG, 'gban_installer:1', '#install gbans: add a list of gbans into your redis db.')

		-- welcome.lua --
        set_text(LANG, 'welcome:0', 3)
        set_text(LANG, 'welcome:1', '#setwelcome [text for welcome]. You can make a custom welcome for this chat. Put a "0" to set the default welcome.')
        set_text(LANG, 'welcome:2', '#getwelcome - returns the current welcome in this chat')
        set_text(LANG, 'welcome:3', '#welcome on/off - enable/disable welcome in this chat')

		-- giverank.lua --
		set_text(LANG, 'promote:0', 6)
		set_text(LANG, 'promote:1', '#admin (reply): add admin by reply.')
		set_text(LANG, 'promote:2', '#admin <user_id>/<user_name>: add admin by user ID/Username.')
		set_text(LANG, 'promote:3', '#mod (reply): add mod by reply.')
		set_text(LANG, 'promote:4', '#mod <user_id>/<user_name>: add mod by user ID/Username.')
		set_text(LANG, 'promote:5', '#user (reply): remove admin by reply.')
		set_text(LANG, 'promote:6', '#user <user_id>/<user_name>: remove admin by user ID/Username.')

		-- id.lua --
		set_text(LANG, 'id:0', 1)
		set_text(LANG, 'id:1', '#id (or reply): Return your ID and the chat id if you are in one.')

		-- moderation.lua --
		set_text(LANG, 'moderation:0', 7)
		set_text(LANG, 'moderation:1', '#kick <reply>/<id>/<username>: the user will be kicked in the current chat.')
		set_text(LANG, 'moderation:2', '#ban <reply>/<id>/<username>: the user will be banned in the current chat and it wont be able to return.')
		set_text(LANG, 'moderation:3', '#unban <reply>/<id>/<username>: the user will be unbanned in the current chat.')
		set_text(LANG, 'moderation:4', '#gban <reply>/<id>/<username>: the user will be banned from all chats and it wont be able to enter.')
		set_text(LANG, 'moderation:5', '#ungban <reply>/<id>/<username>: the user will be unbanned from all chats.')
		set_text(LANG, 'moderation:6', '#mute <reply>/<id>/<username>: the user will be silenced in the current chat, erasing all its messages.')
		set_text(LANG, 'moderation:7', '#unmute <reply>/<id>/<username>: the user will be unsilenced in the current chat.')

		-- settings.lua --
	    set_text(LANG, 'settings:0', 20)
		set_text(LANG, 'settings:1', '#tgservices on/off: when disabled, all telegram service messages will be cleared.')
		set_text(LANG, 'settings:2', '#invite on/off: when disabled, all new invited participants will be cleared.')
		set_text(LANG, 'settings:3', '#lang <language (en, es...)>: changes the language of the bot.')
		set_text(LANG, 'settings:4', '#photos on/off: when disabled, all photos will be cleared.')
		set_text(LANG, 'settings:5', '#videos on/off: when disabled, all videos will be cleared.')
		set_text(LANG, 'settings:6', '#stickers on/off: when disabled, all stickers will be cleared.')
		set_text(LANG, 'settings:7', '#gifs on/off: when disabled, all gifs will be cleared.')
	   	set_text(LANG, 'settings:8', '#voice on/off: when disabled, all voicess will be cleared.')
	    set_text(LANG, 'settings:9', '#audios on/off: when disabled, all audios will be cleared.')
		set_text(LANG, 'settings:10', '#documents on/off: when disabled, all documents will be cleared.')
		set_text(LANG, 'settings:11', '#location on/off: when disabled, all locations will be cleared.')
		set_text(LANG, 'settings:12', '#games on/off: when disabled, all games will be cleared.')
	    set_text(LANG, 'settings:13', '#spam on/off: when disabled, all spam messages will be cleared.')
		set_text(LANG, 'settings:14', '#forward on/off: when disabled, all forwarded messages will be cleared.')
		set_text(LANG, 'settings:15', '#floodtime <secs>: set the time that bot uses to check flood. Set 0 to desactivate.')
	    set_text(LANG, 'settings:16', '#maxflood <msgs>: set the maximum messages in a floodtime to be considered as flood. Set 0 to desactivate.')
	    set_text(LANG, 'settings:17', '#links on/off: when disabled, all links will be cleared.')
	    set_text(LANG, 'settings:18', '#arabic on/off: when disabled, all messages with arabic/persian will be cleared.')
		set_text(LANG, 'settings:19', '#english on/off: when disabled, all messages with english letters will be cleared.')
	    set_text(LANG, 'settings:20', '#emoji on/off: when disabled, all messages with emoji will be cleared.')
	    -- set_text(LANG, 'settings:5', '#bots on/off: when disabled, if someone adds a bot, it will be kicked.')

		if matches[1] == 'install' then
			return '`>` *Português* foi instalado com êxito no seu bot.'
		elseif matches[1] == 'update' then
			return '`>` *Português* foi atualizado com sucesso em seu bot.'
		end
	else
		return "`>` Este plugin *requer* o uso de privilégios *sudo*."
	end
end

return {
	patterns = {
		'[!/#](install) (portuguese_lang)$',
		'[!/#](update) (portuguese_lang)$'
	},
	run = run
}
