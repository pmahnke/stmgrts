$html = <<EndofHTML;
<!doctype html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>

  <!-- Basic Page Needs
  ================================================== -->
  $METAcharSet
  $METAlang

  <meta name="author" content="Peter Mahnke"/>
  <meta name="copyright" content="&copy; Copyright 2004-2017 by Peter Mahnke. All rights reserved."/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

  <!-- Mobile Specific Metas
  ================================================== -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <!-- CSS
  ================================================== -->
  <link rel="stylesheet" type="text/css" media="screen" href="/assets/css/main.css">

  <!--[if lt IE 9]>
    <script async src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

  <!-- Fonts -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300&amp;subset=latin,latin-ext">

  <!-- RSS -->
  <link rel="alternate" type="application/atom+xml" title="Atom" href="/feed.xml"/>

  <title>St Margarets Community Website: $tmTitle</title>

  <!-- Mobile Specific Metas
  ================================================== -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">


  <!--[if lt IE 9]>
    <script async src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

  <!-- Favicons
  ================================================== -->
  <link rel="shortcut icon" href="/favicon.ico">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
  <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">

  <!-- Fonts -->
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css'>

  $METAstyle

  <style type="text/css">
    $tmstyleInclude
  </style>

  $tmjsFile

  <script type="text/javascript" language="javascript">
    $tmjsInclude
  </script>

</head>

<body>

<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-MXJB5Z"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-MXJB5Z');</script>
<!-- End Google Tag Manager -->

  <div class="container">
  <!-- banner -->
      <div id="banner" class="sixteen columns">
        <div id="logo" ><a href="/" accesskey="1" title="St Margarets Community Website"><img src="/assets/images/stmgrts_logo_tree.png" width="85" height="77" alt="St Margarets Community Website" /></a></div><!-- /logo -->
        <div id="sitename" ><h1><a href="/" accesskey="1" title="St Margarets Community Website">St Margarets<br /><span>Community Website</span></a></h1></div><!-- /sitename -->

        <div id="search" class="offset-by-twelve four">
          <form id="searchbox_011552492105320257021:aklyesuuk5c" action="http://www.google.com/cse">
            <input type="hidden" name="cx" value="011552492105320257021:aklyesuuk5c" />
            <input name="q" type="text" size="20" placeholder="Search" />
            <input type="hidden" name="cof" value="FORID:0" />
          </form>
        </div><!-- /search -->
      </div><!-- /banner -->

  <!-- navigation -->
      <div id="navigation" class="sixteen columns">
        <nav>
          <ul>
            <li><a href="/" class="nav">home</a></li>
            <li><a href="/archives/news/" class="nav">news</a></li>
            <li><a href="/archives/editorial/" class="nav">editorial</a></li>
            <li><a href="/archives/around-town/" class="nav">around town</a></li>
            <li><a href="/event" class="nav">events</a></li>
            <li><a href="/directory" class="nav">local info</a></li>
            <li><a href="/forum" class="nav">forums</a></li>
            <li><a href="/colophon" class="nav">about</a></li>
            <li><a href="/cgi-bin/newsletter.cgi" class="nav">newsletter</a></li>
          </ul>
        </nav>
      </div><!-- /navigation -->


            <div id="twocolcenter" class="offset-by-one eleven columns clearfix">

                <div class="content">

$content


                </div><!-- end div content -->

            </div><!-- end div twocolcenter -->

            <div id="right" class="four columns">
                <div class="sidebar">


                </div><!-- end div sidebar -->
            </div><!-- end div right -->
            <div style="clear: both;" id="footnoteLinks">&#160;</div>

            <div id="footer" class="sixteen clearfix">
              <div id="footer_nav" class="offset-by-one five columns">
                 <h2>Navigation</h2>
                 <ul>
                    <li><a href="/">homepage</a></li>
                    <li><a href="/event">events</a></li>
                    <li><a href="/directory">local info</a></li>
                    <li><a href="/forum">forums</a></li>
                    <li><a href="/cgi-bin/newsletter.cgi">newsletter</a></li>
                    <li><a href="/poll">polls</a></li>
                    <li><a href="/contact">contact</a></li>
                    <li><a href="/colophon">about</a></li>
                 </ul>
               </div><!-- end div footer_nav -->

              <div id="footer_archives" class="five columns">
                 <h2><a href="/archives" title="Archives">Archives</a></h2>
                 <ul>
                    <li><a href="/archives/news">news</a></li>
                    <li><a href="/archives/editorial">editorial</a></li>
                    <li><a href="/archives/around-town">around town</a></li>
                 </ul>

                 <h2>News Feed</h2>

                 <ul>
                    <li><a href="/feed.xml">atom</a></li>
                 </ul>


               </div><!-- end div footer_archives -->

              <div id="footer_search" class="five columns">
            <!-- Search Google -->
                <h2>Search</h2>

                <form id="searchbox_011552492105320257021:aklyesuuk5c" action="http://www.google.com/cse">
                  <input type="hidden" name="cx" value="011552492105320257021:aklyesuuk5c"/>
                  <p><input name="q" type="text" size="20"/></p>
                  <p><input type="submit" name="sa" value="Search"/></p>
                  <input type="hidden" name="cof" value="FORID:0"/>
                </form>
            <!-- Search Google -->


                <h2>Train Schedules</h2>

                <ul>
                  <li> <a href="/cgi-bin/train_parser.cgi?station=SMG">St Margarets Station</a></li>
                  <li> <a href="/cgi-bin/train_parser.cgi?station=TWI">Twickenham Station</a></li>
                  <li> <a href="/cgi-bin/train_parser.cgi?station=RMD">Richmond Station</a></li>
                </ul>

              </div><!-- end div footer_search -->


              <p class="copyright">Copyright &copy; 2005-2015 St Margarets Community Website<br/>Some rights reserved <a href="http://creativecommons.org/licenses/by-nd/2.0/"><img alt="Creative Commons License" src="//stmgrts.org.uk/assets/images/cc_by_nd.png" width="69" height="13" class="inline" style="padding: 0; margin: 0;" /></a></p>

            </div><!-- end div footer -->
        </div><!-- end div container -->
    </body>
</html>
EndofHTML
