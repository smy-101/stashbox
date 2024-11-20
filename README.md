# Quick Start

```
docker compose -f docker-compose.db.yml up -d

rails db:migrate

rails s
```

## 重置环境

```
# 停止并删除容器和网络（保留数据卷）
docker compose -f docker-compose.db.yml down

# 停止并删除容器、网络和数据卷
docker compose -f docker-compose.db.yml down -v

# 重新创建并启动
docker compose -f docker-compose.db.yml up -d
```

