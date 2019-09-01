class Sysdig < Formula
  desc "System-level exploration and troubleshooting tool"
  homepage "https://www.sysdig.org/"
  url "https://github.com/draios/sysdig/archive/0.26.2.tar.gz"
  sha256 "6f4f5b7b187c3774b6c374c1728b3f905ac18a945bde15151dcfb24c79abb441"

  bottle do
    sha256 "88ea4aa2330d02ad848eabdfb32579a6571fcebaa9834ee51a1375ca2e5ae244" => :mojave
    sha256 "22fce688d02c2cc853e6d95eb46fd54bd0b200f33329fea922196f11c15d4d87" => :high_sierra
    sha256 "05ae33eeda66600860e14490ee51a1b57848915f45aa6714fa42eb202be8927c" => :sierra
  end

  depends_on "cmake" => :build
  depends_on "jsoncpp"
  depends_on "luajit"
  depends_on "tbb"

  # More info on https://gist.github.com/juniorz/9986999
  resource "sample_file" do
    url "https://gist.githubusercontent.com/juniorz/9986999/raw/a3556d7e93fa890a157a33f4233efaf8f5e01a6f/sample.scap"
    sha256 "efe287e651a3deea5e87418d39e0fe1e9dc55c6886af4e952468cd64182ee7ef"
  end

  def install
    mkdir "build" do
      system "cmake", "..", "-DSYSDIG_VERSION=#{version}",
                            "-DUSE_BUNDLED_DEPS=OFF",
                            *std_cmake_args
      system "make"
      system "make", "install"
    end

    (pkgshare/"demos").install resource("sample_file").files("sample.scap")
  end

  test do
    output = shell_output("#{bin}/sysdig -r #{pkgshare}/demos/sample.scap")
    assert_match "/tmp/sysdig/sample", output
  end
end
