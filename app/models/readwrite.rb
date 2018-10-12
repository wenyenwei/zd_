class ReadWrite
  class << self

    def read(file_name_input, parent_folder, child_folder)
      begin
        file_name = file_name_input
        copy_path = Rails.root.join(parent_folder, child_folder)
        classes_copy_file = File.read(copy_path.join(file_name))
        copy = JSON.parse(classes_copy_file)
      rescue StandardError => ex
        puts 'Read Error: ', ex
      end

    end

    def write(file_name_input, parent_folder, child_folder, write_data)
      begin
        file_name = file_name_input
        copy_path = Rails.root.join(parent_folder, child_folder)
        write_data = write_data.to_json.gsub(/\"{/, "{").gsub(/\}\"/, "}").gsub(/\\/, "")
        File.open(copy_path.join(file_name), "w") { |file| file.write write_data }
      rescue StandardError => ex
        puts 'Write Error: ', ex
      end
    end

  end
end