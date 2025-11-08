

% MIME workaround to enable windows-1252 and utf-7 %{{{
static variable state = 0, article, orig_article, header, body;
static variable level = 0, parents_state = 0;
static define extract_match (s, n) %{{{
{
  variable pos, len;
  
  (pos, len) = string_match_nth (n);
  strtrim (substr (s, pos+1, len), " \"");
}

static define extract_match_1 () %{{{
{
  extract_match (1);
}
static variable local_charset = "latin9";

static variable map_charsets = Assoc_Type[String_Type, ""];
map_charsets["windows-1252"] = "ms-ansi.." + local_charset;
map_charsets["utf-7"] = "utf-7.." + local_charset;

static variable recode_tempfile = 
  make_home_filename ("slrn-recoded-article.txt");

static variable recode = "/usr/bin/recode";

static define get_encoding () %{{{
{
   variable content_type = strlow (extract_article_header ("Content-Type"));
   variable encoding = "";
   
   if (string_match (content_type, "^.*charset *= *\"?\\([^ ;\"]+\\)", 1))
     encoding = map_charsets[extract_match_1 (content_type)];
   return encoding;
}
%}}}
static define recode_article () %{{{
{
   variable pn = "recode_article: ";
   variable fp, recoded_body;
   variable encoding = get_encoding ();


   if (encoding == "")
     return;

   fp = fopen (recode_tempfile, "w");
   if (fp == NULL)
     verror (pn + "Unable to open %s for writing", recode_tempfile);

   if ((-1 == fputs (body, fp)) or (-1 == fclose (fp)))
     error (pn + "Error writing to " + recode_tempfile);

   if (popen (recode + " " + encoding + " " + recode_tempfile, "r") == NULL)
     error (pn + "Failed to invoke recode");
   
   fp = fopen(recode_tempfile, "r");
   if (fp == NULL)
     verror (pn + "Unable to open %s for reading", recode_tempfile);
   recoded_body = fgetslines (fp);
   if (recoded_body == NULL)
     error (pn + "Read error!"):
   () = fclose (fp);
   body = strjoin (recoded_body, "");
   article = header + body;
   replace_article (article);
}
%}}}
