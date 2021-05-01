#import the gem for xcodeproj
require 'xcodeproj'

#import the gem for fileutls
require 'fileutils'

#import the gem for Date
require 'date'

def addfiles(path, file, current_group, targets)
  if File.basename(path.to_s) != current_group.to_s
    new_folder = File.basename(path)
    created_group = current_group.find_subpath(new_folder, true)
    created_group.set_path(path.gsub(file.to_s, ''))
    i = created_group.new_file(file)
    targets.each do |target|
       target.add_file_references([i])
    end
  else
    i = current_group.new_file(file)
    targets.each do |target|
       target.add_file_references([i])
    end
  end
end

def replacePlaceholders(text, module_name, project_name, user_name)
  new_text = text.gsub('template', module_name)
  new_text = new_text.gsub('project_name', project_name)
  new_text = new_text.gsub('user_name', user_name)
  new_text = new_text.gsub('dd', Date.today.day.to_s).gsub('mm', Date.today.month.to_s).gsub('yy', Date.today.year.to_s)
  return new_text
end

def createFolderIfNeeded(path)
  unless File.directory?(path)
    FileUtils.mkdir_p(path)
  end
end

def main()
  current_path = ARGV[0]
  project_name = ARGV[1]
  module_name = ARGV[2]
  user_name = ARGV[3]

  if ARGV[4] != nil && ARGV[4].include?('targets=')
    argument_targets = ARGV[4].gsub('targets=', '')
  end
  if ARGV[5] != nil && ARGV[5].include?('targets=')
    argument_targets = ARGV[5].gsub('targets=', '')
  end
  if ARGV[4] != nil && ARGV[4].include?('folder=')
    in_folder = ARGV[4].gsub('folder=', '')
  end
  if ARGV[5] != nil && ARGV[5].include?('folder=')
    in_folder = ARGV[5].gsub('folder=', '')
  end

  if in_folder == nil
    in_folder = ''
  else
    createFolderIfNeeded(in_folder)
    in_folder = in_folder + '/'
  end
  project = Xcodeproj::Project.open(File.join(current_path, project_name))

  targets = Array.new(0)

  puts argument_targets
  if argument_targets != nil
    argument_targets = argument_targets.split(',')
    project.targets.each do |target|
      if argument_targets.include?(target.to_s)
        targets.append(target)
      end
    end
  end

  if targets.count == 0
    targets.append(project.targets.first)
  end

  template_directory = __dir__+"/template"
  template_directories = Dir.glob(template_directory+"/**/*")

  module_paths = Array.new(0)

  destination_directory = in_folder + module_name

  createFolderIfNeeded(destination_directory)

  group_path = File.join(project_name.gsub('.xcodeproj', ''), destination_directory)
  new_group = project.main_group.find_subpath(group_path, true)
  new_group.set_path(module_name)
  template_directories.each do |path|
    if File.file?(path)
      text = File.read(path)
      new_text = replacePlaceholders(text, module_name, project_name.gsub('.xcodeproj', ''), user_name)
      file_path_dir = File.dirname(File.join(current_path, project_name.gsub('.xcodeproj', ''), destination_directory, path.gsub(template_directory, '')).gsub('template', module_name))
      createFolderIfNeeded(file_path_dir)
      file = File.join(file_path_dir, File.basename(path).gsub('template', module_name))
      puts "Creating -> " + file
      File.open(file, "w") { |f| f.write(new_text) }
      addfiles(file_path_dir, file, new_group, targets)
    end
  end

  new_group.sort_recursively_by_type()

  project.save()

  puts "Done!"
end

main()
