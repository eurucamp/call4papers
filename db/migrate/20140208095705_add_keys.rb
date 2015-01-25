class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "authentications", "users", on_delete: :cascade
    add_foreign_key "papers", "calls", on_delete: :restrict
    add_foreign_key "papers", "users", on_delete: :cascade
  end
end
