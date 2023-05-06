#!/usr/bin/env sh

# 让脚本抛出遇到的错误
set -e
# 拉取当前仓库最新配置
git pull origin master
# 创建 docs 目录 用来初始化内容仓库
mkdir -p docs
# 进入 docs 目录
cd docs
git init
# Check if 'origin' remote exists
if ! git remote | grep -q "^origin$"; then
  # If 'origin' does not exist, add it
  git remote add origin git@github.com:imarvinle/how2cs_config.git
fi
# 拉取最新内容文件
git pull origin master
cd -
# 编译构建
yarn install
yarn docs:build
echo "构建成功，✿✿ヽ(°▽°)ノ✿"
# 拷贝文件到 nginx 映射目录
mkdir -p ~/wwww
/bin/cp -rf docs/.vuepress/dist/*  ~/www/