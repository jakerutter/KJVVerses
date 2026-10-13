-- KJVVerses v2.4 - World of Warcraft Classic Era
local ADDON_NAME = "KJVVerses"
local DEFAULT_ROTATION_INTERVAL = 120
local ROTATION_OPTIONS = {30, 60, 120, 300, 600}
local PADDING = 15
local MIN_WIDTH, MAX_WIDTH = 250, 900
local MIN_HEIGHT, MAX_HEIGHT = 60, 350
local MIN_FONT_SIZE, MAX_FONT_SIZE = 10, 30

-- Light colors selected for readability over dark game backgrounds.
-- The Scripture reference always stays gold.
local TEXT_COLORS = {
    { name = "White",      hex = "FFFFFF" },
    { name = "Warm White", hex = "FFF1D6" },
    { name = "Gold",       hex = "FFD700" },
    { name = "Light Blue", hex = "86CEFA" },
    { name = "Light Green",hex = "98E6A3" },
    { name = "Soft Yellow",hex = "FFF59A" }
}

local function FindTextColor(name)
    for _, color in ipairs(TEXT_COLORS) do
        if color.name == name then return color end
    end
    return TEXT_COLORS[1]
end

local verses = {
    { reference = "John 14:6", text = "Jesus saith unto him, I am the way, the truth, and the life: no man cometh unto the Father, but by me." },
    { reference = "John 3:16", text = "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life." },
    { reference = "Matthew 11:28", text = "Come unto me, all ye that labour and are heavy laden, and I will give you rest." },
    { reference = "John 8:12", text = "Then spake Jesus again unto them, saying, I am the light of the world: he that followeth me shall not walk in darkness, but shall have the light of life." },
    { reference = "Matthew 22:39", text = "And the second is like unto it, Thou shalt love thy neighbour as thyself." },
    { reference = "John 13:34", text = "A new commandment I give unto you, That ye love one another; as I have loved you, that ye also love one another." },
    { reference = "Matthew 6:33", text = "But seek ye first the kingdom of God, and his righteousness; and all these things shall be added unto you." },
    { reference = "John 14:15", text = "If ye love me, keep my commandments." },
    { reference = "Matthew 5:14", text = "Ye are the light of the world. A city that is set on an hill cannot be hid." },
    { reference = "Luke 9:23", text = "And he said to them all, If any man will come after me, let him deny himself, and take up his cross daily, and follow me." },
    { reference = "Matthew 28:19-20", text = "Go ye therefore, and teach all nations, baptizing them in the name of the Father, and of the Son, and of the Holy Ghost: Teaching them to observe all things whatsoever I have commanded you: and, lo, I am with you alway, even unto the end of the world. Amen." },
    { reference = "Philippians 4:13", text = "I can do all things through Christ which strengtheneth me." },
    { reference = "Proverbs 3:5", text = "Trust in the LORD with all thine heart; and lean not unto thine own understanding." },
    { reference = "Joshua 1:9", text = "Have not I commanded thee? Be strong and of a good courage; be not afraid, neither be thou dismayed: for the LORD thy God is with thee whithersoever thou goest." },
    { reference = "Romans 12:2", text = "And be not conformed to this world: but be ye transformed by the renewing of your mind, that ye may prove what is that good, and acceptable, and perfect, will of God." },
    { reference = "Psalm 119:105", text = "Thy word is a lamp unto my feet, and a light unto my path." },
    { reference = "Galatians 5:22-23", text = "But the fruit of the Spirit is love, joy, peace, longsuffering, gentleness, goodness, faith, Meekness, temperance: against such there is no law." },
    { reference = "Ephesians 2:8-9", text = "For by grace are ye saved through faith; and that not of yourselves: it is the gift of God: Not of works, lest any man should boast." },
    { reference = "1 Thessalonians 5:16-18", text = "Rejoice evermore. Pray without ceasing. In every thing give thanks: for this is the will of God in Christ Jesus concerning you." },
    { reference = "Micah 6:8", text = "He hath shewed thee, O man, what is good; and what doth the LORD require of thee, but to do justly, and to love mercy, and to walk humbly with thy God?" },
    { reference = "Genesis 1:1", text = "In the beginning God created the heaven and the earth." },
    { reference = "Psalm 23:1", text = "The LORD is my shepherd; I shall not want." },
    { reference = "Psalm 27:1", text = "The LORD is my light and my salvation; whom shall I fear? the LORD is the strength of my life; of whom shall I be afraid?" },
    { reference = "Psalm 34:8", text = "O taste and see that the LORD is good: blessed is the man that trusteth in him." },
    { reference = "Psalm 37:4", text = "Delight thyself also in the LORD; and he shall give thee the desires of thine heart." },
    { reference = "Psalm 46:1", text = "God is our refuge and strength, a very present help in trouble." },
    { reference = "Psalm 46:10", text = "Be still, and know that I am God: I will be exalted among the heathen, I will be exalted in the earth." },
    { reference = "Psalm 56:3", text = "What time I am afraid, I will trust in thee." },
    { reference = "Psalm 118:24", text = "This is the day which the LORD hath made; we will rejoice and be glad in it." },
    { reference = "Psalm 121:2", text = "My help cometh from the LORD, which made heaven and earth." },
    { reference = "Proverbs 3:6", text = "In all thy ways acknowledge him, and he shall direct thy paths." },
    { reference = "Proverbs 16:3", text = "Commit thy works unto the LORD, and thy thoughts shall be established." },
    { reference = "Isaiah 40:31", text = "But they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint." },
    { reference = "Isaiah 41:10", text = "Fear thou not; for I am with thee: be not dismayed; for I am thy God: I will strengthen thee; yea, I will help thee; yea, I will uphold thee with the right hand of my righteousness." },
    { reference = "Jeremiah 29:11", text = "For I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil, to give you an expected end." },
    { reference = "Matthew 5:16", text = "Let your light so shine before men, that they may see your good works, and glorify your Father which is in heaven." },
    { reference = "Matthew 7:7", text = "Ask, and it shall be given you; seek, and ye shall find; knock, and it shall be opened unto you:" },
    { reference = "Matthew 19:26", text = "But Jesus beheld them, and said unto them, With men this is impossible; but with God all things are possible." },
    { reference = "Mark 10:27", text = "And Jesus looking upon them saith, With men it is impossible, but not with God: for with God all things are possible." },
    { reference = "Luke 6:31", text = "And as ye would that men should do to you, do ye also to them likewise." },
    { reference = "John 10:11", text = "I am the good shepherd: the good shepherd giveth his life for the sheep." },
    { reference = "John 11:25", text = "Jesus said unto her, I am the resurrection, and the life: he that believeth in me, though he were dead, yet shall he live:" },
    { reference = "Romans 5:8", text = "But God commendeth his love toward us, in that, while we were yet sinners, Christ died for us." },
    { reference = "Romans 8:28", text = "And we know that all things work together for good to them that love God, to them who are the called according to his purpose." },
    { reference = "Romans 10:9", text = "That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved." },
    { reference = "2 Timothy 1:7", text = "For God hath not given us the spirit of fear; but of power, and of love, and of a sound mind." },
    { reference = "Hebrews 11:1", text = "Now faith is the substance of things hoped for, the evidence of things not seen." },
    { reference = "James 1:5", text = "If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him." },
    { reference = "1 Peter 5:7", text = "Casting all your care upon him; for he careth for you." },
    { reference = "Revelation 3:20", text = "Behold, I stand at the door, and knock: if any man hear my voice, and open the door, I will come in to him, and will sup with him, and he with me." }
}

