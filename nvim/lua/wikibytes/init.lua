require("wikibytes.keymaps")
require("wikibytes.lazy")
require("wikibytes.options")


function compileAndRun() local file = vim.fn.expand('%:p') -- Get the full path of the current file
    local directory = vim.fn.expand('%:p:h') -- Get the directory of the current file
    local filename = vim.fn.expand('%:t:r') -- Get the name of the current file without extension
    local file_extension = vim.fn.expand('%:e') -- Get the file extension

    -- Change the working directory to the directory of the file
    vim.fn.execute('cd ' .. directory)

    local compile_command = ''
    local run_command = ''

    if file_extension == 'java' then
        compile_command = 'javac ' .. file
        run_command = 'java -cp ' .. directory .. ' ' .. filename
    elseif file_extension == 'c' then
        compile_command = 'gcc ' .. file .. ' -o ' .. filename
        run_command = './' .. filename
    elseif file_extension == 'cpp' then
        compile_command = 'g++ ' .. file .. ' -o ' .. filename
        run_command = './' .. filename
    elseif file_extension == 'go' then
        compile_command = 'go run ' .. file
        run_command = ''
    else
        print('Unsupported file type')
        return
    end

    local compile_output = vim.fn.systemlist(compile_command)

    if vim.tbl_isempty(compile_output) then
        if run_command ~= '' then
            local run_output = vim.fn.systemlist(run_command)

            local output_buffer = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(output_buffer, 0, -1, false, run_output)

            vim.api.nvim_buf_set_option(output_buffer, 'filetype', file_extension)

            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local float_config = {
                relative = 'cursor',
                row = cursor_pos[1] + 1,
                col = cursor_pos[2],
                width = 80,
                height = #run_output + 2,
                style = 'minimal'
            }
            local float_win = vim.api.nvim_open_win(output_buffer, true, float_config)

            vim.api.nvim_win_set_option(float_win, 'wrap', false)
            vim.api.nvim_win_set_option(float_win, 'winblend', 10)
        end
    else
        print('Compilation failed: ' .. table.concat(compile_output, '\n'))
    end
end

vim.cmd('command! -nargs=0 CJ lua compileAndRun()')
--

--
--
-- function compileAndRun()
--     local file = vim.fn.expand('%:p') -- Get the full path of the current file
--     local directory = vim.fn.expand('%:p:h') -- Get the directory of the current file
--     local filename = vim.fn.expand('%:t:r') -- Get the name of the current file without extension
--     local file_extension = vim.fn.expand('%:e') -- Get the file extension
--
--     -- Change the working directory to the directory of the file
--     vim.fn.execute('cd ' .. directory)
--
--     local compile_command = ''
--     local run_command = ''
--
--     if file_extension == 'java' then
--         compile_command = 'javac ' .. file
--         run_command = 'java -cp ' .. directory .. ' ' .. filename
--     elseif file_extension == 'c' then
--         compile_command = 'gcc ' .. file .. ' -o ' .. filename
--         run_command = './' .. filename
--     elseif file_extension == 'cpp' then
--         compile_command = 'g++ ' .. file .. ' -o ' .. filename
--         run_command = './' .. filename
--     elseif file_extension == 'go' then
--         compile_command = 'go run ' .. file
--         run_command = ''
--     else
--         print('Unsupported file type')
--         return
--     end
--
--     local compile_output = vim.fn.systemlist(compile_command)
--
--     if vim.tbl_isempty(compile_output) then
--         if run_command ~= '' then
--             -- Prompt for input if needed
--             local input = vim.fn.input('Enter input for the program: ')
--             local run_output = vim.fn.systemlist(run_command, input)
--
--             local output_buffer = vim.api.nvim_create_buf(false, true)
--             vim.api.nvim_buf_set_lines(output_buffer, 0, -1, false, run_output)
--
--             vim.api.nvim_buf_set_option(output_buffer, 'filetype', file_extension)
--
--             local cursor_pos = vim.api.nvim_win_get_cursor(0)
--             local float_config = {
--                 relative = 'cursor',
--                 row = cursor_pos[1] + 1,
--                 col = cursor_pos[2],
--                 width = 80,
--                 height = #run_output + 2,
--                 style = 'minimal'
--             }
--             local float_win = vim.api.nvim_open_win(output_buffer, true, float_config)
--
--             vim.api.nvim_win_set_option(float_win, 'wrap', false)
--             vim.api.nvim_win_set_option(float_win, 'winblend', 10)
--         end
--     else
--         print('Compilation failed: ' .. table.concat(compile_output, '\n'))
--     end
-- end
--
