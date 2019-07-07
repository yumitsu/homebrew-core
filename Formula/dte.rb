class Dte < Formula
  desc "Small and configurable console text editor"
  homepage "https://github.com/craigbarnes/dte"
  url "https://github.com/craigbarnes/dte/releases/download/v1.8.2/dte-1.8.2.tar.gz"
  sha256 "778786c0b2588f0d9a651ebfde939885a5579745dae8f5d9adc480f4895d6c04"

  def install
    system "make", "-j#{ENV.make_jobs}"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    assert_equal "20", shell_output("#{bin}/dte -b compiler/gcc | wc -l").strip
  end
end
