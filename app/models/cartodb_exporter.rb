class CartodbExporter

  def self.export(project)
    puts "Saving data..."
    file_name = project.cartodb_table_name
    file_path = Rails.root.join("public", "cartodb_files", "#{file_name}.csv")

    colum_names = ['id', 'username', 'name', 'email', 'bio', 'contributions', 'avatar_url', 'location', 'latitude', 'longitude', 'country', 'state', 'city']
    CSV.open(file_path, "wb") do |csv|
      csv << colum_names
      project.contributors.each do |cont|
        csv << [cont.id, cont.username, cont.name, cont.email, cont.bio, cont.contributions, cont.avatar_url, cont.location, cont.latitude, cont.longitude, cont.country, cont.state, cont.city]
      end
    end
    return file_path
  end

end