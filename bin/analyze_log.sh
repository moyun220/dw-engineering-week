#!/bin/bash
echo "=== 开始分析日志 ==="

echo "1. 总 PV 数:"
wc -l < ../data/raw/access_2026-11-14.log

echo "2. 独立 IP (UV) 数:"
awk '!seen[$1]++ {count++} END {print count}' ../data/raw/access_2026-11-14.log

echo "3. 访问最多的 Top 3 接口:"
awk '{print $8}' ../data/raw/access_2026-11-14.log | sort | uniq -c | sort -rn | head -n 3
