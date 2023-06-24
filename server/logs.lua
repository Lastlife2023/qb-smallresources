local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['playermoney'] = 'https://discordapp.com/api/webhooks/1097218242570883155/TH15wbUVGMc2nAKq-oPrR1azK9MsslWAcN5w7FNCKFgOmwG2D8eZvOuz2Qm0W-lQ-0t1',
    ['playerinventory'] = 'https://discordapp.com/api/webhooks/1097218337584455710/yim8ia4oG_utIywoye-gRHNvCbR7geeEjKXyYTOOuOwNT2DI3RT-G_zMb3LMHUBCzrGG',
    ['robbing'] = 'https://discordapp.com/api/webhooks/1097218536478351431/2PWoBZe3mN-rgwHx4frNB3O9R0-sNsMDp6Bx7BTnK1-6yKhL73yHxgtg_9LNSR4YCXmA',
    ['cuffing'] = '',
    ['drop'] = 'https://discordapp.com/api/webhooks/1097218602307964969/gAuz7NFCF2n9vGAJCjlNAJanX_8rwNZhZqodmJci14X4DvxdJH6RCPhSy1TNAM4uey05',
    ['trunk'] = 'https://discordapp.com/api/webhooks/1097210797865832498/6gu_ij-W76Bb_vdjImqN7g0FvH_3OCPv2uJAWlKYMqc3_4PgFU1nCzZay6v94ivWFfrN',
    ['stash'] = 'https://discordapp.com/api/webhooks/1097210797865832498/6gu_ij-W76Bb_vdjImqN7g0FvH_3OCPv2uJAWlKYMqc3_4PgFU1nCzZay6v94ivWFfrN',
    ['glovebox'] = 'https://discordapp.com/api/webhooks/1097210797865832498/6gu_ij-W76Bb_vdjImqN7g0FvH_3OCPv2uJAWlKYMqc3_4PgFU1nCzZay6v94ivWFfrN',
    ['banking'] = '',
    ['vehicleshop'] = '',
    ['vehicleupgrades'] = '',
    ['shops'] = 'https://discordapp.com/api/webhooks/1097218128993337545/-rJ9w9i_Il1zv2dqvXqiZjrwhu7U9BJTVsPJ17FbzkWslG65nkaNkl1TxvlOygh1X2pL',
    ['dealers'] = '',
    ['storerobbery'] = 'https://discordapp.com/api/webhooks/1097218757358792734/dmmHKtIg6D2eLfF3XsgsENVNK_cpCyEFi8_uM68Hd18FcWrM8b0E6I1zGWn2P2GYBUOs',
    ['bankrobbery'] = 'https://discordapp.com/api/webhooks/1097218757358792734/dmmHKtIg6D2eLfF3XsgsENVNK_cpCyEFi8_uM68Hd18FcWrM8b0E6I1zGWn2P2GYBUOs',
    ['powerplants'] = '',
    ['death'] = 'https://discordapp.com/api/webhooks/1097218434200244368/vQvsUF1R-T_jbK0FmCn9tkGvWwW2zhRNFzz8bv0tQ3oAvrLyWl27NENGN5PNUAvatAiD',
    ['joinleave'] = '',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = '',
    ['anticheat'] = '',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ['robbery'] = 'https://discordapp.com/api/webhooks/1097218757358792734/dmmHKtIg6D2eLfF3XsgsENVNK_cpCyEFi8_uM68Hd18FcWrM8b0E6I1zGWn2P2GYBUOs',
    ['casino'] = '',
    ['traphouse'] = 'https://discordapp.com/api/webhooks/1097218944651239484/LPd7WpKPfmX_BrODDizp51zC22bmaRB4MkWGr7Vkj1BiLDtrOFT5-WJi10J5mSr0FzAh',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ['qbjobs'] = '',
    ['registry'] = 'https://discord.com/api/webhooks/1100500385711525958/cd2WyRIZpc5ySUr9TXd0m9q_RyQQ4bqmsYtcxTgcJ44Nr2p_BVN2LrbkQ6TOWCQAF7AZ',
    -- Added Logs:
    ['hunting'] = '',
    ['commands'] = 'https://discord.com/api/webhooks/1104591162616070154/vvlB2gHisZUClKmzenVLpvBdrAiK8p7WcdACwHRHP4wZQVEDS1HtycqxtVHL1uoKwAFe'
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

local logQueue = {}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Lastlife',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1082812097185984563/1082812405236629586/logo.png',
            },
        }
    }

    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name]+1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        local postData = { username = 'Lastlife', embeds = {}}

        for i = 1, #logQueue[name] do
            postData.embeds[#postData.embeds+1] = logQueue[name][i].data[1]
        end
    end

    PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })

    logQueue[name] = {}

    CreateThread(function ()
        local timer = 0
        while true do
            Wait(1000)
            timer = timer + 1
            if timer >= 60 then -- If 60 seconds have passed, post the logs
                timer = 0
                for name, queue in pairs(logQueue) do
                    if #queue > 0 then
                        local postData = { username = 'Lastlife', embeds = {} }
                        for i = 1, #queue do
                            postData.embeds[#postData.embeds+1] = queue[i].data[1]
                        end
                        PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
                        logQueue[name] = {}
                    end
                end
            end
        end
    end)
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
