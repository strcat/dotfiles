% A couple of macros i've found in http://groups.google.com 
% or written by myself ;-)


% simular to 'o' but it will save a article without all (X-)Header
define save_without_header()
{
	variable datei;
	datei = read_mini ("Speichern unter: ", "saved_article", "");
	pipe_article ("sed -e '1,/^$/d' > "+datei);
	message (datei+" wurde gespeichert");
}
definekey ("save_without_header", ")", "article");

% View my posts with Mutt (<http://www.mutt.org/>)
define view_my_posts() { () = system ("neomutt -f /home/dope/nslrn/Posts"); }
define view_my_res() { () = system ("neomutt -f /home/dope/nslrn/Posts"); } 
definekey ("view_my_posts", "^T", "article");
definekey ("view_my_posts", "^T", "group");

% msg_id search macro for google modified from:
% de_spy v0.5 [by Tomasz 'tsca' Sienicki, <tsca@edb.dk>      ]
%             [<http://www.geocities.com/tsca.geo/slang.html>]
% Modified by Keith Wyatt n6jpa_spam@attbi.com 
%--------------------------------------------------
% define msg_id ()
% {
%    variable whois = extract_article_header ("Message-ID"),
%    re,wann,hvr,lan,nm_,ae_,browser=get_variable_value("Xbrowser");
%      
%    wann = string_match(whois,"\\C\\(\\<[\%-_0-9a-z.\$]*@[^.][\%-_0-9a-z\$.]*\\>\\)",1);
%    if(wann) {(hvr,lan)=string_match_nth(1); ae_ = substr (whois, hvr+1, lan);}
%    else error ("No MSG-ID address has been found");
% 
%    ae_ = read_mini (sprintf(" C-g cancels Search Google for %s?",ae_),"",ae_);
%    ae_=sprintf("http://groups.google.com/groups?as_umsgid=%s",ae_);
%    if (browser == "") 
%      { re=get_yes_no_cancel ("No browser defined! Try lynx?");
%           !if (re == 1) 
%           { message ("\"de_spy\" terminated: No browser available."); break; }
%         browser = "lynx \"%s\"";
%      }
%    system (sprintf (browser,ae_));
% }
%    definekey ("msg_id", "\em", "article");
% 
%-------------------------------------------------- 
