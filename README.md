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

1. このディレクトリへ移動

    $ cd /path/to/this/repository

2. Node.js の依存性を解決します（開発用、初回のみ）

    $ docker-compose -f docker-compose-dependencies.yml run result-app

3. アプリケーションを起動します

    $ docker-compose up

投票は 5000 番ポート、結果は 5001 番ポートで繋がります。


Docker イメージ
------------------

各サービスで利用されている Docker イメージは、すべて Docker Hub で自動的に生成されているものです。  
（データ転送速度向上のため、Docker 公式とは異なり、一部 [Alpine Linux](http://www.alpinelinux.org/) ベースのものに変更しています）

 - [pottava/python:2.7](https://hub.docker.com/r/pottava/python/)
 - [pottava/nodejs](https://hub.docker.com/r/pottava/nodejs/)
 - [java:7](https://hub.docker.com/_/java/)
 - [pottava/redis](https://hub.docker.com/r/pottava/redis/)
 - [kiasaki/alpine-postgres](https://hub.docker.com/r/kiasaki/alpine-postgres/)
