module Admin
  class PaperDecorator < SimpleDelegator
    include ActionView::Helpers::TagHelper

    def self.wrap(collection)
      collection.map do |obj|
        new obj
      end
    end

    def formatted_time_slot
      slot_value = time_slot.gsub(/ minutes$/, 'm')
      content_tag(:span, slot_value, class: "ts-#{slot_value}")
    end

    def formatted_created_at
      formatted_time(created_at)
    end

    def formatted_updated_at
      if updated?
        formatted_time(updated_at)
      else
        ''
      end
    end

    def formatted_score
      empty_score = score.nil? or score.nan? 
      score_value = empty_score ? 'n/a' : score
      score_class = empty_score ? 'na'  : "sc-#{score.round}"
      content_tag(:span, score_value, class: score_class)
    end

    private

    def formatted_time(time)
      content_tag(:time, time.strftime('%d.%m'),
        datetime: time.to_formatted_s(:rfc822),
        title:    time.to_formatted_s(:long))
    end
  end
end
