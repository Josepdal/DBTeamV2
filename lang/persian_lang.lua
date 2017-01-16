--------------------------------------------------
	-- ____ ____ _____ --
	-- | \| _ )_ _|___ ____ __ __ --
	-- | |_ ) _ \ | |/ ·__| _ \_| \/ | --
	-- |____/|____/ |_|\____/\_____|_/\/\_|v2 --
	-- --
	--------------------------------------------------
	local LANG = 'fa'
	local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "lang_install") then
	-------------------------
	-- Translation version --
	-------------------------
	set_text(LANG, 'version', '2.0')
	set_text(LANG, 'versionExtended', 'Translation version 2.0')
	-------------
	-- Plugins --
	-------------
	-- global plugins --
	set_text(LANG, 'require_sudo', 'فقط براي سودو امکان پذير است.')
	set_text(LANG, 'require_admin', 'اين پلاگين براي ادمين يا بالاتر است.')
	set_text(LANG, 'require_mod', 'اين پلاگين براي مدير گروه در دسترس ميباشد!.')
	-- welcome.lua
	set_text(LANG, 'weloff', 'خوش آمد گويي روشن')
	set_text(LANG, 'welon', 'خوش آمد گويي خاموش.')
	set_text(LANG, 'byeon', 'پيام خروج روشن شد')
	set_text(LANG, 'byeoff', 'پيام خروج خاموش شد')
	set_text(LANG, 'welcome1', 'سلام ')
	set_text(LANG, 'welcome2', 'خوش آمديد به')
	set_text(LANG, 'weldefault', 'خوش امد گويي بصورت پيشفرض')
	set_text(LANG, 'byedefault', 'پيام خروج به صورت پيشفرض.')
	set_text(LANG, 'newbye', 'پيام خروج تعييين شد به')
	set_text(LANG, 'bye1', 'خداحافظ ')
	set_text(LANG, 'bye2', ' مچکرم براي ديدار')
	set_text(LANG, 'welnew', 'پيام خوش آمد گويي تعيين شد به')
	set_text(LANG, 'defaultWelcome', 'خوش آمديد $users به گروه')
	-- settings.lua --
	set_text(LANG, 'user', 'کاربر')
	set_text(LANG, 'isFlooding', '*در حال فرستادن پيام هاي مکرر و سريع است*')
	set_text(LANG, 'isSpamming', '*در حال فرستادن هرزنامه است.*')
	set_text(LANG, 'noStickersT', '`>` `استيکر مجاز نيست در اين گروه`.')
	set_text(LANG, 'stickersT', '`>` استيکر فرستادن در حال حاظر مجاز است.')
	set_text(LANG, 'noTgservicesT', '`>` حذف پيام هاي مارکدون غير فعال است.')
	set_text(LANG, 'tgservicesT', '`>` حذف پيام هاي مارکدون فعال است.')
	set_text(LANG, 'gifsT', '`>` *عکس متحرک(گيف) در گروه مجاز است.')
	set_text(LANG, 'noGifsT', '`>` ارسال پيام متحرک (گيف)در حال حاظر مجاز نيست.')
	set_text(LANG, 'photosT', '`>` فرستادن عکس در حال حاظر مجاز است .')
	set_text(LANG, 'noPhotosT', '`>` فرستادن عکس هم اکنون در گروه مجاز نيست')
	set_text(LANG, 'botsT', '`>` ورود ربات ها هم اکنون مجاز است در گروه')
	set_text(LANG, 'noBotsT', '`>` ورود ربات ها هم اکنون غير مجاز است در گروه.')
	set_text(LANG, 'arabicT', '`>` متون عربي يا فارسي هم اکنون مجاز است در گروه.')
	set_text(LANG, 'noArabicT', '`>` متون عربي در گروه غير مجاز است.')
	set_text(LANG, 'audiosT', '`>` فرستادن صدا هم اکنون مجاز است در گروه.')
	set_text(LANG, 'noAudiosT', '`>` فرستادن صدا هم اکنون غير مجاز')
	set_text(LANG, 'documentsT', '`>` فرستادن فايل در گروه مجاز است.')
	set_text(LANG, 'noDocumentsT', '`>` ارسال صدا در گروه غير مجاز است.')
	set_text(LANG, 'videosT', '`>` فرستادن فيلم در گروه مجاز است.')
	set_text(LANG, 'noVideosT', '`>` ارسال فيلم در گروه غير مجاز است.')
	set_text(LANG, 'locationT', '`>` ارسال مکان هم اکنون در گروه مجاز است.')
	set_text(LANG, 'noLocationT', '`>`ارسال مکان هم اکنون در گروه غير مجاز است')
	set_text(LANG, 'emojisT', '`>` ارسال ايموجي مجاز است.')
	set_text(LANG, 'noEmojisT', '`>` اراسل ايموجي غير مجاز است.')
	set_text(LANG, 'englishT', '`>` متون انگليسي در گروه مجاز است')
	set_text(LANG, 'noEnglishT', '`>` ارسال متون انگليسي هم اکنون در گروه غير مجاز است.')
	set_text(LANG, 'inviteT', '`>` دعوت کردن افراد هم اکنون مجاز است')
	set_text(LANG, 'noInviteT', '`>` دعوت کردن افراد هم اکنون غير مجاز است')
	set_text(LANG, 'voiceT', '`>` ارسال صداي ضبط شده هم اکنون مجاز است.')
	set_text(LANG, 'noVoiceT', '`>` ارسال صداي ظبط شده هم اکنون غير مجاز است .')
	set_text(LANG, 'infoT', '`>` عکس گروه را هم اکنون ميتوانيد تغيير دهيد.')
	set_text(LANG, 'noInfoT', '`>` عکس گروه را هم اکنون نميتوان تغيير داد')
	set_text(LANG, 'gamesT', '`>` شروع بازي انلاين هم اکنون مجاز است.')
	set_text(LANG, 'noGamesT', '`>` شروع کردن بازي غير مجاز است.')
	set_text(LANG, 'spamT', '`>` ارسال هرزنامه هم اکنون مجاز است.')
	set_text(LANG, 'noSpamT', '`>` ارسال هرزنامه هم اکنون غير مجاز است .')
	set_text(LANG, 'setSpam', '`>` حساسيت هرزنامه ')
	set_text(LANG, 'floodT', '`>` ارسال پيام هاي مکرر مجاز است.')
	set_text(LANG, 'noFloodT', '`>` ارسال پيام هاي مکرر غير مجاز است.')
	set_text(LANG, 'floodTime', '`>` زمان ارسال پيام مکرر و سريع تغيير يافت به : ')
	set_text(LANG, 'floodMax', '`>` حساسيت ارسال پيام مکرر تغير يافت به: ')
	set_text(LANG, 'gSettings', 'تنظيمات گروه')
	set_text(LANG, 'allowed', 'مجاز')
	set_text(LANG, 'noAllowed', 'غير مجاز ')
	set_text(LANG, 'noSet', 'تعيين نشده')
	set_text(LANG, 'stickers', 'استيکر')
	set_text(LANG, 'tgservices', 'سرويس تلگرام')
	set_text(LANG, 'links', 'ارسال لينک')
	set_text(LANG, 'arabic', 'فارسي و عربي')
	set_text(LANG, 'bots', 'ربات ')
	set_text(LANG, 'gifs', ' عکس متحرک .|گيف|')
	set_text(LANG, 'photos', 'عکس ')
	set_text(LANG, 'audios', 'صدا')
	set_text(LANG, 'kickme', 'اخراج خود')
	set_text(LANG, 'spam', 'هرزنامه')
	set_text(LANG, 'gName', 'نام گروه')
	set_text(LANG, 'flood', 'پيام مکرر')
	set_text(LANG, 'language', 'زبان')
	set_text(LANG, 'mFlood', 'حساسيت پيام مکرر')
	set_text(LANG, 'tFlood', 'زمان پيام مکرر')
	set_text(LANG, 'setphoto', 'تغيير عکس گروه')
	--DBTEAMV2
	set_text(LANG, 'videos', 'ويديو')
	set_text(LANG, 'invite', 'دعوت')
	set_text(LANG, 'games', 'بازي اينلاين')
	set_text(LANG, 'documents', 'فايل')
	set_text(LANG, 'location', 'مکان')
	set_text(LANG, 'voice', 'صداي ظبط شده')
	set_text(LANG, 'icontitle', 'Change icon/title')
	set_text(LANG, 'english', 'متون انگليسي')
	set_text(LANG, 'emojis', 'ايموجي')
	--Made with @TgTextBot by @iicc1
	set_text(LANG, 'groupSettings', 'تنظيمات گروه')
	set_text(LANG, 'allowedMedia', 'رسانه هاي مجاز')
	set_text(LANG, 'settingsText', 'متن ')
	set_text(LANG, 'langUpdated', 'زبان شما تغيير يافت به : ')
	-- export_gban.lua --
	set_text(LANG, 'accountsGban', 'کاربران بن گلوبال')
	-- promote.lua --
	set_text(LANG, 'alreadyAdmin', 'اين کاربر در حال حاظر ادمين ميباشد')
	set_text(LANG, 'alreadyMod', 'اين کاربر در حال حاظر مدير ميباشد')
	set_text(LANG, 'newAdmin', '`>` *ادمين جديد*')
	set_text(LANG, 'newMod', '`>` *مدير جديد*')
	set_text(LANG, 'nowUser', '`>` *در حال حاظر کاربر عادي است.*')
	set_text(LANG, 'modList', '`>` *ليست مديران*')
	set_text(LANG, 'adminList', '`>` *ليست ادمين ها')
	set_text(LANG, 'modEmpty', '*هيچ مديري در اين گروه وجود ندارد .')
	set_text(LANG, 'adminEmpty', '*هيچ ادميني وجود ندارد.*')
	-- id.lua --
	set_text(LANG, 'user', 'کابر')
	set_text(LANG, 'chatName', 'نام گروه')
	set_text(LANG, 'chat', 'گروه')
	-- moderation.lua --
	set_text(LANG, 'kickUser', '`>` کاربر اخراج شد*')
	set_text(LANG, 'banUser', '`>` کابر بن شد و ورودش مسدود شد.*')
	set_text(LANG, 'unbanUser', '`>` اين کاربر در حال حاظر از ليست مسدود ها خارج شد.*')
	set_text(LANG, 'gbanUser', '`>` اين کاربر بن جهاني شد و ورودش براي تمام گروه ها که ربات ادمين ان است مسدود شد*.')
	set_text(LANG, 'ungbanUser', '`>` اين کابر از بن جهاني خارج شد.*')
	set_text(LANG, 'muteUser', '`>` اين کاربر ديگر قادر به چت کردن نيست*')
	set_text(LANG, 'muteChat', '`>` اين گروه در حال حاظر در حالت سکوت قرار دارد*')
	set_text(LANG, 'unmuteUser', '`>` کاربر از ليست سکوت خارج شد و ميتواند صحبت کند.*')
	set_text(LANG, 'unmuteChat', '`>` گروه از حالت سکوت خارج شد و همه کاربران ميتوانند چت کنند*')
	-- commands.lua --
	set_text(LANG, 'commandsT', 'دستور ها')
	set_text(LANG, 'errorNoPlug', 'اين پلاگين وجود ندارد.')
	------------
	-- Usages --
	------------
	-- commands.lua --
	set_text(LANG, 'commands:0', 2)
	set_text(LANG, 'commands:1', '#commands:اين دستور براي ديدن دستورات تمام پلاگين ها ميباشد.')
	set_text(LANG, 'commands:2', '#commands [plugin]: براي گرفتن دستورات يک پلاگين.')
	-- export_gban.lua --
	--	set_text(LANG, 'export_gban:0', 2)
	--	set_text(LANG, 'export_gban:1', '#gbans installer: دريافت ليست بن گلوبال به صورت فايل لوا.')
	--	set_text(LANG, 'export_gban:2', '#gbans list: ليست تمام بن گلوبال ها.')
	-- gban_installer.lua --
	--	set_text(LANG, 'gban_installer:0', 1)
	--	set_text(LANG, 'gban_installer:1', '#install gbans: يکسان سازي بن گلوبال هاي شما و ربات db.')
	-- welcome.lua --
	set_text(LANG, 'welcome:0', 6)
	set_text(LANG, 'welcome:1', '#setwelcome [text for welcome]. شما ميتوانيد با اين دستور متن خوش آمد گويي را تغيير دهيد.')
	set_text(LANG, 'welcome:3', '#getwelcome - دريافت پيام خوش آمد گويي')
	set_text(LANG, 'welcome:5', '#welcome on/off - خاموش يا روشن کردن پيام خوش آمد گويي')
	-- giverank.lua --
	set_text(LANG, 'giverank:0', 6)
	set_text(LANG, 'giverank:1', '#admin (reply): اضافه کردن ادمين با استفاده از ريپلي کردن.')
	set_text(LANG, 'giverank:2', '#admin <user_id>/<user_name>: اضافه کردن ادمين با استفاده از شناسه يا نام کاربري.')
	set_text(LANG, 'giverank:3', '#mod (reply): اضافه کردن مدير با ريپلي.')
	set_text(LANG, 'giverank:4', '#mod <user_id>/<user_name>: اضافه کردن مدير با استفاده از شناسه يا نام کاربري.')
	set_text(LANG, 'giverank:5', '#user (reply): حذف ادمين با استفاده از ريپلي.')
	set_text(LANG, 'giverank:6', '#user <user_id>/<user_name>:حذف ادمين با استفاده از شناسه يا نام کاربري.')
	-- id.lua --
	set_text(LANG, 'id:0', 6)
	set_text(LANG, 'id:1', '#id: دريافت آيدي خود و گروه.')
	set_text(LANG, 'id:2', '#ids chat: دريافت آيدي کاربران گروه.')
	set_text(LANG, 'id:4', '#id <user_name>: دريافت شناسه با استفاده از نام کاربري.')
	set_text(LANG, 'id:5', '#whois <user_id>/<user_name>: دريافت نام کاربري با استفاده از شناسه.')
	set_text(LANG, 'id:6', '#whois (reply): دريافت شناسه با استفاده از ريپلي.')
	-- moderation.lua --
	set_text(LANG, 'moderation:0', 7)
	set_text(LANG, 'moderation:1', '#kick <reply>/<id>/<username>:حذف کاربر با استفاده از ريپلي يا نام کاربري و شناسه.')
	set_text(LANG, 'moderation:2', '#ban <reply>/<id>/<username>: مسدود کردن کاربران و مجاز نبودن ورود دوباره آنها.')
	set_text(LANG, 'moderation:3', '#unban <reply>/<id>/<username>: رفع مسدوديت يک فرد با استفاده از ريپلي نام کاربري و شناسه.')
	set_text(LANG, 'moderation:4', '#gban <reply>/<id>/<username>: بن جهاني فرد با اسفاده از ريپلي ناسه نام کاربري.')
	set_text(LANG, 'moderation:5', '#ungban <reply>/<id>/<username>: رفع مسدوديت يک فرد .')
	set_text(LANG, 'moderation:6', '#mute <reply>/<id>/<username>: سکوت يک فرد با استفاده از ريپلي شناسه نام کاربري.')
	set_text(LANG, 'moderation:7', '#unmute <reply>/<id>/<username>: رفع حالت سکوت يک فرد.')
	-- settings.lua --
	set_text(LANG, 'settings:0', 21)
	set_text(LANG, 'settings:1', '#tgservices on/off: خاموش يا روشن کردن و حذف تمام پيام هاي تلگرام سرويس گذشته.')
	set_text(LANG, 'settings:2', '#invite on/off: خاموش يا روشن کردن و حذف تمام پيام هاي گذشته .')
	set_text(LANG, 'settings:4', '#lang <language (en, es...)>: تغيير زبان ربات')
	---- set_text(LANG, 'settings:5', '#bots on/off: خاموش يا روشن کردن و حذف تمام ربات هاي گروه.')
	set_text(LANG, 'settings:6', '#photos on/off: خاموش کردن يا روشن کردن و حذف تمام عکس هاي اخير.')
	set_text(LANG, 'settings:7', '#videos on/off: خاموش يا روشن کردن و حذف تمام فيلم هاي گذشته.')
	set_text(LANG, 'settings:8', '#stickers on/off: روشن يا خاموش کردن مجاز بودن استيکر .')
	set_text(LANG, 'settings:9', '#gifs on/off: روشن يا خاموش کردن مجاز بودن ارسال عکس متحرک.')
	set_text(LANG, 'settings:10', '#voice on/off: روشن يا خاموش کردن ارسال صداي ضبط شده.')
	set_text(LANG, 'settings:11', '#audios on/off: حذف صدا و اهنگ.')
	set_text(LANG, 'settings:12', '#documents on/off: حذف فايل.')
	set_text(LANG, 'settings:13', '#location on/off:ارسال مکان')
	set_text(LANG, 'settings:14', '#games on/off: شروع کردن بازي .')
	set_text(LANG, 'settings:15', '#spam on/off: هرزنامه.')
	set_text(LANG, 'settings:16', '#floodtime <secs>: تعيين کردن حساسيت زمان فلود.')
	set_text(LANG, 'settings:17', '#maxflood <msgs>: تعيين حساسيت فلود کردن.')
	set_text(LANG, 'settings:18', '#links on/off: ارسال لينک.')
	set_text(LANG, 'settings:19', '#arabic on/off: زبان عربي.')
	set_text(LANG, 'settings:20', '#english on/off: زبان انگليسي.')
	set_text(LANG, 'settings:21', '#emoji on/off: ارسال ايموجي.')
	if matches[1] == 'install' then
	return '`>` زبان فارسي با موفقيت نصب شد.'
	elseif matches[1] == 'update' then
	return '`>` زبان فارسي با موفقيت بروز رساني شد.'
	end
	else
	return "`>` فقط براي سودو ممکن است."
	end
	end
	return {
	patterns = {
	'[!/#](install) (persian_lang)$',
	'[!/#](update) (persian_lang)$'
	},
	run = run
	}
