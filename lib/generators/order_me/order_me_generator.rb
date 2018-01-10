class OrderMeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def install
   copy_file "order_me.rb", "lib/order_me.rb"
 end
end
