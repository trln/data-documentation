<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgd29825b">1. endeca<sub>dmod</sub><sub>elements.txt</sub>: list of unique elements from Endeca data model spreadsheet from the following tabs/columns (dmod<sub>fields</sub> tab):</a></li>
<li><a href="#orge2e0b80">2. Notice that data model spreadsheet is not in full agreement with some things in the actual Endeca configuration and extract separate lists of elements and information about them from the Endeca config.</a>
<ul>
<li><a href="#orgeeb09d8">2.1. endeca<sub>dimensions.tsv</sub>: Extract dimension names and behavior from serverc: /data/TRLN/config/pipeline/Dimensions.xml, using top-level dimension nodes only.</a>
<ul>
<li><a href="#org4495df2">2.1.1. Call Number Range dimension defined in: ./data/TRLN/config/pipeline/LCC<sub>NLM</sub><sub>full.xml</sub>:  &lt;DIMENSION NAME="Call Number Range" SRC<sub>TYPE</sub>="INTERNAL"&gt;</a></li>
<li><a href="#org0752b18">2.1.2. Language dimension defined in: ./data/TRLN/config/pipeline/language<sub>utf8.xml</sub>:  &lt;DIMENSION NAME="Language" SRC<sub>TYPE</sub>="INTERNAL"&gt;</a></li>
<li><a href="#org7e4d1bc">2.1.3. Data on facet refinement behavior extracted from: /data/TRLN/config/pipeline/TRLN.refinement<sub>config.xml</sub></a></li>
</ul>
</li>
<li><a href="#orge56d135">2.2. endeca<sub>properties.tsv</sub>: Extract property information from /data/TRLN/config/pipeline/TRLN.prop<sub>refs.xml</sub></a>
<ul>
<li><a href="#orgfc00613">2.2.1. Sortable data extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>sort</sub><sub>config.xml</sub></a></li>
<li><a href="#orgc9c997e">2.2.2. System primary key extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>spec.xml</sub></a></li>
<li><a href="#org6531860">2.2.3. Filter value extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>filter.xml</sub></a></li>
</ul>
</li>
<li><a href="#org05c1219">2.3. endeca<sub>config</sub><sub>elements.txt</sub>: From the lists of Endeca dimensions and propties derived from the Endeca configuration files, create a unique list of Endeca element names from the config</a></li>
<li><a href="#orge506f5f">2.4. endeca<sub>indexing.tsv</sub>: Define which elements are searchable in which indexes, by extracting configuration from: serverc: /data/TRLN/config/pipeline/TRLN.recsearch<sub>config.xml</sub></a></li>
<li><a href="#org4ba1963">2.5. _endeca<sub>indexing</sub><sub>reduced.tsv</sub>: derived from endeca<sub>indexing.tsv</sub> via endeca<sub>indexing</sub><sub>reduce.rb</sub></a></li>
</ul>
</li>
<li><a href="#org28b4f5e">3. Identify list of elements in endeca<sub>dmod</sub><sub>elements.txt</sub> that are NOT in endeca<sub>config</sub><sub>elements.txt</sub></a></li>
<li><a href="#org281edf5">4. Identify elements in endeca<sub>config</sub><sub>elements.txtthat</sub> are not in endeca<sub>dmod</sub><sub>elements.txt</sub> (omitting the ones with minor name differences identified in previous comparison)</a></li>
<li><a href="#org4391eb8">5. Everything in endeca<sub>dmod</sub><sub>elements.txt</sub> but not endeca<sub>config</sub><sub>elements.txt</sub> was either</a>
<ul>
<li><a href="#orga97a7da">5.1. in endeca<sub>config</sub><sub>elements.txt</sub> with slightly different name</a></li>
<li><a href="#org1f34be9">5.2. deleted from data model but left in spreadsheet and formatted with strikethrough text</a></li>
<li><a href="#orgf841726">5.3. a special Segmented element, which we don't care about, as per the next step</a></li>
</ul>
</li>
<li><a href="#orgb1bafcf">6. <b>Thus we now consider endeca<sub>config</sub><sub>elements.txt</sub> to be the final, authoritative element list going forward</b></a></li>
<li><a href="#org28321af">7. endeca<sub>final</sub><sub>elements.tsv</sub> is created, initially duplicating endeca<sub>config</sub><sub>elements.txt</sub></a>
<ul>
<li><a href="#org2c87ee2">7.1. Remove elements with "Normalized" in the property/dimension name, since we assume Solr will be handling normalization. This results in removal of the following from endeca<sub>final</sub><sub>elements.tsv</sub>:</a></li>
<li><a href="#org2161a46">7.2. Remove elements with "Vernacular" (and "Vernacular Segmented") in the name, since we assume we are handling vernacular data very differently in Solr. The following are removed from endeca<sub>final</sub><sub>elements.tsv</sub>:</a></li>
<li><a href="#orgda17f4b">7.3. Remove these elements from endeca<sub>final</sub><sub>elements.tsv</sub>: Title1, Title2, Title3, Title4 on the assumption that we'll have better ways to deal with relevance ranking for short titles.</a></li>
<li><a href="#org9029515">7.4. Add column mapping each config element name to an element in endeca<sub>dmod</sub><sub>elements.txt</sub>, in order to facilitate future data merging from Endeca data model spreadsheet</a></li>
</ul>
</li>
<li><a href="#org8a1487e">8. _endeca<sub>final</sub><sub>elements</sub><sub>compiled.tsv</sub> is compiled by endeca<sub>final</sub><sub>elements</sub><sub>compile.rb</sub></a></li>
<li><a href="#org85173fd">9. endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>dmod</sub><sub>element.tsv</sub>: create mapping of Endeca pre-pipeline labels to Endeca data model element names</a></li>
<li><a href="#org65b43dd">10. _endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>element</sub><sub>info.tsv</sub>: compiled by endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>element.rb</sub></a></li>
</ul>
</div>
</div>


