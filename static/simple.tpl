$html = <<EndofHTML;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <title>$tmTitle</title>

  $METAstyle
  $METAcharSet
  $METAlang

  $script

  <!-- start of embedded stylesheet -->
  <style type="text/css">
    $tmstyleInclude
  </style>
  <!-- end of embedded stylesheet -->

  <!-- start JavaScript Files to Reference -->
  $tmjsFile
  <!-- end JavaScript Files to Reference -->

  <!-- start JavaScript Files to Include -->
  $tmjsInclude
  <!-- end JavaScript Files to Include -->

 </head>
 <body>

$content

 </body>
</html>
EndofHTML












