define ignore_subthread ()
{
   if (is_group_mode ())
     error (_function_name () + " doesn't work in group mode!");

   variable p_handle, datestring;
   p_handle = popen("date --date '21 days' '+%m/%d/%Y'","r");
   () = fgets(&datestring, p_handle);
   () = pclose(p_handle);

   set_input_string (strcat("-9998\n",datestring));
   set_input_chars ("rty");
   call ("create_score");
}

define auto_kill_fups ()
{
   if (is_group_mode ())
     error (_function_name () + " doesn't work in group mode!");
   
   uncollapse_threads;
   call ("header_bob");
   
   variable mid;
   variable hdr = "extract_article_header(\"From\")";
%   variable trace_file = "/home/themel/slang-log" ;
   variable trace_file = "/dev/null" ; 
   variable of = fopen(trace_file, "w") ; 

   
   % Real name filter - fscking double escape :)
   variable expression = "(string_match("+hdr+
     ",\"[^ ]+ +[^ ]+ +<.+@.+>\",1) == 0) and (string_match("+hdr+
     ",\"peter\\.bergt\",1) == 0) and (string_match("+hdr+
     ",\".+@.+ +([^ ]+ [^ ]+.+)\", 1) == 0)";
   
   do
     {
        if (eval(expression))
          {
             mid = extract_article_header("Message-Id");
             () = fputs("MID " + mid + " is fake (" + extract_article_header("From") + "), killing + FUp's", of) ;   
             mid = str_quote_string(mid, "\\^$[]*.+?", '\\');
             set_header_flags(get_header_flags() | HEADER_READ);
             ignore_subthread();
          }     
     } while (header_down(1));
   
   call ("header_bob");
   collapse_threads;
}

define article_mode_hook ()
{
	auto_kill_fups () ;
}
