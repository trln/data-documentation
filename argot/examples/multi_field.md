These are fake/mocked up examples to show a range of values/situations in a compressed way. 

We are unlikely to see records like these, but we will definitely see records that contain the patterns that these examples show.

## Main entry + uniform title
MARC data: 
```
100 1 _ $aBroughton, James,$d1913-1999,$eauthor,$etranslator.
240 1 0 $aAllemagne de notre temps.$lEnglish
245 1 0 $aGermany in our time/$cwritten and translated by J. Broughton.
```

Display/behavior mockup:
```
(Optionally displayed as separate field labeled "Main author" OR displayed with any other names under "Authors" label)
Main author: 
  <a href="author index query on \"Broughton, James, 1913-1999\">Broughton, James, 1913-1999</a>, author, translator.

(Optionally main_title displayed alone/in combo with main_author field)
Title: 
  Germany in our time
OR
(Optionally main_title shown displayed in combination with statement_of_responsibility)
Title:
  Germany in our time / written and translated by J. Broughton.

Other versions of this work: 
  <a href="citation index exact phrase query on: \"Broughton, James, 1913-1999. Allemagne de notre temps\">Broughton, James, 1913-1999. Allemagne de notre temps.</a> English
  
Value in author facet: 
  Broughton, James, 1913-1999

Values in author index:
  Broughton, James, 1913-1999.
  written and translated by J. Broughton.
  
Values in title index:
  Germany in our time
  Allemagne de notre temps. English
  
Values in work_citation index:
  Broughton, James, 1913-1999. Allemagne de notre temps.

Values in keyword index: 
  Broughton, James, 1913-1999, author, translator
  Allemagne de notre temps. English
  Germany in our time
  written and translated by J. Broughton.
```

## Multivolume work containing multiple works, with related work
MARC data:
```
245 0 0 $aSelected horror classics/$cselected and introduced by Werner Hertzog and Bruce Campbell.
700 1 _ $aHerzog, Werner,$d1942-$4edt$4aui$3Volume 1
700 1 _ $aCampbell, Bruce,$d1958-$4edt$4aui$3Volume 2
700 1 2 $3Volume 1$aPoe, Edgar Allan,$d1809-1849,$eauthor.$tBlack cat
700 1 2 $3Volume 1:$aLovecraft, H. P.$q(Howard Phillips),$d1890-1937.$tCall of Cthulhu
700 1 2 $3Volume 2$aLe Fanu, Joseph Sheridan,$d1814-1873.$tCarmilla
700 1 2 $3Volume 2 -$aIrving, Washington,$d1783-1859.$tLegend of Sleepy Hollow
710 2 _ $iContinuation of (work):$aAssociation of Horror Buffs.$tStories you should know
```

