define un_oe_quote ()
{ variable
            htq = 1  % 1: correct quotes by inserting missing quote signs
                     % 0: correct quotes by un-wrapping

 ,rtk, hvr,len, ccs, cregexp = "\\(\n[:|>]+[:|> ]*\\)[^§]\\{60,\\}\n" +
                               "\\([^>|:]\\{1,15\\}\\)\n" +
                               "[>|:]";
 forever
  { rtk = article_as_string;
    if (string_match(rtk,cregexp,2))
     { if(htq) {(hvr,len) = string_match_nth(1); ccs = substr(rtk,hvr+1,len);}
       (hvr,len) = string_match_nth(2);
       if(htq) replace_article(substr(rtk,1,hvr-1)+ccs+substr(rtk,hvr+1,-1));
       else replace_article(substr(rtk,1,hvr-1)+substr(rtk,hvr+1,-1));
     } else break;
} } definekey ("un_oe_quote", "\eq", "article");
