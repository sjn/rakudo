# Rakudo Perl 6

This is Rakudo Perl, a Perl 6 compiler for the Parrot virtual machine,
the JVM and MoarVM.

Rakudo Perl is Copyright (C) 2008-2014, The Perl Foundation. Rakudo Perl
is distributed under the terms of the Artistic License 2.0. For more
details, see the full text of the license in the file LICENSE.

This directory contains only the Rakudo Perl 6 compiler itself; it 
does not contain any of the modules, documentation, or other items
that would normally come with a full Perl 6 distribution.  If you're
after more than just the bare compiler, please download [the latest
Rakudo Star package](http://rakudo.org/downloads/star).

For a high-level overview of implemented and missing features,
please visit http://perl6.org/compilers/features .

## Building Rakudo on Parrot

See the INSTALL.txt file for detailed prerequisites and build and
installation instructions. The short version is

    $ # recommended: install libicu-dev and libreadline-dev packages
    $ perl Configure.pl --gen-parrot --backends=parrot
    $ make
    $ make spectest # optional
    $ make install # IMPORTANT, installs to install/bin/perl6

Note that the 'make install' step is necessary for running
Rakudo from outside the build directory. But don't worry, it
installs locally by default, so you don't need any administrator
privileges for carrying out this step.

## Building Rakudo on JVM

You need the JDK 1.7 installed and a make program. These instructions
will fetch an appropriate revision of nqp, build it, and then build
rakudo on the jvm.

    $ perl Configure.pl --gen-nqp --backends=jvm
    $ make

Note that Rakudo on JVM implements a slightly different set of features
than Rakudo on Parrot.

If you get an out of memory error building rakudo on the JVM, you may
need to modify your NQP runner to limit memory use. e.g. Adding
`-Xms500m -Xmx2g` as options passed to java in the installed nqp / nqp.bat.

## Building Rakudo on MoarVM

The easiest way is:

    $ perl Configure.pl --gen-moar --gen-nqp --backends=moar
    $ make
    $ make spectest # optional
    $ make install # IMPORTANT, installs to install/bin/perl6

Note that the 'make install' step is necessary for running
Rakudo from outside the build directory. But don't worry, it
installs locally by default, so you don't need any administrator
privileges for carrying out this step.

## Multiple backends at the same time

By supplying combinations of backends to the --backends flag, you
can get two or three backends built in the same prefix. The first
backend you supply in the list is the one that gets the "perl6" name
as a symlink, all backends are installed as perl6-\*.

The format for the --backends flag is:

    $ perl Configure.pl --backends=moar,parrot
    $ perl Configure.pl --backends=parrot,moar,jvm
    $ perl Configure.pl --backends=ALL

## Where to get help or answers to questions

There are several mailing lists, IRC channels, and wikis available with
help for Perl 6 and Rakudo on Parrot. Figuring out the right one to use
is often the biggest battle. Here are some rough guidelines:

The central hub for Perl 6 information is http://perl6.org/ .
This is always a good starting point.

If you have a question about Perl 6 syntax or the right way to approach
a problem using Perl 6, you probably want the "perl6-users@perl.org"
mailing list or the "irc.freenode.net/#perl6" channel.  The perl6-users
list is primarily for the people who want to use Perl 6 to write
programs, so newbie questions are welcomed there.  Newbie questions
are also welcome on the #perl6 channel; the Rakudo and Perl 6
development teams tend to hang out there and are generally glad
to help.  You can follow "@rakudoperl" on Twitter, and there's
a Perl 6 news aggregator at <http://planeteria.org/perl6/> .

Questions about NQP can also be posted to the #perl6 IRC channel.
For questions about Parrot, see <http://parrot.org/> for links and
resources, or join the #parrot IRC channel on irc.perl.org .
For questions about MoarVM, you can join #moarvm on freenode.

## Reporting bugs

Bug reports should be sent to "rakudobug@perl.org" with the moniker
[BUG]\(including the brackets) at the start of the subject so that it
gets appropriately tagged in the RT system (https://rt.perl.org/rt3/).
Please include or attach any sample source code that exhibits the bug,
and include either the release name/date or the git commit identifier.
You find that information in the output from "perl6 --version" (or in
the first line of "git log", if Rakudo fails to build). There's no need
to cc: the perl6-compiler mailing list, as the RT system will handle
this on its own.

If you find a bug in MoarVM or NQP, you can either discuss it on the IRC
and have it reported for you, or you can submit an issue to the issue
trackers on github for perl6/nqp or moarvm/moarvm.

## Submitting patches

If you have a patch that fixes a bug or adds a new feature, please
submit it to "rakudobug@perl.org" with the moniker [PATCH]\(including
the brackets) at the start of the subject line. We'll generally accept
patches in any form if we can get them to work, but unified diff from
the "git" command is greatly preferred. In general this means that in
the "rakudo" directory you make your changes, and then type

    git commit -m 'Your commit message' changed/filename.pm
    git format-patch HEAD^

This will generate a file called "001-your-commit-message.patch", or
more of them if you made multiple commits; please attach these to your
email. Please note that if you made more than one commit, you have to
specify a proper commit range for format-patch,
for example origin/nom..HEAD .

(Note to the maintainers: you can apply these patches with the 
"git-am -s" command; it preserves meta information like author).

## How the compiler works

See `docs/compiler_overview.pod`.

## AUTHOR

Patrick Michaud "pmichaud@pobox.com" is the current pumpking for
Rakudo Perl 6.  See CREDITS for the many people that have contributed
to the development of the Rakudo compiler.
