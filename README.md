# rssSub
> 为Dice!编写的可插件化管理的rss订阅mod


[![](https://img.shields.io/github/issues/HsiangNianian/rssSub)](https://github.com/HsiangNianian/rssSub/issues) [![](https://img.shields.io/github/issues-pr/HsiangNianian/rssSub)](https://github.com/HsiangNianian/rssSub/pulls)[![GitHub last commit](https://img.shields.io/github/last-commit/HsiangNianian/rssSub.svg)](https://github.com/HsiangNianian/rssSub/commits) [![release](https://img.shields.io/github/v/release/HsiangNianian/rssSub.svg)](https://github.com/HsiangNianian/rssSub/releases)
```json
{
    "mod":"rssSub",
    "author":"简律纯",
    "ver":"release-1.1.0",
    "dice_build":636,
    "brief":"rss订阅推送",
    "comment":"",
    "repo":"https://ghproxy.com/https://github.com/HsiangNianian/rssSub.git",
    "helpdoc":{
        "rssSub":"RssSub release-1.1.0\n指令列表:\n1.添加一个rss源订阅至监听列表:\n\t【{strRssSubAdd}[(\\f)url]】\n2.删除rss监听列表里指定的源:\n\t【{strRssSubRemove}[分片url]]】\n3.添加窗口到通知列表:\n\t【{strRssSubSwitchOn}[user_id,group_id]】\n4.删除通知列表里的指定窗口:\n\t【{strRssSubSwitchOff}[user_id,group_id]】\n5.列出所有监听列表里的源:\n\t【{strRssSubListAll}】\n6.调试模式开关(开启会将所有回应存入script/log/xxx.log文件内):\n\t【{strRssSubDebugOn}】\n\t【{strRssSubDebugOff}】\n\ngithub repo:\nhttps://github.com/HsiangNianian/rssSub"
    }
}
```

## To-Do

- [x] 群订阅
- [ ] 设置推送时间

## 1. install

- Dice版本(636+)以上安装方法:

  1. 在 `./DiceQQ/conf/mod/source.list`文件内（没有mod文件夹和这文件就新建）输入 `https://ssjskfjdj.netlify.app/Module/`。
  2. 使用 `.system load`命令重载bot，这样做的目的是为了让步骤1里的远程地址生效。
  3. 对bot发送 `.mod get rssSub`命令，等待安装。
  4. 回到第二步，这样做的目的是为了让mod被加载。
  5. Enjoy Your Self!
- Dice版本(636)以下安装方法：
 ```
 - 无法使用: 因为版本太低不支持`*.toml`文件
 ```

## 2.概览
如果安装/更新成功了，那么bot会回复以下消息。
```
{self}所载模块详细信息:[xx]rssSub
- 版本: release-1.1.0
- 作者: 简律纯
- 简介: 支持插件化管理的rss订阅推送mod
- 事件: 1条
- 回复: 7项
- 脚本: 18份
- 帮助: 1条
- 台词: 26项
```
涉及的用户配置：
```lua
1. UserConf(getDiceQQ(), "RssSubDebugger") --"on"/"off"
```
## 3.命令
> 以下命令可使用`.help rssSub`呼出，同时均🉑在`mod/rssSub/speech/strRssSub.yml`文件中自定义（见第五节），里面的回复也可以修改，支持多个回复。
- 订阅rss
 `{strRssSubAdd}` 默认为 `订阅rss`
- 退订rss
 `{strRssSubRemove}` 默认为 `退订rss`
- 添加当前聊天窗口到通知列表
 `{strRssSubSwitchOn}` 默认为 `开启rss订阅`
- 删除通知列表里的指定窗口（默认当前）
 `{strRssSubSwitchOff}` 默认为 `关闭rss订阅`
- 列出所有监听列表里的源
 `{strRssSubListAll}` 默认为 `全部rss源`
- 调试模式（开启后会将所有回复以log形式发送并保存在`mod/rssSub/script/log/xxxx-xx-xx.log`文件内）
 - 开启:
  `{strRssSubDebugOn}` 默认为 `开启调试模式`
 - 开启关闭:
  `{strRssSubDebugOff}` 默认为 `关闭调试模式`

## 4.示例
- 订阅rss
 ```
 简律纯:
 订阅rss
 https://academic.jyunko.cn/feed.xml
 
 krypton:
 成功添加新的rss订阅✓
 ```

## 5.个性化
```yaml
# Add
strRssSubAdd: ["订阅rss"]
strRssSubAddFail: ["添加rss源失败！"]
strRssSubAddSuccess: ["成功添加新的rss订阅√", "添加成功~"]
strRssSubAlreadyAdded: ["已添加过该rss源"]
# Remove
strRssSubRemove: ["退订rss"]
strRssSubRemoveFail: ["删除失败!", "删除时遇到了点困难"]
strRssSubRemoveSuccess: ["删除成功√", "成功退订此rss源"]
strRssSubAlreadyRemoved: ["监听列表本就没有此rss源"]
# List
strRssSubListAll: ["全部rss源"]
strRssSubListNone: ["没有找到rss源"]
strRssSubListRespo: ["列出以下rss源:\n"]
# Switch
strRssSubSwitchOn: ["开启rss订阅"]
strRssSubSwitchOff: ["关闭rss订阅"]
strRssSubSwitchOnFail: ["开启本窗口的rss订阅通知失败！"]
strRssSubSwitchOffFail: ["关闭本窗口的rss订阅通知失败！"]
strRssSubSwitchAlreadyOn: ["本窗口已经开启rss订阅通知"]
strRssSubSwitchAlreadyOff: ["本窗口已经关闭rss订阅通知"]
strRssSubSwitchOnSuccess: ["成功开启本窗口的rss订阅通知"]
strRssSubSwitchOffSuccess: ["成功关闭本窗口的rss订阅通知"]
# Listen
strRssSubListener: ["更新了。"]
# Debug
strRssSubDebugOn: ["开启调试模式"]
strRssSubDebugOff: ["关闭调试模式"]
strRssSubDebugAlreadyOff: ["调试模式已经关闭"]
strRssSubDebugAlreadyOn: ["调试模式已经开启"]
strRssSubDebugOnSuccess: ["调试模式开启成功"]
strRssSubDebugOffSuccess: ["调试模式关闭成功"]
```

## 6.测试
添加一个rss订阅后，要怎么知道到底管不管用呢？在已经设置了通知窗口的前提下（简单粗暴私聊发送`开启rss订阅`）可以进行如下测试：
1. 随意修改`mod/rssSub/script/src/xxx_xxx.xml`文件，这里的`xxx_xxx`形如`baidu_com`，是rss网址的`_`字符串体现。
2. 保存。
3. 等待片刻。
4. bot发送更新提示。
