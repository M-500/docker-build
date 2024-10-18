# 阶段一: 打包阶段
FROM golang:1.22-alpine as builder

# 设置build目录
WORKDIR /build

COPY . .
RUN go mod tidy

# 编译成可执行文件，其文件名为hello  编译的文件为 main.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o hello main.go


## 阶段二 : 运行阶段
FROM alpine:3.14

# 设置工作目录
WORKDIR /app

# 从阶段一中复制二进制文件到这个新的阶段
COPY --from=builder  /build/hello /app

# 暴露端口
EXPOSE 8181

CMD ["./hello"]