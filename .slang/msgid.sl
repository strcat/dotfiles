% -*- mode: slang; mode: fold; -*- %{{{
% 
% This macro searches the article for msg-id's and presents them 
% in the menu form (just as it is with URL's).
% by tsca@mailserver.dk
% see more @ http://www.geocities.com/tsca.geo/slang.html %}}}

 define msgid_menu ()
{
 variable fnd="",hvr,len,mid,m="",reg="<[^/ @]*@[^ @]*>",list,dl,i;

 call("art_bob"); while (re_search_article(reg))
  { fnd = (); ()=string_match(fnd,reg,1); (hvr,len)=string_match_nth(0);
    substr(fnd,hvr+1,len); fnd = ();
    if (string_match(fnd,"news:",1)) {fnd="<"+substr(fnd,7,-1);} m=m+fnd+",";
  }

 list = strchop (m,',',0); dl = length(list)-1;
 !if (dl) {error("No msgid's found.");}
 "Which one?"; for (i=0; i<dl; i++) {list[i];} dl; 0; mid = select_list_box();
 locate_header_by_msgid(mid,1);
}
 definekey("msgid_menu","M","article");

% -- EOT ------------------------------------------------------------------
