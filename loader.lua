local BASE_URL = "https://raw.githubusercontent.com/NNNNxfig/HB/main/"

local function import(file)
    return loadstring(game:HttpGet(BASE_URL .. file))()
end

import("fly.lua")
import("gui.lua")
-- import("utils.lua") -- если появится
