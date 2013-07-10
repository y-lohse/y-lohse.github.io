module Jekyll
  module RandomFilter
    def random(input)
      input.sample
    end
  end
end

Liquid::Template.register_filter(Jekyll::RandomFilter)