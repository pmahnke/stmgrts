#!/usr/bin/perl

#######################################################################
#
# editPages.cgi
#
#  HTML front end to content management system
#
#   written by Peter Mahnke 1 Nov 2001
#
#   last modified by Peter Mahnke on 17 Dec 2001
#   15 October 2016 - added htaccess
#
#######################################################################

use Text::Textile;
require ("/home/stmargarets/cgi-bin/auth.pl");

#######################################################################
#Variables

$thisScript       = "editPages_sm.cgi";
$buildPagesScript = "build.cgi";
$rootDir          = "/home/stmargarets/src/stmgrts";
$outputDir        = "";
$inputDir         = "/static/";
$longName         = "stmargarets.london";
$shortNameDB      = "$rootDir"."/static/properties.db";
$localhost        = "stmargarets.london";
$CMDcp            = "/bin/cp";
$CMDgrep          = "/bin/grep";
$CMDls            = "/bin/ls";

#######################################################################
# read post

use CGI::Lite;
$cgi = new CGI::Lite;
$cgi->set_platform (Unix);
%FORM = $cgi->parse_form_data;

$FORM{'text'} = &clean($FORM{'text'}) if ($FORM{'text'});


#######################################################################
# decide what to do
&readLocaleInfo;
$siteDir = $dir{$FORM{'category'}};

if (!$FORM{'page'}) {

  # nothing was submitted.... print the list of locales
  &printCategoryMenu;

} elsif ($FORM{'page'} eq "category") {

  # the locale was selected and now get the pages to edit
  &printFirstPage;

} elsif ($FORM{'page'} eq "build all") {

  &printBuildAllPage;

} elsif ($FORM{'page'} eq "auto build all") {

  &autoBuildAll;

} elsif ($FORM{'page'} eq "new page") {

  &printEditPage;

} elsif ($FORM{'page'} eq "edit") {

  # a file was passed to be edited
  `$CMDcp $rootDir$inputDir$siteDir$FORM{'file'} $rootDir$inputDir$siteDir$FORM{'file'}.temp`;
  $page = &readPage($FORM{'file'});
  &printEditPage;

} elsif ($FORM{'page'} eq "review") {

  # the user wants to look at the proposed changes...
  my $tempFileName = "$FORM{'file'}".".temp";
  &saveTempFile($tempFileName);
  $page = $FORM{'text'};
  $page =~ s/\r\n/\n/g;

  #require ("/home/transitionelement/html/cms/common_spelling.pl");
  #require ("/home/mahnke/html/peter/MT/extlib/Text/Textile.pm");

  # textile
  $textile = new Text::Textile;
  $textile->head_offset(0);
  $spelling = $textile->process($page);


  #spelling
  $spelling = &checkSpelling($spelling);

  &printEditPage;

} elsif ($FORM{'page'} eq "save") {

  # the user wants to save the changes...

  $FORM{'file'} = $FORM{'newfile'} if ($FORM{'newfile'});

  &saveTempFile($FORM{'file'});
  &printSavePage;

} else {

  &printCategoryMenu;
}
exit;

#######################################################################


