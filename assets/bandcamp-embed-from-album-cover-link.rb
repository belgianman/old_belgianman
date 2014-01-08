# bandcamp-embed-from-album-cover-link.rb

require 'nokogiri'
require 'open-uri'
require 'json'
require 'fileutils'

# get filenames array from cli arguments
files = Array.new
ARGV.each do|a|
  files.push(a)
end

# main loop
files.each do |filename|
	# open file
	f = File.open(filename)
	doc = Nokogiri::HTML(f)
	f.close

	doc.xpath('//a[contains(@href, "album")]').each { |album|

		puts ""

		puts "url:"
		url = album['href']
		puts url
		puts ""

		puts "album id:"
		albumid = JSON.parse(open("http://api.bandcamp.com/api/url/1/info?key=vatnajokull&url=" + url).read)["album_id"]
		puts albumid
		puts ""

		albuminfo = JSON.parse(open( "http://api.bandcamp.com/api/album/2/info?key=vatnajokull&album_id=" + albumid.to_s ).read)
		artist = albuminfo["artist"]
		if artist == nil
			bandid = albuminfo["band_id"]
			bandinfo = JSON.parse(open( "http://api.bandcamp.com/api/band/3/info?key=vatnajokull&band_id=" + bandid.to_s ).read)
			artist = bandinfo["name"]
		end
		title = albuminfo["title"]

		puts albumid.to_s
		puts title
		puts artist

		puts "html:"
		embed = '<p class="bandcamp"><iframe style="border: 0; width:100%;" src="http://bandcamp.com/EmbeddedPlayer/album=' + albumid.to_s + '/size=large/bgcol=333333/linkcol=e32c14/transparent=true/" seamless><a href="' + url + '">' + title + ' by ' + artist + '</a></iframe></p>'
		puts embed
		puts ""

		album.swap(embed)

	}

	doc.xpath('//a[contains(@href, "track")]').each { |track|

		puts ""

		puts "url:"
		url = track['href']
		puts url
		puts ""

		puts "track id:"
		trackid = JSON.parse(open("http://api.bandcamp.com/api/url/1/info?key=vatnajokull&url=" + url).read)["track_id"]
		puts trackid
		puts ""

		albuminfo = JSON.parse(open( "http://api.bandcamp.com/api/track/3/info?key=vatnajokull&track_id=" + trackid.to_s ).read)
		title = albuminfo["title"]

		puts "html:"
		embed = '<p class="bandcamp"><iframe style="border: 0; width:100%;" src="http://bandcamp.com/EmbeddedPlayer/album=' + trackid.to_s + '/size=large/bgcol=333333/linkcol=e32c14/transparent=true/" seamless><a href="' + url + '">' + title + '</a></iframe></p>'
		puts embed
		puts ""

		track.swap(embed)

	}
	FileUtils.mv(filename, filename + ".old")
    File.open(filename, 'w') {|f| f.write(doc) }
end
