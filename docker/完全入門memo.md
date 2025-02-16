# Docker仮想サーバー完全入門メモ

## dockerの主なコマンド
``` txt
- docker 
  - container  
            - run  
            - start  
            - stop  
            - rm  
  - compose
            - up  
            - run  
            - start  
            - stop  
            - down  
   - image  
            - build   
            - ls  
            - pull  
            - push  
            - rm  
    - nework  
            - crate  
            - ls  
            - rm  
    - volume  
            - create  
            - ls  
            - rm  
```

## container操作

### コンテナ作成、実行
```ps1
> docker container run --name apache1 --publish 808080 --deatch --rm httpd
```

### コンテナ停止
```ps1
> docker contanier stop apache1
```

### コンテナ削除
```ps1
docker container rm apache1
```

## compse操作

### compose作成、実行
```ps1
> docker compose up --deatch
```

### compose停止
```ps1
> docker compose stop

```
### comppose再開

```ps1
> docker compose start
```

### compose一覧
```
```ps1
> docker compose ls
```

### compose削除
```ps1
> docker compose down --rmi all
```
※オプションによりイメージやボリュームを削除

```ps1
> docker compose rm
```
※停止後に削除
※ネットワークは削除しない


### compose copy
```ps1
> docker compose cp [コンテナ名:コンテナのファイルパス] [ホストのファイルパス]
```

```ps1
> docker compose cp [ホストのファイルパス] [コンテナ名:コンテナのファイルパス]
```

### コンテナ内でコマンドを実行
```ps1
> docker compose exec コンテナ名 実行するコマンド  

> docker compose exec コンテナ名 実行するコマンド bash
```

### コンテナ内のログ
```ps1
> docker compose logs コンテナ名
```

### コンテナのイメージをビルド
```ps1
> docker compose build  

# キャッシュを使用せずビルド
> docker compose build --no-cache

# 再ビルドと実行
> docker compose up -d --build  
```



## image操作

### イメージ一覧

```ps1
> docker image ls
```


## network操作

### ネットワーク一覧

```ps1
> docker network ls
```
