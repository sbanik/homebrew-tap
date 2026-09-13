class Documax < Formula
  desc "Package and restore directory trees as portable documents"
  homepage "https://github.com/sbanik/documax"
  url "https://github.com/sbanik/documax/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "63f709653a6880020f8fcd70c0bd1e7b4c637928ead8693965b457d71ed4606d"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"documax"), "./cmd/documax"
  end

  test do
    source = testpath/"project"
    source.mkpath
    (source/"main.py").write <<~PYTHON
      if True:
          print("hello")
    PYTHON

    system bin/"documax", "pack", source
    archive = testpath/"project-documax.md"
    assert_predicate archive, :exist?

    system bin/"documax", "validate", archive
  end
end