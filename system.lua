require "import"
import "java.io.*"

-- 一些系统相关的操作

function exists(path)
 -- 检测文件夹是否存在
 local file = io.open(path, 'rb')
 if file then
  file:close()
 end
 return file ~= nil
end

function mkdir(FloderPath)
 os.execute("mkdir " .. FloderPath) -- 创建文件夹
end


function writeFile(path, content)
 -- 创建文件并写入内容
 local file = io.open(path, "w")
 file:write(content)
 file:close()
end
