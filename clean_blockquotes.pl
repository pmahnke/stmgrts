#!/usr/local/bin/perl

my @file = `grep -lR 'bq..' /Users/peter/Branches/stmgrts/_posts/2004/*.textile`;

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
        s/bq..//; # remove bq..
        $_ = "> $_"; # add markdown blockquote >
        print STDERR qq |bq. now: '$_'\n|;
        
    }

    $output .= $_;

  }
  close (FILE);

  open (OUT, ">$file") || die "Can't open $file";
  print OUT $output;
  close (OUT);

  print STDERR qq |output of $file now:\n $output\n|;
   

}
