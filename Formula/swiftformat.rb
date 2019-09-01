class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.40.11.tar.gz"
  sha256 "dfb459fdf9555b5a146577b4472f5c56e273acf9a0c9f396e8f116416d9b5494"
  head "https://github.com/nicklockwood/SwiftFormat.git", :shallow => false

  bottle do
    cellar :any_skip_relocation
    sha256 "fd7fda3ec8558a3edc6e023c59e7aa6a3f5d9b89ceac4e8c7780e34e3f4d2d0a" => :mojave
    sha256 "afc7434a0adb3c348fc52bbb23ad56399bbe591e833eedd5e72e46db1a3e81bf" => :high_sierra
  end

  depends_on :xcode => ["9.3", :build]

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end
