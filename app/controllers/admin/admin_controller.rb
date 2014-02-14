class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :allow_staff_only

  def allow_staff_only
    redirect_to root_path unless current_user.staff?
  end

  protected

  def build_csv(object, columns)
    require 'csv'

    csv_response = CSV.generate do |csv|
      csv << columns
      object.each do |paper|
        csv << columns.map { |col| paper.send(col) }
      end
    end
  end
end
