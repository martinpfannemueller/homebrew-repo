class Minisat < Formula
  desc "Boolean satisfiability (SAT) problem solver"
  homepage "http://minisat.se"
  url "https://github.com/MaxenceCaronLasne/minisat/archive/master.zip"
  sha256 "8c93839aa54850f4c5450f68dcef2ce346d44194c19b31dac2ce801a7e81fcf4"
  revision 3
  version "2.2.1"

  depends_on "gcc"

  fails_with :clang do
    cause "error: friend declaration specifying a default argument must be a definition"
  end

  def install
    ENV["MROOT"] = buildpath
    system "make", "-C", "minisat/simp", "r"
    bin.install "minisat/simp/minisat_release" => "minisat"
  end

  test do
    dimacs = <<~EOS
      p cnf 3 2
      1 -3 0
      2 3 -1 0
    EOS

    assert_match(/^SATISFIABLE$/, pipe_output("#{bin}/minisat", dimacs, 10))
  end
end
