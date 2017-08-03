origin_files = Dir.glob("./collections_ePub/**/*.epub")
encoding_options = {
	:invalid           => :replace,
	:undef             => :replace,
	:replace           => '',
	:universal_newline => true
}  
puts origin_files.map do |origin_file|
	path = File.dirname origin_file
	file_name = File.basename(origin_file, ".*").encode(Encoding.find('ASCII'), encoding_options)
	file_name = file_name.underscore.split(/\s| |\.|_/).delete_if{|s| s.blank?}
	file_name = file_name.join("-")
	#puts File.join(path, "#{file_name}.epub")
	new_file = File.join(path, "#{file_name}.epub")
	File.rename origin_file, new_file
	new_file
end
