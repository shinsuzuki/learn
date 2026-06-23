# VSCode拡張機能

**「VS Code ES7 React/Redux/React-Native/JS snippets」** は、
**短い文字を打つだけで、Reactのひな形を自動で入れてくれる拡張機能**です。

ReactやJavaScript、TypeScriptのファイルで、よく使うコードをすばやく作れます。

対応する主なファイルは、次のようなものです。

* `.js`
* `.jsx`
* `.ts`
* `.tsx` ([Visual Studio Marketplace][1])

## まず理解すること

たとえば料理でいうと、
**「毎回レシピを最初から書かずに、定番の型を一瞬で出す道具」**
がスニペットです。

たとえば `rfce` と入力して Enter を押すと、
Reactコンポーネントのひな形が自動で入ります。
この拡張機能には、こうした定番の型がたくさん用意されています。

## よく使うもの

### 1. `rfce`

**関数でコンポーネントを作り、最後に `export default` まで入れたいとき**に使います。 

入力

```jsx
rfce
```

出てくる形の例

```jsx
import React from 'react'

function Sample() {
  return (
    <div>
      
    </div>
  )
}

export default Sample

```

※ この拡張機能の元の形では `import React from 'react'` が付く場合があります。
ただし、今のReactでは不要なことも多いです。拡張機能の設定で出さないようにもできます。

### 2. `rafce`

**アロー関数でコンポーネントを作り、最後に `export default` まで入れたいとき**に使います。

入力

```jsx
rafce
```

出てくる形の例

```jsx
import React from 'react'

const Sample = () => {
  return (
    <div>
      
    </div>
  )
}

export default Sample

```

これも `rfce` と同じで、
**書き方がアロー関数になる版**と考えるとわかりやすいです。

### 3. `clg`

**確認用のログ出力をすばやく入れたいとき**に使います。

入力

```jsx
clg
```

出てくる形の例

```jsx
console.log(object);
```

使いどころは、
**変数の中身を確認したいとき**です。


## まずはこう使えばOK

1. VS Codeで `App.jsx` などのファイルを開く
2. たとえば `rafce` と入力する
3. 候補が出たら Enter を押す
4. ひな形が自動で入る


## 初学者向けの覚え方

* `rfce`
  → 普通の関数で部品を作る
* `rafce`
  → アロー関数で部品を作る
* `clg`
  → `console.log` をすばやく入れる



## ひとことでまとめると

この拡張機能は、
**「Reactでよく書く定番コードを、短い合言葉で一気に出す道具」**
です。
最初は **`rfce` `rafce` `clg`** の3つを覚えれば十分です。