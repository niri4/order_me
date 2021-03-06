class OrderMeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def install
    install_dependency
       copy_file "order_me.rb", "vendor/order_me.rb"
       copy_file "order_me.yml", "config/order_me.yml"
   #remove_file "app/assets/stylesheets/application.css"
   copy_file "application.css.scss", "app/assets/stylesheets/order_me_application.css.scss"
    insert_into_file "app/assets/javascripts/application.js", "//= require jquery \n //= require bootstrap\n //= require jquery_ujs\n",
                    :before => "//= require rails-ujs"
    append_to_file 'config/initializers/assets.rb' do
      'Rails.application.config.assets.precompile += %w( order_me_application.css.scss )'
    end
    insert_into_file "app/views/layouts/application.html.erb", "<%= stylesheet_link_tag 'order_me_application', media: 'all', 'data-turbolinks-track': 'reload' %>", :before => "</head>"
  end

  private
  def install_dependency
     gem 'bootstrap', '~> 4.0.0'
     gem 'jquery-rails'
     gem "font-awesome-rails"
     Bundler.with_clean_env do
       run "bundle install"
     end
   end


end
