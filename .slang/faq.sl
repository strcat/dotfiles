% Retreive FAQ for the current newsgroup.    % -*- mode: s-lang; mode: fold -*-
% The people who need to read FAQs the most never read them at all.
%
% Copyright © 2002 J.B. Nicholson-Owens
% Title: rtfFAQ.sl
% Author: J.B. Nicholson-Owens
% Version: 1.01
% License: GNU GPL
% Last tested with: slrn 0.9.7.4 and S-Lang 1.4.5
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  You may
% also download a copy of the applicable license from
% <URL:http://forestfield.org/gpl.txt>.

#iffalse % Documentation                                                %{{{
% This macro set allows you to easily find the frequently asked
% questions (FAQ) list for the current newsgroup.  By assigning
% rtfFAQ->now() to a key, you are one keystroke away from reading
% valuable information about the newsgroup the cursor is pointing
% on.
% 
% To install this macro set:
%
% (1) Save a copy of this file as "rtfFAQ.sl" somewhere so slrn can
%     find it.  Your home directory will do if you don't have a better place
%     for it.
%
% (2) Append the following lines to your slrn.rc ($HOME/.slrnrc on Unix) to
%     make slrn load this file:
%
%        interpret "rtfFAQ.sl"
%
% (3) Quit and restart slrn.  slrn will tell you it has loaded this file.
%
% Optional steps:
%
% * Add a key to access a FAQ: edit your slrn.rc and add a setkey line after
%   loading the macro set:
%
%     interpret "rtfFAQ.sl"
%     setkey group   rtfFAQ->now "_"
%     setkey article rtfFAQ->now "_"
%
%   This will make the underscore key ("_") read the FAQ for the current
%   newsgroup in either group or article mode.
%
% * Change the FAQ source.  This macro set has a preference setting to
%   tell it where to get FAQs.  You can change this setting by making a text
%   file (say, "my-macros.sl" in your home directory if you don't have a
%   better place for it) and copying the following line into it:
%
%     rtfFAQ->set_preference ("FAQ source", "http://www.cs.uu.nl/wais/html/na-bng/%g.html");
%
%   There are a small set of sprintf-style percent escapes for use with this
%   preference:
%
%     %% -> literal percent sign ("%")
%     %f -> first part lowercase (news.software.readers -> news)
%     %F -> first part uppercase (news.software.readers -> NEWS)
%     %l -> last part lowercase (news.software.readers -> readers)
%     %L -> last part uppercase (news.software.readers -> READERS)
%     %g -> newsgroup (lowercase)
%     %G -> newsgroup (uppercase)
%     %d -> newsgroup as lowercase directory (news.software.readers -> news/software/readers)
%     %D -> newsgroup as uppercase directory (news.software.readers -> NEWS/SOFTWARE/READERS)
%
%   Trailing lone percent signs are equivalent to "%%", so:
%
%     "http://www.faqs.example/%"
%     "http://www.faqs.example/%%"
%
%    are equivalent.  sprintf() modifiers are not available.  So there is
%    no way to get the first 5 characters of a newsgroup name into setting
%    this preference.  If this is a problem, let me know or hack it in and
%    feel free to send me a patch.
%
%    Here is a FAQ site:
%
%      http://www.cs.uu.nl/wais/html/na-bng/%g.html
%
% Changelog
% 1.0   Released.
% 1.01  Documentation error fixed.  Thanks to Thomas Schultz <tststs@gmx.de> for spotting.
%       rtfFAQ->now() handles no current newsgroup.  Thanks to Thomas Schultz <tststs@gmx.de>
%	  for idea.
#endif %}}}

implements ("rtfFAQ");

private define str_replace_all (str, old, new)                          %{{{
{
#ifexists strreplace
   (str,) = strreplace (str, old, new, strlen (str));
   return str;
#else
   while (str_replace (str, old, new))
     str = ();
   return str;
#endif
}

%}}}

static variable prefs = Assoc_Type[String_Type];
prefs["FAQ source"] = "http://www.faqs.org/faqs/by-newsgroup/%f/%g.html";

static define set_preference (preference, value)                        %{{{
{
   preference = string (preference);
   !if (assoc_key_exists (prefs, preference))
     error ("Preference does not exist: " + preference);

   variable desired_type = typeof (prefs[preference]);
   if (andelse
         { desired_type != Null_Type }
         { typeof (value) != desired_type })
     {
        verror ("Wrong type for %s: This preference wants %S not %S",
                preference, desired_type, typeof (value));
     }
#ifexists preference_check
   if (andelse
        { assoc_key_exists (preference_check, preference) }
        { @preference_check[preference] (value) })
     {
        vmessage ("Warning: Invalid setting for %s -- using %S instead",
                  preference, prefs[preference]);
        return ();
     }
#endif
   prefs[preference] = value;
}

%}}}
static define expand (expression, newsgroup)                            %{{{
{
   % creep along the expression, expanding homemade %-escapes along the way.
   % (isn't there a fancy way to do homemade %-escapes with sprintf()?)
   %
   % expand the directory variable according to the following
   % sprintf-style % escapes:
   %   %% -> %
   %   %f -> first part lowercase (news.software.readers -> news)
   %   %F -> first part uppercase (news.software.readers -> NEWS)
   %   %l -> last part lowercase (news.software.readers -> readers)
   %   %L -> last part uppercase (news.software.readers -> READERS)
   %   %g -> newsgroup (lowercase)
   %   %G -> newsgroup (uppercase)
   %   %d -> newsgroup as lowercase directory (news.software.readers -> news/software/readers)
   %   %D -> newsgroup as uppercase directory (news.software.readers -> NEWS/SOFTWARE/READERS)

   variable
     conversion = Assoc_Type[String_Type],
     newsgroup_array = strchop (newsgroup, '.', 0),
     newsgroup_dir = str_replace_all (newsgroup, ".", "/");

   conversion["%"] = "%";
   conversion["f"] = strlow (newsgroup_array[0]);
   conversion["F"] = strup (newsgroup_array[0]);
   conversion["l"] = strlow (newsgroup_array[-1]);
   conversion["L"] = strup (newsgroup_array[-1]);
   conversion["g"] = strlow (newsgroup);
   conversion["G"] = strup (newsgroup);
   conversion["d"] = strlow (newsgroup_dir);
   conversion["D"] = strup (newsgroup_dir);

   variable
     i = 0,                                      % dummy index variable
     l = strlen (expression) - 1,                % last char in expression
     expansion = "";                             % expanded value (retval)

   for (i = 0; i <= l; i++)
     {
        if (expression[i] != '%') expansion += char (expression[i]); % copy XOR
        else                                                         % parse.
          {
             % Trailing percent signs get copied as percent signs.
             % They are implicitly "%%".
             if (i == l)
               {
                  expansion += "%";
                  return expansion;    % or "continue;"
               }
             % expand the percent escape and skip over the percent escape.
             else
               {
                  expansion += conversion[char(expression[i+1])];
                  i++;
               }
          }
     }

   return expansion;
}

%}}}
static define now ()                                                    %{{{
{
   variable
      browser = "non_Xbrowser",
      newsgroup = current_newsgroup ();

   if (getenv ("TERM") == "xterm") browser = "Xbrowser";
   
   if (newsgroup == "") error ("There is no current newsgroup!");

   () = system (sprintf (get_variable_value (browser),
                         expand (prefs["FAQ source"], current_newsgroup ())));
}

%}}}
static define version () { return (1.01); }
