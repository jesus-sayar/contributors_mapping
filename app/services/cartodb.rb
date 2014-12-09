require 'rest_client'

class Cartodb
  def upload_file(file_path)
    RestClient.post "https://#{$cartodb_username}.cartodb.com/api/v1/imports/?api_key=#{$cartodb_api_key}", file: File.new(file_path)
  end

  def get_table(table_name)
    url = "http://#{$cartodb_username}.cartodb.com/api/v2/sql?q=SELECT * FROM " + table_name + " ORDER BY contributions DESC&api_key=#{$cartodb_api_key}"
    uri = URI.parse(URI.encode(url.strip))
    response = JSON.load(Net::HTTP.get(uri))
    response["rows"]
  end

end
