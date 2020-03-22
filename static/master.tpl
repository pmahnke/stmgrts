$html = <<EndofHTML;
<!doctype html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>

  <!-- Basic Page Needs
  ================================================== -->
  <meta charset="utf-8">
  <meta name="author"    content="Peter Mahnke" />
  <meta name="copyright" content="&copy; Copyright 2004-2018 by Peter Mahnke. All rights reserved." />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link rel="alternate" href="https://stmargarets.london" hreflang="en-gb" />

  <!-- Mobile Specific Metas
  ================================================== -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <!-- CSS
  ================================================== -->
  <link rel="stylesheet" type="text/css" media="screen" href="/assets/css/main.css">

  <!--[if lt IE 9]>
    <script async src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

  <!-- Favicons
  ================================================== -->
  <link rel="shortcut icon" href="/favicon.ico">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png">
  <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
  <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">

  <!-- RSS -->
  <link rel="alternate" type="application/rss+xml" title="{{ site.title }}" href="{{ "/feed.xml" | prepend: site.baseurl | prepend: site.url }}">

  <!-- Javascript -->
  <script src="https://www.google.com/recaptcha/api.js" async defer></script>

  <!-- FROM JEKYLL -->
  <title>{% if page.title %}{{ page.title }}{% else %}{{ site.title }}{% endif %}</title>
  <meta name="description" content="{% if page.excerpt %}{{ page.excerpt | strip_html | strip_newlines | truncate: 160 }}{% else %}{{ site.description }}{% endif %}">

  <link rel="canonical" href="{{ page.url | replace:'index.html','' | prepend: site.baseurl | prepend: site.url }}">

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
<!-- banner -->
<!-- banner -->
<header id="navigation" class="p-navigation">
  <div class="p-navigation__row  u-fixed-width">
    <div class="p-navigation__banner">
      <div class="p-navigation__logo">
        <a class="p-navigation__link" href="/" accesskey="1" title="St Margarets Community Website">
          <img class="p-navigation__image" src="/assets/images/stmgrts-logo.svg" alt="St Margarets Community Website" />
        </a>
      </div>
      <a href="#navigation" class="p-navigation__toggle--open" title="menu">Menu</a>
      <a href="#navigation-closed" class="p-navigation__toggle--close" title="close menu">Close menu</a>
    </div>
    <nav class="p-navigation__nav" role="menubar">
      <span class="u-off-screen">
        <a href="#main-content">Jump to main content</a>
      </span>
      <ul class="p-navigation__links" role="menu">
        <li class="p-navigation__link {% if page.url contains '/archives/news/' %}is-selected{% endif %}" role="menuitem"><a href="/archives/news/" class="nav">news</a></li>
        <li class="p-navigation__link {% if page.url contains '/archives/editorial/' %}is-selected{% endif %}" role="menuitem"><a href="/archives/editorial/" class="nav">editorial</a></li>
        <li class="p-navigation__link {% if page.url contains '/archives/around-town/' %}is-selected{% endif %}" role="menuitem"><a href="/archives/around-town/" class="nav">around town</a></li>
        <li class="p-navigation__link {% if page.url contains '/event' %}is-selected{% endif %}" role="menuitem"><a href="/event" class="nav">events</a></li>
        <li class="p-navigation__link {% if page.url contains '/directory' %}is-selected{% endif %}" role="menuitem"><a href="/directory" class="nav">local info</a></li>
        <li class="p-navigation__link {% if page.url contains '/forum' %}is-selected{% endif %}" role="menuitem"><a href="/forum" class="nav">forums</a></li>
      </ul>
      <form class="p-search-box" id="google-appliance-search-form" id="searchbox_011552492105320257021:aklyesuuk5c" action="https://www.google.com/cse">
        <input type="hidden" name="cx" value="011552492105320257021:aklyesuuk5c" />
        <input type="hidden" name="cof" value="FORID:0" />
        <input class="p-search-box__input" name="q" type="search" size="20" placeholder="Search"  required="">
        <button type="reset" class="p-search-box__reset" alt="reset"><i class="p-icon--close"></i></button>
        <button type="submit" class="p-search-box__button" alt="search"><i class="p-icon--search"></i></button>
      </form>
    </nav>
  </div>
</header>
<div class="wrapper u-no-margin--top">
  <div id="main-content" class="inner-wrapper">

$content

  </div><!-- /.inner-wrapper -->
</div><!-- /.wrapper -->
<!-- footer -->
<footer class="p-footer u-no-margin--top">
  <div class="row">
    <nav class="p-footer__nav">
      <div class="col-4">

        <h2 class="p-muted-heading">Navigation</h2>
        <ul class="p-list">
          <li class="p-list__item"><a href="/">homepage</a></li>
          <li class="p-list__item"><a href="/event">events</a></li>
          <li class="p-list__item"><a href="/directory">local info</a></li>
          <li class="p-list__item"><a href="/forum">forums</a></li>
          <li class="p-list__item"><a href="/cgi-bin/newsletter.cgi">newsletter</a></li>
          <li class="p-list__item"><a href="/poll">polls</a></li>
          <li class="p-list__item"><a href="/contact">contact</a></li>
          <li class="p-list__item"><a href="/colophon">about</a></li>
        </ul>

      </div><!-- end left -->

      <div class="col-4">

        <h2 class="p-muted-heading"><a href="/archives" title="Archives">Archives&nbsp;&rsaquo;</a></h2>

        <ul class="p-list">
          <li class="p-list__item"><a href="/archives/news">news</a></li>
          <li class="p-list__item"><a href="/archives/editorial">editorial</a></li>
          <li class="p-list__item"><a href="/archives/around-town">around town</a></li>
        </ul>

        <h2 class="p-muted-heading">News Feed</h2>
        <ul class="p-list">
          <li class="p-list__item"><a href="/feed.xml">atom</a></li>
        </ul>

      </div><!-- end middle -->

      <div class="col-4">

        <h2 class="p-muted-heading">Train Schedules</h2>
        <ul class="p-list">
          <li class="p-list__item"> <a href="/cgi-bin/train_parser.cgi?station=SMG">St Margarets Station</a></li>
          <li class="p-list__item"> <a href="/cgi-bin/train_parser.cgi?station=TWI">Twickenham Station</a></li>
          <li class="p-list__item"> <a href="/cgi-bin/train_parser.cgi?station=RMD">Richmond Station</a></li>
        </ul>

      </div><!-- end right -->
      <span class="u-off-screen">
        <a href="#">Go to the top of the page</a>
      </span>
    </nav>
  </div>

  <div class="row">
    <div class="u-fixed-width">
      <p class="u-align--right">
        <small>
          Copyright &copy; 2005-2018 St Margarets Community Website<br />
          Some rights reserved <a href="https://creativecommons.org/licenses/by-nd/4.0/">CC BY-ND 4.0</a>
        </small>
      </p>
    </div>
  </div>
</footer>

<!-- Fonts -->
<link  rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:400,300&amp;subset=latin,latin-ext">

  </body>
</html>
EndofHTML
