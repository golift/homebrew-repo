# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Unpoller < Formula
  desc "Polls a UniFi controller, exports metrics to InfluxDB, Prometheus and Datadog"
  homepage "https://unpoller.com/"
  version "2.10.0"
  license "MIT"

  on_macos do
    url "https://github.com/unpoller/unpoller/releases/download/v2.10.0/unpoller_2.10.0_darwin_all.tar.gz"
    sha256 "97393f9e6f713d50dbbc9b714cdc6d7d2e47fa6460bc86938e39c8fbad56c409"

    def install
      bin.install "unpoller"
      etc.mkdir "unpoller"
      etc.install "examples/up.conf" => "unpoller/up.conf.example"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.10.0/unpoller_2.10.0_linux_arm64.tar.gz"
      sha256 "8f5424fcbc03d48c74526508ebac1537723d15d4ab4362fa91cae36fc4648a8a"

      def install
        bin.install "unpoller"
        etc.mkdir "unpoller"
        etc.install "examples/up.conf" => "unpoller/up.conf.example"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/unpoller/unpoller/releases/download/v2.10.0/unpoller_2.10.0_linux_amd64.tar.gz"
      sha256 "e6f56c3dbac78a56a1c6df58d5f10c696d2fd485c257f78c3d860d23f804efe1"

      def install
        bin.install "unpoller"
        etc.mkdir "unpoller"
        etc.install "examples/up.conf" => "unpoller/up.conf.example"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.10.0/unpoller_2.10.0_linux_armv6.tar.gz"
      sha256 "3ed72ffbecb0c5d55c9ee11b68d01894f5fb425190e85b613b8024fca665a565"

      def install
        bin.install "unpoller"
        etc.mkdir "unpoller"
        etc.install "examples/up.conf" => "unpoller/up.conf.example"
      end
    end
  end

  conflicts_with "unifi-poller"

  def post_install
    etc.install "examples/up.conf" => "unpoller/up.conf"
  end

  def caveats
    <<~EOS
      Edit the config file at #{etc}/unpoller/up.conf then start unpoller with brew services start unpoller ~ log file: #{var}/log/unpoller.log The manual explains the config file options: man unpoller
    EOS
  end

  service do
    run [opt_bin/"unpoller", "--config", etc/"unpoller/up.conf"]
    keep_alive true
    log_path var/"log/unpoller.log"
    error_log_path var/"log/unpoller.log"
  end

  test do
    assert_match "unpoller v#{version}", shell_output("#{bin}/unpoller -v 2>&1", 2)
  end
end
