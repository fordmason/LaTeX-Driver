#!/usr/bin/perl -w                                         # -*- perl -*-

use strict;

use Config;
use File::Spec::Functions qw( catfile );
use ExtUtils::MakeMaker;
use English qw( -no_match_vars );
use Cwd;

select STDERR;
$| = 1;
select STDOUT;

our $QUIET  = 0;
our $ACCEPT = 0;
our $WIN32  = ($^O eq 'MSWin32');
our $MODVERSION = sprintf("%.2f", get_module_version());

#------------------------------------------------------------------------

message(<<EOF);

LaTeX::Driver v$MODVERSION
-------------------

LaTeX::Driver runs the 'xelatex', 'pdflatex', 'lualatex' or straight
'latex' command on a LaTeX document.  If unresolved cross references,
bibliographic references or index definitions are found then 'bibtex'
or 'makeindex' will be run as appropriate and the 'latex' processor
re-run as necessary.  The output will be postprocessed with the
'dvips' and 'ps2pdf' programs if necessary to create PDF, DVI or
PostScript documents.

To use the module you will first need to install LaTeX on your system
and make sure the above programs are available.

EOF

#------------------------------------------------------------------------

my %opts = (
    'NAME'         => 'LaTeX-Driver',
    'VERSION_FROM' => 'lib/LaTeX/Driver.pm',
    'EXE_FILES'    => [ 'scripts/latex2dvi', 'scripts/latex2pdf', 'scripts/latex2ps' ],
    'PMLIBDIRS'    => [ 'lib' ], 
    'PREREQ_PM'    => { 
	'Class::Accessor'  => 0,
	'Cwd'              => 0,
	'Exception::Class' => 0,
	'File::Slurp'      => 0,
	'File::Spec'       => 0,
	'IO::File'         => 0,
	($OSNAME eq 'MSWin32') ? () : ( 'IPC::ShellCmd'  => 0 ),
        'Readonly'         => 0,
    },
    'dist'         => {
        'COMPRESS' => 'gzip',
        'SUFFIX'   => 'gz',
    },
);

if (((my $version = $ExtUtils::MakeMaker::VERSION) =~ s/_//) >= 5.43) {
    $opts{ AUTHOR   } = 'Andrew Ford <andrew@ford-mason.co.uk>';
    $opts{ ABSTRACT } = 'LaTeX Driver',
}

WriteMakefile((MM->can('signature_target') ? (SIGN => 1) : ()), %opts);



#------------------------------------------------------------------------
# message($text)
#
# Print message unless quiet mode.
#------------------------------------------------------------------------

sub message {
    return if $QUIET;
    print @_;
}


sub get_module_version {
    open(MODULE, catfile('lib','LaTeX','Driver.pm'))
	or die "cannot find LaTeX::Driver module\n";
    while (<MODULE>) {
	return $1 if /VERSION = (\d+\.\d+)/;
    }
    return "<unkown version>";
}
