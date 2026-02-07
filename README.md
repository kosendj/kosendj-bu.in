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
