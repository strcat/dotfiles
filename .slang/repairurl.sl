define _Util__ReplaceRE (source, str, replace) 
{
   variable tmp;
   variable pos = 1, len = 0;
   
   while (string_match(source,str,pos + len)) 
   { 
      (pos, len) = string_match_nth(0);
      tmp = substr (source, pos+1, len);
      (source, ) = strreplace(source, tmp, replace, strlen(source));
   }
   return source;
}

define _Util__ArticleReplaceRE2 (search, str, replace)
{
   variable article, tmp, found;
   variable pos = 1, len = 0;
   
   article = article_as_string();
   while (string_match(article,search,pos + len)) 
   { 
      (pos, len) = string_match_nth(0);
      tmp = substr (article, pos+1, len);
      found=tmp;
      tmp = _Util__ReplaceRE (tmp, str, replace);
      (article, ) = strreplace(article, found, tmp, strlen(article));
   }
   replace_article (article);
}

define _test__WrapURL()
  % Wrap Multiline-URL <URL:...\n..>
{
   variable pattern = "[-a-z0-9_\./~\*\?\+#@=&:;,%]";
   loop (10) _Util__ArticleReplaceRE2 ("\\C<URL:[hf]t+p://"+pattern+"*\n"+pattern, "\n", "");
%    loop (10) _Util__ArticleReplaceRE2 ("\\C<[hf]t+p://"+pattern+"*\n"+pattern, "\n", "");
}

definekey("_test__WrapURL","\ed","article");

% Hinweis: Ich habe meine s-lang Anleitung gerade verlegt... geht auch
% so
