class Documax < Formula
  desc "Package and restore directory trees as portable documents"
  homepage "https://github.com/sbanik/documax"
  url "https://github.com/sbanik/documax/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "ce7291f1bb8b9de450d62753942fece58a0d534cf46fd0e50bb96dc7c156dc33"
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
