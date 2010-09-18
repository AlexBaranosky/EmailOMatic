module PathMaking
  def resource_path(file_name)
    File.join(File.dirname(__FILE__), '..', 'resources', file_name)
  end
end
