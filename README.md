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
