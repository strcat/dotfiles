% -*- mode: slang; mode: fold; -*-
%
%  NINIEJSZY PLIK ZAWIERA FUNKCJE WYKORZYSTYWANE W INNYCH MAKRACH slrn-pl
%          -- ZAWSZE £ADUJ GO JAKO PIERWSZY, PRZED INNYMI! --
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#ifn$slrn_pl_sl
putenv("slrn_pl_sl=1");


 implements ("slpl");  % slrn-pl macro library

% Funkcja conloc %{{{
% Zwraca prawdê, je¶li warto¶æ którejkolwiek ze zmiennych LANG, LC_ALL,
% LC_MESSAGES w systemie rozpoczyna siê ci±giem "pref"

 define conloc (pref) %{{{
  {
     variable tmp1 = "", tmp2;

     foreach(["LC_ALL","LC_MESSAGES","LANG"])
      {
         tmp1 += ","; tmp2 = ();
         if (getenv(tmp2) != NULL) tmp1 += getenv(tmp2);
      }

     if (is_substr (tmp1, "," + pref)) return 1; else return 0;
  } %}}}

 variable loc = 0;

%if (conloc("de")) loc = 2; % 2: niemiecki
 if (conloc("pl")) loc = 1; % 1: polski

%}}}

% Funkcja i18n_reshape %{{{
% Pierwszy argument: tablica komunikatów, Drugi argument: liczba jêzyków
 define i18n_reshape(msgs, nlang)
  {
     reshape (msgs, [length(msgs) / nlang, nlang]);
     return msgs;
  }
%}}}

% komunikaty wykorzystywane przy rejestracji hookow %{{{
 variable hook_info =  [  "Unable to register hook in the following file:",
                          "Problem z rejestracj± hooka w nastêpuj±cym pliku:"
                       ];
%}}}

% Funkcja check_make_dir sprawdza, czy katalog istnieje, je¶li nie, tworzy go.
% Pierwszy argument (String) to sciezka/katalog do utworzenia[/sprawdzenia.]
% Drugi argument (String) to nazwa jednostki[/makra] wywo³uj±cej funkcjê. %{{{

 define check_make_dir (cmdir, makro)
  {
    variable st = stat_file (cmdir),
      komunikat = [ "%s: Cannot create directory '%s'!",
                    "%s: Nie mo¿na utworzyæ katalogu '%s'!",
                    "%s: '%s' is not a directory!",
                    "%s: '%s' nie jest katalogiem!" ];
    komunikat = i18n_reshape (komunikat, 2);

    if (st == NULL)
     { 
        if (mkdir (cmdir, 0700) != 0)
        vmessage (komunikat[0, loc], makro, cmdir);
     }
    else !if (stat_is ("dir", st.st_mode))
     vmessage (komunikat[1, loc], makro, cmdir);
  }
%}}}

#endif

% $Id: slrn-pl.sl,v 1.6 2002/05/04 18:30:35 tsca Exp $
