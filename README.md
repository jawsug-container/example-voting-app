投票アプリ
==================

これはマイクロサービスと Docker によるサンプルアプリケーションです。  
Docker Compose で起動し、Docker Networking を使いお互いに通信します。  
（バージョン 1.6 以降の Docker Compose が必要です）


アーキテクチャー
------------------

* voting-app: Python による Web アプリケーション。2つの選択肢のいずれかに投票できます。
* result-app: Node.js による Web アプリケーション。リアルタイムに投票の結果を表示します。
* worker: Java によるワーカー。Redis から投票データを取得し、Postgres に保存します。
* redis: Redis サーバ。新規投票を収集します。
* db: PostgreSQL サーバ。投票結果を保持します。


起動手順
------------------

１. このディレクトリへ移動

```
git clone <this-repository>
cd example-voting-app
```

２. 各サービスの依存性を解決（初回 + 依存性変更後）

```
docker-compose -f docker-compose-dependencies.yml run voting-app
docker-compose -f docker-compose-dependencies.yml run result-app
docker-compose -f docker-compose-dependencies.yml run worker
```

３. アプリケーションの起動

```
export OPTION_A=Cats OPTION_B=Dogs
docker-compose up -d
```

投票は 5000 番ポート、結果は 5001 番ポートで繋がります。


その他
------------------

* ログの確認

```
docker-compose logs
（停止: Ctrl + C）
```

* 投票画面の文言を変えてみる

投票画面の文字は、環境変数で切り替わるようになっています。

```
export OPTION_A="Star Wars" OPTION_B="Star Trek"
docker-compose stop voting-app
docker-compose rm -f voting-app
docker-compose up -d
```

* 投票**結果**画面の文言を変えてみる

投票結果画面の文字は、HTML にベタ書きされています。

`/result-app/views/index.html` の Cats や Dogs を書き換えてみましょう。  
ブラウザを更新すると、投票結果画面の文字が変わります。


Docker イメージ
------------------

各サービスで利用されている Docker イメージは、すべて Docker Hub で自動的に生成されているものです。  
（データ転送速度向上のため、Docker 公式とは異なり、一部 [Alpine Linux](http://www.alpinelinux.org/) ベースのものに変更しています）

 - [pottava/python:2.7](https://hub.docker.com/r/pottava/python/)
 - [pottava/nodejs](https://hub.docker.com/r/pottava/nodejs/)
 - [pottava/maven:3.3-java7](https://hub.docker.com/r/pottava/maven/)
 - [pottava/redis](https://hub.docker.com/r/pottava/redis/)
 - [kiasaki/alpine-postgres](https://hub.docker.com/r/kiasaki/alpine-postgres/)
