name="sato"
echo $name

count=$(ls | wc -l)
echo "count: $count"

today=$(date)
echo "$today"

path="home/$USER/app"
echo "$path"

# 本日のyyyy-mm-ddを取得したい
today_formatted=$(date +%Y-%m-%d)
echo "$today_formatted"

# 配列を作成したい
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"
do
    echo "$fruit"
done





