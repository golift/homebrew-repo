# Homebrew Formula Template. Built by Makefile: `make fomula`
# This is part of Application Builder.
# https://github.com/golift/application-builder
# This file is used when FORMULA is set to 'service'.
class Motifini < Formula
  desc "SecuritySpy-iMessage Integrator and Messages.app API"
  homepage "https://github.com/golift/motifini"
  url "https://codeload.github.com/golift/motifini/tar.gz/v0.0.2"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  head "https://github.com/golift/motifini"

  depends_on "go" => :build
  depends_on "dep"

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/github.com/golift/motifini"
    # Copy all files from their current location (GOPATH root)
    # to $GOPATH/src/github.com/golift/motifini
    bin_path.install Dir["*",".??*"]
    cd bin_path do
      system "dep", "ensure", "--vendor-only"
      system "make", "install", "VERSION=#{version}", "ITERATION=48", "PREFIX=#{prefix}", "ETC=#{etc}"
      # If this fails, the user gets a nice big warning about write permissions on their
      # #{var}/log folder. The alternative could be letting the app silently fail
      # to start when it cannot write logs. This is better. Fix perms; reinstall.
      touch("#{var}/log/#{name}.log")
    end
  end

  def caveats
    <<-EOS
  Edit the config file at #{etc}/motifini.conf then start #{name} with
  brew services start #{name} ~ log file: #{var}/log/#{name}.log
  The manual explains the config file options: man #{name}
    EOS
  end

  plist_options :startup => false

  def plist
    <<-EOS
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
     <dict>
         <key>Label</key>
         <string>#{plist_name}</string>
         <key>ProgramArguments</key>
         <array>
             <string>#{bin}/#{name}</string>
             <string>--config</string>
             <string>#{etc}/motifini.conf</string>
         </array>
         <key>RunAtLoad</key>
         <true/>
         <key>KeepAlive</key>
         <true/>
         <key>StandardErrorPath</key>
         <string>#{var}/log/#{name}.log</string>
         <key>StandardOutPath</key>
         <string>#{var}/log/#{name}.log</string>
     </dict>
  </plist>
    EOS
  end

  test do
    assert_match "#{name} v#{version}", shell_output("#{bin}/#{name} -v 2>&1", 2)
  end
end