local function Defaults()
    return {
        x = 0, y = (UIParent:GetHeight() / 2) - 100,
        width = 500, height = 100, opacity = 0.35,
        fontSize = 16, textColor = "White", visible = true, rotationInterval = DEFAULT_ROTATION_INTERVAL
    }
end

local function Clamp(n, low, high)
    return math.max(low, math.min(high, n))
end

local function InitializeSettings()
    local defaults = Defaults()
    if type(KJVVersesDB) ~= "table" then KJVVersesDB = {} end
    for key, value in pairs(defaults) do
        if type(KJVVersesDB[key]) ~= type(value) then KJVVersesDB[key] = value end
    end
    KJVVersesDB.width = Clamp(KJVVersesDB.width, MIN_WIDTH, MAX_WIDTH)
    KJVVersesDB.height = Clamp(KJVVersesDB.height, MIN_HEIGHT, MAX_HEIGHT)
    KJVVersesDB.opacity = Clamp(KJVVersesDB.opacity, 0, 1)
    KJVVersesDB.fontSize = Clamp(KJVVersesDB.fontSize, MIN_FONT_SIZE, MAX_FONT_SIZE)
    KJVVersesDB.textColor = FindTextColor(KJVVersesDB.textColor).name
    local validInterval = false
    for _, interval in ipairs(ROTATION_OPTIONS) do
        if KJVVersesDB.rotationInterval == interval then validInterval = true; break end
    end
    if not validInterval then KJVVersesDB.rotationInterval = DEFAULT_ROTATION_INTERVAL end
