# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Unpoller < Formula
  desc "Polls a UniFi controller, exports metrics to InfluxDB, Prometheus and Datadog"
  homepage "https://unpoller.com/"
  version "2.7.2"
  license "MIT"

  on_macos do
    url "https://github.com/unpoller/unpoller/releases/download/v2.7.2/unpoller_2.7.2_darwin_all.tar.gz"
    sha256 "7aa8aec808694bb8ed5c56bf7e8b9ad50b0ac8d40ff5fa9016544a72fd183943"

    def install
      bin.install "unpoller"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.2/unpoller_2.7.2_linux_amd64.tar.gz"
      sha256 "d3d6f74d9d75b74079464024a43471f452a3653029495391d90e3da51ee9ea89"

      def install
        bin.install "unpoller"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.2/unpoller_2.7.2_linux_arm64.tar.gz"
      sha256 "8f31ffdb0b93950edeac40f9f21346534418ced0dd741d8034401203392c0303"

      def install
        bin.install "unpoller"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.7.2/unpoller_2.7.2_linux_armv6.tar.gz"
      sha256 "6603617319126eccf8879200e75a8541a494c1e578fb6329d1218eb4e04238e0"

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
