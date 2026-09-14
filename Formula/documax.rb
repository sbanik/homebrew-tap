class Documax < Formula
  desc "Package and restore directory trees as portable documents"
  homepage "https://github.com/sbanik/documax"
  url "https://github.com/sbanik/documax/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "5ddaaff38bdcb0778d5ec9313925663ed5af540b3ef7e59832a1f67db5faa8c6"
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
    assert_path_exists archive

    system bin/"documax", "validate", archive
  end
end
