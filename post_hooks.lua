_G.ONSC = {

}

-- Balala Unit to Pixels (i am not pasting the formula 100 times)
ONSC.BU2PX = function (bu)
    return bu * (G.TILESCALE*G.TILESIZE)
end

local oldhook = G.FUNCS.select_text_input
G.FUNCS.select_text_input = function(e)
    if true then -- for testing, in final version you should be able to toggle this
        love.keyboard.setTextInput( true, ONSC.BU2PX(e.T.x), ONSC.BU2PX(e.T.y), ONSC.BU2PX(e.T.w), ONSC.BU2PX(e.T.h))
    end
    return oldhook(e)
end

ONSC.release_hook = function(args) 
    love.keyboard.setTextInput(false)
end