##################
sub printSavePage {

  $popupPage = $FORM{'file'};
  $popupPage = "Content\-type: text\/html\n\nnothing to display\n" if ($FORM{'file'} =~ /.incl/);

  local $build = "";
  local $file   = "";

  if ($FORM{'file'} =~ /.incl/) {

  # if its an include file, you can't build the normal page
  @inclFiles = &grepDir($FORM{'file'});

  $build .= "This include file (<b\>$FORM{'file'}<\/b\>) affects the following pages:<p\>";

  foreach $file (sort @inclFiles) {
    $build .=<<HTML;
    <p>Click here to publish <a href="$buildPagesScript?page=$file&amp;extraDir=$inputDir&amp;shortName=$FORM{'category'}&amp;action=build" target="print" onClick="printPopup('$file','print','resizable=yes,toolbar=yes,scrollbars=yes,menubar=yes,width=510,height=400')"><strong>$file</b></a\><\p>";
HTML
  }

  $build .= "<p\>Press each link, one at a time to build each of the pages that uses the include file.<\/p\>";

  } else {

  $build =<<HTML;
  <p>Click here to publish <a href="$buildPagesScript?page=$FORM{'file'}&amp;extraDir=$inputDir&amp;shortName=$FORM{'category'}&amp;action=build" target="print" onClick="printPopup('$popupPage','print','resizable=yes,toolbar=yes,scrollbars=yes,menubar=yes,width=510,height=400')"><strong>$FORM{'file'}</strong></a></p>";
HTML

  }

  $menu = "";

  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
  <title>Publish Saved Page</title>

  <script language="JavaScript">
    <!--
    // Article Printing JavaScript Popup Function -- Begin

    // This overides the window.open which breaks when used in a "Javascript:" line
    // in Netscape 3.
    function printPopup( szWindowURL, szWindowName, szWindowAttributes )
    {
      wndPopup = window.open(szWindowURL, szWindowName, szWindowAttributes);
    }

    // Article Printing JavaScript Popup Function -- End
    // -->
  </script>

  </head>
  <body>
    <div class="content">
      <h1>$longName ~ $longName{$FORM{'category'}}</h1>
      <h2>Publish Saved Page ~ $FORM{'file'} </h2>

      <p><a href=editPages.html>help</a> | <a href=$thisScript>edit different page</a></p>

      <p>Nothing will happen to the live site if you do not select the link below.  You can go back and edit this page some more, but all your previous changes have been saved to the staging server.  If you made a mistake, do not press this link, email <a href="mailto:peter\@mahnke.net">Peter Mahnke</a>.</p>

      $build

    </div>
  </body>
  </html>

EndofHTML
  exit;



} # end sub printSavePage




##################
sub autoBuildAll {

  &readDir($siteDir);
  &readDir($dir{$shortName{$FORM{'category'}}});

  foreach $file (sort keys %buildFileList) {

    $URL = "http://$localhost/static/$buildPagesScript?page\=$file\&amp\;extraDir\=$inputDir\&amp\;shortName\=$FORM{'category'}\&amp\;action\=build";
    $output .= &Connection($URL);

  }

  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Auto Build All</title>
    <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
  </head>
  <body>

    $output

  </body>
  </html>

  EndofHTML

}

#######################################################################


##################
sub printBuildAllPage {

  &readDir($siteDir);
  &readDir($dir{$shortName{$FORM{'category'}}});
  &readDir($dir{$shortName{$shortName{$FORM{'category'}}}});

  foreach $file (sort keys %buildFileList) {

  $buildFileList .=<<HTML
  <p><a href=$buildPagesScript?page=$file&amp;extraDir=$inputDir&amp;shortName=$FORM{'category'}&amp;action=build" target="print" onClick="printPopup('$file','print','resizable=yes,toolbar=yes,scrollbars=yes,menubar=yes,width=510,height=400')"><strong>$file</strong></a></p>";

  }

  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
    <title>Edit Page</title>
    <script language="JavaScript">
      <!--
      // Article Printing JavaScript Popup Function -- Begin

      // This overides the window.open which breaks when used in a "Javascript:" line
      // in Netscape 3.
      function printPopup( szWindowURL, szWindowName, szWindowAttributes )
      {
        wndPopup = window.open(szWindowURL, szWindowName, szWindowAttributes);
      }

      // Article Printing JavaScript Popup Function -- End
      // -->
    </script>

  </head>
  <body>
    <div class="content">

      <form method=post action=$thisScript>

      <h1>$longName ~ $longName{$FORM{'category'}}</h1>

      <h2>Click to publish</h2>

      <!-- from sitedir $siteDir<p>
      <p>dirlocaleformsite $dir{$shortName{$FORM{'category'}}} <p> $FORM{'category'}</p>
      $shortName{$FORM{'category'}} -->

      <p>$buildFileList</p>

    </div>
  </body>
</html>


EndofHTML

  exit;

}


#######################################################################
#


