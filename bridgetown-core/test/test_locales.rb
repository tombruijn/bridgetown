# frozen_string_literal: true

require "helper"

class TestLocales < BridgetownUnitTest
  def reset_i18n_config
    I18n.enforce_available_locales = false
    I18n.locale = nil
    I18n.default_locale = nil
    I18n.load_path = nil
    I18n.available_locales = nil
    I18n.backend = nil
    I18n.default_separator = nil
    I18n.enforce_available_locales = true
    I18n.fallbacks = nil if I18n.respond_to?(:fallbacks=)
  end

  context "similar pages in different locales" do
    setup do
      reset_i18n_config
      @site = resources_site
      @site.process
      # @type [Bridgetown::Resource::Base]
      @english_resource = @site.collections.pages.resources.find do |page|
        page.relative_path.to_s == "_pages/second-level-page.en.md"
      end
      @french_resource = @site.collections.pages.resources.find do |page|
        page.relative_path.to_s == "_pages/second-level-page.fr.md"
      end
    end

    should "have the correct permalink and locale in English" do
      assert_equal "/second-level-page/", @english_resource.relative_url
      assert_includes @english_resource.output, "<p>Locale: en</p>"
    end

    should "have the correct permalink and locale in French" do
      assert_equal "/fr/second-level-page/", @french_resource.relative_url
      assert_includes @french_resource.output, "<p>C’est <strong>bien</strong>.</p>\n\n<p>Locale: fr</p>"

      assert_includes @french_resource.output, <<-HTML
    <li>I'm a Second Level Page: /second-level-page/</li>
    <li>I'm a Second Level Page in French: /fr/second-level-page/</li>
      HTML
    end
  end

  context "one page which is generated into multiple locales" do
    setup do
      reset_i18n_config
      @site = resources_site
      @site.process
      # @type [Bridgetown::Resource::Base]
      @resources = @site.collections.pages.resources.select do |page|
        page.relative_path.to_s == "_pages/multi-page.multi.md"
      end
      @english_resource = @resources.find { |page| page.data.locale == :en }
      @french_resource = @resources.find { |page| page.data.locale == :fr }
    end

    should "have the correct permalink and locale in English" do
      assert_equal "/multi-page/", @english_resource.relative_url
      assert_includes @english_resource.output, 'lang="en"'
      assert_includes @english_resource.output, "<title>Multi-locale page</title>"
      assert_includes @english_resource.output, "<p>English: Multi-locale page</p>"
    end

    should "have the correct permalink and locale in French" do
      assert_equal "/fr/multi-page/", @french_resource.relative_url
      assert_includes @french_resource.output, 'lang="fr"'
      assert_includes @french_resource.output, "<title>Sur mesure</title>"
      assert_includes @french_resource.output, "<p>French: Sur mesure</p>"

      assert_includes @french_resource.output, <<-HTML
    <li>Multi-locale page: /multi-page/</li>
    <li>Sur mesure: /fr/multi-page/</li>
      HTML
    end
  end

  context "one page which is generated into multiple locales (as specified in locales key)" do
    setup do
      reset_i18n_config
      @site = resources_site
      @site.process
      # @type [Bridgetown::Resource::Base]
      @resources = @site.collections.pages.resources.select do |page|
        page.relative_path.to_s == "_pages/multi-page-with-specified-locales.multi.md"
      end
      @english_resource = @resources.find { |page| page.data.locale == :en }
      @french_resource = @resources.find { |page| page.data.locale == :fr }
    end

    should "have the correct permalink and locale in English" do
      assert_equal "/multi-page/", @english_resource.relative_url
      assert_includes @english_resource.output, 'lang="en"'
      assert_includes @english_resource.output, "<title>Multi-locale page</title>"
      assert_includes @english_resource.output, "<p>English: Multi-locale page</p>"
    end

    should "have not have a locale in French" do
      assert_equal @french_resource, nil
    end
  end

  context "locales and a base_path combined" do
    setup do
      reset_i18n_config
      @site = resources_site(base_path: "/basefolder")
      @site.process
      # @type [Bridgetown::Resource::Base]
      @resources = @site.collections.pages.resources.select do |page|
        page.relative_path.to_s == "_pages/multi-page.multi.md"
      end
      @english_resource = @resources.find { |page| page.data.locale == :en }
      @french_resource = @resources.find { |page| page.data.locale == :fr }
    end

    should "have the correct permalink and locale in English" do
      assert_equal "/basefolder/multi-page/", @english_resource.relative_url
      assert_includes @english_resource.output, 'lang="en"'
      assert_includes @english_resource.output, "<title>Multi-locale page</title>"
      assert_includes @english_resource.output, "<p>English: Multi-locale page</p>"
    end

    should "have the correct permalink and locale in French" do
      assert_equal "/basefolder/fr/multi-page/", @french_resource.relative_url
      assert_includes @french_resource.output, 'lang="fr"'
      assert_includes @french_resource.output, "<title>Sur mesure</title>"
      assert_includes @french_resource.output, "<p>French: Sur mesure</p>"

      assert_includes @french_resource.output, <<-HTML
    <li>Multi-locale page: /basefolder/multi-page/</li>
    <li>Sur mesure: /basefolder/fr/multi-page/</li>
      HTML
    end
  end

  context "locales, prefix_default_locale, and base_path combined" do
    setup do
      reset_i18n_config
      @site = resources_site(base_path: "/basefolder", prefix_default_locale: true)
      @site.process
      # @type [Bridgetown::Resource::Base]
      @resources = @site.collections.pages.resources.select do |page|
        page.relative_path.to_s == "_pages/multi-page.multi.md"
      end
      @english_resource = @resources.find { |page| page.data.locale == :en }
      @french_resource = @resources.find { |page| page.data.locale == :fr }
    end

    should "have the correct permalink and locale in English" do
      assert_equal "/basefolder/en/multi-page/", @english_resource.relative_url
      assert_includes @english_resource.output, 'lang="en"'
      assert_includes @english_resource.output, "<title>Multi-locale page</title>"
      assert_includes @english_resource.output, "<p>English: Multi-locale page</p>"
    end

    should "have the correct permalink and locale in French" do
      assert_equal "/basefolder/fr/multi-page/", @french_resource.relative_url
      assert_includes @french_resource.output, 'lang="fr"'
      assert_includes @french_resource.output, "<title>Sur mesure</title>"
      assert_includes @french_resource.output, "<p>French: Sur mesure</p>"

      assert_includes @french_resource.output, <<-HTML
    <li>Multi-locale page: /basefolder/en/multi-page/</li>
    <li>Sur mesure: /basefolder/fr/multi-page/</li>
      HTML
    end

    context "translation filters" do
      setup do
        reset_i18n_config
        @site = resources_site
        @site.process
        # @type [Bridgetown::Resource::Base]
        @resources = @site.collections.pages.resources.select do |page|
          page.relative_path.to_s == "_pages/multi-page.multi.md"
        end
        @english_resource = @resources.find { |page| page.data.locale == :en }
        @french_resource = @resources.find { |page| page.data.locale == :fr }
      end

      should "pull in the right English translation" do
        assert_includes @english_resource.output, "<p>English: Test Name</p>"
      end

      should "fall back to English on missing translation" do
        assert_includes @french_resource.output, "<p>Français: Test Name</p>"
      end
    end
  end

  context "fallback chain" do
    setup do
      reset_i18n_config
      @site = resources_site
      @site.process
    end

    should "include English for base language" do
      assert_equal %i[de en], I18n.fallbacks[:de]
      assert_equal %i[fr en], I18n.fallbacks[:fr]
    end

    should "include English and base language for regional locale" do
      assert_equal %i[de-NL de en], I18n.fallbacks[:"de-NL"]
      assert_equal %i[fr-CA fr en], I18n.fallbacks[:"fr-CA"]
    end
  end

  context "fallback chain with different default locale" do
    setup do
      reset_i18n_config
      @site = resources_site("default_locale" => :es, "available_locales" => %w[en es])
      @site.process
    end

    should "include both the default language and English in the fallback chain" do
      assert_equal %i[de es en], I18n.fallbacks[:de]
      assert_equal %i[es en], I18n.fallbacks[:es]
    end

    should "include base language, default, and English for regional language" do
      assert_equal %i[de-NL de es en], I18n.fallbacks[:"de-NL"]
      assert_equal %i[es-MX es en], I18n.fallbacks[:"es-MX"]
    end
  end
end
