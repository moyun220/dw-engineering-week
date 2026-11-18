import random
from datetime import datetime, timedelta
import os

# 确保输出目录存在
os.makedirs("../data/raw", exist_ok=True)
file_path = "../data/raw/access_2026-11-14.log"

with open(file_path, "w") as f:
    for _ in range(800):
        ip = f"192.168.{random.randint(1,255)}.{random.randint(1,255)}"
        time_str = (datetime(2026, 11, 14, 0, 0, 0) + timedelta(seconds=random.randint(0, 86399))).strftime("%Y-%m-%d %H:%M:%S +0800")
        paths = ["/api/v1/health", "/api/v1/login", "/api/v1/order", "/api/v1/pay", "/api/v1/user"]
        weights = [60, 10, 20, 5, 5] 
        path = random.choices(paths, weights=weights, k=1)[0]
        statuses = [200, 404, 500, 502, 503]
        status_weights = [85, 10, 2, 2, 1]
        status = random.choices(statuses, weights=status_weights, k=1)[0]
        bytes_sent = random.randint(100, 5000)
        time_cost = random.randint(10, 2000)
        log_line = f'{ip} - - [{time_str}] "GET {path} HTTP/1.1" {status} {bytes_sent} {time_cost} "curl/8.4.0"\n'
        f.write(log_line)

print(f"✅ 成功生成 800 行 Nginx 日志，文件位置：{os.path.abspath(file_path)}")