<a id="orgd29825b"></a>

# endeca<sub>dmod</sub><sub>elements.txt</sub>: list of unique elements from Endeca data model spreadsheet from the following tabs/columns (dmod<sub>fields</sub> tab):

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Tab</td>
<td class="org-left">Column</td>
</tr>


<tr>
<td class="org-left">Dimensions</td>
<td class="org-left">Endeca<sub>Dimension</sub><sub>Name</sub></td>
</tr>


<tr>
<td class="org-left">Properties</td>
<td class="org-left">Endeca<sub>Property</sub></td>
</tr>


<tr>
<td class="org-left">EAD mappings</td>
<td class="org-left">Endeca<sub>Property</sub></td>
</tr>
</tbody>
</table>


<a id="orge2e0b80"></a>

# Notice that data model spreadsheet is not in full agreement with some things in the actual Endeca configuration and extract separate lists of elements and information about them from the Endeca config.


<a id="orgeeb09d8"></a>

## endeca<sub>dimensions.tsv</sub>: Extract dimension names and behavior from serverc: /data/TRLN/config/pipeline/Dimensions.xml, using top-level dimension nodes only.


<a id="org4495df2"></a>

### Call Number Range dimension defined in: ./data/TRLN/config/pipeline/LCC<sub>NLM</sub><sub>full.xml</sub>:  <DIMENSION NAME="Call Number Range" SRC<sub>TYPE</sub>="INTERNAL">


<a id="org0752b18"></a>

### Language dimension defined in: ./data/TRLN/config/pipeline/language<sub>utf8.xml</sub>:  <DIMENSION NAME="Language" SRC<sub>TYPE</sub>="INTERNAL">


<a id="org7e4d1bc"></a>

### Data on facet refinement behavior extracted from: /data/TRLN/config/pipeline/TRLN.refinement<sub>config.xml</sub>


<a id="orge56d135"></a>

## endeca<sub>properties.tsv</sub>: Extract property information from /data/TRLN/config/pipeline/TRLN.prop<sub>refs.xml</sub>


<a id="orgfc00613"></a>

### Sortable data extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>sort</sub><sub>config.xml</sub>


<a id="orgc9c997e"></a>

### System primary key extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>spec.xml</sub>


<a id="org6531860"></a>

### Filter value extracted from: serverc: /data/TRLN/config/pipeline/TRLN.record<sub>filter.xml</sub>


<a id="org05c1219"></a>

## endeca<sub>config</sub><sub>elements.txt</sub>: From the lists of Endeca dimensions and propties derived from the Endeca configuration files, create a unique list of Endeca element names from the config


<a id="orge506f5f"></a>

## endeca<sub>indexing.tsv</sub>: Define which elements are searchable in which indexes, by extracting configuration from: serverc: /data/TRLN/config/pipeline/TRLN.recsearch<sub>config.xml</sub>


<a id="org4ba1963"></a>