##################
sub printEditPage {

  local $review = "";
  local $file   = "";

  if ($FORM{'file'} =~ /.incl/) {

    # if its an include file, you can't build the normal page
    @inclFiles = &grepDir($FORM{'file'});

    $review .= "<p\>This include file (<b\>$FORM{'file'}<\/b\>) affects the following pages:<p\>";

    foreach $file (sort @inclFiles) {
      $review .= "<li\> <strong\>$file<\/strong\><br\>";
    }

    $review .= "<p\>You can not preview the page before you save it, so when you are sure of the changes, press the <b\>Save<\/b\> button and build these pages.<\/p\>";
    $cType = "<font color\=navy\>Content Component<\/font\>";

  } elsif ($FORM{'page'} eq "new page") {


    $review .= "\n\n<p\>filename: <input type\=\"text\" name\=\"newfile\" \/\></p>\n<input type\=\"hidden\" name\=\"action\" value\=\"new page\" \/\>\n\n ";


  } else {

    $review =<<HTML;
    | <a href="$buildPagesScript?page=$shortName$FORM{'file'}.temp&amp;shortName=$FORM{'category'}&amp;extraDir=$inputDir" target="print" onClick="printPopup('$buildPagesScript?page=$FORM{'file'}.temp&shortName=$FORM{'category'}&extraDir=$inputDir','print','resizable=yes,toolbar=yes,scrollbars=yes,menubar=yes,width=510,height=400')">preview this page</a><br />
HTML
    $cType = "<font color\=\"red\"\>Template Page<\/font\>";
  }

  local $spell =<<EOF if ($spelling);
<div id="spelling">
  <h4>spelling</h4>
  $spelling
</div>
EOF



  # print the HTML page
  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
  <head>
                <meta http-equiv="Content-type" content="text/html; charset=utf-8" />

    <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
    <title>Edit Page</title>

    <style>
    body
    { font-family: verdana;
      font-size: x-small;
    }

    .err { color: red; }
    .sug { color: #666; }
    #spelling { width: 500px; border: 1px dashed black; }
    </style>

    <!-- javascript begin -->
    <SCRIPT LANGUAGE="JavaScript">
    <!--
    // Article Printing JavaScript Popup Function -- Begin

    // This overides the window.open which breaks when used in a "Javascript:" line
  // in Netscape 3.
    function printPopup( szWindowURL, szWindowName, szWindowAttributes )
    {
      wndPopup = window.open(szWindowURL, szWindowName, szWindowAttributes);
    }

    // Article Printing JavaScript Popup Function -- End
    // -->
    </SCRIPT>

    <!-- javascript end -->

  </head>
  <body>

    <div class="content">
      <form method="post" action="$thisScript">

        <h1>$longName ~ $longName{$FORM{'category'}}</h1>

        <h2>Edit $cType  ~ $FORM{'file'} </h2>

        <p><a href="editPages.html">help</a> | <a href="$thisScript">edit different page</a> $review</p>

        <p><textarea name="text" rows="20" cols="80" wrap="wrap">$page</textarea></p>

        <p><input type="hidden" name="category" value="$FORM{'category'}" />
        <input type="hidden" name="file" value="$FORM{'file'}" />
        <input type="submit" name="page" value="review" />
        <input type="submit" name="page" value="save" /></p>

        $spell


      </form>
    </div>
  </body>
</html>

EndofHTML
  exit;



} # end sub printEditPage

#######################################################################
#


##################
sub readPage {

  open (PAGE, "$rootDir$inputDir$siteDir$_[0]") ||
  die "readPage: can't open: $_[0]";

  $FORM{'text'} = "";

  while (<PAGE>) {
    s/\&/\&amp\;/g; # turn ampersans into html tag
    s/</\&lt\;/g; # turn less thans into html tag
    s/\r\n\r\n/\n/g;
    s/\r\n/\n/g;
    $FORM{'text'} .= $_;
  }
  close (PAGE);

  return ($FORM{'text'});

} # end sub readPage


#######################################################################
#


##################
sub printCategoryMenu {

  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
  <head>
                <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
    <title>Select a Category</title>
  </head>
  <body>
    <div class="content">
      <form method="post" action="$thisScript">

        <h1>$longName</h1>

        <h2>Select the Category</h2>

        <p><a href="editPages.html">help</a></p>

        <p>
          <select name="category">
          $FORMdir
          </select>
        </p>

        <p><input type="submit" name="page" value="category" /></p>

      </form>
    </div>
  </body>
</html>

EndofHTML

  exit;


}

#######################################################################
#


##################
sub printFirstPage {

  local @files = &readDir($siteDir);
  local ($file, $template, $content) = "";


  foreach $file (sort @files) {
    $template .= "<tr\><td\><input type\=radio name\=file value\=$file\><\/td\><td\>$file<\/td\><td\><font color\=red\>template<\/font\><\/td\><\/tr\>\n" if ($file =~ /\.text/);
    $content .= "<tr\><td\><input type\=radio name\=file value\=$file\><\/td\><td\>$file<\/td\><td\><font color\=navy\>content component<\/font\><\/td\><\/tr\>\n" if ($file =~ /\.incl/);
    $allFiles .= "file\=$file\&" if ($file =~ /\.text/);
  }

  $listing = "$template"."$content";

  print <<EndofHTML;
Content-type: text/html; charset=utf-8

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html>
  <head>
                <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/styles-site.css"		 type="text/css" />
    <title>Select a Page</title>
  </head>
  <body>

    <div class="content">
      <form method="post" action="$thisScript">

      <input type="hidden" name="category" value="$FORM{'category'}" />

      <h1>$longName  ~ $longName{$FORM{'category'}}</h1>

      <h2>Select a Page to Edit</h2>

      <p>
      <input type="submit" name="page" value="edit" />
      <input type="submit" name="page" value="new page" />
      <input type="submit" name="page" value="build all" />
      <input type="submit" name="page" value="auto build all" /></p>

      <table>
      $listing
      </table>

      <p><input type="submit" name="page" value="edit" /></p>

      <p><a href="editPages.html">help</a></p>

      </form>

    </div>
  </body>
</html>

EndofHTML

  exit;

} # end sub printFirstPage

#######################################################################
#


##################
sub grepDir {

  # $siteDir = $dir{$FORM{'category'}};

  # $fileMask = "$rootDir$inputDir$siteDir"."*.html"; # only html files
  # $grep = `$CMDgrep -l -s $_[0] $fileMask`;
  # $grep =~ s/$rootDir$inputDir$siteDir//g;
  # local @file = split ("\n", $grep);
  # return(@file);


  local $file	   = "";
  $curDir		   = "";
  local $file	   = "";

  # LEVEL 0
  # found file in current locale

  $fileMask = "$rootDir$inputDir$dir{$FORM{'category'}}"."*.text";
  $grep = `$CMDgrep -l -s $_[0] $fileMask`;

  $msg = "$rootDir$inputDir$dir{$FORM{'category'}}";

  if ($grep) {
    $grep =~ s/$rootDir$inputDir$dir{$FORM{'category'}}//g;
    local @file = split ("\n", $grep);
    return(@file);
  }

  # file doesn't exist even at the top level
  # return (0)	if ($COOKIE{'locale'} eq "wcw");

  # LEVEL 1
  # look for file up one level

  $fileMask = "$rootDir$inputDir$dir{$shortName{$FORM{'category'}}}"."*.text";
  $grep = `$CMDgrep -l -s $_[0] $fileMask`;

  if ($grep) {
    $grep =~ s/$rootDir$inputDir$dir{$shortName{$FORM{'category'}}}//g;
    local @file = split ("\n", $grep);
    return(@file);
  }

  # if is doesn't fail if at top level
  #return (0)	if ($shortName{$COOKIE{'locale'}} eq "wcw");


  # LEVEL 2
  # look for file up one more level

  $fileMask = "$rootDir$inputDir$dir{$shortName{$shortName{$FORM{'category'}}}}"."*.text";
  $grep = `$CMDgrep -l -s $_[0] $fileMask`;

  if ($grep) {
    $grep =~ s/$rootDir$inputDir$dir{$shortName{$shortName{$FORM{'category'}}}}//g;
    local @file = split ("\n", $grep);
    return(@file);
  }


  # if is doesn't fail if at top level
  # probably affects all HTML pages

  $fileMask  = "$rootDir$inputDir$dir{$FORM{'category'}}"."*.text";
  $grep	  = `$CMDls -1 $fileMask`;
  $grep	  =~ s/$rootDir$inputDir$dir{$FORM{'category'}}//g;

  $fileMask  = "$rootDir$inputDir$dir{$shortName{$FORM{'category'}}}"."*.text";
  $grep	 .= `$CMDls -1 $fileMask`;
  $grep	  =~ s/$rootDir$inputDir$dir{$shortName{$FORM{'category'}}}//g;


  # $fileMask  = "$rootDir$inputDir$dir{$shortName{$shortName{$FORM{'category'}}}}"."*.html";
  # $grep	 .= `$CMDls -1 $fileMask`;
  # $grep	  =~ s/$rootDir$inputDir$dir{$shortName{$shortName{$FORM{'category'}}}}//g;


  local @file = split ("\n", $grep);


  return (@file);

}





#######################################################################
#


##################
sub readDir {

  # read inputDir's files

  my $dir = "$rootDir$inputDir$_[0]";
  $dir =~ s|\/\/|\/|g; # replace // with /

  opendir (DIR, "$dir") || die "\nCan't open DIR: \|$dir\|\n";
  my @files = readdir (DIR);
  closedir (DIR);

  splice @files, 0, 2;  # remove . and .. listings

  # parse out non-editable files
  my $file = "";
  my $fileList = "";

  foreach $file (@files) {

    next if (-d $file);  # next if its a directory

    if ($file =~ /.text$/ || $file =~ /.incl$/) {
      push @fileList, $file;
      $buildFileList{$file} = $file  if ($file =~ /.text$/ || $file =~ /.txt$/);
    }

  }
  return (@fileList);

} # end sub readDir


#######################################################################


##################
  sub saveTempFile {

  my $tempName = "$rootDir$inputDir$siteDir$_[0]";

  $FORM{'text'} =~ s/\r\n/\n/g; # replace DOS endlines with UNIX

  open (TEMP, ">$tempName") ||
  die "Can't open TempFile: $tempName $_[0]\n";
  print TEMP $FORM{'text'};
  close (TEMP);

  return();


} # end sub saveTempFile

#######################################################################



##################
sub readLocaleInfo {

  open (LOCALE, "$shortNameDB") || die "Can't open locale db: $shortNameDB\n";

  while (<LOCALE>) {

    chop();

    # example Local Business Directory|business|business/

    my @listing = split (/\|/);

    $longName{$listing[1]}   = "$listing[0]";
    $shortName{$listing[1]}  = "$listing[1]";
    $dir{$listing[1]}        = "$listing[2]";

    $FORMdir .= "	  <option value\=\"$listing[1]\">\ $listing[0]<\/option\>\n";

  }

  close (LOCALE);

}



##################
sub Connection {

  my $Output = "";

  # Create a user agent object
  use LWP::UserAgent;
  my $ua = new LWP::UserAgent;
  $ua->agent("Mozilla/5.0");

  # Create a request
  my $req = new HTTP::Request('GET', $_[0]);

  # authentication
  $req->authorization_basic('peter', 'hi11top');

  # Pass request to user agent and get response
  my $res = $ua->request($req);

  $Output = $res->content;

  # Check output
  if ($res->is_success) {
    return($Output);
  } else {
    return($Output, $_[0]); # return error info and url attempted
  }


}			# end of sub Connection



sub clean {

    my $value = $_[0];

    $value =~ s/\302\240//g;
    $value =~ s/\302\243/{L-}/g;

    $value =~ s/\305�/&#x159;/g;
    $value =~ s/\303\240/{a'}/g;

    $value =~ s/\342\200[\230\231]/\'/g;
    $value =~ s/\342\200\246/.../g;
    $value =~ s/\342\200\223/-/g;
    $value =~ s/\342\200\224/--/g;
    $value =~ s/\342\200[\234\235]/\"/g;

    return ($value);

}
