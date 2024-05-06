local function OpenCharacterCreationMenu()
    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
    frame:SetPos(ScrW() / 3 - (ScrW() * 0.2) / 3, ScrH() / 3 - (ScrH() * 0.2) / 2)
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:SetTitle("")
    frame:MakePopup()

    local firstName = ""
    local lastName = ""

    frame.Paint = function(self, w, h)
        draw.RoundedBoxEx(20, 0, 0, w, h, Color(237, 211, 129), true, true, true, true) 
        
        self.lblTitle:SetColor(Color(0, 0, 0)) 
        self.lblTitle:SetFont("DermaLarge") 

        local text = "Création de personnage"
        surface.SetFont("DermaLarge")
        local textWidth, textHeight = surface.GetTextSize(text)
        local textX = (w - textWidth) / 2
        local textY = 25 
        draw.SimpleTextOutlined(text, "DermaLarge", textX, textY, Color(0, 0, 0), 5, 5, 2, Color(255, 255, 255))

        draw.RoundedBox(400, 350, 200, w - 700, 50, Color(30, 30, 30))
        draw.RoundedBox(400, 350, 350, w - 700, 50, Color(30, 30, 30))

        local firstNameLabel = "Prénom"
        local firstNameLabelWidth = surface.GetTextSize(firstNameLabel)
        local firstNameLabelX = (w - 700) / 2 + 290
        local firstNameLabelY = 180
        draw.SimpleTextOutlined(firstNameLabel, "DermaLarge", firstNameLabelX, firstNameLabelY - 20, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
        
        local lastNameLabel = "Nom de famille"
        local lastNameLabelWidth = surface.GetTextSize(lastNameLabel)
        local lastNameLabelX = (w - 700) / 2 + 250
        local lastNameLabelY = 330
        draw.SimpleTextOutlined(lastNameLabel, "DermaLarge", lastNameLabelX, lastNameLabelY - 20, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
        
        -- LOGO SERVER
        local logoWidth = 120
        surface.SetDrawColor(255, 255, 255) 
        surface.SetMaterial(Material("materials/devramba/logo.png")) 
        surface.DrawTexturedRect((w - logoWidth) / 46, h * 0.01, logoWidth, logoWidth)
    end

    local firstNameEntry = vgui.Create("DTextEntry", frame)
    firstNameEntry:SetSize(frame:GetWide() - 1, 50)
    firstNameEntry:SetPos((frame:GetWide() - (frame:GetWide() - 920)) / 2 + 1, 200)
    firstNameEntry:SetText("")
    firstNameEntry:SetPlaceholderText("Entrez votre prénom")
    firstNameEntry:SetDrawBackground(false)
    firstNameEntry:SetFont("DermaDefaultBold")
    firstNameEntry:SetTextColor(Color(255, 255, 255))
    firstNameEntry.OnTextChanged = function(self)
        firstName = self:GetText()
    end
    
    local firstNamePlaceholderText = "Entrez votre prénom"
    local firstNamePlaceholderTextWidth = surface.GetTextSize(firstNamePlaceholderText)
    local firstNamePlaceholderX = (firstNameEntry:GetWide() - firstNamePlaceholderTextWidth) / 2
    
    firstNameEntry.Paint = function(self, w, h)
        draw.SimpleTextOutlined(firstNamePlaceholderText, "DermaDefaultBold", firstNamePlaceholderX, -20, Color(150, 150, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
        self:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 0), Color(255, 255, 255))
    end
    
    local lastNameEntry = vgui.Create("DTextEntry", frame)
    lastNameEntry:SetSize(frame:GetWide() - 1, 50)
    lastNameEntry:SetPos((frame:GetWide() - (frame:GetWide() - 900)) / 2, 350)
    lastNameEntry:SetText("")
    lastNameEntry:SetPlaceholderText("Entrez votre nom de famille")
    lastNameEntry:SetDrawBackground(false)
    lastNameEntry:SetFont("DermaDefaultBold")
    lastNameEntry:SetTextColor(Color(255, 255, 255))
    lastNameEntry.OnTextChanged = function(self)
        lastName = self:GetText()
    end
    
    local lastNamePlaceholderText = "Entrez votre nom de famille"
    local lastNamePlaceholderTextWidth = surface.GetTextSize(lastNamePlaceholderText)
    local lastNamePlaceholderX = (lastNameEntry:GetWide() - lastNamePlaceholderTextWidth) / 2
    
    lastNameEntry.Paint = function(self, w, h)
        draw.SimpleTextOutlined(lastNamePlaceholderText, "DermaDefaultBold", lastNamePlaceholderX, -20, Color(150, 150, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
        self:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 0), Color(255, 255, 255))
    end
    
    local function ValidateTextFields()
        if firstName ~= "" and lastName ~= "" then
            frame:Close()
            RunConsoleCommand("say", "/rpname " .. firstName .. " " .. lastName)
        else
            print("Veuillez remplir tous les champs!")
        end
    end
    
    hook.Add("PlayerInitialSpawn", "OpenCharacterCreationMenuOnFirstJoin", function(ply)
        if not IsValid(ply) then return end
        OpenCharacterCreationMenu()
    end)

    local validateButton = vgui.Create("DButton", frame)
    validateButton:SetSize(100, 100)
    validateButton:SetPos((frame:GetWide() - 150) / 2, 438)
    validateButton:SetText("")
    validateButton.Paint = function(self, w, h)
        surface.SetMaterial(Material("materials/devramba/iconplay.png"))
        surface.DrawTexturedRect(0, 0, w, h)
    end
    validateButton.DoClick = ValidateTextFields

    local discordButton = vgui.Create("DButton", frame)
    discordButton:SetSize(50, 50)
    discordButton:SetPos(frame:GetWide() / 1.1 + 30, frame:GetTall() * 0.9) 
    discordButton:SetText("")
    discordButton.Paint = function(self, w, h)
        surface.SetMaterial(Material("materials/devramba/discord-icon.png"))
        surface.DrawTexturedRect(0, 0, w, h)
    end
    discordButton.DoClick = function()
        gui.OpenURL("https://discord.gg/6mdP36PK") 
    end
end

concommand.Add("open_char_menu", OpenCharacterCreationMenu)
