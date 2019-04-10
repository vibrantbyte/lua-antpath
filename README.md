# lua-antpath
The default implementation is AntPathMatcher, supporting the  * Ant-style pattern syntax.  The description is from java spring framework.

> 参考地址：[https://github.com/golang/go/wiki/cgo](https://github.com/golang/go/wiki/cgo)  
 参考地址：[https://golang.org/cmd/cgo/](https://golang.org/cmd/cgo/)  
 参考地址：[https://groups.google.com/forum/#!topic/golang-nuts/Nb-nfVdAyF0](https://groups.google.com/forum/#!topic/golang-nuts/Nb-nfVdAyF0)

# 编译环境
> luajit 2.1  
go 1.9.2+

# 使用
```lua
local lua2go = require('lua2go')
local antpath = lua2go.Load('./libcgoantpath.so')
local cjson = require("cjson")

lua2go.Externs[[
   extern char* Version();
   extern void Increment(GoInt* value);
   extern GoBool IsPattern(GoString path);
   extern GoBool Match(GoString pattern,GoString path);
   extern GoBool MatchStart(GoString pattern,GoString path);
   extern GoString ExtractPathWithinPattern(GoString pattern,GoString path);
   extern GoString ExtractUriTemplateVariables(GoString pattern,GoString path);
   extern GoString Combine(GoString pattern1,GoString pattern2);
   extern void SetPathSeparator(GoString pathSeparator);
   extern void SetCaseSensitive(GoInt8 caseSensitive);
   extern void SetTrimTokens(GoInt8 trimTokens);
   extern void SetCachePatterns(GoInt8 cachePatterns);
 ]]

-- 使用Version函数 -- begin --
local version = antpath.Version()
-- 1. 获取版本号信息
local v = lua2go.ToLuaString(version)
-- 2. 打印版本号信息
print(v)
-- 使用Version函数 -- end --

print("--------------------------")

-- 使用Increment函数 -- begin --
-- 指针操作
local intPtr = lua2go.ToGoPointer(1)
antpath.Increment(intPtr)
print(lua2go.ToLua(intPtr[0]))
-- 使用Increment函数 -- end --

print("--------------------------")

-- 使用Match函数 -- begin --
-- 1. 验证是否匹配
local bn = antpath.Match(lua2go.ToGoString("/*/1.html"),lua2go.ToGoString("/100/1.html"))
-- 2. 打印匹配信息
print(lua2go.ToLuaBool(bn))
-- 使用Match函数 -- end --


print("--------------------------")

-- 使用IsPattern函数 -- begin --
local ispattern = antpath.IsPattern(lua2go.ToGoString("/*/1.html"))
print(lua2go.ToLuaBool(ispattern))
-- 使用IsPattern函数 -- end --

print("--------------------------")

-- 使用Combine函数 -- begin --
local combine = antpath.Combine(lua2go.ToGoString("/hotels/*"),lua2go.ToGoString("/booking"))
-- 1. 打印需要的pattern信息
print(lua2go.ToLuaString(combine.p))
-- 2. 使用完成后回收信息
lua2go.AddToGC(combine.p)
-- 使用Combine函数 -- end --

print("--------------------------")

-- 使用MatchStart函数 -- begin --
local start = antpath.MatchStart(lua2go.ToGoString("/*/1.html"),lua2go.ToGoString("/100/1.html"))
print(lua2go.ToLuaBool(start))
-- 使用MatchStart函数 -- end --

print("--------------------------")

-- 使用ExtractPathWithinPattern函数 -- begin --
local variable = antpath.ExtractPathWithinPattern(lua2go.ToGoString("/docs/cvs/*.html"),lua2go.ToGoString("/docs/cvs/commit.html"))
print(lua2go.ToLuaString(variable.p))
-- 使用完成后回收信息
lua2go.AddToGC(variable.p)
-- 使用ExtractPathWithinPattern函数 -- end --

print("--------------------------")

-- 使用ExtractUriTemplateVariables函数 -- begin --
local map = antpath.ExtractUriTemplateVariables(lua2go.ToGoString("/hotels/{hotel}"),lua2go.ToGoString("/hotels/11232"))
local mapstr = lua2go.ToLuaString(map.p)
local data = cjson.decode(mapstr)
print(data.hotel)
lua2go.AddToGC(map.p)


-- 使用fExtractUriTemplateVariables函数 -- end --

print("--------------------------")

-- 设置fields信息 -- begin --
antpath.SetPathSeparator(lua2go.ToGoString("/"))
print("设置SetPathSeparator成功")
antpath.SetCaseSensitive(0)
print("设置SetCaseSensitive成功")
antpath.SetTrimTokens(1)
print("设置SetTrimTokens成功")
antpath.SetCachePatterns(1)
print("设置SetCachePatterns成功")
-- 设置fields信息 -- end --
```