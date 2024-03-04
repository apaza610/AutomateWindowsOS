------------------- LUA Macros Profile Chooser -------------------------------------------------
lmc_device_set_name('ApazaMacropad','348AC14A')
lmc_print_devices()
lmc_set_handler('ApazaMacropad', function(button,direction)

  if (direction == 1) then return end
    
    --Number 0--
     if (button == 96) then
        lmc_say('firefox')
        lmc_send_keys('{F24}')

    --Number 1--
     elseif (button == 97) then
        --Load Desktop Macro Profile--
        --This is a text to speech line if you want to use it just delete the "--" from the line--
        --lmc_say('Modo Escritorio')--
        lmc_load('File Path Here')  

    --Number 2--
     elseif (button == 98) then
        --Load Uipath Macro Profile--
        --lmc_say('Modo yu ay pat')--
      --   os.execute(".exe Path Here")
      --   lmc_load('File Path Here')
         lmc_say('double commander')
         lmc_send_keys('{F22}')

    --Number 3--
     elseif (button == 99) then
         --Load Davinci Macro Profile--
        --lmc_say('Davinci Risolf')--
        lmc_load('File Path Here')

    --Number 4--
     elseif (button == 100) then
            --lmc_say('calculator')
            --lmc_spawn("calc")
         lmc_say('screen to gif')
         lmc_send_keys('{F17}')
    
    --Number 5--
     elseif (button == 101) then
            lmc_say('freeplane')
            lmc_send_keys('{F13}')
        
    --Number 6--
     elseif (button == 102) then
         lmc_say('krita')
         lmc_send_keys('{F14}')   
            --print( lmc_get_window_title() )

    --Number 7--
     elseif (button == 103) then
         lmc_say('apaza tool')
         lmc_send_keys('{F15}')
        --COMMENT--
     
    --Number 8--
     elseif (button == 104) then
         lmc_say('draw io')
         lmc_send_keys('{F16}')
        --COMMENT--
     
    --Number 9--
     elseif (button == 105) then
        --COMMENT--

    --NUMMULTIPLY--
     elseif (button == 106) then
        --COMMENT--

    --NUMPLUS-- 
     elseif (buttin == 107) then
        --COMMENT--

    --NUMMINUS--
     elseif (button == 109) then
            lmc_say('helper')
            lmc_send_keys('{F18}')
        --COMMENT--

    --NUMDECIMAL--
     elseif (button == 110) then
            lmc_say('annotation')
            lmc_send_keys('{F19}')
        --COMMENT--

    --NUMDIVIDE--
     elseif (button == 111) then
         if string.find( lmc_get_window_title(), "Blender" ) then
            lmc_say('using blender')
         elseif string.find( lmc_get_window_title(), "Freeplane" ) then
            lmc_say('using freeplane')
         end
        --COMMENT--
  end
end
)
-------------------LUA Macros script ends here -------------------------------------------------
