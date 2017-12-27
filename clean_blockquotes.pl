#!/usr/local/bin/perl

# for moving with [tomd ](https://github.com/blog/2115-upgrading-your-textile-posts-to-markdown)
# from textile to markdown
# must run BEFORE the tomd scripts
# deals with multiline blockquotes and citations


my @file = `grep -lR 'bq..' /Users/peter/Branches/stmgrts/_posts/2017/*.textile`;

foreach my $file (@file) {

  open (FILE, $file) || die "Can't open $file";

  my ($FLAG_on, $output) = "";

  while (<FILE>) {

    if (/(p. |\?\?)/ && $FLAG_on) {

        # end of block quote area
        $FLAG_on = 0;
        $output =~ s/> \n$/\n/; # remove last "> \n"
        print STDERR qq |end bq. with '$_'\n|;

    }

    if (/bq\.\./ || $FLAG_on) {

        $FLAG_on = 1;
        s/bq\.\.//; # remove bq..
        $_ = "bq. $_"; # add markdown blockquote >
        print STDERR qq |bq. now: '$_'\n|;

    }

    s/\?\?(.*)\?\?/<cite>$1<\/cite>/;

    $output .= $_;

  }
  close (FILE);

  open (OUT, ">$file") || die "Can't open $file";
  print OUT $output;
  close (OUT);

  print STDERR qq |output of $file now:\n $output\n|;


}
