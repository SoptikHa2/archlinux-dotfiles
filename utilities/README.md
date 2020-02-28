# Utilities

Scripts and programs that I use rarely, but are still useful.

## Facebook takeout

### Messenger messages: json -> csv (interesting fields only)

Use this after fixing file encoding with one of the scripts here.

```sh
jq '.messages[]' fixed-messages.json | tr -d '{\n' | tr '}' '\n' | grep ' *"sender_name"' | sed 's/"[^"]*": //g' | sed 's/\[          //'
```

### Messenger messages: frequency per day
(from csv file)

```sh
for line in $(csvcut file.csv -c 2 | tac); do  
day_value=$(echo "$(bc <<< "($line / 1000) / 86400")" | awk -F'.' '{print $1}')
echo "$day_value"
done | uniq -c > perday.txt
```