Display/behavior mockup:
```
(Optionally displayed as separate field labeled "Main author" OR displayed with any other names under "Authors" label)
Main author: 
  (blank) -- no author for overall work. Herzog and Campbell are in 'editor' field to make them available to citation builder feature(s)

(Optionally main_title displayed alone/in combo with main_author field)
Title: 
  Selected horror classics
OR
(Optionally main_title shown displayed in combination with statement_of_responsibility)
Title:
  Selected horror classics / selected and introduced by Werner Hertzog and Bruce Campbell.

Authors/contributors: 
  (Volume 1) <a href="query link to phrase search for \"Herzog, Werner, 1942-\"">Herzog, Werner, 1942-</a> editor, author of introduction
  (Volume 2) <a href="query link to phrase search for \"Campbell, Bruce, 1958-\"">Campbell, Bruce, 1958- editor, author of introduction
  
Other versions of this work: 
  <a href="citation index exact phrase query on: \"Selected horror classics\">Selected horror classics</a>
  
Contains works: 
  (Volume 1) <a href="citation index exact phrase query on: \"Poe, Edgar Allan, 1809-1849. Black cat\"">Poe, Edgar Allan, 1809-1849. Black cat</a>
  (Volume 1) <a href="citation index exact phrase query on: \"Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu\"">Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu</a>
  (Volume 2) <a href="citation index exact phrase query on: \"Le Fanu, Joseph Sheridan, 1814-1873. Carmilla\"">Le Fanu, Joseph Sheridan, 1814-1873. Carmilla</a>
  (Volume 2) <a href="citation index exact phrase query on: \"Irving, Washington, 1783-1859. Legend of Sleepy Hollow\"">Irving, Washington, 1783-1859. Legend of Sleepy Hollow</a>
  
Related works:
Continuation of: <a href="citation index exact phrase query on: \"Association of Horror Buffs. Stories you should know\"">Association of Horror Buffs. Stories you should know</a> 
  
Values in author facet: 
  Herzog, Werner, 1942-
  Campbell, Bruce, 1958-
  Poe, Edgar Allan, 1809-1849
  Lovecraft, H. P. (Howard Phillips), 1890-1937
  Le Fanu, Joseph Sheridan, 1814-1873
  Irving, Washington, 1783-1859
  
  (Association of Horror Buffs NOT in facet because known "related" names are excluded)
  
Values in author index:
  Herzog, Werner, 1942- (from editor field, so slightly lower relevance contribution)
  Campbell, Bruce, 1958- (from editor field, so slightly lower relevance contribution)
  Poe, Edgar Allan, 1809-1849 (from included_work_creator field, so high relevance contribution)
  Lovecraft, H. P. (Howard Phillips), 1890-1937 (from included_work_creator field, so high relevance contribution)
  Le Fanu, Joseph Sheridan, 1814-1873 (from included_work_creator field, so high relevance contribution)
  Irving, Washington, 1783-1859 (from included_work_creator field, so high relevance contribution)
  selected and introduced by Werner Hertzog and Bruce Campbell. (from statement_of_responsibility field, so high relevance contribution)
  Association of Horror Buffs (from related_work_creator field, so lower relevance contribution)

Values in title index:
  Selected horror classics (main_title of this work, so highest relevance contribution)
  Black cat (included, high relevance contribution)
  Call of Cthulhu (included, high relevance contribution)
  Carmilla (included, high relevance contribution)
  Legend of Sleepy Hollow (included, high relevance contribution)
  Stories you should know (related, lower relevance contribution)

Values in work_citation index:
  Selected horror classics (when no 1XX field, use main_title)
  Poe, Edgar Allan, 1809-1849. Black cat (included work, high relevance)
  Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu (included work, high relevance)
  Le Fanu, Joseph Sheridan, 1814-1873. Carmilla (included work, high relevance)
  Irving, Washington, 1783-1859. Legend of Sleepy Hollow (included work, high relevance)
  Association of Horror Buffs. Stories you should know (related work, low relevance)

Values in keyword index: 
  Selected horror classics
  selected and introduced by Werner Hertzog and Bruce Campbell.
  Volume 1 Herzog, Werner, 1942- editor, author of introduction
  Volume 2 Campbell, Bruce, 1958- editor, author of introduction
  Volume 1 Poe, Edgar Allan, 1809-1849, author. Black cat
  Volume 1 Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu
  Volume 2 Le Fanu, Joseph Sheridan, 1814-1873. Carmilla
  Volume 2 Irving, Washington, 1783-1859. Legend of Sleepy Hollow
  Continuation of (work): Association of Horror Buffs. Stories you should know
``` 




700 1 _ $aRosny, Leon.
700 1 _ $aVol. 3$aSmith, Henry.$tAnnotated decisions.
710 1 _ $aUnited States.$bGeneral Accounting Office.$tDecisions of the Comptroller General of the United States (Annual)$x0011-7323
710 2 _ $31992-$aOhio State University.
730 0 _ $aForeign affairs (Council on Foreign Relations)
740 4 _ $aThe very random title
```

Argot fields:
```
unspecified_name_index: ["Rosny, Leon.", "Smith, Henry.", "United States. General Accounting Office.", "Ohio State University"]
unspecified_name_entry: ["Rosny, Leon.", "Ohio State University"]
unspecified_name_entry_label: ["", "1992-"]
unspecified_title_index: ["Annotated decisions.", "Decisions of the Comptroller General of the United States (Annual)", "Foreign affairs (Council on Foreign Relations)", "Very random title"]
unspecified_issn: ["0011-7323"]
unspecified_work_citation: ["Smith, Henry. Annotated decisions.", "United States. General Accounting Office. Decisions of the Comptroller General of the United States (Annual).", "Foreign affairs (Council on Foreign Relations)", "The very random title"]
unspecified_work_citation_ids: ["", "", 
unspecified_work_citation_label: ["Vol. 3", "", ""]
```

Display/behavior mockup:
```
Authors: 
  (any creator_main, creator_add, director, editor, contributor, other_name field values displayed first)
  <a href="query URL to author search on \"Rosny, Leon.\"">Rosny, Leon.</a>
  (1992-): <a href="query URL to author search on \"Ohio State University.\"">Ohio State University.</a>
  
Related works: 
  (any related_work_citation field values displayed first)
  
```
