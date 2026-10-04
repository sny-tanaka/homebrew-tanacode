# homebrew-tanacode

[tanacode](https://github.com/sny-tanaka/tanacode)（Claude Code と IDE をひとつにした macOS 用のデスクトップアプリ）の Homebrew の tap。

## インストール

```bash
brew install --cask sny-tanaka/tanacode/tanacode
```

tap の追加（`brew tap sny-tanaka/tanacode`）も一緒に済みます。Apple Silicon・Intel のどちらでも、その Mac に合った zip を tanacode の [Releases](https://github.com/sny-tanaka/tanacode/releases) から入れます。

必要なものは tanacode の [README](https://github.com/sny-tanaka/tanacode#必要なもの) を参照。

## 更新

```bash
brew upgrade --cask tanacode
```

更新の前に、tanacode をメニューの「ファイル → Claude Code も止めて終了」で終了してください。アプリの入れ替えで、動いている Claude Code が途中で切れないようにするためです。

tanacode の新しいバージョンを公開すると、この tap の cask も自動で新しいバージョンになります。

## アンインストール

先に、メニューの「ファイル → Claude Code も止めて終了」で終了します。

```bash
brew uninstall --cask tanacode          # アプリだけを消す
brew uninstall --cask --zap tanacode    # 設定やセッションの記録（~/Library/Application Support/tanacode/）も消す
```

Claude Code の会話ログ（`~/.claude/`）は Claude Code のものなので残ります。

## 署名について

tanacode は個人で作っているため、Apple の署名・公証は未取得。そのままでは、macOS がダウンロードしたアプリに付ける実行前の確認の印（quarantine 属性）のせいで、起動できません。

そこでこの tap の cask は、インストールと更新のたびに、`tanacode.app` だけから quarantine 属性を外します（`xattr -dr com.apple.quarantine /Applications/tanacode.app`）。tanacode の README で zip から入れるときに案内しているコマンドと同じもの。この tap を信頼してインストールする場合に限った、意図的な回避です。

Homebrew は、ダウンロードしたファイルが cask に書いた SHA-256 と一致するかを確かめてから入れます。cask の SHA-256 は、tanacode のリリースの `SHA256SUMS.txt` と同じ値。

## 仕組み

`Casks/tanacode.rb` の `version` と `sha256` は、tanacode のリリースの公開のあとに、tanacode の [`.github/workflows/homebrew.yml`](https://github.com/sny-tanaka/tanacode/blob/develop/.github/workflows/homebrew.yml) が書き換えます。書き換えの前に、その cask で実際にインストールし、quarantine 属性が外れることを確かめます。書き込みには、この tap にだけ書き込める GitHub App を使います。

不具合・要望は tanacode の [Issues](https://github.com/sny-tanaka/tanacode/issues) へ。
