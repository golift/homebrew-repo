# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Unpoller < Formula
  desc "Polls a UniFi controller, exports metrics to InfluxDB, Prometheus and Datadog"
  homepage "https://unpoller.com/"
  version "2.11.2"
  license "MIT"

  on_macos do
    url "https://github.com/unpoller/unpoller/releases/download/v2.11.2/unpoller_2.11.2_darwin_all.tar.gz"
    sha256 "7eb3eff9b258352d3948259bef544b8f2d39471cb6e5d5d2f65992f3e209a3d6"

    def install
      bin.install "unpoller"
      etc.mkdir "unpoller"
      etc.install "examples/up.conf" => "unpoller/up.conf.example"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/unpoller/unpoller/releases/download/v2.11.2/unpoller_2.11.2_linux_amd64.tar.gz"
      sha256 "c40d6fd931df2af0aca2b33aeea27c32ad4fb39fd43079b5a1dd32b376636d8d"

      def install
        bin.install "unpoller"
        etc.mkdir "unpoller"
        etc.install "examples/up.conf" => "unpoller/up.conf.example"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.11.2/unpoller_2.11.2_linux_armv6.tar.gz"
      sha256 "c9c7775dee00806665919e9a6c35faa1714b97ca26e06c3e32a28d9a08a870f1"

      def install
        bin.install "unpoller"
        etc.mkdir "unpoller"
        etc.install "examples/up.conf" => "unpoller/up.conf.example"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/unpoller/unpoller/releases/download/v2.11.2/unpoller_2.11.2_linux_arm64.tar.gz"
      sha256 "7cca7f07a2a2233504081ca5a36b994eead80b6b314c724ba025b75e9760677b"

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
