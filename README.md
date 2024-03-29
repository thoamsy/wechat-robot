# 说明

SwiftUI 和 iOS 初探项目, 想知道 SwiftUI 的能力边界和一些局限,相比 JSX 的优缺点和 Combine 的强大.
想实现一个企业微信发送器, 期望做到以下功能

- [x] 基本的增加编辑机器人, 并发送指定类型的信息
- [ ] 支持对 news 实时预览
- [ ] 整合 shortcut 的自动化
- [ ] 用点新特性, 比如 `CoreHaptic` 啥的
- [ ] Apple Watch ⌚️

终于完成了第一个基本需求了. 🌚

## 关于 Combine

目前发现自己还不是很了解 Combine 的这种理念, 只能使用 Subject 做点简单的事情.
可以通过这个[文档](https://heckj.github.io/swiftui-notes/?utm_source=Swift_Developments&utm_medium=email&utm_campaign=Swift_Developments_Issue_191&utm_term=2019-07-09)进行学习

## 更新记录

主要是我的代码中, 有所改动的地方
**PS: 每次升级真的改不动. 文档没有, 报错乱报. 真他妈无语**

不知道为啥, 我的代码在 beta5 里跑不起来了.

### Beta 5

1. `@BindableObject -> @ObservableObject`,  `@ObjectBinding -> @ObservedObject`, 新增 `@Published` 来节省之前无聊的 `willSet` 逻辑
2. `border(::cornerRadius)` 淘汰
3. `SegmentedControl -> Picker().pickerStyle(SegementedControl())` 
4. `tapAction -> onTapGesture`


### Beta 4

1. `BindableObject` 的协议改了, 叫做 `willChange` 并在 `willSet` 中 `send`.
2. 修复了 Preview 不能输入的问题
3. `PresentationLink` 被淘汰了, 采用新的 `sheet` 来展示 `Modal`. 使用方式类似 `navigationTitle`
4. `color` -> `foregroundColor`
5. `identified(by:)` 被废弃, 可以直接对 `ForEach, List` 指定 id.

更多调整参考 macOS [更新日志](https://developer.apple.com/documentation/macos_release_notes/macos_catalina_10_15_beta_4_release_notes)


## Bug

1. TextField 不支持中文, 在上面写中文光标会跳

## 感受

SwiftUI 解决不了的问题, 必须用到 UIKit. 目前对于 UIKit 还不是很熟悉, 所以发现写出了很多用不了的 View.

相比 JSX 动态语言的灵活性, SwiftUI 的能力就相比差很多了. 想用一些骚姿势写代码, 就告诉你 `some view` 和 `some view` 类型不同.
也主要我太久没写 Swift 了, 对于静态语言的边界没有很好的把握.

Combine 很爽, 目前只是用用静态的场景, 不需要异步. 什么都不管 `didChange.send(self)` 写一套就能同步数据了, 稳得一逼

Beta 4 之前 Bug 有点多, `Button` 配合 `Modal` 不支持通过 `@State` 来关闭, 只能采用 `PresentationLink` 来曲线救国.
`TextField` 只能在模拟器上跑起来, Preview 不行.
