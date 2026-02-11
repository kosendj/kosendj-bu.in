# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

高専DJ部（kosendj-bu）のウェブサイト。Middleman（Ruby製静的サイトジェネレータ）で構築されたシングルページサイト。
ドメイン: kosendj-bu.in / ホスティング: GitHub Pages（gh-pages ブランチ）

## 開発コマンド

```bash
# セットアップ
bundle install
pnpm install

# 開発サーバー起動（localhost:4567、livereload: 35729）
bundle exec middleman server

# ビルド（./build に出力）
bundle exec middleman build
```

Docker でも開発可能: `docker compose up` でポート4567にサーバーが起動する。

## テスト

テストスイートは存在しない。CI（GitHub Actions）では `bundle exec middleman build` の成功をもって検証している。

## デプロイ

master ブランチへの push で GitHub Actions が自動的に build → gh-pages ブランチへデプロイする。

## アーキテクチャ

### SCSS コンパイルパイプライン

Middleman の external_pipeline 機能を利用。`config.rb` で設定:
- 開発時: `pnpm run watch`（Sass watch モード）
- ビルド時: `pnpm run build`（Sass 一回実行）
- `source/stylesheets/all.css.scss` → `.tmp/all.css` → Middleman が取り込み

`source/stylesheets/*.scss` は Middleman 側で ignore され、外部パイプラインのみで処理される。

### テンプレート

- レイアウト: `source/layouts/layout.slim` — meta タグ、Google Fonts、FontAwesome、GTM を読み込む
- メインページ: `source/index.html.slim` — Slim テンプレートで全セクション（EVENT, MEMBER, GALLERY, ACCESS）を構成

### データファイル（`data/`）

Middleman の Data Files 機能により `data.event`、`data.members` としてテンプレートからアクセスされる。

- `data/event.yml` — 次回イベントの日時・タイムテーブル
- `data/members.yml` — メンバー情報（name, icon, description, services）
- `archive/` — 過去イベントの YAML（01〜41）

### メンバー追加時の構造

`data/members.yml` にエントリを追加し、画像を `source/images/members/` に配置する。
サービスアイコンのマッピングは `source/index.html.slim` 内の `service_icons` ハッシュで定義されている。
対応サービス: twitter, soundcloud, mixcloud, web, YouTube, Spotify, last.fm, tumblr, twitch

### ランタイムバージョン

`.ruby-version`、`.node-version`、`package.json#packageManager` で管理。

## イベント更新時の変更箇所

- `data/event.yml` — 日時・タイムテーブル
- `source/index.html.slim` — イベント回数（「第41回」）、TwiPla URL、Twitch 配信 URL、注意書き内リンク

## Gotchas

- SCSS は `source/stylesheets/all.css.scss` の単一ファイル構成。Middleman の ignore 設定により `source/stylesheets/` 内の SCSS は直接処理されず、外部パイプライン（`.tmp/all.css`）経由のみ
- ヒーロー画像は JavaScript で `source/images/pc/mv0-5.jpg`（または `sp/`）からランダム選択される。画像追加・削除時は `index.html.slim` 末尾の JS も変更が必要
- `data/members.yml` の services.name は `index.html.slim` 内の `service_icons` ハッシュのキーと完全一致が必要（大文字小文字区別あり: `YouTube`, `last.fm` など）
