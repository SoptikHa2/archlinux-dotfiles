# Utilities

Scripts and programs that I use rarely, but are still useful.

## Messenger takeout: json -> csv (interesting fields only)

Use this after fixing file encoding with one of the scripts here.

```sh
jq '.messages[]' fixed-messages.json | tr -d '{\n' | tr '}' '\n' | grep ' *"sender_name"' | sed 's/"[^"]*": //g' | sed 's/\[          //'
```

