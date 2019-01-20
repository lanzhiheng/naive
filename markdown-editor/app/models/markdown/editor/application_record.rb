module Markdown
  module Editor
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
