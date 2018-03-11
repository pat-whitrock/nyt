class MartianPresenter < SimpleDelegator
  MARTIANABLE_METHODS = %i(byline headline summary).freeze
  MARTIANABLE_WORD = /[\w]{4,}/i.freeze

  MARTIANABLE_METHODS.each do |method_name|
    define_method method_name do
      super().gsub(MARTIANABLE_WORD) do |word|
        if word.first.match(/[[:upper:]]/)
          'Boinga'
        else
          'boinga'
        end
      end
    end
  end
end
