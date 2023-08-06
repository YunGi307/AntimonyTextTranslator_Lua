require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
import "java.io.*"
import "system"
import "android.webkit.MimeTypeMap"
import "android.content.Intent"
import "android.net.Uri"
import "base64"
import "dataset"

activity.setTitle('锑星文字试验场')
activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView(layout) -- 加载布局文件

result.settings.javaScriptEnabled = false
result.settings.domStorageEnabled = true

function hasElement(arr, element)
 -- arr 是否含有元素 element
 for i = 1, #arr do
  if arr[i] == element then
   return true
  end
 end
 return false
end



function translate(text)
 local res = ""
 local splits = {}
 local iter = {}

 -- 按照字符拆分，为了适配汉字等"多字节"(非 ASCII)字符
 isFinish = false
 local i = 1
 while not isFinish do
  char = string.sub(text, i, i)
  byte = string.byte(char)
  if byte > 128 then -- 非 ASCII 字符
   table.insert(iter, string.sub(text, i, i + 2))
   i = i + 3
   else
   table.insert(iter, char)
   i = i + 1
  end

  if i > #text then
   isFinish = true -- 完成
  end
 end

 for i=1, #iter do
  -- tostring 是为了防止出现 nil 的情况
  local left = iter[i] .. tostring(iter[i + 1])
  local right = tostring(iter[i - 1]) .. iter[i]
  local now = iter[i] -- 当前字符

  if hasElement(metachars, right) then
   table.insert(splits, right)
   elseif hasElement(metachars, now) then
   table.insert(splits, now)
   elseif hasElement(metachars, left) then
   local nothong = 0 -- 跳过，该字符已处理
   elseif now == " " then
   table.insert(splits, "&nbsp;&nbsp;&nbsp;&nbsp;") -- 处理空格
   elseif now == "\n" then -- 处理换行符
   table.insert(splits, "<br/>")
   else
   table.insert(splits, now)
  end
 end

 for i=1, #splits do
  local char = splits[i]
  local ans = dataset[char]
  if ans != nil then
   res = res .. ans
   else
   res = res .. char
  end
 end
 return res
end


function download(url, filename)
 -- 目前没有用上
 Http.download(url, '/storage/emulated/0/AndroLua/project/锑星文字试验场/' .. filename, nil, nil, nil)
end


function convertText()
 local content = contentBox.Text
 local res = translate(content)
 res = "<!-- " .. base64.enc(content) .. " -->\n\n" .. res
 result.loadDataWithBaseURL(nil, res, "text/html", "UTF-8", nil)
 return res
end


function expertFile()
 local res = convertText()
 writeFile(floderPath .. "/Expert.html", res)
 showMsg("已经导出至 \"" .. floderPath .. "\" 啦")
end


floderPath = '/storage/emulated/0/AntimonyTextFiles'
if not exists(floderPath) then
 mkdir(floderPath)
end

