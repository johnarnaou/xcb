#import the gem for xcodeproj
require 'xcodeproj'

#import the gem for fileutls
require 'fileutils'

#import the gem for Date
require 'date'

def addfiles (path, file, current_group, main_target)
  if File.basename(path.to_s) != current_group.to_s
    new_folder = File.basename(path)
    created_group = current_group.new_group(new_folder)
    i = created_group.new_file(file)
    main_target.add_file_references([i])
  else
    i = current_group.new_file(file)
    main_target.add_file_references([i])
  end
end

def replacePlaceholders(text, module_name, project_name, user_name)
  new_text = text.gsub('template', module_name)
  new_text = new_text.gsub('project_name', project_name)
  new_text = new_text.gsub('user_name', user_name)
  new_text = new_text.gsub('dd', Date.today.day.to_s).gsub('mm', Date.today.month.to_s).gsub('yy', Date.today.year.to_s)
  return new_text
end

def main()
  current_path = ARGV[0]
  project_name = ARGV[1]
  module_name = ARGV[2]
  user_name = ARGV[3]

  project = Xcodeproj::Project.open(current_path+"/"+project_name)
  targets = project.targets.first

  template_directory = __dir__+"/template"
  template_directories = Dir.glob(template_directory+"/**/*")

  module_paths = Array.new(0)

  unless File.directory?(module_name)
    FileUtils.mkdir_p(module_name)
  end

  new_group = project.main_group.find_subpath(File.join(project_name.gsub('.xcodeproj', ''), module_name), true)

  template_directories.each do |path|
    full_path = path
    if File.file?(full_path)
      text = File.read(full_path)
      new_text = replacePlaceholders(text, module_name, project_name.gsub('.xcodeproj', ''), user_name)
      dirname = File.dirname(new_group.to_s+full_path.gsub(template_directory, ''))
      file_path_dir = File.dirname(current_path+"/"+project_name.gsub('.xcodeproj', '')+"/"+module_name+full_path.gsub(template_directory, ''))
      unless File.directory?(file_path_dir)
        FileUtils.mkdir_p(file_path_dir)
      end
      file = file_path_dir+"/"+File.basename(path).gsub('template', module_name)
      puts "Creating -> " + file
      File.open(file, "w") { |f| f.write(new_text) }
      addfiles(file_path_dir, file, new_group, targets)
    end
  end

  project.save()

  puts "Done!"
end

main()
