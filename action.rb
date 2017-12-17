require "thor"
class Action < Thor
  include Thor::Actions
  desc "empty_directory!", "create the empty directory"
  Action.source_root File.expand_path('../', __FILE__)
 #Speak.new.template "layout.html.erb", "app/views/layouts/l.html.erb"
  def empty_directory!(page_name)
    Action.new.empty_directory "app/views/#{file_name(page_name)}"
    remove_file("app/views/home/home.html.erb")
  end

  desc "new_file!", "create the file from link"
  def new_file!(link,location)
    get "http://gist.github.com/103208", "app/views/#{file_name(page_name)}/#{file_name(page_name)}.html.erb"
  end
  desc "append_file!", "put the text in file"
  def append_file!(append_location,message)
    append_to_file 'config/routes.rb' do
      'root: "home#index"'
    end
  end
  desc "replacement_in_file!", "replacement_in_file"
  def replacement_in_file!(replacement_location,text_remove,text_add)
    gsub_file "app/views/layouts/application.html.erb", 'root: "home#index"', '\1'
  end
  desc "search_in_file!", "Search In File"
  def search_in_file!(location)
    begin
         find_in_source_paths(location)
         return true
     rescue Thor::Error => e
       return false
     end
  end
  desc "remove_file!", "remove the file"
  def remove_file!(location)
    begin
      remove_file(location)
         return true
     rescue Thor::Error => e
       return false
     end
  end

  private
  def file_name(page_name)
    page = page_name.split(' ')
    if page.length == 1
      return page_name
    else
      return page.join('_')
    end
  end
end