end

local currentVerse = math.random(1, #verses)
local paused = false -- Pause state is session-only; reload resumes rotation.
local rotationTimer
local editMode = false
local verseFrame, verseText, background, resizeHandle, configFrame
local lockButton, pauseButton, intervalButton, colorButton
local sliders = {}
local borderTextures = {}

local function PrintMessage(message)
    print("|cFFFFD700KJVVerses:|r " .. message)
end

local function ApplyPosition()
    verseFrame:ClearAllPoints()
    verseFrame:SetPoint("CENTER", UIParent, "CENTER", KJVVersesDB.x, KJVVersesDB.y)
end

local function SavePosition()
    local x, y = verseFrame:GetCenter()
    local parentX, parentY = UIParent:GetCenter()
    if x and y and parentX and parentY then
        KJVVersesDB.x, KJVVersesDB.y = x - parentX, y - parentY
        ApplyPosition()
    end
end

local function ApplyOpacity()
    background:SetColorTexture(0, 0, 0, KJVVersesDB.opacity)
end

local function UpdateVerseLayout()
    if not verseFrame or not verseText then return end
    verseFrame:SetWidth(KJVVersesDB.width)
    verseText:SetWidth(KJVVersesDB.width - (2 * PADDING))
    local neededHeight = verseText:GetStringHeight() + (2 * PADDING)
    verseFrame:SetHeight(math.max(KJVVersesDB.height, neededHeight))
end

local function ApplyFontSize()
    local path, _, flags = verseText:GetFont()
    if not path then path = "Fonts\\FRIZQT__.TTF" end
    verseText:SetFont(path, KJVVersesDB.fontSize, flags or "")
    UpdateVerseLayout()
end

local function UpdateVerse()
    local verse = verses[currentVerse]
    local color = FindTextColor(KJVVersesDB.textColor)
    verseText:SetText("|cFFFFD700" .. verse.reference .. "|r - |cFF" .. color.hex .. verse.text .. "|r")
    UpdateVerseLayout()
end

local ResetVerseTimer
ResetVerseTimer = function()
    if rotationTimer then
        rotationTimer:Cancel()
        rotationTimer = nil
    end
    if paused then return end
    rotationTimer = C_Timer.NewTimer(KJVVersesDB.rotationInterval, function()
        rotationTimer = nil
        currentVerse = (currentVerse % #verses) + 1
        UpdateVerse()
        ResetVerseTimer()
    end)
end

local function ChangeVerse(direction)
    currentVerse = ((currentVerse - 1 + direction) % #verses) + 1
    UpdateVerse()
    ResetVerseTimer() -- Only schedules when not paused.
end

local function RefreshPauseButton()
    if pauseButton then
        pauseButton:SetText(paused and "Resume Rotation" or "Pause Rotation")
    end
end

local function SetPaused(value)
    if paused == value then
        PrintMessage(paused and "Rotation is already paused." or "Rotation is already running.")
        return
    end
    paused = value
    ResetVerseTimer()
    RefreshPauseButton()
    PrintMessage(paused and "Automatic rotation paused." or ("Rotation resumed; next verse in " .. KJVVersesDB.rotationInterval .. " seconds."))
end

local function ShowVersePanel()
    KJVVersesDB.visible = true
    verseFrame:Show()
end

local function HideVersePanel()
    KJVVersesDB.visible = false
    verseFrame:Hide()
end

local function RefreshLockButton()
    if lockButton then lockButton:SetText(editMode and "Lock Panel" or "Unlock Panel") end
end

local function SetEditMode(enabled)
    editMode = enabled
    verseFrame:EnableMouse(enabled)
    for _, edge in ipairs(borderTextures) do
        if enabled then edge:Show() else edge:Hide() end
    end
    if enabled then
        ShowVersePanel()
        resizeHandle:Show()
    else
        resizeHandle:Hide()
    end
    RefreshLockButton()
    PrintMessage(enabled and "Panel unlocked. Drag it or resize using the gold corner." or "Panel locked.")
end

local function FormatInterval(seconds)
    if seconds < 60 then return seconds .. " seconds" end
    return (seconds / 60) .. (seconds == 60 and " minute" or " minutes")
end

local function RefreshIntervalButton()
    if intervalButton then
        intervalButton:SetText("Rotation: " .. FormatInterval(KJVVersesDB.rotationInterval))
    end
end

local function SetRotationInterval(seconds)
    for _, allowed in ipairs(ROTATION_OPTIONS) do
        if seconds == allowed then
            if KJVVersesDB.rotationInterval ~= seconds then
                KJVVersesDB.rotationInterval = seconds
                ResetVerseTimer()
            end
            RefreshIntervalButton()
            return true
        end
    end
    return false
end

-- The color selector cycles through the six readable presets.
local function RefreshColorButton()
    if colorButton then
        colorButton:SetText("Text Color: " .. KJVVersesDB.textColor)
    end
end

local function SetTextColor(name)
    KJVVersesDB.textColor = FindTextColor(name).name
    UpdateVerse()
    RefreshColorButton()
end

local function RefreshSliders()
    if sliders.width then sliders.width:SetValue(KJVVersesDB.width) end
    if sliders.height then sliders.height:SetValue(KJVVersesDB.height) end
    if sliders.opacity then sliders.opacity:SetValue(math.floor(KJVVersesDB.opacity * 100 + 0.5)) end
    if sliders.fontSize then sliders.fontSize:SetValue(KJVVersesDB.fontSize) end
end

local function CreateSlider(parent, label, minValue, maxValue, step, initialValue, yOffset, onChange)
    local slider = CreateFrame("Slider", nil, parent)
    slider:SetOrientation("HORIZONTAL")
    slider:SetSize(265, 18)
    slider:SetPoint("TOP", parent, "TOP", 0, yOffset)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValueStep(step)

    local track = slider:CreateTexture(nil, "BACKGROUND")
    track:SetPoint("LEFT", slider, "LEFT")
    track:SetPoint("RIGHT", slider, "RIGHT")
    track:SetHeight(6)
    track:SetColorTexture(0.25, 0.25, 0.25, 1)
    slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
    slider:GetThumbTexture():SetSize(24, 24)

    local labelText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelText:SetPoint("BOTTOM", slider, "TOP", 0, 8)

    local lowText = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lowText:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, -5)
    lowText:SetText(tostring(minValue))

    local highText = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    highText:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 0, -5)
    highText:SetText(tostring(maxValue))

    slider:SetScript("OnValueChanged", function(self, value)
        value = Clamp(math.floor(value / step + 0.5) * step, minValue, maxValue)
        labelText:SetText(label .. ": " .. tostring(value))
        onChange(value)
    end)
    slider:SetValue(initialValue)
    return slider
end

local function CreateVersePanel()
    verseFrame = CreateFrame("Frame", "KJVVersesPanel", UIParent)
    verseFrame:SetSize(KJVVersesDB.width, KJVVersesDB.height)
    verseFrame:SetFrameStrata("MEDIUM")
    verseFrame:SetMovable(true)
    verseFrame:EnableMouse(false)
    verseFrame:RegisterForDrag("LeftButton")
    ApplyPosition()

    background = verseFrame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(verseFrame)
    ApplyOpacity()

    verseText = verseFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    verseText:SetPoint("CENTER", verseFrame, "CENTER")
    verseText:SetJustifyH("CENTER")
    verseText:SetJustifyV("MIDDLE")
    verseText:SetTextColor(1, 1, 1)
    verseText:SetWidth(KJVVersesDB.width - 2 * PADDING)
    ApplyFontSize()

    -- Four clearly visible gold edges only while unlocked.
    local function AddBorderEdge(point1, point2, width, height)
        local edge = verseFrame:CreateTexture(nil, "BORDER")
        edge:SetColorTexture(1, 0.75, 0.18, 0.95)
        edge:SetPoint(point1, verseFrame, point1)
        edge:SetPoint(point2, verseFrame, point2)
        if width then edge:SetWidth(width) end
        if height then edge:SetHeight(height) end
        edge:Hide()
        table.insert(borderTextures, edge)
    end
    AddBorderEdge("TOPLEFT", "TOPRIGHT", nil, 2)
    AddBorderEdge("BOTTOMLEFT", "BOTTOMRIGHT", nil, 2)
    AddBorderEdge("TOPLEFT", "BOTTOMLEFT", 2, nil)
    AddBorderEdge("TOPRIGHT", "BOTTOMRIGHT", 2, nil)

    verseFrame:SetScript("OnDragStart", function(self)
        if editMode then self:StartMoving() end
    end)
    verseFrame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        SavePosition()
    end)

    resizeHandle = CreateFrame("Frame", nil, verseFrame)
    resizeHandle:SetSize(30, 30)
    resizeHandle:SetPoint("BOTTOMRIGHT", verseFrame, "BOTTOMRIGHT")
    resizeHandle:EnableMouse(true)
    resizeHandle:SetFrameLevel(verseFrame:GetFrameLevel() + 5)

    local gripBg = resizeHandle:CreateTexture(nil, "BACKGROUND")
    gripBg:SetAllPoints(resizeHandle)
    gripBg:SetColorTexture(0.18, 0.14, 0.04, 0.9)

    local grip = resizeHandle:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    grip:SetPoint("CENTER")
    grip:SetText("\\")
    grip:SetTextColor(1, 0.8, 0.25)
    -- Three diagonal strokes give the corner a grip appearance.
    local function GripStroke(offset)
        local stroke = resizeHandle:CreateTexture(nil, "ARTWORK")
        stroke:SetColorTexture(1, 0.8, 0.25, 1)
        stroke:SetSize(3, 3)
        stroke:SetPoint("BOTTOMRIGHT", resizeHandle, "BOTTOMRIGHT", -5 - offset, 5)
    end
    GripStroke(0)
    GripStroke(6)
    GripStroke(12)

    local resizing, startX, startY, startWidth, startHeight = false
    local function StopResize()
        if not resizing then return end
        resizing = false
        KJVVersesDB.width = math.floor(KJVVersesDB.width + 0.5)
        KJVVersesDB.height = math.floor(KJVVersesDB.height + 0.5)
        UpdateVerseLayout()
        RefreshSliders()
    end

    resizeHandle:SetScript("OnMouseDown", function(self, button)
        if button ~= "LeftButton" or not editMode then return end
        resizing = true
        local scale = UIParent:GetEffectiveScale()
        startX, startY = GetCursorPosition()
        startX, startY = startX / scale, startY / scale
        startWidth, startHeight = KJVVersesDB.width, KJVVersesDB.height
    end)
    resizeHandle:SetScript("OnUpdate", function()
        if not resizing then return end
        if not IsMouseButtonDown("LeftButton") then
            StopResize()
            return
        end
        local scale = UIParent:GetEffectiveScale()
        local x, y = GetCursorPosition()
        x, y = x / scale, y / scale
        KJVVersesDB.width = Clamp(startWidth + (x - startX), MIN_WIDTH, MAX_WIDTH)
        KJVVersesDB.height = Clamp(startHeight + (startY - y), MIN_HEIGHT, MAX_HEIGHT)
        UpdateVerseLayout()
    end)
    resizeHandle:SetScript("OnMouseUp", StopResize)
    resizeHandle:Hide()

    if KJVVersesDB.visible then verseFrame:Show() else verseFrame:Hide() end
