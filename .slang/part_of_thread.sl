% wie kann ich mit slrn's Makrosprache erkennen ob die aktuelle
% Nachricht Teil eines Threads ist?

%v+
define is_part_of_thread ()
{
   if (thread_size() > 1)
        return 1;
   variable start = extract_article_header ("Message-ID");
   variable result = 0;
   collapse_thread();
   if (thread_size() > 1)
        result = 1;
   () = locate_header_by_msgid (start, 0);
   return result;
}
%v-
			       
