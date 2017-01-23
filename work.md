<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org135e7bd"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development</a>
<ul>
<li><a href="#orgf996bf0"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Develop initial manual ILS extract processes</a>
<ul>
<li><a href="#org44f815d"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> UNC ILS extract processes</a></li>
<li><a href="#org4a49a8c"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> Duke ILS extract processes</a></li>
<li><a href="#orga88e057"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCSU ILS extract processes</a></li>
<li><a href="#orgeeb0f74"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCCU ILS extract processes</a></li>
</ul>
</li>
<li><a href="#orgc1a8ac7"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Initial definition of Argot format</a>
<ul>
<li><a href="#org78290f3"><span class="done DONE">DONE</span> <span class="priority">[A]</span> Create Argot template showing structure of Argot record and available elements</a></li>
<li><a href="#org67ab6c5"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Add examples of records in Argot</a></li>
<li><a href="#orgbf00eca"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Add instructions/examples to Argot template</a></li>
<li><a href="#orgb551c26"><span class="todo WAIT">WAIT</span> <span class="priority">[B]</span> Create data mapping: Endeca data element -&gt; Argot element</a></li>
<li><a href="#org6210132"><span class="todo WAIT">WAIT</span> <span class="priority">[C]</span> Create data mapping: MARC bib -&gt; Argot element</a></li>
</ul>
</li>
<li><a href="#orga1a90f7"><span class="todo INPROGRESS">INPROGRESS</span> <span class="priority">[A]</span> Develop initial working transformation process for MARC to Argot</a>
<ul>
<li><a href="#orgc41b580"><span class="todo WAIT">WAIT</span> <span class="priority">[A]</span> UNC MARC to Argot transformation</a></li>
<li><a href="#orge389134"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> Duke MARC to Argot transformation</a></li>
<li><a href="#orgff4bd7a"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCSU MARC to Argot transformation</a></li>
<li><a href="#orgb17ec8c"><span class="todo TODO">TODO</span> <span class="priority">[A]</span> NCCU MARC to Argot transformation</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>


<a id="org135e7bd"></a>

# Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:31]</span></span>


<a id="orgf996bf0"></a>

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


<a id="org44f815d"></a>

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


<a id="org4a49a8c"></a>

### Duke ILS extract processes


<a id="orga88e057"></a>

### NCSU ILS extract processes


<a id="orgeeb0f74"></a>

### NCCU ILS extract processes


<a id="orgc1a8ac7"></a>

## Initial definition of Argot format

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:27]</span></span>

-   Argot is under intense development and will be throughout much of the development phase of this project, so more formal documentation of the Argot model outside the code is not currently a priority
-   Initial version of Argot is directly based on the properties and dimensions currently defined in Endeca
-   Template is ready for data team members to begin using as an initial data transformation model, and it is available for collective improvement/modification on Github


<a id="org78290f3"></a>

### Create Argot template showing structure of Argot record and available elements

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>

-   Blank Argot template with full record structure and all available fields is at: [the proto-argot template](https://github.com/trln/proto-argot/blob/master/template.json)


<a id="org67ab6c5"></a>

### Add examples of records in Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>
-   [Example of bib record transformed to Argot](https://github.com/trln/proto-argot/blob/master/argot_out.json)
-   More examples are needed


<a id="orgbf00eca"></a>

### Add instructions/examples to Argot template

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 22:39]</span></span>
-   [template-updates branch version of proto-argot template](https://github.com/trln/proto-argot/blob/template-updates/template.json)


<a id="orgb551c26"></a>

### Create data mapping: Endeca data element -> Argot element

-   State "WAIT"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 22:40] </span></span>   
    Let Argot template get slightly more settled before creating this.


<a id="org6210132"></a>

### Create data mapping: MARC bib -> Argot element

-   State "WAIT"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:09] </span></span>   
    Whether this should be done in a centralized way, or left completely to each institution, depends upon decision from Steering Committee or Advisory Team.


<a id="orga1a90f7"></a>

## Develop initial working transformation process for MARC to Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:28]</span></span>
-   We have a working start at this process: [MARC to Argot transformer](https://github.com/trln/marc-to-argot) - has general transformation instructions and institution-specific configs
    -   Details of MARC transformations currently embedded [in the code](https://github.com/trln/marc-to-argot)
    -   Initial design based on UNC data and assumption that we would, as much as possible, like to:
        -   a) have one set of instructions for the transformations/mappings we can all do the same way; and
        -   b) use institution-specific config files to handle locally-specific processing or overrides/exceptions to shared processing instructions


<a id="orgc41b580"></a>

### UNC MARC to Argot transformation

-   State "WAIT"       from "INPROGRESS" <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:35] </span></span>   
    Adding logic to transform data from attached holdings and order records depends upon extract process producing that data.
-   Currently it can transform  bib and attached item data
-   Work on [MARC to Argot transformer](https://github.com/trln/marc-to-argot) has been based on UNC data so far <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun]</span></span>
-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:30]</span></span>


<a id="orge389134"></a>

### Duke MARC to Argot transformation


<a id="orgff4bd7a"></a>

### NCSU MARC to Argot transformation


<a id="orgb17ec8c"></a>

### NCCU MARC to Argot transformation

