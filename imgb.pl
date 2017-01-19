#!/usr/bin/perl

if (!$ARGV[0]) {

    print qq |
    imgb <filename> <directory or blog (M, S, T, C - optional>
    
    will create:
    
    1. resize <filename> to image with 1500px as largest size
    2. create a thumbnail with 250px width
    3. will move it to directory if provided\n\n|;

    exit;

}

my ($year, $filename, $ext, $dir, $relpath, $full, $thumb, $thumbwidth, $output, $class) = "";

# default thumbnail width
$thumbwidth = 250;

# test if blog
if ($ARGV[1] =~ /(M|S|T|C)/i) {

    $year = `date +'%Y'`;
    chop($year);
    
    $relpath = qq |/assets/images/$year/|;
    
    if ($ARGV[1] =~ /M/i) {
        $dir     = qq |/Users/peter/Branches/mahnke/assets/images/$year/|;
        $thumbwidth = 500;
        $relpath = qq |/peter/assets/images/$year/|;
    } elsif ($ARGV[1] =~ /S/i) {
        $dir     = qq |/Users/peter/Branches/stmgrts/assets/images/$year/|; 
        $relpath = qq |https://stmargarets.london/assets/images/$year/|;
        $class   = qq | class="photo right"|;
    } elsif ($ARGV[1] =~ /T/i) {
        $dir     = qq |/Users/peter/Branches/transitionelement/assets/images/$year/|;
    } elsif ($ARGV[1] =~ /C/i) {
        $dir     = qq |/Users/peter/Branches/cavendish/assets/images/$year/|;
    }
    
    
} else {

    # it is a directory
    $dir = "./";
    $dir = $ARGV[1] if ($ARGV[1] && -d "$ARGV[1]");
    $dir =~ s!/*$!/!; # Add a trailing slash
}

$filename = $ARGV[0];
$filename =~/\/([^\/]+)$/;
($filename, $ext) = split (/\./, $filename);
$filename =~ s/(\W|\s)/-/g; # replace spaces, etc... with dashes
$ARGV[0] =~ s/ /\ /g;

# command to create large image
$full = $filename.".".$ext;
`/usr/bin/sips -Z 1500 --out $dir$full $ARGV[0]`;
print qq |/usr/bin/sips -Z 1500 --out $dir$full $ARGV[0]\n|;

# command to create thumbnail
$thumb = $filename."-thumb.".$ext;
`/usr/bin/sips --resampleWidth $thumbwidth --out $dir$thumb $ARGV[0]`;
print qq |/usr/bin/sips --resampleWidth $thumbwidth --out $dir$thumb $ARGV[0]\n|;


$output = qq |\n<a href="$relpath$full" title="Click for a larger image"><img src="$relpath$thumb" width="$thumbwidth" alt="Image - $filename" $class/></a>\n|;

print qq |
dir        - $dir
relpath    - $relpath
filename   - $filename
extension  - $ext
fullname   - $full
thumbnail  - $thumb
thumbwidth - $thumbwidth
output     - $output
|;


`echo '$output' | /usr/bin/pbcopy`;

print $output;