end

local function CreateSettingsWindow()
    configFrame = CreateFrame("Frame", "KJVVersesConfig", UIParent)
    configFrame:SetSize(370, 625)
    configFrame:SetPoint("CENTER")
    configFrame:SetFrameStrata("DIALOG")
    configFrame:SetMovable(true)
    configFrame:EnableMouse(true)
    configFrame:RegisterForDrag("LeftButton")

    local bg = configFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(configFrame)
    bg:SetColorTexture(0.06, 0.06, 0.08, 0.96)

    local title = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -20)
    title:SetText("KJV Verses Settings")

    configFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    configFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    local closeButton = CreateFrame("Button", nil, configFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", configFrame, "TOPRIGHT", -3, -3)
    closeButton:SetScript("OnClick", function() configFrame:Hide() end)

    sliders.width = CreateSlider(configFrame, "Panel Width", MIN_WIDTH, MAX_WIDTH, 10,
        KJVVersesDB.width, -90, function(value)
            KJVVersesDB.width = value
            UpdateVerseLayout()
        end)

    sliders.height = CreateSlider(configFrame, "Minimum Height", MIN_HEIGHT, MAX_HEIGHT, 10,
        KJVVersesDB.height, -168, function(value)
            KJVVersesDB.height = value
            UpdateVerseLayout()
        end)

    sliders.opacity = CreateSlider(configFrame, "Background Opacity %", 0, 100, 5,
        math.floor(KJVVersesDB.opacity * 100 + 0.5), -246, function(value)
            KJVVersesDB.opacity = value / 100
            ApplyOpacity()
        end)

    sliders.fontSize = CreateSlider(configFrame, "Font Size", MIN_FONT_SIZE, MAX_FONT_SIZE, 1,
        KJVVersesDB.fontSize, -324, function(value)
            KJVVersesDB.fontSize = value
            ApplyFontSize()
        end)

    -- Scripture text color selector; reference remains gold.
    local colorLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    colorLabel:SetPoint("TOP", configFrame, "TOP", 0, -396)
    colorLabel:SetText("Scripture text color")

    colorButton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
    colorButton:SetSize(220, 28)
    colorButton:SetPoint("TOP", configFrame, "TOP", 0, -414)
    colorButton:SetScript("OnClick", function()
        local nextIndex = 1
        for i, color in ipairs(TEXT_COLORS) do
            if color.name == KJVVersesDB.textColor then
                nextIndex = (i % #TEXT_COLORS) + 1
                break
            end
        end
        SetTextColor(TEXT_COLORS[nextIndex].name)
    end)
    RefreshColorButton()

    -- Rotation interval selector; cycles through preset values.
    local intervalLabel = configFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    intervalLabel:SetPoint("TOP", configFrame, "TOP", 0, -472)
    intervalLabel:SetText("Verse rotation interval")

    intervalButton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
    intervalButton:SetSize(220, 28)
    intervalButton:SetPoint("TOP", configFrame, "TOP", 0, -490)
    intervalButton:SetScript("OnClick", function()
        local nextIndex = 1
        for i, seconds in ipairs(ROTATION_OPTIONS) do
            if seconds == KJVVersesDB.rotationInterval then
                nextIndex = (i % #ROTATION_OPTIONS) + 1
                break
            end
        end
        SetRotationInterval(ROTATION_OPTIONS[nextIndex])
    end)
    RefreshIntervalButton()

    lockButton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
    lockButton:SetSize(145, 28)
    lockButton:SetPoint("BOTTOMLEFT", configFrame, "BOTTOMLEFT", 30, 48)
    lockButton:SetScript("OnClick", function() SetEditMode(not editMode) end)

    pauseButton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
    pauseButton:SetSize(145, 28)
    pauseButton:SetPoint("BOTTOMRIGHT", configFrame, "BOTTOMRIGHT", -30, 48)
    pauseButton:SetScript("OnClick", function() SetPaused(not paused) end)

    local hint = configFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hint:SetPoint("BOTTOM", 0, 18)
    hint:SetText("Changes save automatically. /kjv help for commands.")

    configFrame:SetScript("OnShow", function()
        RefreshSliders()
        RefreshLockButton()
        RefreshPauseButton()
        RefreshIntervalButton()
        RefreshColorButton()
    end)
    RefreshLockButton()
    RefreshPauseButton()
    configFrame:Hide()
end

local function OpenSettings() configFrame:Show() end
local function ToggleSettings()
    if configFrame:IsShown() then configFrame:Hide() else OpenSettings() end
end

local function ResetSettings()
    local defaults = Defaults()
    for key, value in pairs(defaults) do
        if key ~= "visible" and key ~= "rotationInterval" then KJVVersesDB[key] = value end
    end
    ApplyPosition()
    ApplyOpacity()
    ApplyFontSize()
    RefreshSliders()
    RefreshColorButton()
    UpdateVerse()
    PrintMessage("Panel layout and appearance restored to defaults.")
end

local function PrintHelp()
    PrintMessage("Available commands:")
    print("  /kjv - Toggle settings window")
    print("  /kjv config - Open settings")
    print("  /kjv next | prev - Change verse (reset timer when running)")
    print("  /kjv pause | resume - Stop or restart automatic rotation")
    print("  /kjv interval 30|60|120|300|600 - Rotation interval in seconds")
    print("  /kjv show | hide - Show or hide the verse panel")
    print("  /kjv unlock | lock - Enable or disable moving and resizing")
    print("  /kjv reset - Show reset instructions")
    print("  /kjv reset confirm - Restore panel appearance and position")
    print("  /kjv help - Show this help")
end

SLASH_KJVVERSES1 = "/kjv"
SlashCmdList["KJVVERSES"] = function(message)
    local command, argument = message:lower():match("^%s*(%S*)%s*(.-)%s*$")
    command, argument = command or "", argument or ""
    if command == "" then
        ToggleSettings()
    elseif command == "config" or command == "settings" then
        OpenSettings()
    elseif command == "next" then
        ChangeVerse(1)
    elseif command == "prev" or command == "previous" then
        ChangeVerse(-1)
    elseif command == "interval" then
        local seconds = tonumber(argument)
        if seconds and SetRotationInterval(seconds) then
            PrintMessage("Rotation interval: " .. FormatInterval(seconds) .. ".")
        else
            PrintMessage("Choose /kjv interval 30, 60, 120, 300, or 600 (seconds).")
        end
    elseif command == "pause" then
        SetPaused(true)
    elseif command == "resume" then
        SetPaused(false)
    elseif command == "show" then
        ShowVersePanel()
        PrintMessage("Verse panel shown.")
    elseif command == "hide" then
        HideVersePanel()
        PrintMessage("Verse panel hidden.")
    elseif command == "unlock" then
        SetEditMode(true)
    elseif command == "lock" then
        SetEditMode(false)
    elseif command == "reset" then
        if argument == "confirm" then
            ResetSettings()
        else
            PrintMessage("Type /kjv reset confirm to restore the default panel layout.")
        end
    elseif command == "help" then
        PrintHelp()
    else
        PrintMessage("Unknown command. Type /kjv help.")
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, addon)
    if addon ~= ADDON_NAME then return end
    InitializeSettings()
    CreateVersePanel()
    CreateSettingsWindow()
    UpdateVerse()
    ResetVerseTimer()
    self:UnregisterEvent("ADDON_LOADED")
    -- Only greet once per installation; existing users see no repeated startup spam.
    if not KJVVersesDB.welcomeShown then
        PrintMessage("Welcome! Use /kjv for settings or /kjv help for commands.")
        KJVVersesDB.welcomeShown = true
    end
end)
