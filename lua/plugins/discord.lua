return {
  'vyfor/cord.nvim',
   ---@type CordConfig
  opts = {
	  display = { 
		  theme = 'catppuccin',
	  },
      assets = {
  ['.rs'] = {
    tooltip = 'Rust.. Stop taking ownership',
    text = function(opts)
      return 'Fighting the borrow checker in ' .. opts.filename .. ' 🦀'
    end,
  },
  ['.ts'] = {
    tooltip = 'An attempt at a better JavaScript.. (A Failed one)',
    text = function(opts)
      return 'Barely surviving in' .. opts.filename
    end,
  },
  ['.js'] = {
    tooltip = 'An worse TypeScript',
    text = function(opts)
      return 'Barely surviving in' .. opts.filename
    end,
  },
  ['.tsx'] = {
    tooltip = 'Better than JSX',
    text = function(opts)
      return 'React-ing to hydrochloric acid in ' .. opts.filename
    end,
  },
  ['.jsx'] = {
    tooltip = 'Worse than TSX',
    text = function(opts)
      return 'React-ing to hydrochloric acid in ' .. opts.filename
    end,
  },
  ['.py'] = {
    tooltip = 'Python.. it\'s pure torture',
    text = function(opts)
      return 'Dying in ' .. opts.filename
    end,
  },
},

  }
}
