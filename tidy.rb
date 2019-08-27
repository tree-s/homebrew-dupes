class Tidy < Formula
  homepage "http://tidy.sourceforge.net/"
  stable do
    url "ftp://mirror.internode.on.net/pub/gentoo/distfiles/tidy-20090325.tar.bz2"
    sha1 "28c000a2cd40262fc0d7c2c429eb2a09b2df7bf4"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  head do
    url "https://github.com/w3c/tidy-html5.git"

    depends_on "cmake" => :build
  end

  def install
    if build.stable?
      system "sh", "build/gnuauto/setup.sh"
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    else
      cd "build/cmake" do
        system "cmake", "../..", *std_cmake_args
        system "make", "install"
      end
    end
  end
end
