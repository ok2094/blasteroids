function love.conf( t )
    t.identity      = "savestate"
    t.version       = "0.10.2"

    t.window.title  = "Blasteroids"
    t.window.icon = nil
    t.window.width  = 800
    t.window.height = 600
    t.window.resizable = false

    t.window.fsaa   = 4
    t.window.vsync  = true
end
