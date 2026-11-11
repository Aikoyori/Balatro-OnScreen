_G.ONSC = {

}

-- Balala Unit to Pixels (i am not pasting the formula 100 times)
ONSC.BU2PX = function (bu)
    return bu * (G.TILESCALE*G.TILESIZE)
end

local oldhook = G.FUNCS.select_text_input
G.FUNCS.select_text_input = function(e)
    if true then -- for testing, in final version you should be able to toggle this
        local desired_y = ONSC.BU2PX(e.T.y) > love.graphics.getHeight() / 2 and math.min ( ONSC.BU2PX(e.T.y) * 2.1, love.graphics.getHeight()) or ONSC.BU2PX(e.T.y)
        love.keyboard.setTextInput( true, ONSC.BU2PX(e.T.x), desired_y, ONSC.BU2PX(e.T.w), ONSC.BU2PX(e.T.h))
    end
    return oldhook(e)
end

ONSC.release_hook = function(args) 
    love.keyboard.setTextInput(false)
end

local old_text_input = G.FUNCS.text_input
G.FUNCS.text_input = function(e)
    if true then -- also waiting for config
        local args =e.config.ref_table
        if G.CONTROLLER.text_input_hook == e then
            e.parent.parent.config.colour = args.hooked_colour
            args.current_prompt_text = ''
            args.current_position_text = args.position_text
        else
            e.parent.parent.config.colour = args.colour
            args.current_prompt_text = (args.text.ref_table[args.text.ref_value] == '' and args.prompt_text or '')
            args.current_position_text = ''
        end
        local OSkeyboard_e = e.parent.parent.parent
        if OSkeyboard_e.children.controller_keyboard then
            OSkeyboard_e.children.controller_keyboard:remove()
            OSkeyboard_e.children.controller_keyboard = nil
            G.CONTROLLER.screen_keyboard = nil
            G.CONTROLLER:mod_cursor_context_layer(-1)
        end
    else
        return old_text_input(e)
    end
end