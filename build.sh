#!/usr/bin/perl

use strict;

my $GIT_REPO      = '/home/stmargarets/src/stmgrts';
my $PUBLIC_WWW    = '/home/stmargarets/html';

`unset GIT_INDEX_FILE`;
`unset GIT_DIR`;
chdir $GIT_REPO;
print `bundle exec jekyll build -I --source $GIT_REPO --destination $PUBLIC_WWW`;
