# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Unpoller < Formula
  desc "Polls a UniFi controller, exports metrics to InfluxDB, Prometheus and Datadog"
  homepage "https://unpoller.com/"
  version "2.14.0"
  license "MIT"

  on_macos do
    url "https://github.com/unpoller/unpoller/releases/download/v2.14.0/unpoller_2.14.0_darwin_all.tar.gz"
    sha256 "f4cd39d68266150c50cf8927c666b5283b48b5c4c2712e0bad3af3ad8f81ec0c"

    def install
      bin.install "unpoller"
      etc.mkdir "unpoller"
      etc.install "examples/up.conf" => "unpoller/up.conf.example"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/unpoller/unpoller/releases/download/v2.14.0/unpoller_2.14.0_linux_amd64.tar.gz"
        sha256 "b3ffe3f53072181629f351986f9f9fb61467ef55e44ac6368931346e673f6f5f"

        def install
          bin.install "unpoller"
          etc.mkdir "unpoller"
          etc.install "examples/up.conf" => "unpoller/up.conf.example"
        end
      end
    end
    if Hardware::CPU.arm?
      if !Hardware::CPU.is_64_bit?
        url "https://github.com/unpoller/unpoller/releases/download/v2.14.0/unpoller_2.14.0_linux_armv6.tar.gz"
        sha256 "300a0c5b6e291331a6a45df2ee74bac0830ad17ff1f488c5d9c5bb5828cc5386"

        def install
          bin.install "unpoller"
          etc.mkdir "unpoller"
          etc.install "examples/up.conf" => "unpoller/up.conf.example"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/unpoller/unpoller/releases/download/v2.14.0/unpoller_2.14.0_linux_arm64.tar.gz"
        sha256 "37b67a4684234cf5ed403801c3b7a9a656b39abda992b97e8d3b5a4feeca3d5b"

        def install
          bin.install "unpoller"
          etc.mkdir "unpoller"
          etc.install "examples/up.conf" => "unpoller/up.conf.example"
        end
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
