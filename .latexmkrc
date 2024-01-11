#!/usr/bin/perl
# %O Option
# $S Source
# $D Output

$latex     = 'pdflatex -synctex=1 %S -halt-on-error -file-line-error %O';
$bibtex    = 'bibtex %O %S';
#$makeindex = 'makeindex %O -s nomencl.ist -o %D %S';
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls{
system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"")
}

$max_repeat = 5;
# pdf_mode
# 0: create dvi file using $latex. does not create pdf file.
# 1: create pdf file using $pdflatex without creating dvi file and so on...
# 2: create pdf file using $ps2pdf after converting dvi file created using $latex to ps file using $dvips.
# 3: create dvi file using $latex, then create pdf file using $dvipdf
$pdf_mode   = 1;
# use bibtex
$bibtex_use = 2;

if ($^O eq 'linux'){
	$pdf_previewer = 'evince';
}
$preview_continuous_mode = 1;

$clean_ext = 'blg bbl spl out nlo aux fls log fdb_latexmk';
