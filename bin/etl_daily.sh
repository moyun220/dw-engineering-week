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

# 关键坑：如果你用的是相对路径，而 crontab 没有 cd，这里就会报错找不到文件
if [[ ! -f "$DATA_FILE" ]]; then
    log ERROR "数据文件 $DATA_FILE 不存在！任务终止。"
    exit 3
fi

log INFO "数据校验通过，处理完毕！"
