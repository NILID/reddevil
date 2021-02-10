# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.2'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( soundmanager2.swf soundmanager2_flash9.swf)
Rails.application.config.assets.precompile += %w[ckeditor/config.js]

THEMES = %w[
default
cerulean
cosmo
cyborg
darkly
flatly
journal
litera
lumen
lux
materia
minty
pulse
sandstone
simplex
sketchy
slate
solar
spacelab
superhero
united
yeti]


THEMES.each do |theme|
  Rails.application.config.assets.precompile += ["bootstrap/#{theme}/bootstrap.min"]
end