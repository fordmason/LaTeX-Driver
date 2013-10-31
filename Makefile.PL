#!/usr/bin/perl -w                                         # -*- perl -*-

use inc::Module::Install 0.91;
use Module::Install::ReadmeFromPod;
use Module::Install::AuthorRequires;
use Module::Install::AuthorTests;
use Module::Install::AssertOS;

assertos qw/ Unix /;

license 'perl';

all_from    'lib/LaTeX/Driver.pm';
readme_from 'lib/LaTeX/Driver.pm';

requires_external_bin 'latex';

requires 'Class::Accessor';
requires 'Cwd';
requires 'Exception::Class';
requires 'File::Slurp';
requires 'File::Spec';
requires 'Getopt::Long';
requires 'IO::File';
requires 'parent';
requires 'IPC::ShellCmd' => 0.002;
requires 'Readonly';

test_requires 'Test::More' => '0.88';

author_requires 'Test::NoTabs';
author_requires 'Test::Pod' => '1.14';
author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Test::Spelling' => '0.11';

install_script 'latex2dvi';
install_script 'latex2pdf';
install_script 'latex2ps';

author_tests 'xt';

resources repository => 'https://github.com/fordmason/LaTeX-Driver.git';

WriteAll;
