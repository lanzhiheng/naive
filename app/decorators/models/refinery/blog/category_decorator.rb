Refinery::Blog::Category.class_eval do
  # TODO: hotfix
  class << self
    def translated
      all
    end
  end
end
