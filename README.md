# mb2md
Summary: Export mbox mail format to maildir format for messages stored within Mozilla Thunderbird.

This work is in __public domain__ (as the original and subsequent authors intended), following [https://unlicense.org/].

## History of Credits & Acknowledgments
 * Orginal Author: Robin Whittle
 * Last Known Maintainer: Juri Haberland <juri@koschikode.com>
 * This script's web abode is [http://batleth.sapienti-sat.org/projects/mb2md/].
 * For a changelog (of previous versions) see [http://batleth.sapienti-sat.org/projects/mb2md/changelog.txt].

### More History
The Mbox -> Maildir inner loop is based on  qmail's script mbox2maildir, which
was kludged by Ivan Kohler in 1997 from convertandcreate (public domain)
by Russel Nelson.  Both these convert a single mailspool file. The qmail distribution has a maildir2mbox.c program.

## Details
 * Almost everything here: [http://batleth.sapienti-sat.org/projects/mb2md/] is still valid.
 * Please see the link above on all usage, except for the __-T__ flag, which is to be used if you are using this forked script for converting Thunderbird's mbox like files.
 * Note that Thunderbird's mbox like files _DO NOT_ have a __.mbx__ extension.
 * This fork deals with a specific case to convert Thunderbird's mbox like files, which seem to diverge a bit in how the "From" line is written in there. Specifically, the "From" separator line does not have any sender email address, or a date.
