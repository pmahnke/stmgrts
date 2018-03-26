#!/usr/local/bin/perl

# reads the movabletype sqlite database and creates jekyll templates

use DateTime;
use DBI;
use utf8;

require ("/home/stmargarets/cgi-bin/common.pl");
require ("/home/stmargarets/cgi-bin/common_text.pl");

my $blog_id = 1; # 9 is stmgrts.org.uk
my $dbh = DBI->connect("dbi:SQLite:dbname=/tmp/mt.db","","",{ PrintError => 1, AutoCommit => 0 });

&get_posts();

############################
sub get_comments {

  my (@out,$sth, $author, $text, $date, $email) ="";

  my $sth = $dbh->prepare(qq |select c.comment_author, c.comment_text, c.comment_created_on, c.comment_email
  from mt_comment as c
  left join mt_entry as e on e.entry_id = c.comment_entry_id
  where
  c.comment_blog_id = $blog_id and
  c.comment_visible = 1 and
  c.comment_junk_status > -1 and
  c.comment_entry_id = ?
  order by c.comment_created_on|);

  $sth->execute($_[0]);

  $sth->bind_columns (\$author, \$text, \$date, \$email);

  while ( $sth->fetch ) {

    $text = &processText(&clean4textile($text));

    $text =~ s/^\s+|\s+$//g; # trim all leading and trailing whitepace
    $text =~ s/\n//g; # remove newline
    $text =~ s/ /+/g;

    $author =~ s/ /+/g;

    $date =~ s/ /+/g;

    $email =~ s/@/%40/;

    # commented on second run
    push @out, "wget 'http://www.mahnke.net/cgi-bin/comments.cgi?name=$author&email=$email&comment=$text&a=comment&date=$date&page-id=";

  }
  return(@out);
}


sub get_posts {

  my $sth = $dbh->prepare(qq|
  select e.entry_id, e.entry_title, e.entry_basename, c.category_label, e.entry_created_on, entry_text, entry_text_more, entry_excerpt, entry_keywords
  from mt_entry as e
  left join mt_placement as p on e.entry_id = p.placement_entry_id
  left join mt_category as c on p.placement_category_id = c.category_id
  where
  e.entry_blog_id=$blog_id |);

  $sth->execute();

  $sth->bind_columns (\$id, \$title, \$basename, \$category, \$date, \$body, \$more, \$excerpt, \$keywords);

  my $i = 0;

  while ( $sth->fetch ) {

    my ($d, $t)         = split (" ", $date);
    my $filename        = $d."-".$basename.".textile";
    my $commentfilename = $d."-".$basename;
    my ($y,$m,$dt)      = split("-", $d);
    my $permalink       = "/archives/$y/$m/$basename".".html";

    if ($excerpt) {
      $excerpt =~ s/\n/\n    /g;
      $excerpt = "excerpt: |\n    $excerpt\n";
    }
    $title =~ s/:/&#58;/g;
    $title =~ s/"/'/g;

    my @comments = &get_comments($id);

    my $out = qq |---
layout: post
title: "$title"
permalink: $permalink
commentfile: $commentfilename
category: $category
date: $date
    $excerpt
---

$body

$more

    |; # removed $comment_code

    # all purpose textile clean-ups
    $out =~ s/{L-}/&pound;/g;
    $out =~ s/\^(.[^\^]*)\^/<sup>$1<\/sup>/g;
    $out =~ s/_\|/\|/g; # should go line by line and chang _| to |_. per that row for <th>

    `mkdir -p /tmp/jekyll/_posts/$y`;

    open (OUT, ">/tmp/jekyll/_posts/$y/$filename") || die "Can't open $filename\n";
    print OUT $out;
    close (OUT);

    if (@comments) {

      $commentfilename = "$commentfilename.textile";

      for $url (@comments) {

        `$url$commentfilename'`;
        print qq|$url.$commentfilename\n\n|;

      }
    }
  }
}
$dbh->disconnect();
