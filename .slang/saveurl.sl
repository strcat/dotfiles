define append_string_to_file (file, str, url)
% sichert url in file
{  
   variable fp = fopen (file, "a");
    
   if (fp == NULL) verror ("%s could not be opened", file);
   () = fputs (str + "\n", fp);
   () = fclose (fp);
   variable b = read_mini_no_echo ("url '" + url + 
        "' saved (press <ENTER>)","" ,"" );
}

define delete_saved_url(str, url)
% löscht die behandelten urls (gesichert oder bereits vorhandenen urls
% aus der Liste und damit aus der selectbox
{  
   url = "\"" + url + "\"";
   variable cnt;
   if ( str == url) { str =""; cnt = 1; }
   else
     if ( is_substr(str, url + ",")) 
          (str,cnt ) = strreplace(str, url + ",", "", 1);
     else
        !if ( is_substr(str, url + ",")) 
           (str, cnt) = strreplace(str, "," + url,"", 1);
   return (str, cnt);
}

define save_url() 
{
   % sucht im angezeigten Artikel alle URLs und bietet sie in einer
   % Listbox zur Auswahl an und hängt sie an ein File an.

   !if (3 == is_article_visible ())
   % nur, wenn der zum Headerfenster passende Artikel
   % angezeigt wird.
   error("Works only if correct article is visible!");
 
   % Suchbegriff
   % Etwas modifiziert, weil mit der /alten/ Version URL's die mit 
   % Ziffern anfangen nicht korrekt geparst wurden.
   % Das Orginal ist bei Google einzusehen:
   % <http://groups.google.com/groups?selm=c2rkdb.bu.ln@rolf-buenning.myfqdn.de>
   %    variable pattern ="[hf]t+p://[-a-zA-Z_\./~\*?#]+";
	variable pattern ="[hf]t+p://[-0-9-a-zA-Z_\./~\*?#]+";

   % enthält den gesamten Artikel
   variable article = article_as_string();

   variable pos = 1, len = 0, url;
   variable url_string = "", item_count=0;
   
   % alle gesammelten URLs
   variable file_name = make_home_filename ("URLS.html");
   variable selected = 2; % positioniert auf 1. url
   variable count;

   % solange ein Treffer erziehlt wird...
   while (string_match(article,pattern,pos + len)) 
   { 
      item_count++;   % Zählen der Treffer
      (pos, len) = string_match_nth(0);
      url = substr (article, pos+1, len); % separieren des Treffers
       if (item_count > 1) url_string += ",";
       url_string = url_string + "\"" + url + "\"";   
   }

   if (item_count == 0) error("no url found"); 
         % nichts gefunden
   
   forever 
   {  % Selectbox anzeigen
      eval("select_list_box(\"select URL or EXIT\",\"EXIT\","  + 
      url_string + "," + string(item_count+1)  + "," + string(selected) + ")");

      url = ();   % url enthält jetzt die selektierte Adresse

%      selected++;    % hmm, funktioniert, aber nicht so wie gewünscht.

      if ((url == "EXIT") or (url == "")) return;
      

      !if (system("/usr/bin/grep " + url + " " + file_name)) 
      % URL in file schon vorhanden?
      {  variable a = read_mini_no_echo (url + 
               " already saved (press <ENTER>)","" ,"" );
         % url aus Liste löschen
         (url_string, count) = delete_saved_url(url_string, url);
         % Anzahl items anpassen
         item_count -= count;
         continue;
      }    
      else
      % wenn nein, speichern
      % Beschreibung

      variable text = read_mini ("Beschreibung: ", "", "");

      append_string_to_file (file_name , "<ul><li><a href=" +
           + url + ">" + text + "<br>" + url + "</a></li></ul>",url);

      % löschen der schon 'behandelten' urls
      % count enthält die Anzahl der gelöschten urls     
      (url_string, count) = delete_saved_url(url_string, url);
      % Anzahl items anpassen
      item_count -= count;
      % aufhören, wenn item_count auf Null
      !if (item_count) return;
   } 
}

definekey("save_url","\eu","article");
