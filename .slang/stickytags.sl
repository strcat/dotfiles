% Sticky tags                                 % -*- mode: slang; mode: fold -*-
% 
% Copyright © 1998-2001 J.B. Nicholson-Owens
% Author: J.B. Nicholson-Owens <jbn@forestfield.org>
% Title: StickyTags.sl
% Version: 1.71
% Last tested on slrn 0.9.7.3 & S-Lang 1.4.4
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  You may
% also download a copy of the applicable license from
% <URL:http://forestfield.org/gpl.txt>.

#iffalse % Documentation                                                %{{{
%This macro set will give you persistent * tags on slrn article headers; if
%you quit article mode or quit slrn, the * tags will be in the right place
%when you next start slrn.  The next time you enter that newsgroup, slrn will
%display the headers with the appropriate tags.  This macro set will not save
%the articles anywhere on your system.  If your server removes the articles
%(through cancellation or expiration, for example) this macro set will not be
%able to mark the articles with an asterisk nor will the tags file be updated.
%
%WARNING: If you routinely run multiple copies of slrn and want this macro
%to work in all the copies, please heed the advice after the installation
%instructions.
%
%To install:
%
%(1) Save a copy of this file (or article) as "stickytags.sl" somewhere so
%    slrn can find it.  Your home directory will do if you don't have a
%    better place for it.
%
%(2) Append the following lines to your slrn.rc ($HOME/.slrnrc on Unix) to
%    make slrn load this file.
%
%       interpret "stickytags.sl"
%
%Now you should be able to start (or restart) slrn and have persistent or
%"sticky" tags which last between entering article mode and across slrn
%sessions.
%
%The default file used to record tag information on Unix is
%"$HOME/.slrn-stickytags".  If you wish to change this, I suggest making a
%new file (call it "my_preferences.sl", put it in your homedir).  Load
%this new file after you load your hooks.  Your hooks should load after
%this macro set.  Your preferences file should have the following line:
%
%    StickyTags->set_preference ("tags file", make_home_filename ("path/file"));
%
%Additional instructions for running multiple slrns at once:
%
%You can use the same StickyTags file for multiple netnews servers but it is
%not recommended you run multiple simultaneous slrn sessions all using the
%same StickyTags file.  This limitation will be alleviated in a future
%version.  As an example, we will make the filenames for the StickyTags
%file unique by appending the news server name to the StickyTags file.
%
%(1) Set your preferences so each slrn you invoke has a unique tags file.  If
%    you don't do this multiple slrns will run with multiple StickyTags macros
%    running, each believing they have exclusive access to the tags file.
%
%    To do this, find the element that makes each slrn invocation unique.  For
%    this example, $NNTPSERVER is that element.  In your preferences, set the
%    file differently:
%
%      variable nntpserver = getenv ("NNTPSERVER");
%      if (nntpserver != NULL)
%      {
%         StickyTags->set_preference ("tags file",
%             make_home_filename (sprintf (".slrn-stickytags-%s", nntpserver)));
%      }
%      else
%      {
%         StickyTags->set_preference ("tags file", make_home_filename (".slrn-stickytags"));
%      }
%
%    This example uses a different tags file for each NNTP server.  If you
%    don't specify an NNTP server, it uses the default
%    "$HOME/.slrn-stickytags".
%
%(2) Quit and restart slrn.
%
%Other preferences (optional settings):
%
%Use StickyTags->set_preference (String_Type preference, setting) to set the
%preferences for this macro set.
%
%* "query catchup cutoff" (default: 30)
%
%    If you try to catchup from group mode using StickyTags->catchup(),
%    StickyTags will prompt you if you are catching up a group with more than
%    'query catchup cutoff' number of articles.  Set to -1 to turn the prompt
%    off and perform the catchup regardless of how many articles there are in
%    the group.  Set to 0 to always prompt.
%
%* "save frequency" (default: 1)
%
%    Normally tags are automatically saved every time they change.  If you
%    would prefer to save the tags only when you want, change this preference
%    to 0.  StickyTags->save_as() can be used at any time to save the tagfile
%    to any file regardless of save_frequency's setting.
%
%* quiet (default: 0)
%
%    Do not show loading and saving messages when loading or saving tags.
%
%* "preserve thread display" (default: 0)
%
%    By default StickyTags will not preserve the thread display when you leave
%    article mode.  This preference changes that.  In versions prior to 1.6
%    StickyTags would preserve the thread display.  That behavior allows you to
%    do things in the article_mode_quit_hook() that depend on preserving the
%    thread display as it was left by the user.  If you set this preference to
%    1 you will make StickyTags execute more slowly; it takes time to carefully
%    uncollapse and recollapse threads as well as do the work StickyTags is
%    made to do.  Leaving this preference at 0 means StickyTags is free to do
%    its work quickly without caring about what the thread display looks like
%    after the job is done.
%
%    If you are setting this preference to 1 in the hopes another macro set
%    will see the thread display the way the user left it be sure to check
%    other macro sets don't disturb that thread display.
%
%In summary, your slrn.rc file should have the following lines in it:
%
%    interpret "stickytags.sl"
%    interpret "my_preferences.sl"
%
%If you set the environment variable STICKYTAGS_FILE to the location of your
%tag file, that will be used instead of the tagsfile preference.  This is
%handy when you want to use a StickyTags file without having to change your
%usual preferences. See your system or shell's documentation for information
%on setting an environment variable.
%
%If you wish you may set a key in your slrn.rc so StickyTags will prompt you
%where to store the tagsfile and adjust the "tags file" preference.  This
%is completely optional--you do not need to do this to make this macro set
%work.
%                     
%    setkey article StickyTags->save_as "S"
%    setkey group   StickyTags->save_as "S"
%
%If you wish to catch up a group from group mode without losing your asterisk
%tags, bind a key to StickyTags->catchup():
%
%    setkey group   StickyTags->catchup "c"
%
%These are only example keybindings.  Feel free to change the key to
%anything you want.  If you bind StickyTags->save_as() to a key the only
%requirement is you place the setkey slrn.rc commands below the interpret
%command (in other words, this macro set has to be loaded before slrn knows
%what StickyTags->save_as refers to).
%
%To remove this macro set:
%
%(1) Comment out or delete the (five, at most) StickyTags lines from your
%    slrn.rc:
%
%      interpret "stickytags.sl"
%      interpret "my_preferences.sl"
%      setkey article StickyTags->save_as "S"
%      setkey group   StickyTags->save_as "S"
%      setkey group   StickyTags->catchup "c"
%
%    You will want to keep my_preferences line in your slrn.rc uncommented if
%    you have other hooks or preferences.  All these setkey lines might not be
%    in your slrn.rc.
%
%(2) Delete the tags file (the default is "$HOME/.slrn-stickytags") and unset
%    the STICKYTAGS_FILE environment variable if you used it.
%
%(3) Quit slrn and restart slrn.  Stickytags will no longer be loaded in your
%    slrn.  The tags file will not be updated as you mark and unmark headers;
%    tags will operate as they did before you installed this macro set.
%
%Major changes:
%1.7: StickyTags now installs itself into slrn's hooks.
%
%     (1.71) StickyTags has a catchup function to catch up articles from group
%     mode without losing one's asterisk tagged articles.  This command
%     necessarily uses your bandwidth to enter article mode.  If you pay for
%     your connection by the byte, you might not want to use this feature
%     at all.
%
%1.6: StickyTags now does not maintain thread display by default.
%     Documentation updated and "preserve thread display" preference added.
%     Thanks to Thomas Schultz <tststs@gmx.de>.
%
%1.5: StickyTags->save_as changed so it also saves currently listed tags from
%     article mode, not just the tags entered into the list by quitting to
%     group mode.  The list is edited to include (or remove) tags added (or
%     marked read) in the current group.
%
%     Corrected a small documentation error.
%
%1.4: # tagging was removed because it worked so poorly (without a way to not
%     numerically tag articles out of order and leave gaps, this doesn't work
%     as well as I'd hoped.  Tagging in crossposts removed because people that
%     wrote me said they found it counterintuitive.
%
%     (1.4.1) Minor bugfixing of prefs["tags file"].
%             Minor fixing of prefs["save_frequency"].
%             Reloading works for preferences.
%             Documentation adjustments.
%     (1.4.2) Bug with untagging fixed.  Thomas Schultz pointed this out to me.
%             Slight simplification of when to tag/untag in article_mode_quit_hook().
%             Copyright date adjustment.  John Gregory pointed this out to me.
%             Added GPL boilerplate intro text.
%             Added example of setting key for StickyTags->save_as().
%             Added uninstall documentation for setting StickyTags->save_as() key.
#endif %}}}

