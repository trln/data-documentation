<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org917a61c"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development</a>
<ul>
<li><a href="#org46624f8"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Develop initial manual ILS extract processes</a>
<ul>
<li><a href="#org145311f"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> UNC ILS extract processes</a></li>
<li><a href="#org5b81391"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> Duke ILS extract processes</a></li>
<li><a href="#org60f421d"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCSU ILS extract processes</a></li>
<li><a href="#org952c40e"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCCU ILS extract processes</a></li>
</ul>
</li>
<li><a href="#orgc6b3573"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Initial definition of Argot format</a>
<ul>
<li><a href="#org0283379"><span class="done DONE">DONE</span> <span class="priority">[A]</span> Create Argot template showing structure of Argot record and available elements</a></li>
<li><a href="#org3868e13"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Add examples of records in Argot</a></li>
<li><a href="#org6037be5"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Add instructions/examples to Argot template</a></li>
<li><a href="#orge71f17e"><span class="todo WAIT">WAIT</span> <span class="priority">[B]</span> Create data mapping: Endeca data element -&gt; Argot element</a></li>
<li><a href="#org18d3e7e"><span class="todo WAIT">WAIT</span> <span class="priority">[C]</span> Create data mapping: MARC bib -&gt; Argot element</a></li>
</ul>
</li>
<li><a href="#orgc691442"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Develop initial working transformation process for MARC to Argot</a>
<ul>
<li><a href="#orgcb8b068"><span class="todo WAIT">WAIT</span> <span class="priority">[A]</span> UNC MARC to Argot transformation</a></li>
<li><a href="#org3838827"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> Duke MARC to Argot transformation</a></li>
<li><a href="#org5b07a07"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCSU MARC to Argot transformation</a></li>
<li><a href="#orgd701140"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCCU MARC to Argot transformation</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgb2aaf13"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[B]</span> MARC bibliographic data mapping review</a>
<ul>
<li><a href="#org172de0f"><span class="done DONE">DONE</span> Derive processable version of current MARC bibliographic standard from </a></li>
<li><a href="#orgb18f3e1"><span class="todo INPROGRESS">INPROGRESS</span> use data in Endeca data model to create list of MARC bib tags/fields NOT mapped into current system</a></li>
<li><a href="#org49793f4"><span class="todo TODO">TODO</span> use data in Endeca data model to create list of MARC subfields in MARC tags/fields mapped into current system, which are not explicitly documented</a></li>
<li><a href="#orgb8dacd9"><span class="todo TODO">TODO</span> have metadata specialists review lists for data that should be included that isn't now</a></li>
</ul>
</li>
</ul>
</div>
</div>


<a id="org917a61c"></a>

# Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:31]</span></span>


<a id="org46624f8"></a>

## Develop initial manual ILS extract processes

-   State "INPROGRESS" from "WAIT"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:29]</span></span>

"Initial manual ILS extract processes" means: 

-   this is the first basic work of getting data out of the ILS in a format that can be transformed into Argot
    -   **Data & Infrastructure Implementation Team chair recommendation:** Each institution extracts their MARC bib and necesary attached item, holdings, or order data into **MARC binary** or **MARC-XML**, mapping attached-record data into locally-defined fields in the bib record. Example: [UNC MARC-XML with attached item record data elements mapped into 999 91 fields](https://github.com/trln/extract_marcxml_for_argot_unc/blob/master/out.xml)
-   processes can be run manually, as they are intended to feed into other manual processes
-   no need to worry about new/updated/deleted records or partial/delta/full updates &#x2013; just be able to get sets of records out of the ILS
-   setting up the full, automated local processes for extracting/transforming local ILS data to Argot comes later
-   **Data & Infrastructure Implementation Team chair recommendation:** For clarity and ease of code sharing and maintenance, etc, this step should be as close to a **pure/literal extract** of the ILS data as possible. All transformations/mappings/massagings of the data should be handled by subsequent scripts/processes.

**Implications if recommendations above are not met**

-   Institution may not be able to share/re-use Traject-based MARC-to-Argot code easily or at all
-   If institution wants to use some other means to transform their ILS data to Argot, they should consider this step complete when they can:
    -   Extract their ILS data in the appropriate format(s) to serve as inputs for their local transformation to Argot


<a id="org145311f"></a>

### UNC ILS extract processes

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:38]</span></span>

Code and example data lives at: <https://github.com/trln/extract_marcxml_for_argot_unc>

