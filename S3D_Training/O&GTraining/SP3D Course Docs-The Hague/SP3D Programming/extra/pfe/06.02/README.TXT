                    Programmer's File Editor 0.06.002
                    ---------------------------------
                             (17 October 1995)

Welcome to Programmer's File Editor. This file is the place to start looking at
the program: if you've not seen PFE before there's a synopsis of its main
features; and if you've used earlier versions there's some essential
information on major changes.

Below you'll find

	1. ABSTRACT
		A brief list of PFE's main features
	2. USING AND DISTRIBUTING PFE
		The terms on which you can use it and pass it on
	3. CONTACTING THE AUTHOR
		How to pass on your criticisms, suggestions, bug reports
		and maybe even praise
	4. WHERE TO GET PFE
		Places to look for PFE on the Internet and elsewhere
	5. WHICH VERSION SHOULD YOU USE?
		How to pick the most appropriate version
	6. UPGRADING FROM 0.06.001
		Important information if you're currently using the release
		immediately prior to this one
	7. UPGRADING FROM 0.05.007 AND EARLIER
		Important information if you're currently using a very old
		release of PFE
	8. OTHER FILES YOU SHOULD LOOK AT
		The other important text files in this release
	9. THE FILES YOU SHOULD GET
		What should be in your distribution set
	10. INSTALLING PFE
		How to install everything

---

Alan Phillips     ( A.Phillips@lancaster.ac.uk )


-------------------------------------------------------------------------------


1. ABSTRACT
-----------

This is the 0.06.002 release of Programmer's File Editor, a large-capacity
multi-file programming oriented editor for Windows 95, Windows NT 3.51 on Intel
and PowerPC platforms, and Windows 3.1x

PFE includes the following features:

- The size of file it can handle is limited only by the total amount of
  virtual memory available
- No arbitrary limit on the number of lines a file can contain
- It can edit multiple files, the number being limited only by the
  available system resources
- Accepts files dropped from File Manager or other drag-drop server
- Allows multiple edit windows showing the same file
- Multi-level undo facility
- Can read and write files in UNIX format using LF as line terminator, with
  automatic format detection
- Can run multiple instances if desired
- Backup copies can be maintained of existing files when saving
- Most-recently-used list of files allows easy selection between sessions
- Line numbers can be shown in any edit window if required
- Any installed fixed-pitch screen font, including TrueType, can be used in
  edit windows
- The most frequent operations can be performed from active buttons on a 
  tear-off toolbar
- Active status bar reports settings and allows easy alteration of common ones
- Text can be copied and moved by dragging and dropping
- Tabs can be inserted as TAB characters or spaces
- DOS commands, such as compilers, can be run with the output captured
  in an edit window
- An application being developed can be quickly launched from a configurable
  dialog
- Commonly-used text can be inserted in a simple operation from template
  libraries
- Fully-remappable keyboard, including two-key operation similar to MicroEMACS
  and mapping of Alt keys to functions
- Multiple sets of key mappings can be stored, and selected as required from
  a dialog or from the command line
- Keystrokes and menu commands can be recorded in a replayable keyboard macro
- Commonly-used program development tools can be configured into a list
  and started simply from a dialog
- Files can be printed either in total, by line range, or selected text only
- Automatic line indenting and removal of trailing spaces
- Automatic configuration of edit options depending on file type
- Automatic configuration of tab sizes depending on file type
- Automatic brace alignment when editing C source
- Text indent/undent operations
- Optional automatic text wrapping at configurable margin
- Can mail files to MAPI-compliant mailers like Microsoft Mail
- User-configurable help menu
- Comprehensive help file with help buttons on all dialogs and F1 help
  available for system messages
- Mouse help available on screen and menu items
- Double click on right button starts help engine for help on keywords
  in edit windows
- Allows Windows to be closed down and the system rebooted from the system menu
- Uses standard MDI methods to be fully compatible with other Windows apps
- All operations are TWI compliant
- Windows can be tiled vertically to maximize width
- Window text, window background, workspace, toolbar and status bar colours
  fully configurable

Additionally, the editor can be controlled by another application across a
DDE client-server link.


2. USING AND DISTRIBUTING PFE
-----------------------------

