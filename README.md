# https://kosendj-bu.in/

## setup

```shell
$ git clone git@github.com:kosendj/kosendj-bu.in.git
$ cd kosendj-bu.in
$ bundle install #require ruby
$ pnpm install
$ bundle exec middleman server
```

## deploy

```shell
$ cd kosendj-bu.in
$ bundle exec middleman build
$ git push origin master
```

`master` ブランチへの push をトリガーに GitHub Actions が `gh-pages` へ deploy します。

## メンバーを追加する

1. メンバーのアイコン画像を `source/images/members/` に配置する
2. `data/members.yml` に以下の形式でエントリを追加する

```yaml
-
  name: your_name
  icon: "members/your_name.jpg"
  description: 自己紹介文
  activities:
    -
      embed:
  services:
    -
      name: twitter
      url: https://example.com/your_name
```

- `services` には `web`, `twitter`, `soundcloud`, `mixcloud`, `YouTube`, `Spotify`, `last.fm`, `tumblr` などを指定できます。複数追加可能です。
- 画像ファイルは 500x500px の正方形を推奨します。

## イベント情報を更新する

`data/event.yml`（回数・日時・TwiPla URL・タイムテーブル）は `script/generate_event.rb` で生成します。

1. `script/generate_event.rb` 冒頭の定数を編集する
    - `NUMBER` … 回数
    - `DATE` … 開催日時の表示文字列（例: `2026.06.13 (Sat.) 14:00-20:00`）
    - `TWIPLA_URL` … TwiPla のイベント URL
    - `INPUT` … タブ区切り (`名前\tジャンル\t所要時間\t開始時間\t終了時刻`) のヒアドキュメント。スプレッドシートからコピペすることを想定しています
2. スクリプトを実行する

 ```shell
 $ ruby script/generate_event.rb
 ```

3. 生成された `data/event.yml` をコミットする

## TwiPla 用の HTML を生成する

TwiPla イベントページの説明欄に貼り付ける HTML を `script/generate_twipla.rb` で生成します。

前提として、上記の手順で `data/event.yml` が最新化されている必要があります。

1. 必要なら `script/generate_twipla.rb` 冒頭の定数（`VENUE`, `VENUE_ADDRESS`, `FEE`, `HASHTAG`, `TWITCH_URL`）を編集する
2. スクリプトを実行する

```shell
$ ruby script/generate_twipla.rb
```

3. 出力された `tmp/twipla.html`（gitignore 対象）の中身を TwiPla の説明欄に貼り付ける
