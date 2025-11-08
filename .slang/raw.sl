% -*- mode: slang; mode: fold; -*-
% SHOW RAW MSG v0.5.1 by Tomasz 'tsca' Sienicki, <tsca@cryogen.com>     %{{{
% This macro works only with a local spool. I tested it with INN, but it
% should work with slrnpull, leafnode, etc as well (Yes, it can be done
% changing the value of "use_mime", but that'd require re-reading the message
% from server). See more @ http://www.geocities.com/tsca.geo/slang.html %}}}

 define show_raw ()
{
%  variable newshome = "~news/articles/",  % where the articles are stored,
                                          % don't forget the final slash
  variable newshome = "~/nslrn/slrnpull/",
% ------------------------------------------------------------------------
 hvlk=extract_displayed_article_header("xref"),nr,hvr,len,grp;

 if (string_match(hvlk,"[^ ]+ \\([^:]+\\):\\(\\d+\\)",1))
   {
    (hvr,len)=string_match_nth(2);nr=substr(hvlk,hvr+1,len+1);
    (hvr,len)=string_match_nth(1);grp=substr(hvlk,hvr+1,len);
    while (str_replace(grp,".","/")) grp=();

    if ((getenv("PAGER")) == NULL) putenv ("PAGER=less");
    system("$PAGER "+newshome+grp+"/"+nr); break;
   } message("Failed.");
}
 definekey ("show_raw","","article"); % Ctrl-R

% Last changes: Sat, 17 Mar 2001, 21:57:52
