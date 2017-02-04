# yaml-translator

[![Gem Version](https://badge.fury.io/rb/yaml-translator.svg)](https://badge.fury.io/rb/yaml-translator)
[![Build Status](https://travis-ci.org/holyshared/yaml-translator.svg?branch=master)](https://travis-ci.org/holyshared/yaml-translator)
[![Coverage Status](https://coveralls.io/repos/github/holyshared/yaml-translator/badge.svg?branch=master)](https://coveralls.io/github/holyshared/yaml-translator?branch=master)
[![Code Climate](https://codeclimate.com/github/holyshared/yaml-translator/badges/gpa.svg)](https://codeclimate.com/github/holyshared/yaml-translator)

# Basic usage

Translate the language file, do as follows.

```ruby
require 'yaml'
require 'yaml-translator'

adapter = ::YamlTranslator::Adapters::GoogleTranslateAdapter.new(ENV['GOOGLE_TRANSLATE_API_KEY'])

yaml = YAML.load(File.open("#{dir}/en.yml", &:read))
translator = ::YamlTranslator::Translator.new(adapter)

result = translator.translate(yaml, to: :ja)
result.save_to('/path/to/directory') # Write a ja.yml
result.save # Write a ja.yml (current directory)
```

## Run the test

	bundle install
	rake spec
