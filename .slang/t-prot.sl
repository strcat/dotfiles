% $Id: t-prot.sl,v 1.17 2006/05/16 11:33:32 jochen Exp $
% Copyright (c) 2003-2005 Jochen Striepe <t-prot@tolot.escape.de>
%
% This file is provided as an example implemention for articles to be
% filtered through t-prot before displayed. They are still filtered if
% you reply to such a message so you will have to deactivate this if
% you want to include quotes of the original article.
%
% Activate this macro by adding
%   interpret t-prot.sl
% to your ~/.slrnrc.
%
% If you are not happy with the suggested t-prot default parameters,
% put something like
%   variable t_prot_params = "-cemtS";
%   variable t_prot_tmpdir = "$HOME/.tmpdir";
%   variable t_prot_qp     = "";
% into ~/.slrn/t-prot-cfg and add
%   interpret .slrn/t-prot-cfg
% to your ~/.slrnrc (after 'interpret t-prot.sl'). If "mimedecode" is
% installed on your system you might want to use
%   variable t_prot_qp     = "mimedecode";
% You can get mimedecode at
%   http://packages.debian.org/stable/mail/mimedecode.html
%
% However, please keep in mind that the path of the temp directory should
% NOT be readable to other users -- otherwise it might reveal information on
% what you read, and probably even be a security hole. Please see t-prot's
% man page for details on command line parameters.
%
% If you want to toggle t-prot filtering on/off without leaving slrn,
% you may want to add something like
%   setkey article   register_t_prot "\e6"
%   setkey article unregister_t_prot "\e7"
% to your ~/.slrnrc -- press ESC-6 to activate t-prot filtering, and
% ESC-7 to disable it (this will take effect on the next article you
% read, see the package's TODO file).
%
% Requirements/Bugs: tr(1) and rm(1) are POSIX and should be available
% on any Unix-like system, mktemp(1) should be available on any recent
% OpenBSD or Debian Linux system -- you can get the sources there
% if your system happens to lack this program. This macro has been
% tested with slrn-0.9.7.4 to slrn-0.9.8.0 and S-Lang v1.4.5, it might
% fail with other versions (and will definitely fail with S-Lang v2.x).
% As always, bug reports, patches (preferrably in unified diff format),
% comments and suggestions are welcome.
%
% License: This file is part of the t-prot package and therefore
% available under the same conditions. See t-prot's man page for
% details.


% these should be reasonable defaults (they work fine for me, SCNR):
variable t_prot_params = "-aceklmtS --diff --bigq -L$HOME/.slrn/mlfooters -A$HOME/.slrn/adfooters";
variable t_prot_tmpdir = "$HOME/tmp/slrn"; % you better make sure it exists
variable t_prot_qp = "perl -i -p -e '$p=1 if /^Content-Transfer-Encoding: quoted-printable/i; if ($p==1) { s/=([0-9a-f][0-9a-f])/chr(hex($1))/egi; s/=\n//eg; };'";

define t_prot () {
	variable art, f, fname, line, qp;
	art = "";

 	% Keep in mind that the path should NOT be readable to other users --
	% otherwise it might reveal information on what you read, and probably
	% even be a security hole:
	f = popen ("mktemp -q "+t_prot_tmpdir+"/t-prot.sl.XXXXXX | tr -d '\n'", "r");
	if (f == NULL) return;
	if (-1 == fgets (&fname, f)) return;
	pclose (f);


	if (t_prot_qp != "") { qp = t_prot_qp+"|"; } else { qp = ""; }

	f = popen (qp+"t-prot "+t_prot_params+" >"+fname, "w");
	if (f == NULL) {
		error ("Unable to filter article to "+fname);
		return;
	}
	() = fputs (article_as_string(), f);
	() = pclose (f);


	f = fopen (fname, "r");
	if (f == NULL) {
		error (fname+" could not be opened.");
		return;
	}
	while (-1 != fgets (&line, f)) {
		art = art + line;
	}
	fclose (f);

	if (0 != remove(fname)) error ("Unable to remove "+fname);

	replace_article (art);
}

define register_t_prot () {
	if (1 == register_hook("read_article_hook", "t_prot")) {
		error("t-prot filtering activated");
	}
	else {
		error("t-prot filtering NOT activated");
	}
}

define unregister_t_prot () {
	if (1 == unregister_hook("read_article_hook", "t_prot")) {
		error("t-prot filtering deactivated");
	}
	else {
		error("t-prot filtering NOT deactivated");
	}
}

% filtering is enabled by default:
register_hook("read_article_hook", "t_prot");
