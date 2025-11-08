% -*- mode: slang; mode: fold -*-

% new-search.sl - a replacement for search.sl that comes with slrn

% Copyright (C) 2000-2002 Thomas Schultz <tststs@gmx.de>
% set_preference() mechanism borrowed from J.B. Nicholson-Owens
% 
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 2, as published by the Free Software
% Foundation.

#iffalse % Documentation %{{{
Description:

This file is meant as a replacement for the file search.sl that comes with
slrn. It also searches through the articles in the current newsgroup, but
has nicer features: It leaves threads in their collapsed / uncollapsed
status, optionally starts the search at the beginning of the buffer or
wraps around the end of the article list.
  
Installation:

The interface consists of two functions: search_first() starts a new
search, search_next() finds subsequent matches of the same regexp. You can
bind them in your slrnrc like this:

  setkey article NewSearch->search_first "$"
  setkey article NewSearch->search_next "&"

Preferences:

You can use the set_preference() function to customize the behaviour of
the macro. To do this, put calls to this function in a file and load it
after this file is loaded. The following examples show the default values:

NewSearch->set_preference("start_at_bob", 0);

  If set to a non-zero value, start the search at the beginning of the
  buffer, not at the current article.

NewSearch->set_preference("wrap_search", 0);

  If set to a non-zero value, the search will wrap around the end of the
  article list.

History:

 - Revision 1.3: Minor tweak to the fix introduced in 1.2
 - Revision 1.2: Fix needed for current (0.9.7.x) versions of slrn
 - Revision 1.1: Updated for slrn 0.9.7.2.
#endif %}}}

implements ("NewSearch");

private variable
  Prev_Search_Str = "",
  Starting_Point = "",
  Prefs = Assoc_Type [];

% Set preferences %{{{
Prefs["start_at_bob"] = 0;
Prefs["wrap_search"] = 0;
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

private define select_current_header () %{{{
{
   if (1 == is_article_visible())
     {
	loop (2) { call ("hide_article"); }
     }
}%}}}

private define search_here(search_str, wrapped) %{{{
{
   if (wrapped)
     if (Starting_Point == extract_article_header("Message-Id"))
       error ("Not found.");

   variable flags = get_header_flags ();
   select_current_header();
   if (re_search_article(search_str))
     {
	pop ();
	return 1;
     }
   set_header_flags(flags);
   call ("hide_article");
   return 0;
}%}}}

private define is_at_end_of_thread ()%{{{
{
   variable starting_point = extract_article_header ("Message-Id");

   EXIT_BLOCK
     {
        () = locate_header_by_msgid (starting_point, 0);
     }

   collapse_thread (); % goes to the first article in the thread
   uncollapse_thread ();
   () = header_down (thread_size () - 1);
   return (extract_article_header ("Message-ID") == starting_point);
}%}}}

private define search_articles(search_str, wrapped) %{{{
{
   variable
     was_thread_collapsed = is_thread_collapsed(),
     was_metamail = get_variable_value("use_metamail");
   set_integer_variable("use_metamail", 0); % Turn off metamail while searching
   
   ERROR_BLOCK
     {
	() = locate_header_by_msgid(Starting_Point, 0);
	if (is_article_visible!=0)
	  call("hide_article");
     }

   EXIT_BLOCK
     {
	set_integer_variable("use_metamail", was_metamail);
     }
   
   if (search_here(search_str, wrapped)) % Is the next match right here?
     return(0);
   
   !if (_is_article_visible() & 2)
     {
	call ("article_line_up");
	if (search_here(search_str, wrapped))
	  return(0);
     }
   
   forever % loop through articles
     {
	loop (thread_size () - 1)
	  {
	     () = header_down(1);
	     if (search_here(search_str, wrapped)) return(0);
	  }
	
	if (is_at_end_of_thread())
	  {
	     if (was_thread_collapsed) collapse_thread();
	     !if (header_down(1)) break;
	     was_thread_collapsed = is_thread_collapsed ();
	     if (search_here(search_str, wrapped)) return(0);
	  }
	else
	  {
	     !if (header_down(1)) break;
	     if (search_here(search_str, wrapped)) return(0);
	  }
     }
   
   EXECUTE_ERROR_BLOCK;
   return(-1);
}%}}}

private define perform_search(search_str) %{{{
{
   Starting_Point = extract_article_header("Message-Id");
   if (search_articles(search_str, 0) == -1) 
     {
	if (Prefs["wrap_search"])
	  {
	     call("header_bob");
	     if (search_articles(search_str, 1) == -1)
	       error("Not found.");
	  }
	else
	  error("Not found.");
     }
}%}}}

static define search_first() %{{{
{
   if (is_group_mode ())
     error (_function_name () + " doesn\'t work in group mode!");
   
   variable search_str = read_mini ("Search for regexp: ", Prev_Search_Str, "");
   if (search_str == "")
     return;
   Prev_Search_Str = search_str;
   if (Prefs["start_at_bob"])
     call("header_bob");
   perform_search(search_str);
}%}}}

static define search_next() %{{{
{
   if (is_group_mode ())
     error (_function_name () + " doesn\'t work in group mode!");
   
   if (Prev_Search_Str == "")
     search_first();
   else
     perform_search(Prev_Search_Str);
}%}}}
