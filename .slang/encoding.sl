% -*- mode: slang; mode: fold; -*-                                     %{{{ 
%
% This allows you to choose the encoding of your posting after writing 
% and before posting it.
% USAGE:   Put the macro/hook in /usr/share/macros/macros.sl
%          (or wherever you wish), and add the following to .slrnrc:
%
%          set macro_directory "/usr/share/macros"
%          interpret "macros.sl"
%
% After you've written a post and exited the editor slrn will ask you:
% Post the message? Yes, No, Edit, poStpone, Filter
% If you choose Filter, you'll be presented with a selection box,
% where you can decide on the desired encoding. 
% See more @ http://www.geocities.com/tsca.geo/tsca.slang              %}}}

 define post_filter_hook ()
{
  variable 
   n_code = select_list_box ("Choose encoding",
                             "iso-8859-1", 
                             "iso-8859-2", 
                             "iso-8859-3", 
                             "utf-8",
                             "koi8-r", 
                              5, 2);
  set_string_variable ("mime_charset", n_code);
}

% --- end here ----------------------------------------

