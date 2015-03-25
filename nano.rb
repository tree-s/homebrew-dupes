require 'formula'

class Nano < Formula
  homepage 'http://www.nano-editor.org/'
  url 'http://www.nano-editor.org/dist/v2.4/nano-2.4.0.tar.gz'
  sha1 '55639cbac2d38febf16780b912b036f2023534d1'
  head 'svn://svn.sv.gnu.org/nano/trunk/nano'
  # see https://savannah.gnu.org/bugs/?44609
  patch :DATA

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--disable-nls",
                          "--enable-utf8"
    system "make install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end

__END__
--- a/src/text.c	2015-03-22 23:45:12.000000000 -0400
+++ b/src/text.c	2015-03-24 22:44:05.000000000 -0400
@@ -2664,7 +2664,7 @@ const char *do_alt_speller(char *tempfil
     ssize_t current_y_save = openfile->current_y;
     ssize_t lineno_save = openfile->current->lineno;
     struct stat spellfileinfo;
-    __time_t timestamp;
+    time_t timestamp;
     pid_t pid_spell;
     char *ptr;
     static int arglen = 3;
