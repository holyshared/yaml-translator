# yaml-translator

yaml-translator is a gem that translates yaml format translation files into each language.  
The translation method supports google translate api in built-in.

[![Gem Version](https://badge.fury.io/rb/yaml-translator.svg)](https://badge.fury.io/rb/yaml-translator)
[![Build Status](https://travis-ci.org/holyshared/yaml-translator.svg?branch=master)](https://travis-ci.org/holyshared/yaml-translator)
[![Coverage Status](https://coveralls.io/repos/github/holyshared/yaml-translator/badge.svg?branch=master)](https://coveralls.io/github/holyshared/yaml-translator?branch=master)
[![Code Climate](https://codeclimate.com/github/holyshared/yaml-translator/badges/gpa.svg)](https://codeclimate.com/github/holyshared/yaml-translator)

## Basic usage

The method of translating the language file is as follows.

```ruby
dir = File.dirname(__FILE__)
adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])
translator = ::YamlTranslator::Translator.new(adapter)


english_locale = translator.file("#{dir}/en.yml")
japanese_locale = english_locale.to(:ja)

p japanese_locale.to_s # convert to japanese locale yaml format
p japanese_locale.save_to(dir) # Write a ja.yml

german_locale = english_locale.to(:de)

p german_locale.to_s # convert to german locale yaml format
p german_locale.save_to(dir) # Write a de.yml
```

## Translation of difference

The method of translating the difference is as follows.

```ruby
adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])
translator = ::YamlTranslator::Translator.new(adapter)

before_english_locale = ::YamlTranslator.load_file("/path/to/before/en.yml")
after_english_locale = ::YamlTranslator.load_file("/path/to/after/en.yml")

diff_locale = before_english_locale.diff(after_english_locale)
diff_japanese_locale = diff_locale.translate(translator, to: :ja)

diff_japanese_locale.save # Save the difference translation file
```

## Run the test

	bundle install
	rake spec
