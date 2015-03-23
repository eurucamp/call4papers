module Admin
  class ProposalDecorator < SimpleDelegator
    include ActionView::Helpers::TagHelper

    def self.wrap(collection)
      collection.map do |obj|
        new obj
      end
    end

    def formatted_time_slot
      slot_value = talk_time_slot.gsub(/ minutes$/, 'm')
      content_tag(:span, slot_value, class: "ts-#{slot_value}")
    end

    def formatted_created_at
      formatted_time(talk.created_at)
    end

    def formatted_updated_at
      if talk.updated?
        formatted_time(talk.updated_at)
      else
        ''
      end
    end

    def formatted_score
      empty_score = score.nil? || score.nan?
      score_value = empty_score ? 'n/a' : score.round(2)
      score_class = empty_score ? 'na'  : "sc-#{score.round}"
      content_tag(:span, score_value, class: score_class)
    end

    def formatted_score_by_dimension(dimension)
      score = score_by_dimension(dimension)
      empty_score = score.nil? || score.nan?
      score_value = empty_score ? 'n/a' : score.round(2)
      score_class = empty_score ? 'na'  : "sc-#{score.round} single"
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
