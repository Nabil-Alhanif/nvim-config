local gl = require('galaxyline')
local gls = gl.section
local condition = require('galaxyline.condition')
gl.short_line_list = {'NvimTree', 'packer'}

local colors = {
    -- bg = '#2E2E2E',
    bg = '#292D38',
    bg_gray = '#aeaeab',
    bg_light_gray = '#3e4452',
    logo_color = '#1a18ab',
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}

local icons = {
    arch_logo = ''
}

-- Helper function
local function aliases()
    local alias = {
        ['n']  = 'NORMAL',
        ['no'] = 'N·PENDING',
        ['v']  = 'VISUAL',
        ['V']  = 'V·LINE',
        [''] = 'V·BLOCK', -- this is not ^V, but it's , they're different
        ['s']  = 'SELECT',
        ['S']  = 'S·LINE',
        [''] = 'S·BLOCK', -- same with this one, it's not ^S but it's 
        ['i']  = 'INSERT',
        ['ic'] = 'INSERT',
        ['R']  = 'REPLACE',
        ['Rv'] = 'V·REPLACE',
        ['c']  = 'COMMAND',
        ['cv'] = 'VIM·EX',
        ['ce'] = 'EX',
        ['r']  = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!']  = 'SHELL',
        ['t']  = 'TERMINAL'
    }
    local aliass = alias[vim.fn.mode()]
    if aliass ~= nil then
        return aliass
    else
        return 'Unknown'
    end
end

local function mode_color()
    local mode_colors = {
        ['n']  = colors.blue,
        ['no'] = colors.blue,
        ['v']  = colors.purple,
        ['V']  = colors.purple,
        [''] = colors.purple,
        ['s']  = colors.orange,
        ['S']  = colors.orange,
        [''] = colors.orange,
        ['i']  = colors.green,
        ['ic'] = colors.yellow,
        ['R']  = colors.red,
        ['Rv'] = colors.red,
        ['c']  = colors.magenta,
        ['cv'] = colors.blue,
        ['ce'] = colors.blue,
        ['r']  = colors.cyan,
        ['rm'] = colors.cyan,
        ['r?'] = colors.cyan,
        ['!']  = colors.blue,
        ['t']  = colors.blue
    }
    local color = mode_colors[vim.fn.mode()]
    if color ~= nil then
        return color
    else
        return colors.cyan
    end
end

-- Left Section
gls.left[1] = {
    rounded_border_logo = {
        provider = function ()
	        return ''
        end,
        highlight = {colors.bg_gray, colors.bg},
    }
}

gls.left[2] = {
    Arch = {
        provider = function () return '  ' end,
        highlight = {colors.logo_color, colors.bg_gray},
        separator = '',
        separator_highlight = {colors.bg_gray, colors.bg_light_gray},
    },
}

gls.left[3] = {
    ViMode = {
        provider = function ()
	        vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color())
            return ' ' .. aliases()
        end,
        highlight = {colors.fg, colors.bg_light_gray, 'bold'},
        separator = '',
        separator_highlight = {colors.bg_light_gray, colors.bg},
    },
}

-- Mid Section
gls.mid[1] ={
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg},
    },
}

gls.mid[2] = {
    FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.bg},
    }
}

-- Right Section
gls.right[1] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.error_red, colors.bg},
    }
}
gls.right[2] = {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.orange, colors.bg}}}

gls.right[3] = {
    DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.vivid_blue, colors.bg}}
}

gls.right[4] = {DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.info_yellow, colors.bg}}}

gls.right[5] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = '  ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[8] = {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[9] = {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[10] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[11] = {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}
