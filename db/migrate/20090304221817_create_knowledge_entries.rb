class CreateKnowledgeEntries < ActiveRecord::Migration
  def self.up
    create_table :knowledge_entries do |t|
      t.string :title
      t.text :content
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :knowledge_entries
  end
end
