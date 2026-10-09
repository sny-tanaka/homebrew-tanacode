# version と sha256 は、tanacode のリリースの公開のあとに、tanacode の .github/workflows/homebrew.yml が書き換えます。手では直しません
cask "tanacode" do
  arch arm: "arm64", intel: "x64"

  version "1.2.3"
  sha256 arm:   "0758b4d64b30539dd1800c6c768d211c215ac79b65753b92b99bad77b7f4813c",
         intel: "64fede6ffede749ff57ed51fd9db3f162c60eb09409119d28115fa634f184e75"

  url "https://github.com/sny-tanaka/tanacode/releases/download/v#{version}/tanacode-#{version}-mac-#{arch}.zip"
  name "tanacode"
  desc "Claude Code と IDE をひとつにしたデスクトップアプリ"
  homepage "https://github.com/sny-tanaka/tanacode"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "tanacode.app"

  # 署名・公証をしていないため、tanacode.app だけから quarantine の印（ダウンロードしたアプリに付く実行前の確認の印）を外します。-s は、アプリの中のシンボリックリンク自身の印も外すため
  postflight_steps do
    run "/usr/bin/xattr", args: ["-drs", "com.apple.quarantine", "{{appdir}}/tanacode.app"]
  end

  zap trash: "~/Library/Application Support/tanacode"

  caveats <<~EOS
    更新（brew upgrade）の前に、tanacode をメニューの「ファイル → Claude Code も止めて終了」で終了してください。
    アプリの入れ替えで、動いている Claude Code が途中で切れないようにするためです。
  EOS
end