## \_endeca<sub>indexing</sub><sub>reduced.tsv</sub>: derived from endeca<sub>indexing.tsv</sub> via endeca<sub>indexing</sub><sub>reduce.rb</sub>


<a id="org28b4f5e"></a>

# Identify list of elements in endeca<sub>dmod</sub><sub>elements.txt</sub> that are NOT in endeca<sub>config</sub><sub>elements.txt</sub>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Data model element</th>
<th scope="col" class="org-left">Element list element or other note</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Medical Subject: Topic</td>
<td class="org-left">In element list as Medical Subject</td>
</tr>


<tr>
<td class="org-left">Subject: Genre</td>
<td class="org-left">In element list as Genre</td>
</tr>


<tr>
<td class="org-left">Subject: Region</td>
<td class="org-left">In element list as Region</td>
</tr>


<tr>
<td class="org-left">Subject: Time Period</td>
<td class="org-left">In element list as Time Period</td>
</tr>


<tr>
<td class="org-left">Subject: Topic</td>
<td class="org-left">In element list as Subject</td>
</tr>


<tr>
<td class="org-left">Access Restriction</td>
<td class="org-left">In element list as Access Restrictions</td>
</tr>


<tr>
<td class="org-left">HoldingsNote</td>
<td class="org-left">In element list as Holdings Note</td>
</tr>


<tr>
<td class="org-left">ItemBarcode</td>
<td class="org-left">Striked out in data model spreadsheet; Not found in config data; Assume not used</td>
</tr>


<tr>
<td class="org-left">ItemDueDate</td>
<td class="org-left">In element list as Item Due Date</td>
</tr>


<tr>
<td class="org-left">ItemNotes</td>
<td class="org-left">In element list as Item Notes</td>
</tr>


<tr>
<td class="org-left">ItemTypes</td>
<td class="org-left">In element list as Item Types</td>
</tr>


<tr>
<td class="org-left">Linking<sub>ISSN</sub></td>
<td class="org-left">In element list as Linking ISSN</td>
</tr>


<tr>
<td class="org-left">Location<sub>property</sub></td>
<td class="org-left">In element list as Location property</td>
</tr>


<tr>
<td class="org-left">Main Author Vernacular Segment</td>
<td class="org-left">In element list as Main Author Vernacular Segmented</td>
</tr>


<tr>
<td class="org-left">None</td>
<td class="org-left">In data model spreadsheet as "999Class (a delimited list of classifications associated with items)" with note: "Class scheme used by TRLN Virtual Browse app, data not mapped to Endeca properties"</td>
</tr>


<tr>
<td class="org-left">Publisher Segmented</td>
<td class="org-left">Did not find in config</td>
</tr>


<tr>
<td class="org-left">SerialHoldingsSummary</td>
<td class="org-left">In element list as Serial Holdings Summary</td>
</tr>


<tr>
<td class="org-left">Syndetics<sub>ISBN</sub></td>
<td class="org-left">In element list as Syndetics ISBN</td>
</tr>


<tr>
<td class="org-left">Table of Contents Vernacular Segment</td>
<td class="org-left">In element list as Table of Contents Vernacular Segmented</td>
</tr>
</tbody>
</table>


<a id="org281edf5"></a>

# Identify elements in endeca<sub>config</sub><sub>elements.txtthat</sub> are not in endeca<sub>dmod</sub><sub>elements.txt</sub> (omitting the ones with minor name differences identified in previous comparison)

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Element</th>
<th scope="col" class="org-left">Notes</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Access</td>
<td class="org-left">Drives "Access Facet" dimension in reference implementation</td>
</tr>


<tr>
<td class="org-left">Authors Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Class Schemes</td>
<td class="org-left">This is likely the None/999Class from the data model</td>
</tr>


<tr>
<td class="org-left">Company</td>
<td class="org-left">Used for Duke digital collections. DC elements not consistently added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">Digital Collection</td>
<td class="org-left">DC elements not consistently added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">ICE Chapter Author</td>
<td class="org-left">Syndetics/ICE elements not added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">ICE Chapter Title</td>
<td class="org-left">Syndetics/ICE elements not added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">Main Author Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Main Title Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Notes Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Primary Source</td>
<td class="org-left">Drives Primary Source facet</td>
</tr>


<tr>
<td class="org-left">Product</td>
<td class="org-left">Used for Duke digital collections. DC elements not consistently added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">Publisher Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Repository URL</td>
<td class="org-left">DC elements not consistently added to data model spreadsheet</td>
</tr>


