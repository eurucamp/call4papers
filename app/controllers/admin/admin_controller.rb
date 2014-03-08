class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :allow_staff_only

  def allow_staff_only
    redirect_to root_path unless current_user.staff?
  end

  protected

  def build_csv(records, columns)
    require 'csv'

    csv_response = CSV.generate do |csv|
      csv << columns.map { |col| records.human_attribute_name(col) }
      records.each do |record|
        csv << columns.map { |col| record.send(col) }
      end
    end
  end
end
