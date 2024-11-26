# Quick Start

```
docker compose -f docker-compose.dev.yml up -d

rails db:migrate

# 编辑credentials
EDITOR="vim" rails credentials:edit --environment development
# 生产环境
EDITOR="code --wait" rails credentials:edit --environment production

rails s
```

# 重置环境

```
# 停止并删除容器和网络（保留数据卷）
docker compose -f docker-compose.dev.yml down

# 停止并删除容器、网络和数据卷
docker compose -f docker-compose.dev.yml down -v

# 重新创建并启动
docker compose -f docker-compose.dev.yml up -d
```

# 测试

```
docker compose -f docker-compose.test.yml up -d
```

