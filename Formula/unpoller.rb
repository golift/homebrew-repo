# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Unpoller < Formula
  desc "Polls a UniFi controller, exports metrics to InfluxDB, Prometheus and Datadog"
  homepage "https://unpoller.com/"
  version "2.7.19"
  license "MIT"

  on_macos do
    url "https://github.com/unpoller/unpoller/releases/download/v2.7.19/unpoller_2.7.19_darwin_all.tar.gz"
    sha256 "7d97aeefbb1d65abe71e8ac1137b52da0d85ad6fbd7a5bc120416bcfc2a14da6"

    def install
      bin.install "unpoller"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.19/unpoller_2.7.19_linux_amd64.tar.gz"
      sha256 "d8d703c7e344552309e075307704f1510c4966eb8cbc37f5a467d9ed1f318d2f"

      def install
        bin.install "unpoller"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.19/unpoller_2.7.19_linux_armv6.tar.gz"
      sha256 "7c6c1515f6cbb840628606541bcf3e1d087a86b45cda3147840fbc165b155f84"

      def install
        bin.install "unpoller"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.19/unpoller_2.7.19_linux_arm64.tar.gz"
      sha256 "043f2fa9270a2286726ae9c1b7bb6571eb77943d2f2be6be824bf50d66f571ee"

      def install
        bin.install "unpoller"
      end
    end
  end

  conflicts_with "unifi-poller"

  def caveats
    <<~EOS
      Edit the config file at #{etc}/unpoller/up.conf then start unpoller with brew services start unpoller ~ log file: #{var}/log/unpoller.log The manual explains the config file options: man unpoller
    EOS
  end

  plist_options startup: false

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
          <string>#{bin}/unpoller</string>
          <string>--config</string>
          <string>#{etc}/unpoller/up.conf</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>#{var}/log/unpoller.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/unpoller.log</string>
  </dict>
</plist>

    EOS
  end

  test do
    assert_match "unpoller v#{version}", shell_output("#{bin}/unpoller -v 2>&1", 2)
  end
end
