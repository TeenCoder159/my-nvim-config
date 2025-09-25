 -- lua/plugins/presence.lua
 local home = vim.loop.os_homedir()
 
 return {
   {
     'andweeb/presence.nvim',
     event = 'VeryLazy',
     config = function()
       require('presence').setup({
         workspace_text = function(filename)
           local path = vim.fn.expand("%:p")
           if path:match("" .. home .. "/.config/nvim/") then
             return "Modifying nvim configs like a pro"
           elseif path:match("" .. home .. "/Documents/onellm/") then
               return "OneLLM is dead, probably"
           elseif path:match("" .. home .. "/Documents/NYP_Stuff") then
               return "Urghhhhhh Schoolwork.. unless it's rust..."
           elseif path:match("" .. home .. "/yamuna/") then
               return "Making my own browser"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/rust/project/fastnd") then
             return "Rusting out a rust based numpy"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/rust") then
             return "Fighting the borrow checker"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/zig") then
             return "Zigging around"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/gleam") then
             return "Gleaming out some code"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/comps") then
             return "Competing with competiton"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/python/projects/") then
                 return "WHY IS IT SO GOD DAMN SLOWWWWW"
           elseif path:match("" .. home .. "/Documents/Coding_stuff/golang/") then
                 return "Gophering some stuff"
           else
                 return "Working on something"
 
 
           end
           local cwd = vim.fn.getcwd()
           return ("Editing %s"):format(vim.fn.fnamemodify(cwd, ":t"))
         end,
 
       })
     end,
   },
 }
