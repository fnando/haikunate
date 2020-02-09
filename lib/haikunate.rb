# frozen_string_literal: true

require "securerandom"
require "pathname"

module Haikunate
  require "haikunate/version"

  class << self
    attr_accessor :default_range
    attr_accessor :default_variant
  end

  self.default_range = 1000..9999
  self.default_variant = -> { rand(default_range) }

  def self.data_dir
    @data_dir ||= Pathname.new(File.expand_path("#{__dir__}/../data"))
  end

  def self.nouns
    @nouns ||= data_dir.join("nouns.txt").read.lines.map(&:chomp)
  end

  def self.nouns=(nouns)
    @nouns = nouns.map(&:chomp)
  end

  def self.adjectives
    @adjectives ||= data_dir.join("adjectives.txt").read.lines.map(&:chomp)
  end

  def self.adjectives=(adjectives)
    @adjectives = adjectives.map(&:chomp)
  end

  def self.call(joiner: "-", variant: default_variant)
    [adjectives.sample, nouns.sample, variant.call].join(joiner)
  end

  def self.next(joiner: "-", variant: default_variant, &block)
    options = {joiner: joiner, variant: variant}
    name = call(**options) while !name || block.call(name)
    name
  end
end

Haiku = Haikunate
