<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="/assets/style.css" title="stylesheet" type="text/css" media="screen">
		<title>Belgian Man Records</title>
		<script type="text/javascript" src="http://use.typekit.com/gjc2qts.js"></script>
		<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
		<script type="text/javascript">
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-7421722-2']);
			_gaq.push(['_trackPageview']);
			(function() {
				var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			})();
		</script>
	</head>
	<body>
		<div id="header">
			<a class="follow" href="http://tumblr.com/follow/belgianman">Follow</a>
			<div class="logo">
				<a href="/"><img src="/assets/logo.png" id="logo" alt="Belgian Man Records" /></a>
			</div>
			<div class="container_12">
				<div class="grid_5 nav">
					<p><a href="/artists">Artists</a></p>
					<p><a href="/releases">Releases</a></p>
					<p><a href="http://music.belgianman.com/merch">Goods</a></p>
					<p><a href="/videos">Videos</a></p>
					<p><a href="/events">Events</a></p>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		
		<div id="main">
			<div class="container_12">
				<div class="grid_2">
					<div class="white title">Belgian Man Records</div>
					<p>Belgian Man Records is a <a href="/artists">collective of artists</a> based in lovely, historic Concord, MA.</p>
					<p>We record music, film videos, make art, and play shows.</p>
					<p>All of our music is licensed under a <a href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons by-nc</a> license, which means you&#8217;re free to share, remix, and re-use it non-commercially, provided you give attribution to the artist. If you&#8217;d like to use Belgian Man music commercially, email <a href="mailto:andrew@belgianman.com">Andrew</a>.</p>
					<div class="grid_4 prefix_4">
						<img src="/assets/concord.png" title="Concord, MA Town Seal" />
					</div>
					<div class="clear"></div>
					<p class="quote"><a href="http://www.youtube.com/watch?v=YodzjpvrtJQ">Representin' MA to the fullest.</a></p>
					<div class="white title">Facebook</div>
					<div id="fb-root"></div>
					<script>
						(function(d, s, id) {
						  var js, fjs = d.getElementsByTagName(s)[0];
						  if (d.getElementById(id)) {return;}
						  js = d.createElement(s); js.id = id;
						  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
						  fjs.parentNode.insertBefore(js, fjs);
						}(document, 'script', 'facebook-jssdk'));
					</script>
					<div class="fb-like-box" data-href="http://facebook.com/belgianman" data-width="250" data-show-faces="false" data-stream="false" data-header="true"></div>
				</div>

				<?php
				    echo "";
				    $request_url = "http://belgianman.tumblr.com/api/read?tagged=release"; //get xml file
				    $xml = simplexml_load_file($request_url); //load it
				    $title = $xml->posts->post->{'regular-title'}; //load post title into $title
				    $post = $xml->posts->post->{'regular-body'}; //load post body into $post
				    $id = $xml->posts->post['id']; //load url of blog post into $link
				    $key = $xml->posts->post['reblog-key']; //load url of blog post into $link
				    echo // spit that baby out with some stylish html
				        '<div class="grid_3">
				            <div class="white title">'.$title.'<a href="http://www.tumblr.com/reblog/'.$id.'/'.$key.'" class="reblog"><img src="/assets/reblog.png" title="Reblog on Tumblr"/></a></div>
				            <div class="post">'.$post.'</div>
				        </div>
				    '; 
				    
				    echo "";
				    $request_url = "http://belgianman.tumblr.com/api/read?tagged=release&start=1&chrono=1&num=1"; //get xml file
				    $xml = simplexml_load_file($request_url); //load it
				    $title = $xml->posts->post->{'regular-title'}; //load post title into $title
				    $post = $xml->posts->post->{'regular-body'}; //load post body into $post
				    $link = $xml->posts->post['url']; //load url of blog post into $link
				    $id = $xml->posts->post['id']; //load url of blog post into $link
				    $key = $xml->posts->post['reblog-key']; //load url of blog post into $link
				    echo // spit that baby out with some stylish html
				        '<div class="grid_3">
				            <div class="white title">'.$title.'<a href="http://www.tumblr.com/reblog/'.$id.'/'.$key.'" class="reblog"><img src="/assets/reblog.png" title="Reblog on Tumblr"/></a></div>
				            <div class="post">'.$post.'</div>
				        </div>
				    '; 

				    echo "";
				    $request_url = "http://belgianman.tumblr.com/api/read?tagged=video&type=video"; //get xml file
				    $xml = simplexml_load_file($request_url); //load it
				    $video = $xml->posts->post->{'video-source'}; //load post title into $title
				    $videoid = substr($video,18,26);
				    $post = $xml->posts->post->{'video-caption'}; //load post body into $post
				    $link = $xml->posts->post['url']; //load url of blog post into $link
				    $id = $xml->posts->post['id']; //load url of blog post into $link
				    $key = $xml->posts->post['reblog-key']; //load url of blog post into $link
				    echo // spit that baby out with some stylish html
				        '<div class="grid_4">
				            <div class="white title">Video<a href="http://www.tumblr.com/reblog/'.$id.'/'.$key.'" class="reblog"><img src="/assets/reblog.png" title="Reblog on Tumblr"/></a></div>
				            <div class="post">
				            	<iframe src="http://player.vimeo.com/video/'.$videoid.'" width="100%" height="400" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
				            	'.$post.'
				            </div>
				        </div>
				    '; 
				?>
				
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<div id="bottom">
			<div class="container_12">
				<div class="space">
					<p>312 S. Michigan Avenue | Suite 1032 #B928 | Chicago, IL 60604</p>
				</div>
				<div class="space">
					<p>All music is licensed under a <a href="http://creativecommons.org/licenses/by-nc/3.0/">Creative Commons by-nc</a> license.</p>
					<p><a href="https://github.com/andrewjmonks/belgianman">Website</a> &copy;2012 Belgian Man Records.</p>
				</div>
		</div>
	</body>
</html>
