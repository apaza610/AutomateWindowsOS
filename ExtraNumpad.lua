------------------- LUA Macros Profile Chooser (29 teclas adicionales)-------------------------------------------------
lmc_device_set_name('ApazaMacropad','206604')
lmc_print_devices()
lmc_set_handler('ApazaMacropad', function(button,direction)
     --lmc_spawn("calc")
     --print( lmc_get_window_title() )
     --lmc_send_keys('#{F21}')
     --os.execute(".exe Path Here")
     --lmc_load('File Path Here')
     --if string.find( lmc_get_window_title(), "Blender" ) then
     --   lmc_say('using blender app')
     --elseif string.find( lmc_get_window_title(), "Freeplane" ) then
     --   lmc_say('using freeplane app')
     --end

     if (direction == 1) then return end
     ----------------------------------------------------------------
     if (button == 144) then   --NUMLOCK--
          lmc_send_keys('+{F20}')
     ----------------------------------------------------------------
     elseif (button == 111) then    --DIVIDE--
          lmc_send_keys('{F14}')
     ----------------------------------------------------------------
     elseif (button == 106) then    --MULT--
          lmc_send_keys('{F15}')
     ----------------------------------------------------------------
     elseif (button == 109) then    --MINUS--
          lmc_send_keys('{F16}')
     ----------------------------------------------------------------
     elseif (button == 103) then    --7--(ON)
          lmc_send_keys('{F17}')
     elseif (button == 36) then    --HOME--(OFF)
          lmc_send_keys('+{F18}')
     ----------------------------------------------------------------
     elseif (button == 104) then   --8--(ON)
          lmc_send_keys('{F18}')
     elseif (button == 38) then   --UP--(OFF)
          lmc_send_keys('+{F17}')
     ----------------------------------------------------------------
     elseif (button == 105) then    --9--
          lmc_send_keys('{F19}')
     elseif (button == 33) then    --PgUp--
          lmc_send_keys('+{F16}')
     ----------------------------------------------------------------
     elseif (button == 107) then    --ADD--
          lmc_send_keys('{F20}')
     ----------------------------------------------------------------
     elseif (button == 100) then    --4--(ON)
          lmc_send_keys('{F21}')
     elseif (button == 37) then     --LEFT--(OFF)
          lmc_send_keys('+{F15}')
     ----------------------------------------------------------------
     elseif (button == 101) then    --5-- (ON)
          lmc_send_keys('{F22}')
     elseif (button == 12) then     --5-- (OFF)
          lmc_send_keys('+{F14}')
     ----------------------------------------------------------------
     elseif (button == 102) then   --6--(ON)
          lmc_send_keys('{F23}')
     elseif (button == 39) then    --RIGHT--(OFF)
          lmc_send_keys('+{F13}')
     ----------------------------------------------------------------
     elseif (button == 8) then           --BACKSPACE--
         lmc_send_keys('{F24}')
     ----------------------------------------------------------------
     elseif (button == 97) then      --1--(ON)
          lmc_send_keys('+{F24}')
     elseif (button == 35) then      --END--(OFF)
          lmc_send_keys('+{F12}')
     ----------------------------------------------------------------
     elseif (button == 98) then     --2--(ON)
          lmc_send_keys('+{F23}')
     elseif (button == 40) then     --DOWN--(OFF)
          lmc_send_keys('+{F11}')
     ----------------------------------------------------------------
     elseif (button == 99) then      --3--(ON)
          lmc_send_keys('+{F22}')
     elseif (button == 34) then     --PgDn--(OFF)
          lmc_send_keys('+{F10}')
     ---------------------------------------------------------------
     elseif (button == 13) then      --ENTER--
         lmc_send_keys('+{F21}')
     ----------------------------------------------------------------
     elseif (button == 96) then     --0--(NumLock ON)
         lmc_send_keys('{F13}')
     elseif (button == 45) then     --INS--(NumLock OFF)
         lmc_send_keys('+{F9}')
     ---------------------------------------------------------------
     elseif (button == 110) then    --DECIMAL--ON
            lmc_send_keys('+{F19}')
     elseif (button == 46) then    --DEL--OFF
         lmc_send_keys('+{F8}')
end
end
)                      -------------------LUAacros script ends here ---------------------------2----------------------
