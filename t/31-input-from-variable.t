#!/usr/bin/perl
# $Id: 31-input-from-variable.t 81 2011-09-18 09:19:03Z andrew $

use strict;
use blib;
use FindBin qw($Bin);
use File::Spec;
use lib ("$Bin/../lib", "$Bin/lib");
use Data::Dumper;

use Test::More tests => 13;
use Test::LaTeX::Driver;
use LaTeX::Driver;
use File::Slurp;

tidy_directory($basedir, $docname, $debug);

my $source = read_file($docpath) or die "cannot read the source data";
my $output;
my $drv = LaTeX::Driver->new( source      => \$source,
			      format      => 'ps',
			      output      => \$output,
			      @DEBUGOPTS );

my $systmpdir = $ENV{TMPDIR} || '/tmp';

diag("Checking the formatting of a simple LaTeX document read from a variable");
isa_ok($drv, 'LaTeX::Driver');
like($drv->basedir, qr{^$systmpdir/$LaTeX::Driver::DEFAULT_TMPDIR\w+$}, "checking basedir");
is($drv->basename, $LaTeX::Driver::DEFAULT_DOCNAME, "checking basename");
is($drv->basepath, File::Spec->catpath('', $drv->basedir, $LaTeX::Driver::DEFAULT_DOCNAME), "checking basepath");
is($drv->formatter, 'latex', "formatter");

ok($drv->run, "formatting $docname");

is($drv->stats->{runs}{latex},         1, "should have run latex once");
is($drv->stats->{runs}{bibtex},    undef, "should not have run bibtex");
is($drv->stats->{runs}{makeindex}, undef, "should not have run makeindex");
is($drv->stats->{runs}{dvips},         1, "should have run dvips once");

like($output, qr/^%!PS/, "got postscript in output string");

my $tmpdir = $drv->basedir;
ok(-d $tmpdir, "temporary directory exists before undeffing driver");
undef $drv;
ok(!-d $tmpdir, "temporary directory deleted after undeffing driver");


tidy_directory($basedir, $docname, $debug)
  unless $no_cleanup;


exit(0);
