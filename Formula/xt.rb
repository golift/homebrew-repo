# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Xt < Formula
  desc "eXtractor Tool - Recursively decompress archives"
  homepage "https://unpackerr.com/"
  version "0.0.3"
  license "MIT"

  on_macos do
    url "https://github.com/Unpackerr/xt/releases/download/v0.0.3/xt_0.0.3_darwin_all.tar.gz"
    sha256 "608942810cd01af8c0fb2c9e51897ef523e5408bc7487410217ebbfca7652c17"

    def install
      bin.install "xt"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/Unpackerr/xt/releases/download/v0.0.3/xt_0.0.3_linux_armv6.tar.gz"
      sha256 "fb8c44279e22038b22cf8d3cb6ca2d371269b05b3c179eb47d241d6d7b3a1bf3"

      def install
        bin.install "xt"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/Unpackerr/xt/releases/download/v0.0.3/xt_0.0.3_linux_amd64.tar.gz"
      sha256 "15e459ee90060029be3584037635a77371957bda875dd6821ab702eedeac6ba8"

      def install
        bin.install "xt"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/Unpackerr/xt/releases/download/v0.0.3/xt_0.0.3_linux_arm64.tar.gz"
      sha256 "3db22354c7954d8633ba5372fc785a8ef9f705899bbcbf95966d17aabcb03e22"

      def install
        bin.install "xt"
      end
    end
  end

  test do
    assert_match "xt v#{version}", shell_output("#{bin}/xt -v 2>&1", 2)
  end
end