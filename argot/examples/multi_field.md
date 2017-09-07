## Note about example data
These are fake/mocked up examples to show a range of values/situations in a compressed way. 

We are unlikely to see records like these, but we will definitely see records that contain the patterns that these examples show.

## Note about example "display"
For now, please ignore the details of labels for displayed fields, or whether your search result view/brief record page view/full record view shows things this way. 

`creator_main`, `title_main`, and `statement_of_responsibility` are three separate fields to allow flexibility/customization here. Each example below is one way to do it, chosen to highlight the issue the example is meant to eludicate.

## Main entry + uniform title
### MARC data: 
```
100 1 _ $aBroughton, James,$d1913-1999,$eauthor,$etranslator.
240 1 0 $aAllemagne de notre temps.$lEnglish
245 1 0 $aGermany in our time/$cwritten and translated by J. Broughton.
```

### Display/behavior mockup:
#### Display
**Main author:**
  - [Broughton, James, 1913-1999](http://fake.com/exact-phrase-author-index-search-on-linked-value), author, translator.

**Title:**
  - Germany in our time
    - written and translated by J. Broughton.

**This work:**
  - [Broughton, James, 1913-1999. Allemagne de notre temps.](http://fake.com/exact-phrase-citation-index-search-on-linked-value) English

#### Facet values
Author facet:
  - Broughton, James, 1913-1999

#### Index values
Author index:
  - Broughton, James, 1913-1999. (_from_ `creator_main` _--high relevance_)
  - written and translated by J. Broughton. (_from_ `statement_of_responsibility` _-high relevance_)
  
Title index:
  - Germany in our time (_from_ `title_main` _--high relevance_)
  - Allemagne de notre temps. (_from MARC 240 field (uniform title) displayed as part of_ `work_citation` _display and thus separate display unnecessary--high relevance_)

Work_citation index:
  - Broughton, James, 1913-1999. Allemagne de notre temps.

Keyword index: 
  - Broughton, James, 1913-1999, author, translator
  - Allemagne de notre temps. English
  - Germany in our time
  - written and translated by J. Broughton.


## Multivolume work containing multiple works, with related work
### MARC data:
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

### Display/behavior mockup:
#### Display
**Title:**
  - Selected horror classics
    - selected and introduced by Werner Hertzog and Bruce Campbell.

**Authors/contributors:**
  - **(Volume 1)** [Herzog, Werner, 1942-](http://fake.com/exact-phrase-author-index-search-on-linked-value) editor, author of introduction
  - **(Volume 2)** [Campbell, Bruce, 1958-](http://fake.com/exact-phrase-author-index-search-on-linked-value) editor, author of introduction
  
**This work:** 
  - [Selected horror classics](http://fake.com/exact-phrase-citation-index-search-on-linked-value)
  
**Contains work(s):**
  - **(Volume 1)** [Poe, Edgar Allan, 1809-1849. Black cat](http://fake.com/exact-phrase-citation-index-search-on-linked-value)
  - **(Volume 1)** [Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu](http://fake.com/exact-phrase-citation-index-search-on-linked-value)
  - **(Volume 2)** [Le Fanu, Joseph Sheridan, 1814-1873. Carmilla](http://fake.com/exact-phrase-citation-index-search-on-linked-value)
  - **(Volume 2)** [Irving, Washington, 1783-1859. Legend of Sleepy Hollow](http://fake.com/exact-phrase-citation-index-search-on-linked-value)
  
**Related works:**
 - Continuation of: [Association of Horror Buffs. Stories you should know](http://fake.com/exact-phrase-citation-index-search-on-linked-value)

#### Facet values
Author facet: 
  - Herzog, Werner, 1942-
  - Campbell, Bruce, 1958-
  - Poe, Edgar Allan, 1809-1849
  - Lovecraft, H. P. (Howard Phillips), 1890-1937
  - Le Fanu, Joseph Sheridan, 1814-1873
  - Irving, Washington, 1783-1859
  
_Association of Horror Buffs NOT in facet because known "related" names are excluded; they are not authors of the thing described by *this* record. Further, in Endeca, only personal names from 7xxs were mapped to the Author facet; corporate and meeting names from 710 and 711 were not faceted as authors._
  
#### Index values
Author index:
  - Herzog, Werner, 1942- _(from_ `editor` _--slightly lower relevance)_
  - Campbell, Bruce, 1958- _(from_ `editor` _--slightly lower relevance)_
  - Poe, Edgar Allan, 1809-1849 _(from_ `included_work_creator` _--high relevance)_
  - Lovecraft, H. P. (Howard Phillips), 1890-1937  _(from_ `included_work_creator` _--high relevance)_
  - Le Fanu, Joseph Sheridan, 1814-1873 _(from_ `included_work_creator` _--high relevance)_
  - Irving, Washington, 1783-1859 _(from_ `included_work_creator` _--high relevance)_
  - selected and introduced by Werner Hertzog and Bruce Campbell. _(from_ `statement_of_responsibility` _--high relevance)_
  - Association of Horror Buffs _(from_ `related_work_creator` _--lower relevance)_

Title index:
  - Selected horror classics _(from_ `title_main` _--high relevance)_
  - Black cat _(from_ `included_work_title` _--high relevance)_
  - Call of Cthulhu _(from_ `included_work_title` _--high relevance)_
  - Carmilla _(from_ `included_work_title` _--high relevance)_
  - Legend of Sleepy Hollow _(from_ `included_work_title` _--high relevance)_
  - Stories you should know _(from_ `related_work_title` _--lower relevance)_

Work_citation index:
  - Selected horror classics _(from_ `work_citation` _--high relevance)_
  - Poe, Edgar Allan, 1809-1849. Black cat _(from_ `included_work_citation` _--high relevance)_
  - Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu _(from_ `included_work_citation` _--high relevance)_
  - Le Fanu, Joseph Sheridan, 1814-1873. Carmilla _(from_ `included_work_citation` _--high relevance)_
  - Irving, Washington, 1783-1859. Legend of Sleepy Hollow _(from_ `included_work_citation` _--high relevance)_
  - Association of Horror Buffs. Stories you should know _(from_ `related_work_citation` _--high relevance)_

Keyword index: 
  - Selected horror classics
  - selected and introduced by Werner Hertzog and Bruce Campbell.
  - Volume 1 Herzog, Werner, 1942- editor, author of introduction
  - Volume 2 Campbell, Bruce, 1958- editor, author of introduction
  - Volume 1 Poe, Edgar Allan, 1809-1849, author. Black cat
  - Volume 1 Lovecraft, H. P. (Howard Phillips), 1890-1937. Call of Cthulhu
  - Volume 2 Le Fanu, Joseph Sheridan, 1814-1873. Carmilla
  - Volume 2 Irving, Washington, 1783-1859. Legend of Sleepy Hollow
  - Continuation of (work): Association of Horror Buffs. Stories you should know


## two "creators", related work
### MARC data:
```
100 1 _ $aBaldwin, James,$d1924-1987,$eauthor.
245 1 0 $aI am not your negro :$ba major motion picture directed by Raoul Peck /$cfrom texts by James Baldwin ; compiled and edited by Raoul Peck.
700 1 _ $aPeck, Raoul,$ecompiler,$eauthor of introduction.
730 0 _ $iScreenplay for (work):$aI am not your negro (Motion picture)
```

### Display/behavior mockup:
#### Display
**Main author:**
  - [Baldwin, James, 1924-1987](http://fake.com/exact-phrase-author-index-search-on-linked-value), author
  
**Title:**
  - I am not your negro : a major motion picture directed by Raoul Peck
    - from texts by James Baldwin ; compiled and edited by Raoul Peck.

**Authors/contributors:**
  - [Baldwin, James, 1924-1987](http://fake.com/exact-phrase-author-index-search-on-linked-value), author.
  - [Peck, Raoul](http://fake.com/exact-phrase-author-index-search-on-linked-value), compiler, author of introduction.
**This work:**
  - [Baldwin, James, 1924-1987. I am not your negro.](http://fake.com/exact-phrase-citation-index-search-on-linked-value)

**Related work(s):**
  - Screenplay for: [I am not your negro (Motion picture)](http://fake.com/exact-phrase-citation-index-search-on-linked-value)

#### Facet values
Author facet:
  - Baldwin, James, 1924-1987
  - Peck, Raoul
  
#### Index values
Author index:
  - Baldwin, James, 1924-1987 (_from_ `creator_main` _--high relevance_)
  - from texts by James Baldwin ; compiled and edited by Raoul Peck. (_from_ `statement_of_responsibility` _-high relevance_)
  - Peck, Raoul (_from_ `creator_add` _--high relevance_)
  
Title index:
  - I am not your negro : a major motion picture directed by Raoul Peck (_from_ `title_main` _--high relevance_)
  - I am not your negro (Motion picture) (_related title --lower relevance_)

Work_citation index:
  - Baldwin, James, 1924-1987. I am not your negro. _(this work -- higher relevance)_
  - I am not your negro (Motion picture) _(related work -- lower relevance)_

Keyword index: 
- Baldwin, James, 1924-1987, author.
- I am not your negro : a major motion picture directed by Raoul Peck / from texts by James Baldwin ; compiled and edited by Raoul Peck.
- Peck, Raoul, compiler, author of introduction
- Screenplay for (work): I am not your negro (Motion picture)

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
