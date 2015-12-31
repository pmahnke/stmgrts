#!/usr/local/bin/perl


print "\n\nWhat date should I use? (yyyymmdd)\n\n";
$date = <STDIN>;

chop($date);

exit if (!$date);

$newHTML = "newsletter_".$date.".html";
$newTEXT = "newsletter_text_".$date.".text";

`cp newsletter.html archive/current.html`;
`cp newsletter.html archive/$newHTML`;
`cp newsletter_text.html archive/$newTEXT`;

print "cp newsletter.html archive/current.html\n";
print "cp newsletter.html archive/$newHTML\n";
print "cp newsletter_text.html archive/$newTEXT\n";

print "\nNewsletter - http://www.stmgrts.org.uk/static/newsletter/archive/$newHTML\n\n";

print "\nDone.\n\n";
