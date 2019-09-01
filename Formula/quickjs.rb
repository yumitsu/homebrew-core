class Quickjs < Formula
  desc "Small and embeddable JavaScript engine"
  homepage "https://bellard.org/quickjs/"
  url "https://bellard.org/quickjs/quickjs-2019-08-10.tar.xz"
  sha256 "c6a9c676ead0e84f249f4d27ac6626b4fdb37aa6b4b7c46f94f95071204840fe"

  bottle do
    sha256 "255460f41d15a44c7f7da0894db878abfa7500d80945e8f3411bc9f0372ac9ed" => :mojave
    sha256 "9e6435e1df1fa19fb53089a3f4843a1906cd966ed895e39f1bf81f04e99f40ca" => :high_sierra
    sha256 "f221f3be11a7464d7bd3e364b953279ebb57c36fbd086c5c49593a7e7baf90ed" => :sierra
  end

  def install
    system "make", "install", "prefix=#{prefix}", "CONFIG_M32="
  end

  test do
    output = shell_output("#{bin}/qjs --eval 'const js=\"JS\"; console.log(`Q${js}${(7 + 35)}`);'").strip
    assert_match /^QJS42/, output

    path = testpath/"test.js"
    path.write "console.log('hello');"
    system "#{bin}/qjsc", path
    output = shell_output(testpath/"a.out").strip
    assert_equal "hello", output
  end
end