<tr>
<td class="org-left">Series Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">SharedRecordFlag</td>
<td class="org-left">Unclear where this gets set/used</td>
</tr>


<tr>
<td class="org-left">Thumbnail URL</td>
<td class="org-left">In production use by UNC, so not sure why it didn't get added to spreadsheet</td>
</tr>


<tr>
<td class="org-left">Titles Normalized</td>
<td class="org-left">Gets created automatically by Endeca process, so adding to data model was likely overlooked</td>
</tr>


<tr>
<td class="org-left">Tracking Tag</td>
<td class="org-left">Unclear where this gets set/used</td>
</tr>


<tr>
<td class="org-left">Troubleshooting</td>
<td class="org-left">Unclear where this gets set/used</td>
</tr>
</tbody>
</table>


<a id="org4391eb8"></a>

# Everything in endeca<sub>dmod</sub><sub>elements.txt</sub> but not endeca<sub>config</sub><sub>elements.txt</sub> was either


<a id="orga97a7da"></a>

## in endeca<sub>config</sub><sub>elements.txt</sub> with slightly different name


<a id="org1f34be9"></a>

## deleted from data model but left in spreadsheet and formatted with strikethrough text


<a id="orgf841726"></a>

## a special Segmented element, which we don't care about, as per the next step


<a id="orgb1bafcf"></a>

# **Thus we now consider endeca<sub>config</sub><sub>elements.txt</sub> to be the final, authoritative element list going forward**


<a id="org28321af"></a>

# endeca<sub>final</sub><sub>elements.tsv</sub> is created, initially duplicating endeca<sub>config</sub><sub>elements.txt</sub>


<a id="org2c87ee2"></a>

## Remove elements with "Normalized" in the property/dimension name, since we assume Solr will be handling normalization. This results in removal of the following from endeca<sub>final</sub><sub>elements.tsv</sub>:

-   Authors Normalized
-   Journal Title Normalized
-   Main Author Normalized
-   Main Title Normalized
-   Notes Normalized
-   Publisher Normalized
-   Series Normalized
-   Subjects Normalized
-   Titles Normalized


<a id="org2161a46"></a>

## Remove elements with "Vernacular" (and "Vernacular Segmented") in the name, since we assume we are handling vernacular data very differently in Solr. The following are removed from endeca<sub>final</sub><sub>elements.tsv</sub>:

-   Edition Vernacular
-   Edition Vernacular Segmented
-   Imprint Vernacular
-   Main Author Vernacular
-   Main Author Vernacular Segmented
-   Main Uniform Title Vernacular
-   Main Uniform Title Vernacular Segmented
-   Other Authors Vernacular Segmented
-   Other Titles Vernacular Segmented
-   Series Statement Vernacular
-   Series Statement Vernacular Segmented
-   Statement of Responsibility Vernacular
-   Statement of Responsibility Vernacular Segmented
-   Subjects Vernacular Segmented
-   Table of Contents Vernacular Segmented
-   Title Vernacular
-   Title Vernacular Segmented
-   Uniform Title Vernacular
-   Uniform Title Vernacular Segmented
-   Varying Titles Vernacular Segmented


<a id="orgda17f4b"></a>

## Remove these elements from endeca<sub>final</sub><sub>elements.tsv</sub>: Title1, Title2, Title3, Title4 on the assumption that we'll have better ways to deal with relevance ranking for short titles.


<a id="org9029515"></a>

## Add column mapping each config element name to an element in endeca<sub>dmod</sub><sub>elements.txt</sub>, in order to facilitate future data merging from Endeca data model spreadsheet


<a id="org8a1487e"></a>

# \_endeca<sub>final</sub><sub>elements</sub><sub>compiled.tsv</sub> is compiled by endeca<sub>final</sub><sub>elements</sub><sub>compile.rb</sub>

-   Adds whether we facet on each element (if yes, then it is a Dimension in Endeca)
-   Adds column on searchability of each element


<a id="org85173fd"></a>

# endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>dmod</sub><sub>element.tsv</sub>: create mapping of Endeca pre-pipeline labels to Endeca data model element names

-   vernacular, segmented, and normalized-specific elements and prepipeline names removed.


<a id="org65b43dd"></a>

# \_endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>element</sub><sub>info.tsv</sub>: compiled by endeca<sub>prepipeline</sub><sub>name</sub><sub>to</sub><sub>element.rb</sub>