implements ("StickyTags");

private variable
   list = Assoc_Type [Null_Type],
   list_has_changed = 0,                         % Boolean
   prefs = Assoc_Type [Any_Type, NULL];

if (prefs["tags file"] == NULL) prefs["tags file"] = make_home_filename (".slrn-stickytags");
if (prefs["save frequency"] == NULL) prefs["save frequency"] = 1;
if (prefs["quiet"] == NULL) prefs["quiet"] = 0;
if (prefs["preserve thread display"] == NULL) prefs["preserve thread display"] = 0;
if (prefs["query catchup cutoff"] == NULL) prefs["query catchup cutoff"] = 30;

private define load (file)                                              %{{{
{
   variable fp = fopen (file, "r");
   if (fp == NULL) return ();

   !if (prefs["quiet"]) vmessage ("loading %s...", file);

   % file format: one msgid per line.  simple since we're only supporting *
   % tags now.

   variable msgid, ntags = 0;
   foreach (fp) using ("line") {
      msgid = strtrim ( () );

      if (string_match (msgid, "^%", 1)) continue;
      !if (string_match (msgid, "^\\(<[^>]+>\\)", 1)) continue;

      list[msgid] = NULL;
      ntags++;
   }

   () = fclose (fp);
   if (orelse { ntags == 0 } { prefs["quiet"] }) return ();

   variable s = "s";
   if (ntags == 1) s = "";
   vmessage ("loading %s...done (%i tag%s loaded)\n", file, ntags, s);
}

%}}}
private define save (file)                                              %{{{
{
   !if (list_has_changed) return ();

   variable fp = fopen (file, "w");
   if (fp == NULL) return ();
   !if (prefs["quiet"]) vmessage ("saving %s...", file);

   ERROR_BLOCK
     if (fclose (fp) == -1)
       error ("Can\'t close %s: %s", file, errno_string (errno));

   variable msgid;
   foreach (list) using ("keys")
     {
        msgid = ();

        if (-1 == fputs (msgid + "\n", fp))
          verror ("Couldn\'t write to %s: %s", file, errno_string (errno));
     }

   EXECUTE_ERROR_BLOCK;
   list_has_changed = 0;                         % mark the list as clean
   !if (prefs["quiet"]) vmessage ("saving %s...done", file);
}

%}}}
private define update_list ()                                           %{{{
{
   % Record which articles are *-tagged.  Update the list.

   variable
     starting_article = extract_article_header ("Message-ID"),
     message_ID, header_flags, thread_was_collapsed, t, t_size,
     header_is_tagged, header_is_read, header_is_in_list;

   if (prefs["preserve thread display"])
     {
        uncollapse_threads ();
        call ("header_bob");
        do
          {
             message_ID = extract_article_header ("Message-ID");
             header_flags = get_header_flags ();
             header_is_tagged = header_flags & HEADER_TAGGED;
             header_is_read = header_flags & HEADER_READ;

             % Since we're seeing every article in the list anyhow,
             % why not simplify here.  Only unread+tagged articles
             % are stored in the list.  All other articles in the
             % header list are taken out of the StickyTags list.

             if (andelse { header_is_read == 0 } { header_is_tagged })
               {
                  list[message_ID] = NULL;
                  list_has_changed = 1;
               }
             else if (assoc_key_exists (list, message_ID))
               {
                  assoc_delete_key (list, message_ID);
                  list_has_changed = 1;
               }
          }
        while (header_down (1));
     }
   else
     {
        call ("header_bob");
        do
          {
             t_size = thread_size ();
             thread_was_collapsed = is_thread_collapsed ();
             uncollapse_thread ();
             
             for (t = 1; t <= t_size; t++)
               {
                  message_ID = extract_article_header ("Message-ID");
                  header_flags = get_header_flags ();
                  header_is_tagged = header_flags & HEADER_TAGGED;
                  header_is_read = header_flags & HEADER_READ;
                  
                  % Since we're seeing every article in the list anyhow,
                  % why not simplify here.  Only unread+tagged articles
                  % are stored in the list.  All other articles in the
                  % header list are taken out of the StickyTags list.
                  
                  if (andelse { header_is_read == 0 } { header_is_tagged })
                    {
                       list[message_ID] = NULL;
                       list_has_changed = 1;
                    }
                  else if (assoc_key_exists (list, message_ID))
                    {
                       assoc_delete_key (list, message_ID);
                       list_has_changed = 1;
                    }
                  
                  if (t != t_size) () = header_down (1);
               }
             
             if (thread_was_collapsed) collapse_thread ();
          }
        while (header_down (1));
     }

   () = locate_header_by_msgid (starting_article, 0);
}

%}}}

