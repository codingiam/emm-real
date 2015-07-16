Sequel.migration do
  up do
    create_table(:adverts) do
      primary_key :id
      String :title, null: false
      String :description, text: true, null: false
      String :link, null: false
      Date :published_at, null: false
    end
  end

  down do
    drop_table(:adverts)
  end
end
