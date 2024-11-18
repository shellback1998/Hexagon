
README for Process Data Editor
______________________________

-----------------
Legal Notices
-----------------
Copyright ©2005 Intergraph Corporation
All Rights Reserved

Including software, file formats, and audio-visual displays;
may only be used pursuant to applicable software license 
agreement;  contains confidential and proprietary information 
of Intergraph and/or third parties which is protected by 
copyright and trade secret law and may not be provided or 
otherwise made available without proper authorization.

RESTRICTED RIGHTS LEGENDS

Use, duplication, or disclosure by the U.S. Government is subject
to restrictions as set forth in subparagraph (c) (1) (ii) of The 
Rights in Technical Data and Computer Software clause at DFARS 
252.227-7013 or subparagraphs (c) (1) and (2) of Commercial 
Computer Software--Restricted Rights at 48 CFR 52.227-19, as 
applicable.

Unpublished--rights reserved under the copyright laws of the
United States.

Intergraph and INtools are registered trademarks of Intergraph 
Corporation. Other brands and product names are trademarks of 
their respective owners.

Intergraph Corporation
Huntsville, Alabama   35894-0001
--------------------------
End of Legal Notices
--------------------------

----------------------
Table of Contents
----------------------
Version Information
Year 2000 Status
System Requirements
Version Compatibility
Installing and Running Process Data Editor
Documentation
Training
Customer Support
Version and Service Pack List
New Features
New Fixes
Open Problems
------------------------------
End of Table of Contents
------------------------------

------------------------
Version Information
------------------------
Product:        Process Data Editor
Version:        07.00.01.09
Date:           MAR-30-2005
Description:    Process Data Editor is an application that allows you to 
                view and modify process data sheets without the 
                need to use SmartPlant Instrumentation or InfoMaker. 
                You have the option of importing files modified in the 
                Process Data Editor back into SmartPlant Instrumentation. 
                The Process Data Editor comes with its own setup utility 
                for installing all required files on your computer.
-------------------------------
End of Version Information
-------------------------------

----------------------
Year 2000 Status
----------------------
Certified as Year 2000 compliant.
------------------------------
End of Year 2000 Status
------------------------------

--------------------------
System Requirements
--------------------------
Hardware Requirements
---------------------
  * 233 MHz Pentium(R) machine (minimum)
  * 256 MB RAM (minimum)
  * 20 MB free disk space
  * One CD-ROM drive
    - or -
  * An accessible network CD-ROM drive

  Note:
  * To install Process Data Editor, you must have Adobe Reader 
    4, 5, 6, or 7 installed on the target machine.

Operating System and Software Requirements
------------------------------------------
 One of the following Microsoft(R) Windows(R) operating systems:
  * Windows XP
  * Windows 2000
-----------------------------------
End of System Requirements
-----------------------------------

-------------------------
Version Compatibility
-------------------------
 Process Data Editor is compatible with the following versions of the software:
  * SmartPlant Instrumentation Version 7.0, Service Pack 1 (for .ipd process 
    data files)
--------------------------------
End of Version Compatibility
--------------------------------

----------------------------------------------
Installing and Running Process Data Editor 
----------------------------------------------
To install Process Data Editor:
 1. Navigate to the Process Data Editor folder containing the 
    Setup.exe file.
 2. Double-click the Setup.exe file.
 3. Follow the instructions in the setup wizard.

For further information, please refer to Online Help file 
'PDEditor_Help409.chm' or to the document 'Process Data Editor 
User Guide.pdf' (Document number: DINS-07.00.0015A).
-----------------------------------------------------
End of Installing and Running Process Data Editor
-----------------------------------------------------

------------------
Documentation
------------------
Use the Help menu to access the Help files and Printable 
Guides for this product. To suggest a change or to ask a 
question about the documentation, send an e-mail message 
to PPMdoc@intergraph.com.
---------------------------
End of Documentation
---------------------------

----------
Training
----------
To register for training on Intergraph Process, Power
& Marine products, call Training Registration at 
(800) 766-7701 in the U.S. Outside the U.S., call 
(256) 730-5400 or contact your local Intergraph office.

For current information on training, use a World Wide 
Web browser to connect to Intergraph Process, Power 
& Marine online at http://ppm.intergraph.com/training/.
------------------
End of Training
------------------

----------------------
Customer Support
----------------------
For the latest Support Services information for this 
product, including solutions to known software issues,
use a World Wide Web browser to connect to 
http://ppm.intergraph.com/support/. To open service 
requests outside the U.S., please contact your local 
Intergraph office.
-------------------------------
End of Customer Support
-------------------------------

-----------------------------
Version and Service Pack List
-----------------------------
This file includes details of fixes and new features for the 
following versions and service packs: 

07.00.01.09
07.00.00.52
------------------------------------
End of Version and Service Pack List
------------------------------------

----------------------------------------
New Features in Service Pack 07.00.01.09
----------------------------------------
  None
-----------------------------------------------
End of New Features in Service Pack 07.00.01.09
-----------------------------------------------

---------------------------------
Fixes in Service Pack 07.00.01.09
---------------------------------
  TR-58332
  If you export process data for a flow instrument where 
  the fluid name source is set as 'User-defined', and you 
  view the fluid name on the Tag Data tab of the Process 
  Data Editor, the software no longer shows the data as if 
  the fluid name source were 'Database'.
----------------------------------------
End of Fixes in Service Pack 07.00.01.09
----------------------------------------

-----------------------------------
New Features in Version 07.00.00.52
-----------------------------------
  None
------------------------------------------
End of New Features in Version 07.00.00.52
------------------------------------------

----------------------------
Fixes in Version 07.00.00.52
----------------------------
  None
-----------------------------------
End of Fixes in Version 07.00.00.52
-----------------------------------

-------------
Open Problems
-------------
  TR-65259
  Problem:
    The software does not prevent you from changing tag service and 
    process data settings that are shared for all tag cases.
  Workaround: 
    Not available

  TR-65292
  Problem:
    Users who changed units of measure codes in SmartPlant Instrumentation 
    should exercise extreme caution when changing units of measure 
    in the Process Data Editor. This is because on the Tag Data tab, the 
    units of measure appear incorrectly. If you change a unit of measure 
    code on the Tag Data tab and then save the changes, after importing 
    the tag process data to SmartPlant Instrumentation, wrong values appear 
    in the database.
  Workaround: 
    If you must change a unit of measure in the Process Data Editor, make 
    sure that you change it on the Tag List tab.
--------------------
End of Open Problems
--------------------