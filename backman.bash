#!/bin/bash -eu

appname="Backman🥠 "

# for debugging
n=

##### ##### ##### ##### #####

command -v rsync terminal-notifier > /dev/null

src="$1"
dest="$2"
ls "$src/" "$dest/" > /dev/null

now="$(date +%Y-%m-%d_%H-%M-%S)"
latest="$(ls -1t "$dest/" | head -n1)"

msg="Start backup on $(date)"
terminal-notifier -title "$appname" -subtitle "$src" -message "$msg"
echo "----- $msg -----"

if [[ -z $latest ]]; then
    set -x
    rsync -ahv${n} --delete "$src/" "$dest/$now"
    set +x
else
    set -x
    rsync -ahv${n} --delete --link-dest="$dest/$latest" "$src/" "$dest/$now"
    set +x
fi

touch "$dest/$now"

msg="Finish backup on $(date)"
terminal-notifier -title "$appname" -subtitle "$src" -message "$msg"
echo "----- $msg -----"

exit 0
