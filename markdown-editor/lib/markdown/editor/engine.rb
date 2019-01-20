require 'refinerycms-core'

module Markdown
  module Editor
    class Engine < ::Rails::Engine
      extend Refinery::Engine
      isolate_namespace Markdown::Editor

      config.to_prepare do
        Rails.application.config.assets.precompile += %w(
          simplemde.css
          adjust.css
          simplemde.js
          init_editor.js
        )
      end

      after_inclusion do
        %w(simplemde adjust).each do |stylesheet|
          Refinery::Core.config.register_visual_editor_stylesheet stylesheet
        end

        %w(simplemde init_editor).each do |javascript|
          Refinery::Core.config.register_visual_editor_javascript javascript
        end
      end
    end
  end
end
