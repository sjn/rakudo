{
    ## duplicate src/core/IO.pm::cwd
    my $CWD = IO::Path.new(nqp::p6box_s(
#?if parrot
        pir::trans_encoding__Ssi(
            nqp::cwd(),
            pir::find_encoding__Is('utf8'))
#?endif
#?if !parrot
            nqp::cwd(),
#?endif
    ));
    PROCESS::<$CWD> = $CWD;

    my $PID = nqp::p6box_i(nqp::getpid());
    PROCESS::<$PID> = $PID;

    my $EXECUTABLE =
#?if parrot
        nqp::p6box_s(pir::interpinfo__Si(pir::const::INTERPINFO_EXECUTABLE_FULLNAME));
#?endif
#?if jvm
        $*VM.properties<perl6.execname>
        or $*VM.properties<perl6.prefix> ~ '/bin/perl6-j';
#?endif
#?if moar
        nqp::execname()
        or ($*VM.config<prefix> ~ '/bin/' ~ ($*VM.config<osname> eq 'MSWin32' ?? 'perl6-m.bat' !! 'perl6-m'));
#?endif
    $EXECUTABLE := $EXECUTABLE.path.absolute;
    PROCESS::<$EXECUTABLE>      = $EXECUTABLE;
    PROCESS::<$EXECUTABLE_NAME> = $EXECUTABLE.basename;

    my Mu $comp := nqp::getcomp('perl6');
    my $PROGRAM_NAME = $comp.user-progname();
    PROCESS::<$PROGRAM_NAME> = $PROGRAM_NAME;

    PROCESS::<$TMPDIR> = IO::Spec.tmpdir().path;
}
