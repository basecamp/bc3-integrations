require "minitest/autorun"
require "dimensions"
require "yaml"
require "pathname"
require "uri"

$VERBOSE = false

class TestCase < MiniTest::Test
  ROOT_PATH = Pathname.new(__dir__).join("..")
  ICON_PATH = ROOT_PATH.join("icons")

  class << self
    def integrations
      @integrations ||= YAML.load_file(ROOT_PATH.join("integrations.yml"))
    end

    def each_integration
      integrations.each_with_index do |integration, index|
        name = integration["name"] || "unnamed integration at index #{index}"
        yield name, integration
      end
    end
  end
end

class IntegrationsTest < TestCase
  WEBSITE_PATTERN = /\A#{URI.regexp(%w( http https ))}\z/
  MAX_DESCRIPTION_SIZE = 160

  each_integration do |name, integration|
    define_method "test_#{name.inspect}" do
      %w( name description website icon ).each do |field|
        assert present?(integration[field]), "#{field} can't be blank"
        assert_kind_of String, integration[field], "#{field} must be a string"
      end

      assert (integration["description"].size <= MAX_DESCRIPTION_SIZE), "description exceeds the #{MAX_DESCRIPTION_SIZE} character limit"

      assert_match WEBSITE_PATTERN, integration["website"], "website must be a valid URL"

      assert (1..9).cover?(integration["category"]), "category must be between 1 and 9"
      assert_kind_of Integer, integration["category"], "category must be an integer"

      icon_path = ICON_PATH.join(integration["icon"])
      assert icon_path.exist?, "icon file is missing"
      assert_equal ".png", icon_path.extname
      assert_equal [256, 256], Dimensions.dimensions(icon_path), "icon must be 256x256"
    end
  end

  private
    def present?(string = nil)
      !string.nil? && !string.size.zero?
    end
end
