# docker-snell-server

## 环境变量

| 名称 | 默认值 |          说明           |
| :--: | :----: | :---------------------: |
| PORT |  2021  |  snell-sever 使用端口   |
| PSK  |        | 自定义 PSK,不填随机生成 |
| OBFS |  tls   |     off, http, tls      |

## 拉取镜像

```bash
docker pull vyron/snell
```

## 启动容器

```bash
docker run --name snell -p 2021:2021 --restart always -d vyron/snell:latest
```

## 查看配置

```bash
docker logs snell
```
