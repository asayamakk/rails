module Mime
  class Type
    def self.lookup(string)
      LOOKUP[string]
    end
    
    def initialize(string, symbol = nil, synonyms = [])
      @symbol, @synonyms = symbol, synonyms
      @string = string
    end
    
    def to_s
      @string
    end
    
    def to_sym
      @symbol || to_sym
    end

    def ===(list)
      if list.is_a?(Array)
        (@synonyms + [ self ]).any? { |synonym| list.include?(synonym) }
      else
        super
      end
    end
    
    def ==(mime_type)
      (@synonyms + [ self ]).any? { |synonym| synonym.to_s == mime_type.to_s } if mime_type
    end
  end

  ALL  = Type.new "*/*", :all
  HTML = Type.new "text/html", :html
  JS   = Type.new "text/javascript", :js, %w( application/javascript application/x-javascript )
  XML  = Type.new "text/xml", :xml, %w( application/xml application/x-xml )
  RSS  = Type.new "application/rss+xml", :rss
  ATOM = Type.new "application/atom+xml", :atom
  YAML = Type.new "application/x-yaml", :yaml

  LOOKUP = Hash.new { |h, k| h[k] = Type.new(k) }

  LOOKUP["*/*"]                      = ALL
  LOOKUP["text/html"]                = HTML
  LOOKUP["application/rss+xml"]      = RSS
  LOOKUP["application/atom+xml"]     = ATOM
  LOOKUP["application/x-yaml"]       = YAML

  LOOKUP["text/javascript"]          = JS
  LOOKUP["application/javascript"]   = JS
  LOOKUP["application/x-javascript"] = JS

  LOOKUP["text/xml"]                 = XML
  LOOKUP["application/xml"]          = XML
  LOOKUP["application/x-xml"]        = XML
end