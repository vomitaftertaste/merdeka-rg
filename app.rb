require 'instagram'
require 'sequel'
require 'unirest'
require './secret.rb'

hashtags = ['ANTICORRUPTION']
sleep_interval = 5 #seconds
run_count = 0

loop do
  puts 'Connecting to instagram...'

  client = Instagram.client(access_token: Secret.instagram['hdr'][:access_token])

  result_feeds = []
  for hashtag in hashtags do
    puts "Searching for tag #{hashtag}..."
    media_feeds = client::tag_recent_media(hashtag)
    result_feeds = result_feeds | media_feeds
    puts "Sleeping for #{sleep_interval} seconds..."
    sleep(sleep_interval)
  end

  # get latest timestamp
  latest_timestamp = (Unirest.get Secret.remote_url['tp'][:latest_timestamp_data]).body[0]['max_timestamp']
  latest_timestamp = "0" if latest_timestamp.nil?
  
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
    feed_hashtags = feed.tags.inject("") { |res,el| "#{res}\##{el} " }
    #merdekas.insert(message: message, imageUrl: image_url, timeStamp: timestamp, hashtag: hashtags, instagram_id: instagram_id)
    response = Unirest.get Secret.remote_url['tp'][:post_data],
                            parameters: {message: message, imageUrl: image_url, timeStamp: timestamp, hashtag: feed_hashtags, instagram_id: instagram_id}
    puts response.body
  end
  run_count += 1
  puts "Run count \##{run_count}"
  puts "Sleep #{sleep_interval} seconds..."
  sleep(sleep_interval)
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

