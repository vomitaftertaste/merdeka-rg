require 'instagram'
require 'sequel'
require 'unirest'
require './secret.rb'

hashtags = ['cat','dog']

loop do
  puts 'Connecting to instagram...'

  client = Instagram.client(access_token: Secret.instagram['hdr'][:access_token])

  result_feeds = []
  for hashtag in hashtags do
    puts "Searching for tag #{hashtag}..."
    media_feeds = client::tag_recent_media(hashtag)
    result_feeds = result_feeds | media_feeds
    puts "Sleeping for 10 seconds..."
    sleep(10)
  end

  # get latest timestamp
  latest_timestamp = (Unirest.get Secret.remote_url['tp'][:latest_timestamp_data]).body[0]['max_timestamp']

  DB = Sequel.connect(Secret.db['local_mysql_hdr'])
  merdekas = DB[:merdeka]

  for feed in result_feeds do
    if feed.created_time <= latest_timestamp then
      puts "feed #{feed.id} is earlier #{feed.created_time} than the latest timestamp #{latest_timestamp}"
      next
    end

    puts "inserting #{feed.id} to the database"
    instagram_id = feed.id
    message = feed.caption['text']
    timestamp = feed.created_time
    image_url = feed.images.standard_resolution.url
    hashtags = feed.tags.inject("") { |res,el| "#{res}\##{el} " }
    #merdekas.insert(message: message, imageUrl: image_url, timeStamp: timestamp, hashtag: hashtags, instagram_id: instagram_id)
    response = Unirest.get Secret.remote_url['tp'][:post_data],
                            parameters: {message: message, imageUrl: image_url, timeStamp: timestamp, hashtag: hashtags, instagram_id: instagram_id}
    puts response.body
  end

  puts 'Sleep 5 minutes...'
  sleep(300)
end


#puts media_feeds
#
# domain = 'ftp.tienpingx2.96.lt'
# username = 'u972812590'
# password = 'thereisnospoon'
#
#
# ftp = Net::FTP.new(domain)
# ftp.passive = true
# ftp.login(username, password)
# ftp.chdir(path_on_server)
# ftp.puttextfile(path_to_web_file)
# ftp.close
#
# ftp.storb

