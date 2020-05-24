class CreateCategoryships < ActiveRecord::Migration[4.2]
  def change
    create_table :categoryships do |t|
      t.references :doc, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end

    Doc.all.each do |doc|
      doc.categoryships.create!(category_id: doc.category_id)
    end
  end
end
