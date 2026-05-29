#!/bin/sh

# 获取用户输入的 commit 信息
commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# 定义正则表达式，匹配规范：type(scope): subject 或 type: subject
reg_expr="^(feat|fix|docs|style|refactor|perf|test|chore|revert|ci)(\(.+\))?: .+"

if ! echo "$commit_msg" | grep -Eq "$reg_expr"; then
    # 检测当前环境是否支持颜色输出
    if [ -t 1 ]; then
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        NC='\033[0m' # 无颜色
    else
        RED=''
        GREEN=''
        NC=''
    fi

    printf "${RED}❌ 错误: 你的 Git Commit 信息不符合规范！${NC}\n"
    printf "--------------------------------------------------------\n"
    printf "💡 正确格式：${GREEN}<type>: <description>${NC}\n"
    printf "例如: ${GREEN}fix: 修复首页特定模型下的闪退问题${NC}\n"
    printf "例如: ${GREEN}feat(home): 新增下拉刷新功能${NC}\n"
    printf "--------------------------------------------------------\n"
    printf "允许的 type 类型: feat, fix, docs, style, refactor, perf, test, chore, revert, ci\n"
    exit 1
fi