PFE may be used in any way, for any purpose, at no cost. In may be distributed
by any means, provided that the original files as supplied by the author remain
intact and no charge is made other than for reasonable distribution costs.

You do not need to register to use PFE, or buy a licence.

PFE may be placed on any archive or BBS system

PFE may not be distributed as a component of any commercial product without a
prior license agreement with the author



3. CONTACTING THE AUTHOR
------------------------

I would very much appreciate hearing from you if you use PFE and find problems,
or if you can think of ways it could be improved - and even (or is that
'especially'?) if you just think it's great. Even if the facility you would
like to see appears to be of interest only to you, tell me about it - you'd be
surprised how many ideas in that class have a much wider appeal.

You can contact me by e-mail at

                    A.Phillips@lancaster.ac.uk

I will try to reply to all the mail I receive, but it may take a week or so if
I'm very busy.

Please DON'T mail me on CompuServe - you may find an account there with my name
on it, but it's owned by my employers and I don't visit it often. I don't
respond to mail I find there not related to work, sorry. If YOU are on
CompuServe it's easy to mail me on the Internet - just address the mail to

                 >internet:A.Phillips@lancaster.ac.uk

However, this may cost you a little more than mail to other CompuServe users


4. WHERE TO GET PFE
-------------------

PFE is distributed in three ZIP files. The names they have when they
leave me are

   pfe0602i.zip      The 32-bit edition for Windows 95 and Windows NT 3.51
                       on Intel platforms
   pfe0602p.zip      The 32-bit edition for Windows NT 3.51 on PowerPC
                       platforms
   pfe0602.zip       The 16-bit edition for Windows 3.1x

The definitive source for new releases is the PFE Home Page on the World Wide
Web; the URL is

                http://www.lancs.ac.uk/people/cpaap/pfe/

The home page also contains a list of archives where the latest version of
PFE is known to be held


5. WHICH VERSION SHOULD YOU USE?
-------------------------------

The Windows 95, Windows NT and Windows 3.1x operating systems allow you a lot of
flexibility in what versions of programs you can run. However, PFE works best
in certain combinations, as listed below:


System		Edition		Comments
------		-------		--------

Windows 95	16-bit 		NOT RECOMMENDED
(4.00.950)			You will not be able to run commands and
				capture output, or use long file names.
		32-bit Intel	RECOMMENDED
				All facilities are available
		32-bit PowerPC	WILL NOT RUN

Windows 3.1x	16-bit		RECOMMENDED
				All facilities are available
		32-bit Intel	NOT RECOMMENDED
				You will not be able to run commands and
				capture output
		32-bit PowerPC	WILL NOT RUN

Windows NT 3.1	16-bit 		NOT RECOMMENDED
(Intel)				You will not be able to run commands and
				capture output
		32-bit Intel	WILL NOT RUN
		32-bit PowerPC	WILL NOT RUN

Windows NT 3.5	16-bit 		NOT RECOMMENDED
(Intel)				You will not be able to run commands and
				capture output
		32-bit Intel	WILL NOT RUN
		32-bit PowerPC	WILL NOT RUN

Windows NT 3.5	16-bit 		WILL NOT RUN
(PowerPC)	32-bit Intel	WILL NOT RUN
		32-bit PowerPC	WILL NOT RUN

Windows NT 3.51	16-bit		NOT RECOMMENDED
(Intel)				You will not be able to run commands and
				capture output
		32-bit Intel	RECOMMENDED
				All facilities are available
		32-bit PowerPC	WILL NOT RUN

Windows NT 3.51	16-bit 		WILL NOT RUN
(PowerPC)	32-bit Intel	WILL NOT RUN
		32-bit PowerPC	RECOMMENDED
				All facilities are available



6. UPGRADING FROM 0.06.001
--------------------------

The immediately preceding release of PFE was 0.06.001. You don't need to change
anything if you've been using this release; all files and configuration details
are compatible.


7. UPGRADING FROM 0.05.007 AND EARLIER
--------------------------------------

If you're currently using PFE version 0.05.007, you'll find that your keymap
(.key) files and template (.tpl) files will continue to work with this release.
Keymap files produced with earlier releases than 0.05.007 won't be recognised.

In this new release have been many changes to the initialisation file (pfe.ini
or pfe32.ini depending on the edition you use).

