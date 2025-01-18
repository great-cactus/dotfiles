#!/bin/bash
while IFS= read -r line; do
  # 空行またはコメント行をスキップ
  if [[ "$line" =~ ^[[:space:]]*$ ]] || [[ "$line" =~ ^# ]]; then
    continue
  fi

  # キーと値を分割
  IFS="=" read -r key value <<< "$line"

  # 値の周囲の空白を削除し、エクスポート
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)

  # エクスポート処理
  export "$key=$value"
done < "$1"

