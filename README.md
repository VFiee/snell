# docker-snell-server

## 环境变量

|  名称   | 默认值 |          说明           |
| :-----: | :----: | :---------------------: |
|  PORT   |  2021  |  snell-sever 使用端口   |
|   PSK   |        | 自定义 PSK,不填随机生成 |
|  OBFS   |  tls   |     off, http, tls      |
| REBUILD |  off   |   重新生成配置,on,off   |

## 拉取镜像

```bash
docker pull vyronfiee/snell/snell
```

## 启动容器

```bash
docker run --name snell -p 2021:2021 --restart always -d vyronfiee/snell:latest
```

## 查看配置

```bash
docker logs snell
```

## 添加配置

```conf
# View psk value through docker logs
My-Snell-Server = snell,ip, port, psk= custom psk, obfs=tls, version=2, tfo=true
```
