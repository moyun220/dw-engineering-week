#!/bin/bash
APP_NAME="etl_daily"
BIZ_DATE="${1:-2026-11-14}"
mkdir -p logs
LOG_FILE="logs/${APP_NAME}_${BIZ_DATE}.log"

log() {
  local line="$(date '+%F %T') $1 [${APP_NAME}] $2"
  echo "$line"
  echo "$line" >> "$LOG_FILE"
}

log INFO "任务开始执行..."

# 故意休眠 20 秒，用来测试 crontab 重叠和 flock 锁
sleep 20 

DATA_FILE="data/raw/access_${BIZ_DATE}.log"
# --- 下面是我新加的代码 --
LIMIT_ENABLED="true"
echo "DEBUG:测试"
LIMIT_VAL="100"
#新增:检查上游数据是否就绪
修复:如果文件不存在，直接跳过以防死锁