-   DONE [#A] Extract Sierra bib data to MARC-XML

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

-   DONE [#A] Include data from attached, unsuppressed item records

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

-   INPROGRESS [#A] Include data from attached, unsuppressed holdings records

    -   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

-   TODO [#A] Include data from attached, unsuppressed order records


<a id="org5b81391"></a>

### Duke ILS extract processes


<a id="org60f421d"></a>

### NCSU ILS extract processes


<a id="org952c40e"></a>

### NCCU ILS extract processes


<a id="orgc6b3573"></a>

## Initial definition of Argot format

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:27]</span></span>

-   Argot is under intense development and will be throughout much of the development phase of this project, so more formal documentation of the Argot model outside the code is not currently a priority
-   Initial version of Argot is directly based on the properties and dimensions currently defined in Endeca
-   Template is ready for data team members to begin using as an initial data transformation model, and it is available for collective improvement/modification on Github


<a id="org0283379"></a>

### Create Argot template showing structure of Argot record and available elements

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>

-   Blank Argot template with full record structure and all available fields is at: [the proto-argot template](https://github.com/trln/proto-argot/blob/master/template.json)


<a id="org3868e13"></a>

### Add examples of records in Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>
-   [Example of bib record transformed to Argot](https://github.com/trln/proto-argot/blob/master/argot_out.json)
-   More examples are needed


<a id="org6037be5"></a>

### Add instructions/examples to Argot template

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 22:39]</span></span>
-   [template-updates branch version of proto-argot template](https://github.com/trln/proto-argot/blob/template-updates/template.json)


<a id="orge71f17e"></a>

### Create data mapping: Endeca data element -> Argot element

-   State "WAIT"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 22:40] </span></span>   
    Let Argot template get slightly more settled before creating this.


<a id="org18d3e7e"></a>

### Create data mapping: MARC bib -> Argot element

-   State "WAIT"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:09] </span></span>   
    Whether this should be done in a centralized way, or left completely to each institution, depends upon decision from Steering Committee or Advisory Team.


<a id="orgc691442"></a>

## Develop initial working transformation process for MARC to Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:28]</span></span>
-   We have a working start at this process: [MARC to Argot transformer](https://github.com/trln/marc-to-argot) - has general transformation instructions and institution-specific configs
    -   Details of MARC transformations currently embedded [in the code](https://github.com/trln/marc-to-argot)
    -   Initial design based on UNC data and assumption that we would, as much as possible, like to:
        -   a) have one set of instructions for the transformations/mappings we can all do the same way; and
        -   b) use institution-specific config files to handle locally-specific processing or overrides/exceptions to shared processing instructions


<a id="orgcb8b068"></a>

### UNC MARC to Argot transformation

-   State "WAIT"       from "INPROGRESS" <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:35] </span></span>   
    Adding logic to transform data from attached holdings and order records depends upon extract process producing that data.
-   Currently it can transform  bib and attached item data
-   Work on [MARC to Argot transformer](https://github.com/trln/marc-to-argot) has been based on UNC data so far <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun]</span></span>
-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:30]</span></span>


<a id="org3838827"></a>

### Duke MARC to Argot transformation


<a id="org5b07a07"></a>

### NCSU MARC to Argot transformation


<a id="orgd701140"></a>

### NCCU MARC to Argot transformation


<a id="orgb2aaf13"></a>

# MARC bibliographic data mapping review


<a id="org172de0f"></a>

## Derive processable version of current MARC bibliographic standard from <http://www.loc.gov/marc/bibliographic/ecbdlist.html>

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-18 Wed 22:54]</span></span>
-   Script: [extract\_marc\_bib\_spec.rb](https://github.com/trln/data-documentation/blob/master/extract_marc_bib_spec.rb)
-   MARC field file: [\_marc\_bib\_tags.tsv](https://github.com/trln/data-documentation/blob/master/_marc_bib_tags.tsv)
-   MARC subfield file: [\_marc\_bib\_subfields.tsv](https://github.com/trln/data-documentation/blob/master/_marc_bib_subfields.tsv)


<a id="orgb18f3e1"></a>

## use data in Endeca data model to create list of MARC bib tags/fields NOT mapped into current system

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-18 Wed 23:02]</span></span>

-   Caveat: some institutions have gone off the documented data model, so this will not be completely accurate until full review of existing institutional MARC mappings is done


<a id="org49793f4"></a>

## use data in Endeca data model to create list of MARC subfields in MARC tags/fields mapped into current system, which are not explicitly documented

-   Caveat: some institutions have gone off the documented data model, so this will not be completely accurate until full review of existing institutional MARC mappings is done


<a id="orgb8dacd9"></a>

## have metadata specialists review lists for data that should be included that isn't now

