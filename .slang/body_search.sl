% -------------------------------------------------------------------------
% Search body of articles.
%
% Original script:      Tony Summerfelt <tsummerfelt1@myspleenhome.com>
% Revised (heavily):    Preben "Peppe" Guldberg <c928400@student.dtu.dk>
% Last revised:         Wed 14 Apr 1999
% Original appeared in news.software.readers, message id:
%       <slrn7go2cj.3vvjt5f.tsummerfelt1@co146453-a.kico1.on.wave.home.com>
%
% Note: use with caution when reading online. Especially in group
%       mode you might get to download a lot of messages.

% Tag the current article by number.
% Returns two values:
% - the number of the tag
% - whether the article was already tagged (0 or 1)
define tag_stay_put ()
{
    variable collapsed, tagged;
    tagged = get_header_tag_number ();
    if (tagged)
        return tagged, 1;
    else
    {
        collapsed = is_thread_collapsed ();
        if (header_down (1))
        {
            header_up (1);
            call ("tag_header");
            header_up (1);
        }
        else
            call ("tag_header");
        if (collapsed)
            collapse_thread ();
        return get_header_tag_number (), 0;
    }
}

% Untag an article. This is done by retagging the article (as within slrn).
% It must be specified how many times to toggle:
% - once:   tag is the highest numbered tagged article
% - twice:  not the highest numbered
% Call this function only if you know how many times to tag!
define untag_stay_put (n)
{
    variable collapsed;
    collapsed = is_thread_collapsed ();
    loop (n)
        call ("tag_header");
    if (collapsed)
        collapse_thread ();
}

% Untag another message (number tag1)
define untag_other_message (tag1)
{
    variable tag2, tagged, visible;
    (tag2, tagged) = tag_stay_put ();
    visible = is_article_visible ();
    if (visible)
        call ("hide_article");
    () = goto_num_tagged_header (tag1);
    if (tagged)
    {
        untag_stay_put (1);
        goto_num_tagged_header (tag2);
    }
    else
    {
        untag_stay_put (2);
        goto_num_tagged_header (tag1);
        untag_stay_put (1);
    }
    if (visible)
        call ("hide_article");
}

% Search onwards for an article where the criteria is found in the body.
define body_search (criteria)
{
    variable tag, tagged, visible, flags, n;
    (tag, tagged) = tag_stay_put ();
    visible = is_article_visible ();
    n = 0;
    do
    {
        if ( andelse {n == 0} {is_thread_collapsed ()})
        {
            n = thread_size ();
            uncollapse_thread ();
        }
        flags = get_header_flags ();
        if (re_search_article (criteria))
        {
            !if (tagged)
                untag_other_message (tag);
            return 1;
        }
        set_header_flags (flags);
        if (n == 1)
            collapse_thread ();
        if (n)
            n--;
    }
    while (header_down (1));
    goto_num_tagged_header (tag);
    !if (tagged)
        untag_stay_put (1);
    !if (visible)
        call ("hide_article");
    return 0;
}

% The function calling the search routine. Works in group mode,
% aswell as article mode.
%
% First two global variables for later reference:
    variable _criteria = "";
    variable _last_search = _criteria;
% Should we prompt for the use of metamail (probably not)
    variable _prompt_for_metamail = 0;
%
define query_body_search ()
{
    variable group, old_use_metamail, success;
    _criteria = read_mini ("Search message bodies for", "", _criteria);
    !if (strlen (_criteria))
    {  
        _criteria = _last_search;
        !if (strlen (_criteria))
            return;
    }
    group = current_newsgroup ();
    old_use_metamail = get_variable_value ("use_metamail");
    set_integer_variable ("use_metamail", _prompt_for_metamail);
    success = 0;
    if (is_group_mode ())
    {
        %call ("bob");
        do
        {
            if (select_group () == -1)
                continue;
            success = body_search (_criteria);
            if (success)
                break;
            else
                call ("quit");
        }
        while (group_down_n (1));
        !if (success)
            while (group != current_newsgroup ())
                group_up_n (1);
    }
    else
        success = body_search (_criteria);
    set_integer_variable ("use_metamail", old_use_metamail);
    !if (success)
        error ("No articles matched: " + _criteria);
}
definekey ("query_body_search", "\e/", "group");
definekey ("query_body_search", "\e/", "article");

%   vim: ts=4 sw=4 sts=0 et ai si
