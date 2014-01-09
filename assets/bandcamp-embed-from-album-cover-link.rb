# bandcamp-embed-from-album-cover-link.rb
# by Andrew Monks, 1/7/13
# 
# usage: 
# $ ruby bandcamp-embed-from-album-cover-link.rb ./index.html ./otherpage.html


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
	# nokogiri parse file as html
	doc = Nokogiri::HTML(f)
	f.close

	# loop through album links ((every bandcamp album url includes "/album/"))
	# you'd think I'd want to check for false positives but there aren't any
	# at time of writing so dilligaf
	doc.xpath('//a[contains(@href, "album")]').each { |album|

		# get url from link
		url = album['href']
		puts url
		puts ""

		# get albumid from bandcamp api
		albumid = JSON.parse(open("http://api.bandcamp.com/api/url/1/info?key=vatnajokull&url=" + url).read)["album_id"]
		# get albuminfo from bandcamp api
		albuminfo = JSON.parse(open( "http://api.bandcamp.com/api/album/2/info?key=vatnajokull&album_id=" + albumid.to_s ).read)
		artist = albuminfo["artist"]
		# "artist" only populates if it's different from the band name. 
		# On belgian man's bandcamp it always is, but on other bandcamps it isn't.
		# If there's no artist field, use the band name instead.
		if artist == nil
			# we have the bandid in our albuminfo packet
			# send that out and get the band name from bandcamp api
			bandinfo = JSON.parse(open( "http://api.bandcamp.com/api/band/3/info?key=vatnajokull&band_id=" + albuminfo["bandid"].to_s ).read)
			# and set our (currently nil) artist name to that
			artist = bandinfo["name"]
		end

		puts "html:"
		# generate an embed code
		embed = '<p class="bandcamp"><iframe style="border: 0; width:100%;" src="http://bandcamp.com/EmbeddedPlayer/album=' + albumid.to_s + '/size=large/bgcol=333333/linkcol=e32c14/transparent=true/" seamless><a href="' + url + '">' + albuminfo["title"] + ' by ' + artist + '</a></iframe></p>'
		puts embed
		puts ""

		# and swap the new embed code into our doc
		album.swap(embed)

	}

	# loop through track links ((every bandcamp track url includes "/track/"))
	# you'd think I'd want to check for false positives but there aren't any
	# at time of writing so dilligaf
	doc.xpath('//a[contains(@href, "track")]').each { |track|

		# get url from link
		url = track['href']
		puts url
		puts ""

		# get trackid from bandcamp api
		trackid = JSON.parse(open("http://api.bandcamp.com/api/url/1/info?key=vatnajokull&url=" + url).read)["track_id"]
		# get trackinfo from bandcamp api
		trackinfo = JSON.parse(open( "http://api.bandcamp.com/api/track/3/info?key=vatnajokull&track_id=" + trackid.to_s ).read)
		artist = trackinfo["artist"]
		# "artist" only populates if it's different from the band name. 
		# On belgian man's bandcamp it always is, but on other bandcamps it isn't.
		# If there's no artist field, use the band name instead.
		if artist == nil
			# we have the bandid in our trackinfo packet
			# send that out and get the band name from bandcamp api
			bandinfo = JSON.parse(open( "http://api.bandcamp.com/api/band/3/info?key=vatnajokull&band_id=" + trackinfo["bandid"].to_s ).read)
			# and set our (currently nil) artist name to that
			artist = bandinfo["name"]
		end

		puts "html:"
		# generate an embed code
		embed = '<p class="bandcamp"><iframe style="border: 0; width:100%;" src="http://bandcamp.com/EmbeddedPlayer/track=' + trackid.to_s + '/size=large/bgcol=333333/linkcol=e32c14/transparent=true/" seamless><a href="' + url + '">' + trackinfo["title"] + ' by ' + artist + '</a></iframe></p>'
		puts embed
		puts ""

		# and swap the new embed code into our doc
		track.swap(embed)

	}
	# rename the old file
	FileUtils.mv(filename, filename + ".old")
	# and save the new file
    File.open(filename, 'w') {|f| f.write(doc) }
end
