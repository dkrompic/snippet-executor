class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :content
      t.text :execution_output
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
