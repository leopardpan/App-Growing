# 本地测试服务

### 安装pip
```bash
sudo easy_install pip
```

### 安装Flask
```bash
sudo pip install flask
```

### 安装Flask-RESTful
```bash
sudo pip install flask-restful
```

### 使用测试服务
进入 App-Growing/Server/API-1/ 执行命令：
```bash
python api.py
```
在浏览器输入: http://127.0.0.1:4000/todos , 看到test.json 里面的信息。       
也可以把 127.0.0.1 换成你 Wifi 的IP, 在同一个Wifi下就其它的设备也可以访问了。



### 学习资料：
[flask-restful官方文档](http://www.pythondoc.com/Flask-RESTful/index.html)                                     

### 注意：
启动Server时必须指定主机地址为 `0.0.0.0` , 才能让其它电脑访问。 Port不要为80端口, 否则会有防火墙限制。例如：

```bash
app.run(host='0.0.0.0',port=4000,debug=True)
```




