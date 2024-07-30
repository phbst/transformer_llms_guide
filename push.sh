#!/bin/bash

# 提示用户输入提交信息
read -p "Enter commit message: " commit_message

# 将更改添加到暂存区
git add .

# 提交更改
git commit -m "$commit_message"

# 推送到远程仓库
git push