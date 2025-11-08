% -*- mode: slang; mode: fold -*-
%
% identity.sl - a macro for assuming various identities on a per-newsgroup
%               basis.
%
% Copyright (C) 2000-2002 Emmanuele Bassi <emmanuele.bassi@iol.it>
%
% This file may be redistributed and / or modified under the terms of the
% GNU General Public License, version 2, as published by the Free Software
% Foundation.
%
% Version: 2.2.0 - Tue, 16 Apr 2002 13:58:32 +0200

#iffalse % Documentation %{{{
Description:

This macro allows the user to assign variable values, concerning his/hers
identity, on a per-newsgroup basis: that is, to change some of the displayed
informations depending on which newsgroup he/she is posting on a determined
moment.

Installation and Usage:

Make SLRN interpret this macro, with the usual line:
  
  interpret "identity.sl"

put inside your slrn-rc file.
Then, inside another file, that will be interpreted *after* identity.sl, put
a line like this:

  identity->add_new ("id", "newsgroup");

Where "id" it's a mnemonic id representing the identity and "newsgroup"
represents the newsgroup (or a regular expression matching more than one
group) on which you want the Identity to be used in. This procedure
creates a new Identity with the default values, taken from SLRN's
resource file.

To modify the details of your identity, you have five wrappers to the
(private) modify() function:

identity->set_from ("id", "username", "hostname");
identity->set_real ("id", "realname");
identity->set_replyto ("id", "reply-to");
identity->set_signature ("id", "/path/to/.signature");
identity->set_regexp ("id", "regular_expression");

Each of these wrappers will modify a previously created identity, pointed by
the "id" string.

Note 1: in the set_signature() procedure, you'll have to specify the entire path
to the signature file; otherwise, SLRN will search the file in the current
directory.

Note 2: the set_regexp() changes the regular expression for the identity: don't
use it, unless you know what you are doing.

  Viewing your identity:

To view the Identity you are using on a group, use the "ESC I" escape sequence.

History:
v2.2.0	identities are now indexed by an id (thanks to J.B. Nicholson-Owens);
v2.1.1	where possible, s/"error (sprintf"/verror;
v2.1.0	some clean-ups; remove the nested foreach() in modify();
v2.0.0	added `hostname' and `username' to the list of mutable variables;
        added the set_*() wrappers to the create() and modify() methods;
v1.1.0  added regexp matching for identities spanning more than one group;
v1.0.0	initial release;

#endif %}}}

implements ("identity");

% Main identities variable %{{{
private variable
  Identity = Assoc_Type [];
%}}}

% Default values %{{{
private variable
  username_dfl  = get_variable_value ("username"),
  hostname_dfl  = get_variable_value ("hostname"),
  realname_dfl  = get_variable_value ("realname"),
  replyto_dfl   = get_variable_value ("replyto"),
  signature_dfl = get_variable_value ("signature");
%}}}

private define create (id) %{{{
{
  if (0 == strlen (id))
    return;

  % Sanity check.
  if (assoc_key_exists (Identity, id))
    {
      verror ("Identity: id %s already exists.", id);
      return;
    }
  
  % Add a new hash.
  Identity[id] = Assoc_Type [];
  
  % Save identity.
  Identity[id]["regx"] = "*";
  Identity[id]["user"] = username_dfl;
  Identity[id]["host"] = hostname_dfl;
  Identity[id]["real"] = realname_dfl;
  Identity[id]["r_to"] = replyto_dfl;
  Identity[id]["sign"] = signature_dfl;
  
} %}}}

private define modify (id, key, value) %{{{
{
  if ((0 == strlen (id))
      or (0 == strlen (key))
      or (0 == strlen (value)))
    return;

  if (assoc_key_exists (Identity, id))
    if (assoc_key_exists (Identity[id], key)) 
      Identity[id][key] = value;
    else
      verror ("Identity: key %s does not exists in %s", key, id);
  else
    verror ("Identity: an identity \`%s\' does not exists", id);

} %}}}

% Wrappers {{{
static define add_new (id, news_re) %{{{
{
  if ((0 == strlen (id))
      or (0 == strlen (news_re)))
    return;

  create (id);
  modify (id, "regx", news_re);
} %}}}

static define set_regexp (id, news_re) %{{{
{
  if (0 == strlen (id))
    return;

  modify (id, "regx", news_re);
} %}}}

static define set_from (id, username, hostname) %{{{
{
  if (0 == strlen (id))
    return;

  modify (id, "user", username);
  modify (id, "host", hostname);
  
} %}}}

static define set_signature (id, signature) %{{{
{
  if (0 == strlen (id))
    return;

  modify (id, "sign", signature);

} %}}}

static define set_real (id, realname) %{{{
{
  if (0 == strlen (id))
    return;

  modify (id, "real", realname);

} %}}}

static define set_replyto (id, reply_to) %{{{
{
  if (0 == strlen (id))
    return;

  modify (id, "r_to", reply_to);

} %}}}
% End wrappers }}}

static define assign () %{{{
{
  variable newsgroup = current_newsgroup ();

  if (0 == strlen (newsgroup))
    return;
  
  % Default Assigment.
  set_string_variable ("username", username_dfl);
  set_string_variable ("hostname", hostname_dfl);
  set_string_variable ("realname", realname_dfl);
  set_string_variable ("replyto",  replyto_dfl);
  set_string_variable ("signature", signature_dfl);

  foreach (Identity) using ("keys")
    {
      variable id = ();

      if (0 != string_match (newsgroup, Identity[id]["regx"], 1))
	{
	  % Use Identity values.
	  set_string_variable ("username",  Identity[id]["user"]);
	  set_string_variable ("hostname",  Identity[id]["host"]);
          set_string_variable ("signature", Identity[id]["sign"]);
	  set_string_variable ("realname",  Identity[id]["real"]);
	  set_string_variable ("replyto",   Identity[id]["r_to"]);
	  return;
	}
    }
} %}}}

static define view () %{{{
{
  variable id;
  
  if (is_group_mode)
    error (_function_name () + "does\'t work in group mode");
    
  id = sprintf ("Real Name: %s\nFrom: <%s@%s>\nReply-To: %s\nSignature: %s\n",
		get_variable_value ("realname"),
		get_variable_value ("username"), get_variable_value ("hostname"),
		get_variable_value ("replyto"),
		get_variable_value ("signature"));
    
  popup_window ("Identity", id);
} %}}}

% Default key assignment %{{{
definekey ("identity->view", "\eI", "article");
%}}}

% Register hook %{{{
register_hook ("article_mode_hook", "identity->assign");
%}}}
