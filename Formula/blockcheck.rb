class Blockcheck < Formula
  desc "Russian ISP block checker"
  homepage "https://github.com/ValdikSS/blockcheck"
  url "https://github.com/ValdikSS/blockcheck/archive/0.0.8.2.tar.gz"
  sha256 "2d4aacda29d54c13d0111f5a44f58e8574e6bc0aefa07dc13d1cf97b3afe0564"

  depends_on :python3

  resource "dnspython3" do
    url "https://pypi.python.org/packages/83/80/bc1ae10a37f6ccda5dfec343852244b3920754c838d6b31f0a43819c8dd5/dnspython3-1.12.0.zip"
    sha256 "e9630946207864c7a780798809cd2ec9c6bbde6ac88b97a2fda66f018eec1c8d"
  end

  def install
    resource("dnspython3").stage { system "python3", *Language::Python.setup_install_args(libexec/"vendor") }

    bin.install "blockcheck.py"
  end

  test do
    # Bug: http://stackoverflow.com/questions/5387895/unicodeencodeerror-ascii-codec-cant-encode-character-u-u2013-in-position-3
    # system "python3", "#{bin}/blockcheck.py", "-h"
  end
end
