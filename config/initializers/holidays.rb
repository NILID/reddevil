Holidays.load_custom(Dir[Rails.root.join('lib', 'definitions', '*.{yml}').to_s])

Holidays.cache_between(Time.now, 2.years.from_now, :full_ru, :observed)

