% Filename: display_filter.sl
% Version: 0.9.1
% Author: Troy Piggins

% Code needs some tidying up and commenting, but it's functional.

% *** Check the path to slrn_display_filter is correct for your system. ***

define display_filter () {

  variable display_filter_tmp, raw_art, fp, art_display_filter;
  display_filter_tmp = "/tmp/slrn_display_filter."+ string (getpid () );
  raw_art = raw_article_as_string ();
  fp = fopen (display_filter_tmp, "w");

  if (fp == NULL) error (_function_name () +": could not open "+display_filter_tmp);

  fputs (raw_art, fp);
  fclose (fp);
  fp = popen ("slrn_display_filter - < "+display_filter_tmp, "r");

  if (fp == NULL) error (_function_name () +": display_filter pipe failed" );

  art_display_filter = strjoin (fgetslines (fp), "");
  pclose (fp);

  if (art_display_filter != "") replace_article (art_display_filter);
  else error (_function_name () +": failed");

  system ("rm "+display_filter_tmp);

}

% () = register_hook ("read_article_hook", "display_filter");