The first major change is that you no longer ever need to edit it to change
options. Now there's an Options Preferences command that does it all - and
you'll find that there are lots more options to choose from too.

The second major change involves the filters you define for the file open
dialogs. Your existing ones will not be recognised, so please use Options
Preferences to redefine them.

Thirdly, the way the various Windows "managers" (like File Manager and
Print Manager) are handled from the Execute menu has changed, allowing you
to start a full command line with arguments. Your existing definitions will
not be used; again, please use Options Preferences to set up what you want.

Finally, the system of associating file and window modes with file extensions
has been completely redesigned. The modes you can set now include window and
text colours; and instead of mapping a single extension to a set of modes, you
now build "mode groups" containing wildcarded filename patterns, each of which
has a set of modes associated with it. Again your old mode settings won't be
recognised, so you'll need to use Options Preferences to use the new system.

If you wish, you can remove the [fileopen-filters], [modes] and [managers]
sections from your initialisation file.

One other change to note is that the default extension used for making backup
files has changed from ".&&&" to ".$$$". You can also customise it with the
Options Preferences command



8. OTHER FILES YOU SHOULD LOOK AT
---------------------------------

The distribution set contains several other text files of important
information.

For the answers to some of the common questions that users have, see FAQ.TXT.
Looking in here can save you a lot of worry and experimentation, and save you
from posting your question to newsgroups and mailing lists.

The CHANGES.TXT file tells you what's changed from earlier releases. If you
find something unexpected going on, look in here too - it could be a feature
rather than a bug.

The PROBLEMS.TXT file tells you about any major problems that were discovered
too late to be addressed in this release, and what you can do if you hit them.



9. THE FILES YOU SHOULD GET
---------------------------

There are a small number of files in the PFE distribution. You should find the
following items:

32-bit Intel Edition:

	[For Windows 95, and Windows NT 3.51 on Intel platforms]

	pfe32.exe		The editor itself
	pfe32.dbg		Debugging symbols
	pfe.hlp			The help file
	pfedos32.exe		A helper module, needed to run commands and
				capture output
	readme.txt		This file
	changes.txt		Changes from previous releases
	faq.txt			Frequently Asked Questions
	problems.txt		Information on late-breaking problems

32-bit PowerPC Edition:

	[For Windows NT 3.51 on PowerPC platforms]

	pfe32.exe		The editor itself
	pfe.hlp			The help file
	pfedos32.exe		A helper module, needed to run commands and
				capture output
	readme.txt		This file
	changes.txt		Changes from previous releases
	faq.txt			Frequently Asked Questions
	problems.txt		Information on late-breaking problems

16-bit Edition:

	[For Windows 3.1x]

	pfe.exe			The editor itself
        pfe.sym                 Debugging symbols
	pfe.hlp			The help file
	pfedos.exe		A helper module, needed to run commands and
				capture output
	pfedos.pif		The PIF file for this module
	readme.txt		This file
	changes.txt		Changes from previous releases
	faq.txt			Frequently Asked Questions
	problems.txt		Information on late-breaking problems

The help file pfe.hlp is identical for the 16-bit and 32-bit editions.



10. INSTALLING PFE
------------------

There is no setup program for PFE, as it doesn't really need one. Installation
is done by simply copying the supplied files:

32-bit Edition:

 Copy pfe32.exe, pfe.hlp, pfedos32.exe to a suitable directory. This need not
 be on your path; but it's important that all the files are in the _same_
 directory. If you have the Intel version you might like to copy pfe32.dbg into
 this directory also; in the event of a program fault your Dr Watson logs will
 contain a symbolic trace, which will make problem diagnosis easier if you're
 able to mail the details to me.

16-bit Edition:

 Copy pfe.exe, pfe.hlp, pfedos.exe and pfedos.pif to a suitable directory.
 This need not be on your path; but it's important that all the files are
 in the _same_ directory. You might also like to copy the pfe.sym file; this
 gives symbolic information in any Dr Watson logs you get, which make diagnosis
 easier for me.


It's a good idea to keep the 16-bit and 32-bit editions in the same place; then
you will need only one copy of the help file.

After you've installed PFE, the best thing to do is start it up, then use the
Options Preferences command to explore the customisation options and set it up
to run as you prefer.