static define set_preference (preference, value)                        %{{{
{
   preference = string (preference);
   !if (assoc_key_exists (prefs, preference))
     error ("Preference does not exist: " + preference);
   variable desired_type = typeof (prefs[preference]);
   if (typeof (value) != desired_type)
     verror ("Wrong type for %s: This preference wants %S not %S",
             preference, desired_type, typeof (value));

   prefs[preference] = value;
}

%}}}
static define startup_hook ()                                           %{{{
{
   variable env = getenv ("STICKYTAGS_FILE");
   if (env != NULL) prefs["tags file"] = env;

   load (prefs["tags file"]);
}
!if (register_hook ("startup_hook", "StickyTags->startup_hook"))
  message ("StickyTags: Warning: Could not register for startup_hook()!");

%}}}
static define article_mode_hook ()                                      %{{{
{
   % apply the tags to the articles.

   if (is_group_mode ())
     verror ("StickyTags->%s only works in article mode!", _function_name ());

   variable starting_article = extract_article_header ("Message-ID");

   !if (length (assoc_get_keys (list))) return ();

   variable msgid;
   foreach (list) using ("keys")
     {
        msgid = ();
        !if (locate_header_by_msgid (msgid, 0)) continue;
        set_header_flags (get_header_flags () | HEADER_TAGGED);
     }

   () = locate_header_by_msgid (starting_article, 0);
}
!if (register_hook ("article_mode_hook", "StickyTags->article_mode_hook"))
  message ("StickyTags: Warning: Could not register for article_mode_hook()!");

%}}}
static define article_mode_quit_hook ()                                 %{{{
{
   update_list ();
   if (prefs["save frequency"]) save (prefs["tags file"]);
}
!if (register_hook ("article_mode_quit_hook", "StickyTags->article_mode_quit_hook"))
  message ("StickyTags: Warning: Could not register for article_mode_quit_hook()!");

%}}}
static define save_as ()                                                %{{{
{
   variable file = read_mini ("Save tagfile as", prefs["tags file"], "");
   update_list ();
   list_has_changed = 1;                         % mark the list as dirty
   save (file);
}

%}}}
static define catchup ()                                                %{{{
{
   !if (is_group_mode ())
     {
        call ("catchup_all");
        return ();
     }

   variable
     unread_articles = group_unread (),
     cutoff = prefs["query catchup cutoff"];

   if (andelse
         { cutoff != -1 }
         { unread_articles > cutoff })
     {
        variable num_articles = read_mini_integer ("How many articles to mark read: ", cutoff);
        if (orelse { num_articles < 1 } { num_articles > unread_articles }) return ();
        variable prefix_argument = get_prefix_arg ();
        ERROR_BLOCK
          {
             _clear_error ();
             if (prefix_argument !=-1) set_prefix_argument (prefix_argument);
             error ("StickyTags->catchup(): Error: Could not catch up group from group mode.");
          }
        set_prefix_argument (1);
        set_input_string (string (num_articles));
        call ("select_group");
     }

   if (is_group_mode ()) call ("catchup");
   else call ("catchup_all");
   !if (is_group_mode ()) call ("quit");
   if (prefix_argument !=-1) set_prefix_argument (prefix_argument);
}

%}}}
static define version ()                                     { return (1.71); }
