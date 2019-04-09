# 构建go环境下的动态共享库
# 定义变量 project名称
project=cgoantpath

.PHONY: all clean wget build install goal

# 默认使用第一个真target，使用.DEFAULT_GOAL改变默认值
.DEFAULT_GOAL:= all

all: before wget build install clean
	@echo "all is execute."

before:
	rm -rf ./lib${project}.so ./lua2go.lua

wget: goal
	@echo "get from internet"
	@wget https://raw.githubusercontent.com/vibrantbyte/go-antpath/master/antpath.go
	@wget https://raw.githubusercontent.com/vibrantbyte/lua2go/master/lua/lua2go.lua

build: goal
	@echo "execute script"
	go build -ldflags "-s -w" -buildmode=c-shared -o lib${project}.so ./antpath.go
	# 增加执行权限
	chmod g+x,u+x,o+x lib${project}.so

install: goal
	@echo "install application"

clean: goal
	@echo "clean successful"
	rm -rf ./antpath.go ./lib${project}.h