class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order('created_at DESC')
  end

  def export
    @users = User.order('created_at DESC')

    respond_to do |format|
      format.csv do
        csv_response = build_csv(@users, export_columns)
        send_data(csv_response, filename: 'users.csv', disposition: 'attachment', type: 'text/csv; charset=utf-8; header=present')
      end
    end
  end

  private

  def export_columns
    %w(
      id
      name
      email
      bio
      website_url
      twitter_handle
      github_handle
      created_at
      updated_at
      staff
    )
  end

end
