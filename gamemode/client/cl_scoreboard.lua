local scoreboard = nil
local playerList = nil

surface.CreateFont( "TestFont", {

	font = "Arial",
	size = 20,

})

function GM:ScoreboardShow()

    if !IsValid( scoreboard ) then

        scoreboard = vgui.Create( "DFrame" )
        scoreboard:SetSize( 600, 700 )
        scoreboard:Center()
        scoreboard:SetTitle( "" )
        scoreboard:SetDraggable( false )
        scoreboard:ShowCloseButton( false )
        scoreboard.Paint = function( w, h )

            draw.RoundedBox( 5, 0, 0, scoreboard:GetWide(), scoreboard:GetTall(), Color(0, 0, 0, 100 ) )

        end

        scoreboardLogo = vgui.Create( "DImageButton", scoreboard )
        scoreboardLogo:SetPos( 45, 0 )
        scoreboardLogo:SetImage( "materials/naturescourse/logo_big.png" )
        scoreboardLogo:SetSize( 512, 192 )
        scoreboardLogo.DoClick = function()

            gui.OpenURL( "https://github.com/OsirisRapdantCelestial/naturalselection" )

        end

    end

    playerScroll = vgui.Create( "DScrollPanel", scoreboard )
    playerScroll:SetSize( scoreboard:GetWide() -20 , scoreboard:GetTall() - 215 )
    playerScroll:SetPos( 0, 202 )
    local playerScrollBar = playerScroll:GetVBar()
    function playerScrollBar:Paint( w, h )
    end
    function playerScrollBar.btnUp:Paint( w, h )
    end
    function playerScrollBar.btnDown:Paint( w, h )
    end
    function playerScrollBar.btnGrip:Paint( w, h )
    end

    playerList = vgui.Create( "DListLayout", playerScroll )
    playerList:SetSize( playerScroll:GetWide(), playerScroll:GetTall() )
    playerList:SetPos( 0, 0 )

    if IsValid( scoreboard ) then

        for k,v in pairs( player.GetAll() ) do

                players = vgui.Create( "DPanel", playerList )
                players:SetSize( playerList:GetWide(), 50 )
                players:SetPos( 0, 0 )
                players.Paint = function( w, h )

                if !IsValid(v) then return end

					local plycolor = LocalPlayer().stats[ "Color" ]
					if !plycolor then plycolor = Color(150,150,150) end
					draw.RoundedBox( 0, 30, 0 +10, players:GetWide(), players:GetTall(), plycolor )

                    draw.SimpleText( v:GetName(), "TestFont", 85, 20, Color( 255, 255, 255, 255 ) )

					draw.SimpleText( v:Ping(), "TestFont", 530, 20, Color( 255, 255, 255, 255 ) )

					draw.SimpleText( "Wins: " .. v:GetWins(), "TestFont", 325, 20, Color( 255, 255, 255, 255 ) )

					draw.SimpleText( "Losses: " .. v:GetLosses(), "TestFont", 425, 20, Color( 255, 255, 255, 255 ) )

                end

                playerAvatar = vgui.Create( "AvatarImage", players )
                playerAvatar:SetSize( 32, 32 )
                playerAvatar:SetPos( 40, 14 )
                playerAvatar:SetPlayer( v, 32 )
                playerAvatar:SetMouseInputEnabled( false )

        end

        scoreboard:Show()
        scoreboard:MakePopup()
        scoreboard:SetKeyboardInputEnabled( false )

    end

end

function GM:ScoreboardHide()

    if IsValid( scoreboard ) then

        scoreboard:Hide()
        playerList:Clear()

    end

end
