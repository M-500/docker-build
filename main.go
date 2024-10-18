package main

import "github.com/gin-gonic/gin"

func main() {
	engine := gin.Default()
	engine.GET("hello", func(ctx *gin.Context) {
		ctx.String(200, "你干嘛~~~~~诶哟~~~~！！！")
	})

	engine.Run(":8181")
}
