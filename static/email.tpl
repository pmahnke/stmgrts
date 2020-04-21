$html = <<EndofHTML;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
 <head>
  <title>$tmTitle</title>
   <style>
/*<![CDATA[*/
  $tmstyleInclude
/*]]>*/
    </style>
    <meta http-equiv="content-type" content="text/html; charset=us-ascii">
    <meta http-equiv="content-language" content="en-uk">
 </head>
 <body>
<div class="width: 500px;">
$content
</div>
 </body>
</html>
EndofHTML
