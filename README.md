## Backman🥠

- 指定したディレクトリ配下を別のディレクトリに一括コピーします
	- コピーを取得します
- 2回目以降は前回バックアップからの増分のみコピー(差分の無いファイルはハードリンクを作成)するため、ディスクを圧迫しません
- 現状、バックアップのローテーション(削除)機能はありません。そのうちつけるかも

## Requirement

Macでの使用を想定しています

```
# 事前に以下をインストール
brew install rsync
brew install terminal-notifier
```

## Usage

```
# 初回実行時、destは空ディレクトリを作成しておくこと
mkdir "/path_to_dest/hands_backup"

# 直接実行の場合
/path_to_script/backman.bash "/path_to_source/hands" "/path_to_dest/hands_backup"

# crontabで指定する場合
0 13 * * * PATH="/usr/local/bin:$PATH" /path_to_script/backman.bash "/path_to_source/hands" "/path_to_dest/hands_backup" > "/path_to_log/backman_$(date +\%s)_$$.log" 2>&1

# 実行の度に、destディレクトリにサブディレクトリができます
❯ ll /path_to_dest/hands_backup
total 0
drwxr-xr-x  11 xxxx  staff   352B Oct 20 15:47 2018-10-20_15-46-41
drwxr-xr-x  11 xxxx  staff   352B Oct 20 15:50 2018-10-20_15-49-50
drwxr-xr-x  11 xxxx  staff   352B Oct 20 16:04 2018-10-20_16-03-44
drwxr-xr-x  11 xxxx  staff   352B Oct 20 16:05 2018-10-20_16-05-08
drwxr-xr-x  11 xxxx  staff   352B Oct 20 16:08 2018-10-20_16-07-47
drwxr-xr-x  11 xxxx  staff   352B Oct 20 16:31 2018-10-20_16-31-00

# 前回実行時より差分のなかったファイルはハードリンクが作られます
❯ ll -i /path_to_dest/hands_backup/*/scripts/backman.bash
7040410 -rwxr--r--  2 xxxx  staff   473B Oct 20 15:38 2018-10-20_15-46-41/scripts/backman.bash
7040410 -rwxr--r--  2 xxxx  staff   473B Oct 20 15:38 2018-10-20_15-49-50/scripts/backman.bash
7299961 -rwxr--r--  1 xxxx  staff   615B Oct 20 16:03 2018-10-20_16-03-44/scripts/backman.bash
7377279 -rwxr--r--  1 xxxx  staff   623B Oct 20 16:05 2018-10-20_16-05-08/scripts/backman.bash
7458912 -rwxr--r--  2 xxxx  staff   631B Oct 20 16:07 2018-10-20_16-07-47/scripts/backman.bash
7458912 -rwxr--r--  2 xxxx  staff   631B Oct 20 16:07 2018-10-20_16-31-00/scripts/backman.bash
```
