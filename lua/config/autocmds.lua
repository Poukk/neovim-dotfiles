-- Autocommand for C and header files to use real tab characters
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "h" },
  callback = function()
    vim.opt_local.expandtab = false -- Use real tab characters, not spaces
    vim.opt_local.tabstop = 4 -- Number of spaces a <Tab> counts for
    vim.opt_local.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
    vim.opt_local.softtabstop = 4 -- Insert/delete 4 spaces for a tab
    vim.b.autoformat = false -- Disable autoformat
  end,
})

-- Ensure nui.nvim is loaded
local Popup = require("nui.popup")

-- Function to check Norminette on the current file
local function check_norminette()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:p")

  -- Only run for .c or .h files
  if filetype == "c" or filetype == "h" then
    -- Execute the norminette command
    local output = vim.fn.system("norminette " .. filename)

    -- Create a pop-up window using nui.nvim
    local popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
        text = {
          top = "Norminette Result",
          top_align = "center",
        },
      },
      position = "50%",
      size = {
        width = "80%",
        height = "60%",
      },
      buf_options = {
        modifiable = true, -- Set the buffer to modifiable initially
        readonly = false,
      },
    })

    -- Mount the pop-up
    popup:mount()

    -- Set the content of the pop-up
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, vim.split(output, "\n"))

    -- Set the buffer to non-modifiable after inserting the content
    vim.bo[popup.bufnr].modifiable = false

    -- Close the pop-up when pressing 'q'
    popup:map("n", "q", function()
      popup:unmount()
    end, { noremap = true, silent = true })
  else
    print("This is not a .c or .h file.")
  end
end

-- Create a command to trigger the check
vim.api.nvim_create_user_command("NormCheck", check_norminette, {})

-- Optional: map the function to a key (e.g., <leader>n)

local Input = require("nui.input")

-- Command :ConfigHeader to set user and email dynamically with a centered pop-up
vim.api.nvim_create_user_command("ConfigHeader", function()
  -- Create a centered input pop-up using nui.nvim
  local input_popup = Input({
    position = "50%",
    size = {
      width = 40,
      height = 3,
    },
    border = {
      style = "rounded",
      text = {
        top = "Enter your login (<Esc><q> to cancel)",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10, -- Optional: adds some transparency
    },
  }, {
    prompt = "> ", -- The prompt inside the input field
    on_submit = function(input_user)
      if input_user ~= nil and input_user ~= "" then
        -- Set the user in the header config
        local opts = { user = input_user }
        -- Set the email based on the user input
        opts.mail = input_user .. "@student.42sp.org.br"
        -- Reconfigure the plugin with new user and mail
        require("42header").setup(opts)
        print("Header updated with username: " .. input_user)
      else
        print("Username input cancelled or empty")
      end
    end,
  })

  -- Mount the input popup
  input_popup:mount()

  -- Close the pop-up when 'q' is pressed
  input_popup:map("n", "q", function()
    input_popup:unmount()
  end, { noremap = true, silent = true })
end, {})
