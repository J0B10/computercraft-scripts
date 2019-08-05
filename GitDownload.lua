-- Settings
local settings_file = shell.resolve(".gd.cfg")

local function getRepo()
    if fs.exists(settings_file) then 
        local h = fs.open(settings_file, 'r')
        local s = h.readAll()
        h.close()
        return s
    else
        print("Repositpory not set.")
        print("Please specify the base url for all raw files:")
        write("> ")
        local r = read()
        local h = fs.open(settings_file, 'w')
        h.write(r)
        h.close()
        return r
    end
end

local repo = getRepo()



-- Main
local path,name = ...

if repo == nil then
    setRepo()
end

while path == nil or string.len(path) == 0 do 
    print("Please specify a file from the repo to download.")
    write("> ")
    path = read()
end

if name == nil or string.len(name) == 0 then 
    print("Please specify a name for the programm (default: startup)")
    write("> ")
    name = read()
    if name == nil or string.len(name) == 0 then 
        name = "startup"
    end
end
name = string.gsub(name, ".lua", " ")
local file_name = shell.resolve(name)

if fs.exists(file_name) then
    print("Programm " .. name .. " already exists. Override? (Y/N)")
    local y = read()
    if not (y == "y" or y = "Y" or y == "") then
        exit()
    end
end

print("Downloading " .. path .. "...")
http.request(repo .. path)
local loop = true
while loop do
    local event, url, h = os.pullEvent()
    if event == "http_success" then
        local content = h.readAll()
        h.close()
        local file = fs.open(file_name, 'w')
        file.write(content)
        file.close()
        print("Saved " .. name)
        loop = false
    elseif event == "http_failure" then
        print("Download failed!")
        loop = false
    end
end