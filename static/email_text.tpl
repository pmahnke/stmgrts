$content =~ s/<.[^>]*>//g;
$content =~ s/\n\n\n/\n\n/g;

$html = <<EndofHTML;
<pre>
$content
</pre>
EndofHTML









