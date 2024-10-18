# 阶段一: 打包阶段
FROM golang:1.22-alpine as builder

# 为我们的镜像设置必要的环境变量
ENV GO111MODULE=on \
    GOPROXY=goproxy.io \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# 设置build目录
WORKDIR /build
# 先复制go.mod和go.sum文件，下载依赖
COPY go.mod ./
COPY go.sum ./

RUN go mod download
# 再复制其他代码文件
COPY . .

# 编译成可执行文件，其文件名为hello  编译的文件为 main.go
RUN go build -ldflags "-s -w" -o hello  main.go


## 阶段二 : 运行阶段
FROM alpine:3.14

# 设置工作目录
WORKDIR /app

# 从阶段一中复制二进制文件到这个新的阶段
COPY --from=builder  /build/hello /app

# 暴露端口
EXPOSE 8181

CMD ["./hello"]