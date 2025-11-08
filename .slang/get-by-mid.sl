% -*- mode: slang; mode: fold; -*-
% vim:sw=4 ft=slang

% get-by-mid.sl - retrieve article by message-id from server or deja.com

% Copyright (C) 2001 by Thore Tams <t.tams@gmx.de>
% search_by_mid provided by Stefan Foerster <stefan@stefan-foerster.de>
% extract_mid originally written by Jakob Voﬂ <jakob.voss@s1999.tu-chemnitz.de>
%  <URL:news:8muo8g$7r8$1@narses.hrz.tu-chemnitz.de>
% 
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 2, as published by the Free Software
% Foundation.


#iffalse % Documentation %{{{
Description:

This file contains the macro search_by_mid which allows you to scan an
article for Message-Ids and fetch them from deja.com.

If you call the function without prefix, it works like the well-known
slrn function locate_article. If you call it with prefix "1", it scans
the current article for possible Message-Ids and displays them for
selection in a menu. If you call it with prefix "2", you can enter the
Message-Id manually.  The article referenced by the selected/entered
Message-Id is then fetched from your newsserver. If it is not found
there, it is retrieved from deja.com. If this fails, the function will
create an error condition.

Installation:

You need a browser that can dump a webpage to stdout. I prefer wget for
this purpose, lynx wraps lines and does not return raw html.

Change Prefs["browser_call"] to the appropriate value, %s will be replaced
by the URL. If deja.com should ever change its interface for retrieving an
article by Message-Id you have to change Prefs["deja_url"]. %s will be
replaced by the Message-Id including angle brackets.

You may want to bind the function get_article to Esc-l:

setkey article GetByMid->get_article    "\el"
#endif %}}}

implements ("GetByMid");

private variable
    Prefs = Assoc_Type [];

% Set preferences %{{{
%Prefs["browser_call"] = "wget -o /dev/null -O - '%s'";
%Prefs["browser_call"] = "lynx --dump '%s'";
Prefs["browser_call"] = "w3m -dump '%s'";
Prefs["deja_url"]     = "http://groups.google.com/groups?selm=%s&output=gplain";
%}}}

define set_preference (preference, value) %{{{
{
   !if (assoc_key_exists (Prefs, preference))
     error ("Preference does not exist: " + string (preference));
   variable desired_type = typeof (Prefs[preference]);
   if (typeof (value) != desired_type)
     verror ("Wrong type for %s: This preference wants %s not %s",
             string (preference),
             string (desired_type),
             string (typeof (value)));
   Prefs[preference] = value;
} %}}}

define escape_string (s) { %{{{
    variable t = "", c;

    foreach (s)
    {
	c = ();
	if (orelse
		{isdigit(char(c))}
		{int(c) >= 'a' and int(c) <= 'z'}
		{int(c) >= 'A' and int(c) <= 'Z'})
	{
	    t = strcat(t, char(c));
	} else {
	    t = strcat(t, sprintf("%%%X", c));
	} 
    }
    return(t);
} %}}}

define extract_mid() { %{{{
    variable regexp = "[^()<>@,;:\\\\\" \\[\\]]+@[^()<>@,;:\\\\\" \\[\\]]+[^()<>@,;:\\\\\" \\.\\[\\]]";

    if( _is_article_visible () & 1 ) % article visible
    {

	% search for MIDs
	variable line,pos,len;
	variable number=0;

	call("art_bob");

	while( re_search_article(regexp) == 1 )
	{
	    line = ();
	    for( pos=1; string_match(line,regexp,pos)>0; pos+=len )
	    {
		(pos, len) = string_match_nth(0);
		"<" + substr(line, pos+1, len) + ">";       % put MID on stack
		number++;
	    }
	}
 
	% found MID[s]
	if(number>0)
	{
 
	    % put MIDs into array
	    variable mids = String_Type [number];
	    variable i;
	    for(i=number-1; i>=0; i--)
		mids[i] = ();
	    % let select MID (always ask since MID could be email-address)
	    variable evalstr = "select_list_box(\"Goto MID\",";
	    for(i=0;i<number;i++)
		evalstr += "\"" + mids[i] + "\"" + ",";
	    evalstr += sprintf("%d, 1);",number);
	    eval(evalstr);
 
	} else verror("no Message-ID found!");
    } else verror("no article visible!");
} %}}}

define get_from_deja (mid) { %{{{
    variable url, rc, s = "", deja_article = "", fp;

    if (is_group_mode())
	verror ("%s doesn't work in group mode!", _function_name());
    if (strlen (mid) > 0) {
	url = sprintf(Prefs["deja_url"], escape_string(mid));
	fp = popen (sprintf(Prefs["browser_call"], url), "r");
	do {
	    rc = fgets (&s, fp);
	    deja_article = strcat(deja_article, s);
	} while (rc > 0);
	rc = pclose (fp);
	if (strlen(deja_article) > 0 and 
		string_match(deja_article, "Newsgroups:", 1) > 0) {
	    !if (_is_article_visible())
		call ("hide_article");
	    replace_article (deja_article);
	} else {
	    verror("article %s not found on deja.com.", mid);
	}
    } else {
	error("no Message-ID given!");
    }
} %}}}

define search_by_mid (mesgid) { %{{{
    if(mesgid != "")
    {
	% the following line was necessary because
	% locate_header_by_msgid generates an error condition
	% instead of returning 0 before slrn 0.9.7.0
	ERROR_BLOCK {
	   _clear_error();
	   get_from_deja(mesgid);
       	}

	if (0 == locate_header_by_msgid(mesgid, 1))
	{
	   error(""); % Just triggers ERROR_BLOCK
	} else {
	   uncollapse_thread;
	   call("art_bob");
	}
    }
} %}}}

define get_article () { %{{{
    variable p = Integer_Type;
    variable mid;

    p = get_prefix_arg();

    if (p == -1) {
	% no prefix - do it the old way
	call ("locate_article");
    } else if (p == 1) {
	% prefix - scan the current article
	search_by_mid(extract_mid());
    } else if (p == 2) {
        % prefix 2 - get mid via read_mini
        search_by_mid(read_mini("Enter Message-ID", "", ""));
    }
	
} %}}}
