% -*- mode: slang; mode: fold -*-

% sort-headers.sl - sorted output of header lines
% Version 1.1

% Copyright (C) 2000, 2004 Thomas Schultz <tststs@gmx.de>
% sort() based on code written by John E. Davis
% set_preference() mechanism borrowed from J.B. Nicholson-Owens
% 
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 2, as published by the Free Software
% Foundation.

#iffalse % Documentation %{{{
Description:

Some people like to view header lines in a special order. At your option,
this macro set will sort header lines alphabetically, in a user-defined
order or as given in the ``visible_headers'' slrnrc command. It can be
automatically called whenever a new article is read.

Installation:

Interpret sort-headers.sl using a call like
  
  interpret "sort-headers.sl"
  
in your .slrnrc file. It will register for read_article_hook and thus get
executed on each article you read automatically (since version 1.1).

Preferences:

You can use the set_preference() function to customize the behaviour of
the macro. To do this, put calls to this function in a file and load it
after this file is loaded. The following examples show the default values:

SortHeaders->set_preference("method", 1);

  Sorting method to use:
    1 == "sort alphabetically"
    2 == "user-defined order"
    3 == "as found in visible_headers"
  Any other value will turn off sorting.

SortHeaders->set_preference("order", "From:,Subject:,Newsgroups:");

  Define the order in which you want to see the header lines as a
  comma-separated list. This setting matters only if "method" is set to 2.
  
Changes:
1.1   Treat articles without body properly.
      Register for read_article_hook automatically.
#endif %}}}

implements ("SortHeaders");

private variable
  Order,
  Prefs = Assoc_Type [];

% Set preferences %{{{
Prefs["method"] = 1;
Prefs["order"] = "From:,Subject:,Newsgroups:";
%}}}

static define set_preference (preference, value) %{{{
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

private define listcmp(a, b) %{{{
{
   variable
     list = strtok(strlow(Order), ","),
     item,
     item_len,
     a_match,
     b_match;
   
   a = strlow(a);
   b = strlow(b);
   
   foreach (list)
   {
      item = ();
      item_len = strlen(item);
      a_match = (0 == strncmp(a, item, item_len));
      b_match = (0 == strncmp(b, item, item_len));
      if (a_match or b_match)
      {
	 if (a_match and b_match) return 0;
	 return b_match - a_match;
      }
   }
   
   return 0;
}%}}}

static define sort() %{{{
{
   if (is_group_mode ())
     error (_function_name () + " doesn\'t work in group mode!");
   
   variable cmp;
   % choose the correct function for the desired sorting method
   switch (Prefs["method"])
     { case 1 : cmp = &strcmp; }
     { case 2 : Order = Prefs["order"]; cmp = &listcmp; }
     { case 3 : Order = get_visible_headers(); cmp = &listcmp; }
     { return; }
   
   variable
     article = article_as_string(),
     i = is_substr (article, "\n\n"),
     sortres,
     header = "",
     body = "";

   % seperate header and body, taking into account empty bodies
   if (i == 0)
     header = article;
   else
     {
	header = article[[0:i-1]];
	body = article[[i:]];
     }   
   
   % remove continuation lines from the header
   while (str_replace (header, "\n ", " "))
     header = ();
   while (str_replace (header, "\n\t", " "))
     header = ();
   
   % convert the header to an array of strings
   header = strtok (header, "\n");
   
   % do the actual sorting
   sortres = array_sort (header, cmp);
   header = header[sortres];
   
   % join header to the body
   article = strjoin (header, "\n");
   if (i > 0)
     article = strcat (article, "\n", body);
   
   % replace the selected article with our result
   replace_article (article);
}%}}}

!if (register_hook ("read_article_hook", "SortHeaders->sort"))
  message ("Sort Headers: Warning: Could not register for read_article_hook!");
