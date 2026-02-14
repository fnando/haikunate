# frozen_string_literal: true

require "test_helper"

class HaikunateTest < Minitest::Test
  setup do
    Haiku.default_range = 1000..9999
    Haiku.default_variant = -> { rand(Haiku.default_range) }
  end

  test "generates string using default options" do
    haiku = Haiku.call
    adjective, noun, variant = haiku.split("-")

    assert_includes Haiku.adjectives, adjective
    assert_includes Haiku.nouns, noun
    assert_match(/^\d{4}$/, variant)
  end

  test "generates string using custom joiner" do
    haiku = Haiku.call(joiner: ".")
    adjective, noun, variant = haiku.split(".")

    assert_includes Haiku.adjectives, adjective
    assert_includes Haiku.nouns, noun
    assert_match(/^\d{4}$/, variant)
  end

  test "generates string using custom variant" do
    haiku = Haiku.call(variant: -> { "0000" })
    _, _, variant = haiku.split("-")

    assert_equal "0000", variant
  end

  test "returns next available haiku" do
    variants = %w[1234 1234 9999]
    bucket = %w[helpful-fox-1234]

    Haiku.stubs(:adjectives).returns(%w[helpful])
    Haiku.stubs(:nouns).returns(%w[fox])

    haiku = Haiku.next(variant: -> { variants.shift }) do |new_haiku|
      bucket.include?(new_haiku)
    end

    assert_equal "helpful-fox-9999", haiku
  end

  test "generates base36 token with default size" do
    assert_match(/^[0-9a-z]{5}$/, Haiku.random_base36)
  end

  test "generates base36 token from per-character random picks" do
    picks = [0, 1, 10, 35, 5]
    SecureRandom.stubs(:random_number).with(36).returns(*picks)

    assert_equal "01az5", Haiku.random_base36
  end

  test "uses base36 variant" do
    Haiku.stubs(:adjectives).returns(%w[helpful])
    Haiku.stubs(:nouns).returns(%w[fox])
    Haiku.default_variant = Haiku.base36_variant_generator

    assert_match(/\Ahelpful-fox-.{5}\z/, Haiku.call)
  end

  test "uses base36 variant with custom size" do
    Haiku.stubs(:adjectives).returns(%w[helpful])
    Haiku.stubs(:nouns).returns(%w[fox])
    Haiku.default_variant = Haiku.base36_variant_generator(10)

    assert_match(/\Ahelpful-fox-.{10}\z/, Haiku.call)
  end
end
