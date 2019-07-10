# 说明

SwiftUI 和 iOS 初探项目, 想知道 SwiftUI 的能力边界和一些局限,相比 JSX 的优缺点和 Combine 的强大.
想实现一个企业微信发送器, 期望做到一下功能

1. 基本的增加编辑机器人, 并发送指定类型的信息
2. 整合 shortcut 的自动化
3. 瞎搞

目前第一步都没有完成 🌚

## 感受

相比 JSX 动态语言的灵活性, SwiftUI 的能力就相比差很多了. 想用一些骚姿势写代码, 就告诉你 `some view` 和 `some view` 类型不同.
也主要我太久没写 Swift 了, 对于静态语言的边界没有很好的把握.

Combine 很爽, 目前只是用用静态的场景, 不需要异步. 什么都不管 `didChange.send(self)` 写一套就能同步数据了, 稳得一逼

目前 Bug 有点多, `Button` 配合 `Modal` 不支持通过 `@State` 来关闭, 只能采用 `PresentationLink` 来曲线救国.
`TextField` 只能在模拟器上跑起来, Preview 不行.
