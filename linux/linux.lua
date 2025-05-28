---
permalink: /cgi/linux/index.lua
---

-- Function to execute shell commands
local function shell_exec(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Execute shell command
local uname = shell_exec('uname -mrs')

-- Find position of the first occurrence of a substring in a string
local pos = string.find(uname, '-', 1, true)

-- Extract substring
local res = string.sub(uname, 1, pos - 1)

-- Output the HTTP header
io.write("Content-Type: text/plain; charset=utf-8\r\n\r\n")

-- Output the result
io.write(res)

