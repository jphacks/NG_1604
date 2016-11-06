# Akicoma
[![Xcode](https://img.shields.io/badge/Xcode-8.0-orange.svg)](https://developer.apple.com/xcode/)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org/)
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-orange.svg?style=flat)](https://www.apple.com/nl/ios/)
[![Homebrew](https://img.shields.io/badge/Homebrew-1.0.5-orange.svg)](http://brew.sh/index_ja.html)
[![CocoaPods](https://img.shields.io/badge/CocoaPdos-1.1.1-orange.svg)](https://cocoapods.org)
[![SwiftLint](https://img.shields.io/badge/SwiftLint-0.11.1-orange.svg)](https://github.com/realm/SwiftLint)

## セットアップ
- SwiftLint のインストール
```
$ brew install swiftlint
```

- gem のインストール
```
$ bundle install --path=vendor/bundle
```

- カラーパレットのインストール
```
$ make install
```

- ライブラリのインストール
```
$ pod install
```

## 製品概要
### Coma Tech

### 背景（製品開発のきっかけ、課題等）
私たち大学生はみな、大きなひとつの課題を抱えています。講義の隙間時間である「空きコマ」です。
これは、聴講したい講義を履修するとほぼ必ず生まれてしまう、いわば無駄な時間です。さらにひどいことに、空きコマはたった一度きりではなく、毎週やってきます。

この時間は、半期で１コマにつき、1.5時間 x 15週 = 22.5時間にも及びます。
この22.5時間を有効活用することができれば大学生活はもっと充実したものになることは間違いありません。

Akicoma大学生活において、必ず生まれてしまう隙間時間の空きコマを有効活用しましょう。

### 製品説明（具体的な製品の説明）

### 特長
#### 1. プロフィールと空きコマを分析し、毎朝9時に10人の学生をレコメンドする
リコメンド方法として、登録した空きコマを照らし合わし、共通の空きコマを持つユーザを探す。また、単に空きコマの時間が共通であるだけでなく、自己紹介文の分析により、より有効性のあるユーザをリコメンドするシステムを実装した。

#### 2. 空きコマを有効活用することにフォーカスしたインターフェース設計
空きコマを有効活用して大学生活に新しい風を送り込むことのみにフォーカスし、無駄のないインターフェースをデザインした。ターゲットとなる大学生が主に使用する既存のアプリケーションのインターフェースをおかさないものとした。


### 解決出来ること


### 今後の展望


### 注力したこと
##### [iOS]
* バグのないコーディング
* 責務を分けてチーム開発しやすい設計

##### [API]
* 自己紹介文と共通の空きコマによるユーザーマッチング
* スケールするインフラ設計

##### [デザイン]
* 空きコマを有効活用することにフォーカスしたUI設計
* マッチング率を向上させるUX


## 開発技術
### 活用した外部技術
#### API・データ
##### [iOS]
* Firebase
* NTTレゾナント 形態素解析

##### [API]
* Heroku


#### フレームワーク・ライブラリ・モジュール
##### [iOS]
* Swift3
* Cococapods
* SwiftLint

##### [API]
* node.js
* npm
* koa
* es6
* mongoDB
* word2vec

##### [デザイン]
* SketchTool
* npm
* gulp


### 独自技術
#### 期間中に開発した独自機能・技術
* マッチングアルゴリズム
* デザインファイル共有支援ツール


#### 研究内容（任意）
* なし
