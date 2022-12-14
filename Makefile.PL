require 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => "Data::Dump",
   VERSION_FROM => "lib/Data/Dump.pm",
   ABSTRACT_FROM => "lib/Data/Dump.pm",
   AUTHOR => 'Gisle Aas <gisle@activestate.com>',
   LICENSE => "perl",
   MIN_PERL_VERSION => 5.006,
   PREREQ_PM => {
       Symbol => 0,
   },
   META_MERGE => {
       resources => {
           repository  => 'http://github.com/garu/data-dump',
           license     => 'http://dev.perl.org/licenses/',
           bugtracker  => 'https://github.com/garu/data-dump/issues/',
       },
       recommends => {
	   'MIME::Base64' => 0,
       },
   },
   BUILD_REQUIRES => {
       Test => 0,
   },
);

BEGIN {
    # compatibility with older versions of MakeMaker
    my $developer = -d "eg";
    my %mm_req = (
        LICENCE => 6.31,
        META_MERGE => 6.45,
        META_ADD => 6.45,
        MIN_PERL_VERSION => 6.48,
        BUILD_REQUIRES => 6.56,
    );
    undef(*WriteMakefile);
    *WriteMakefile = sub {
        my %arg = @_;
        for (keys %mm_req) {
            unless (eval { ExtUtils::MakeMaker->VERSION($mm_req{$_}) }) {
                warn "$_ $@" if $developer;
                delete $arg{$_};
            }
        }
        ExtUtils::MakeMaker::WriteMakefile(%arg);
    };
}
