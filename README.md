# rssSub
为Dice!编写的rss订阅mod

[![](https://img.shields.io/github/issues/A2C29K9/rssSub)](https://github.com/A2C29K9/rssSub/issues) [![](https://img.shields.io/github/issues-pr/A2C29K9/rssSub)](https://github.com/A2C29K9/rssSub/pulls)[![GitHub last commit](https://img.shields.io/github/last-commit/A2C29K9/rssSub.svg)](https://github.com/A2C29K9/rssSub/commits) [![release](https://img.shields.io/github/v/release/A2C29K9/rssSub.svg)](https://github.com/A2C29K9/rssSub/releases)
```json
{
    "mod":"rssSub",
    "author":"简律纯",
    "ver":"release-0.1.2",
    "dice_build":636,
    "brief":"rss订阅推送",
    "comment":"",
    "repo":"https://ghproxy.com/https://github.com/A2C29K9/rssSub.git",
    "helpdoc":{
        "rssSub":"RssSub release-0.1.1\n指令列表:\n1.添加一个rss源订阅至监听列表:\n\t【{strRssSubAdd}[(\\f)url]】\n2.删除rss监听列表里指定的源:\n\t【{strRssSubRemove}[(\\f)url|number]】\n3.添加窗口到通知列表:\n\t【{strRssSubSwitchOn}[user_id,group_id]】\n4.删除通知列表里的指定窗口:\n\t【{strRssSubSwitchOff}[user_id,group_id]】\n5.列出所有监听列表里的源:\n\t【{strRssSubListAll}】\n6.调试模式开关(开启会将所有回应存入script/log/xxx.log文件内):\n\t【{strRssSubDebugOn}】\n\t【{strRssSubDebugOff}】\n\ngithub repo:\nhttps://github.com/A2C29K9/rssSub"
    }
}
```

## To-Do

- [x] 群订阅
- [ ] 设置推送时间

## 1. install

- Dice版本2.6.5beta12(624+)以上安装方法:

  1. 在 `./DiceQQ/conf/mod/source.list`文件内（没有mod文件夹和这文件就新建）输入 `https://ssjskfjdj.netlify.app/Module/`。
  2. 使用 `.system load`命令重载bot，这样做的目的是为了让步骤1里的远程地址生效。
  3. 对bot发送 `.mod get rssSub`命令，等待安装。
  4. 回到第二步，这样做的目的是为了让mod被加载。
  5. Enjoy Your Self!
- Dice版本2.6.4b(612+)以上安装方法：

  1. 浏览器访问 `https://github.com/A2C29K9/rssSub`并点击绿色按钮 `Code`下的 `Download Zip`按钮下载仓库压缩包。
  2. 解压压缩包，将里面的文件和文件夹全部丢进 `./DiceQQ/mod/`文件夹内。
  3. 使用 `.system load`命令重载。
  4. Enjoy Your Self!
