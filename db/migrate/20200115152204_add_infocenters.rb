class AddInfocenters < ActiveRecord::Migration[5.2]
  def up
    ['Дерево целей', 'Оперативное управление', 'Проектное управление', 'Управление проблемами'].each do |text|
      InfocenterCategory.create!(title: text)
    end

    operative = InfocenterCategory.where(title: 'Оперативное управление').first
    ['Безопасность', 'Качество', 'Исполнение заказов', 'Затраты', 'Корпоративная культура'].each do |text|
      info = InfocenterCategory.new
      info.parent = operative
      info.title = text
      info.save!
    end

    zatrati = InfocenterCategory.where(title: 'Затраты').first
    ['Затраты по продуктам', 'Затраты на персонал'].each do |text|
      info = InfocenterCategory.new
      info.parent = zatrati
      info.title = text
      info.save!
    end

    culture = InfocenterCategory.where(title: 'Корпоративная культура').first
    ['Среднесписочная численность', 'Фонд оплаты труда', 'График отпусков персонала'].each do |text|
      info = InfocenterCategory.new
      info.parent = culture
      info.title = text
      info.save!
    end

  end

  def down
    InfocenterCategory.destroy_all
  end
end
