$html = <<EndofHTML;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?xml version="1.0" encoding="utf-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="generator" content="http://www.movabletype.org/" />
        <meta http-equiv="Content-Style-Type" content="text/css" />
        <meta http-equiv="Content-Language" content="en" />
        <meta name="author"    content="Peter Mahnke" />
        <meta name="copyright" content="&copy; Copyright 2005 by Peter Mahnke. All rights reserved." />

        <link rel="stylesheet" href="http://stmgrts.org.uk/styles-site.css"         type="text/css" />
        <link rel="start" href="http://stmgrts.org.uk" title="Home" />

        $METAcharSet
        $METAlang

        <title>St Margarets Community Website: $tmTitle</title>

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

        <div id="container">

        <div id="banner">
            <a href="http://stmgrts.org.uk/" accesskey="1"><img src="/images/st_margarets_logo_tree.gif" width="400" height="77" alt="St Margarets Community Website" /></a>
        </div><!-- end div banner -->

            <div id="onecolcenter">

                <div class="content">

                    $content

                </div><!-- end div content -->

            </div><!-- end div onecolcenter -->

        <div style="clear: both;">&#160;</div>

$tmfooter

        </div><!-- end div container -->


    </body>
</html>
EndofHTML














