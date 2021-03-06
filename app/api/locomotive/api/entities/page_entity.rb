module Locomotive
  module API
    module Entities

      class PageEntity < BaseEntity

        expose  :title, :slug, :position, :handle, :response_type,
                :redirect, :redirect_url, :redirect_type, :listed, :published, :templatized,
                :is_layout, :allow_layout, :templatized_from_parent, :target_klass_slug,
                :target_klass_name, :raw_template, :seo_title, :meta_keywords,
                :meta_description, :fullpath, :depth, :translated_in,
                :target_entry_name, :parent_id

        expose :editable_elements, using: EditableElementEntity

        expose :escaped_raw_template do |page, _|
          h(page.raw_template)
        end

        # @TODO: determine what to do if target_klass_name is nil.  Templatized fails.
        expose :target_entry_name do |page, _|
          if page.target_klass_name
            page.target_entry_name
          end
        end

        expose :localized_fullpaths do |page, options|
          if (site = options[:site])
            {}.tap do |hash|
              site.locales.each do |locale|
                hash[locale] = site.localized_page_fullpath(page, locale)
              end
            end
          else
            {}
          end
        end

      end

    end
  end
end
