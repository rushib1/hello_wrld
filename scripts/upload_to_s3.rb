require "net/http"
require "json"
puts "UPLOADING APK to S3"

uri = URI('https://stormy-temple-86930.herokuapp.com/build/presigned_url')
req = Net::HTTP::Post.new(uri)
req['Content-Type'] = 'application/json'
req.body = {
    build_id: ENV.fetch('TRAVIS_BUILD_ID'),
    commit: ENV.fetch('TRAVIS_COMMIT'),
    os: ENV.fetch('TRAVIS_OS_NAME'),
}.to_json

res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
end

presigned_post = JSON.parse res.body

uri = URI(presigned_post['url'])
request = Net::HTTP::Post.new(uri)
form_data = []
presigned_post['fields'].each do |key, value|
    form_data.push([key, value])
end



apk_path = "#{ENV.fetch('TRAVIS_BUILD_DIR')}/build/app/outputs/apk/release/app-release.apk"
# apk_path = "../elastic_search.js"
puts "Uploading apk from #{apk_path}"
form_data.push(['file', File.open(apk_path)])
request.set_form form_data, 'multipart/form-data'

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http| # pay attention to use_ssl if you need it
    http.request(request)
end