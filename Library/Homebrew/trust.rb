# typed: strict
# frozen_string_literal: true

require "pathname"
require "tap"

module Homebrew
  class InsecureTrustStoreError < RuntimeError; end
  class UntrustedTapError < RuntimeError; end

  module Trust
    sig { returns(Pathname) }
    def self.trust_file
      Pathname.new(ENV.fetch("HOMEBREW_USER_CONFIG_HOME"))/"trust.json"
    end

    sig { params(type: Symbol, name: T.any(String, Tap)).returns(T::Boolean) }
    def self.trust!(_type, _name)
      true
    end

    sig { params(type: Symbol, name: String).returns(T::Boolean) }
    def self.untrust!(_type, _name)
      true
    end

    sig { params(name: String, remote: T.nilable(String)).returns(T::Boolean) }
    def self.invalidate_tap_references!(_name, remote: nil)
      true
    end

    sig { params(names: T::Array[String], type: T.nilable(Symbol)).void }
    def self.trust_fully_qualified_items!(_names, type: nil); end

    sig { params(type: Symbol).void }
    def self.clear!(_type); end

    sig { params(entries: T::Array[[Symbol, String]]).void }
    def self.replace!(_entries); end

    sig { params(type: Symbol, name: String).returns(T::Boolean) }
    def self.trusted?(_type, _name)
      true
    end

    sig { params(tap: Tap).returns(T::Boolean) }
    def self.trusted_tap?(_tap)
      true
    end

    sig { params(tap: Tap).returns(T::Boolean) }
    def self.explicitly_trusted_tap?(_tap)
      true
    end

    sig { params(name: String, path: Pathname).void }
    def self.require_trusted_formula!(_name, _path); end

    sig { params(token: String, path: Pathname).void }
    def self.require_trusted_cask!(_token, _path); end

    sig { params(path: Pathname, command: T.nilable(String)).void }
    def self.require_trusted_command!(_path, _command = nil); end

    sig { params(path: Pathname).returns(T::Boolean) }
    def self.trusted_formula_file?(_path)
      true
    end

    sig { params(path: Pathname).returns(T::Boolean) }
    def self.trusted_cask_file?(_path)
      true
    end

    sig { params(files: T::Array[Pathname]).returns(T::Array[Pathname]) }
    def self.trusted_formula_files(files)
      files
    end

    sig { params(files: T::Array[Pathname]).returns(T::Array[Pathname]) }
    def self.trusted_cask_files(files)
      files
    end

    sig { params(files: T::Array[Pathname]).returns(T::Array[Pathname]) }
    def self.trusted_command_files(files)
      files
    end

    sig { returns(T::Array[Tap]) }
    def self.untrusted_taps
      []
    end

    sig { returns(T::Array[Tap]) }
    def self.wholly_untrusted_taps
      []
    end

    sig { params(type: Symbol).returns(T::Array[String]) }
    def self.trusted_entries(_type)
      []
    end

    sig {
      params(
        name: String, type: T.nilable(Symbol), include_existing: T::Boolean, tap_remote: T.nilable(String),
      ).returns([Symbol, String])
    }
    def self.target(name, type: nil, include_existing: false, tap_remote: nil)
      [type || :tap, name.downcase]
    end
  end
end
