require 'yaml-translator/structure/tree'
require 'yaml-translator/structure/single_key'

Hash.include YamlTranslator::Structure::Tree
Hash.include YamlTranslator::Structure::SingleKey
