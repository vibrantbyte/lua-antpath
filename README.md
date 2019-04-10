# lua-antpath
The default implementation is AntPathMatcher, supporting the  * Ant-style pattern syntax.  The description is from java spring framework.

# 编译环境
> luajit 2.1  
go 1.9.2+

# 接口
```go
//export Version
func Version() string{
	return "v1.0"
}

//export IsPattern
func IsPattern(path string) bool {
	return pMatcher.IsPattern(path)
}

//export Match
func Match(pattern,path string) bool{
	return pMatcher.Match(pattern,path)
}

//export MatchStart
func MatchStart(pattern,path string) bool{
	return pMatcher.MatchStart(pattern,path)
}

//export ExtractPathWithinPattern
func ExtractPathWithinPattern(pattern,path string) string {
	return pMatcher.ExtractPathWithinPattern(pattern,path)
}

//export ExtractUriTemplateVariables
func ExtractUriTemplateVariables(pattern,path string) *map[string]string {
	return pMatcher.ExtractUriTemplateVariables(pattern,path)
}

////export GetPatternComparator
//func GetPatternComparator(path string) *AntPatternComparator {
//	return pMatcher.GetPatternComparator(path)
//}

//export Combine
func Combine(pattern1,pattern2 string) string {
	return pMatcher.Combine(pattern1,pattern2)
}

//export SetPathSeparator
func SetPathSeparator(pathSeparator string){
	 pMatcher.SetPathSeparator(pathSeparator)
}

//export SetCaseSensitive
func SetCaseSensitive(caseSensitive bool) {
	pMatcher.SetCaseSensitive(caseSensitive)
}

//export SetTrimTokens
func SetTrimTokens(trimTokens bool){
	pMatcher.SetTrimTokens(trimTokens)
}

//export SetCachePatterns
func SetCachePatterns(cachePatterns bool){
	pMatcher.SetCachePatterns(cachePatterns)
}
```