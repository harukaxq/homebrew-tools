# typed: true
# frozen_string_literal: true

# This file was generated by Homebrew Releaser. DO NOT EDIT.
class Llmpack < Formula
  desc "My cool combine and query"
  homepage "https://github.com/harukaxq/llmpack"
  url "https://github.com/harukaxq/llmpack/archive/refs/tags/v0.0.22.tar.gz"
  sha256 "27ddc5993d9991c10ace2efaa7f4cf9aaa08d88b8659da808dcde89aa7969c32"

  def install
    if OS.mac?
  # Download pre-built binary for macOS
  binary_url = "https://github.com/harukaxq/llmpack/releases/download/v#{version}/llmpack-macos"
  binary_path = libexec/"bin/llmpack"
  
  # Create necessary directories
  bin.mkpath
  libexec.mkpath
  (libexec/"bin").mkpath
  
  # Download and install binary
  system "curl", "-fsSL", binary_url, "-o", binary_path
  chmod 0755, binary_path
  
  # Create wrapper script
  (bin/"llmpack").write_env_script binary_path, PATH: "#{libexec}/bin:$PATH"
else
  # Fallback to source installation if binary is not available for the platform
  venv = virtualenv_create(libexec, "python3.12")
  system libexec/"bin/pip", "install", "-v", "--no-deps", buildpath
  (bin/"llmpack").write_env_script libexec/"bin/llmpack", PATH: "#{libexec}/bin:$PATH"
end
  end

  test do
    system "#{bin}/llmpack", "--help"
  end
end
