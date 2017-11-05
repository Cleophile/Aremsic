# Aremsic
项目介绍
Aremsic通过分析文本中语言文字的情感，来推荐契合该情感的音乐，从而帮助读者更好地理解文章，使读者身临其境。
同时，Aremsic也能帮助内容生产者在写文章时获得灵感，记录下这一刻的心情，提升了作品的连贯性。

问题解决步骤
在设计上，采用目前在App Store上较为流行的插件形式，即重心在插件，而本体的作用仅作为应用介绍和使用方式说明。
优点是在大部分iPhone Application采用single view的条件下，无需切换应用即可达成目的。
具体解决步骤如下：
1. 获取选中文本。当用户通过选中文本->共享->Aremsic操作后，立即调用viewDidLoad方法，解析用户选中的内容并过滤非文本内容，将文本内容处理为标准的json
格式，存储于应用程序的动态文件夹下。
2. 在Objective-C和Python之间创建接口，将原始文本转化成的json文件导入Python程序中。
3. 核心算法部分
代码地址
https://github.com/yixuan-wei/sentiment-analysis
https://github.com/yixuan-wei/web_crawler
3.1 进行文本情绪解析：将json发送至IBM Cloud-Tone Analyzer,获得有关情绪json格式的反馈（result.json）
3.2 通过接口将result.json发回Objective-C App，解析成情绪名+得分的Dictionary
3.3 利用web_crawler解析歌曲歌词的情绪，判断整首歌的情绪，同时去除重复项
3.4 将文本和歌词的情绪进行匹配，将歌曲的相关信息（歌曲名，url等）发回Objective-C
4. 将选中的文本，和情绪分析和歌曲推荐组合成一个弹窗界面，查看完毕后用户可以单击 Done/完成 按钮退出并回到原界面。
Objective-C部分主要代码：https://github.com/Cleophile/Aremsic/tree/master/MainAction

操作指南
1. 任意打开一篇文章（如HACKxFDU微信推送），截取一段文字，点击“分享”（“Share”）
2. 在分享界面第二行点击“Aremsic”
3. 进入“Aremsic”欢迎界面
4. Aremsic会自动分析语言所含情感，并在原句下方显示推荐音乐名称、演唱者（Artist）和该音乐收听链接（URL）
