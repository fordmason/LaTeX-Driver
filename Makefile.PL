#!/usr/bin/perl -w                                         # -*- perl -*-

use strict;

use ExtUtils::MakeMaker;
use English qw( -no_match_vars );

our $WIN32  = ($^O eq 'MSWin32');

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

