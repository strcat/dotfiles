% -*- mode: slang; mode: fold; -*-  %{{{
% 
% Name:        slrn-lock.sl
% Author:      tsca * Tomek Sienicki * tsca@edb.dk [for slrn-pl]
% More info:   http://www.geocities.com/tsca.geo/slang.html
% Description: The lock functionality -- if there are other instances
%              of slrn running in the system, the variable
%              slrn_lock->locked will be 1, otherwise it will be 0
% Usage:       1. put 'interpret "slrn-lock.sl"' on top of your .slrnrc file
%              2. define startup_hook () { slrn_lock->check_slrn_lock(); }
%              3. you can use the 'slrn_lock->locked' variable in your macros
% Version:     v0.1, Thu, 21 Mar 2002  %}}}
% --------------------------------------------------------------------------- 

 implements ("slrn_lock");

 variable locked = 0, lockfile = "/tmp/slrn_lock.tmp";

 define create_slrn_lock(mypid) % %{{{
  { variable fpc = fopen(lockfile,"w+");
    if(fpc != NULL) { fputs(mypid,fpc); ()=fclose(fpc); }
  } % %}}}

 define check_slrn_lock ()      % %{{{
  
 % start--->[check lock]--->[no lock]--->[create lock & run]<------.
 %               |                                                 |
 %               `--------->[is lock]--->[is old ]--->[del lock]---'
 %                             |
 %                             `-------->[isvalid]--->[cannot run]
  
  { variable fp, fpp, fpp_p="", filepid, mypid = string(getpid());

    fp = fopen(lockfile, "r+");
     
    if (fp == NULL) create_slrn_lock(mypid);
    else 
     { fgets (&filepid,fp);()=fclose (fp);

       fpp = popen("ps -hp "+filepid, "r"); fgets(&fpp_p, fpp); ()=pclose(fpp);

       !if (andelse {strlen(fpp_p)} {filepid == mypid})
        { if (is_substr(fpp_p,"slrn"))
           { message("Dzia³a ju¿ jeden slrn (PID "+filepid+")."); 
             locked = 1; break;
           }
          else create_slrn_lock(mypid);
        }
     }
  } 
% %}}}

 % Delete the lock %{{{
 % The following is of no use, as slrn lacks a quit_hook() ;-)
 % But let it stay here, maybe in the future... 

 % end--->[ can run ]--->[del lock]--->[end]<----.
 %  |                                            |
 %  `---->[can't run]----------------------------'

 define end_slrn_lock () { !if (slrn_lock->locked) remove (lockfile); }

% %}}}

% -- END OF FILE ----------------------------------------------------------
