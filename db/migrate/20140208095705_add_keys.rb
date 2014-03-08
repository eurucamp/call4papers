class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "authentications", "users", name: "authentications_user_id_fk", dependent: :delete
    add_foreign_key "papers", "calls", name: "papers_call_id_fk", dependent: :restrict
    add_foreign_key "papers", "users", name: "papers_user_id_fk", dependent: :delete
  end
end
