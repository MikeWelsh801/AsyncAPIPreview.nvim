local M = {}

local default_config = {
    port = 4001,
    ip = "localhost"
}

function M.setup(opts)
    for k, v in pairs(opts) do
       if default_config[k] ~= nil then
           default_config[k] = v
       else
           local err = string.format("Unexpected argument in options: %s", k)
           vim.notify(err, vim.log.levels.ERROR)
       end
    end

    vim.fn.jobstart("npm i", {
        on_stderr = function(_, data)
            vim.notify('Error installing dependency: ' .. vim.inspect(data), vim.log.levels.ERROR)
        end
    })

    M.config = default_config
end

function M.preview()
    if M.preview_job then
        M.stop_server()
    end
    -- Get the current buffer's full path
    local current_buffer_path = vim.fn.expand('%:p')

    -- Execute the script with the current buffer path as argument
    local cmd = string.format('asyncapi start studio "%s" -p %d', current_buffer_path, M.config.port)

    -- Run the doc generation command
    M.preview_job = vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
            if code == 0 then
                vim.schedule(function()
                    vim.notify('Preview generation failed with code: ' .. code, vim.log.levels.ERROR)
                end)
            else
                vim.notify("User closed preview", vim.log.levels.INFO)
            end
        end,
        on_stderr = function(_, data)
            -- report only errors
            if string.find(string.lower(vim.inspect(data)), "error") then
                vim.schedule(function()
                    vim.notify('Preview error: ' .. vim.inspect(data), vim.log.levels.ERROR)
                end)
            end
        end
    })
end

function M.stop_server()
    vim.fn.jobstop(M.preview_job)
    M.preview_job = nil
    vim.notify('Preview server stopped', vim.log.levels.INFO)
end

return M
