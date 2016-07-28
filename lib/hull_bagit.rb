require 'bagit'
require 'fileutils'

class HullBagit

  include Hull::BagitHelpers

  def initialize(path, admin_info, description_file_path=nil)

    @temp_dir, @content_temp_dir, @admin_info_temp_dir = create_temp_directory
    move_data(path, @content_temp_dir)
    create_admin_info(admin_info)
    create_description(description_file_path)
    process_description(@content_temp_dir, admin_info)

    Dir.glob(File.join(@temp_dir, '*')).each do |file|
      FileUtils.mv(file, path)
    end

    #delete the temporary directory
    FileUtils.rm_rf(@temp_dir)

    #create a bag from the temporary directory
    BagIt::Bag.new(path)



  end
end