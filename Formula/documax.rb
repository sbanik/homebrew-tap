class Documax < Formula
  desc "Package and restore directory trees as portable documents"
  homepage "https://github.com/sbanik/documax"
  url "https://github.com/sbanik/documax/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "a0c3ec26a2828dcbaed37e801d0098abb17c1603d5fffc9e38151811bc589057"
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
