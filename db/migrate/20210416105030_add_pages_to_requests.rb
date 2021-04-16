class AddPagesToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :pages, :jsonb
  end
end
