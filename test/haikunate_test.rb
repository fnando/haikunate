# frozen_string_literal: true

require "test_helper"

class HaikunateTest < Minitest::Test
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

    Haiku.stub :adjectives, %w[helpful] do
      Haiku.stub :nouns, %w[fox] do
        haiku = Haiku.next(variant: -> { variants.shift }) do |new_haiku|
          bucket.include?(new_haiku)
        end

        assert_equal "helpful-fox-9999", haiku
      end
    end
  end
end
