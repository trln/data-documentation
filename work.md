<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org932c886">1. <span class="todo INPROGRESS">INPROGRESS</span> Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development</a>
<ul>
<li><a href="#org9650cb1">1.1. <span class="todo INPROGRESS">INPROGRESS</span> Develop initial manual ILS extract processes</a>
<ul>
<li><a href="#org40e30a9">1.1.1. <span class="todo INPROGRESS">INPROGRESS</span> UNC ILS extract processes</a></li>
<li><a href="#org47ee97c">1.1.2. <span class="todo TODO">TODO</span> Duke ILS extract processes</a></li>
<li><a href="#org33600a5">1.1.3. <span class="todo TODO">TODO</span> NCSU ILS extract processes</a></li>
<li><a href="#org8be3c44">1.1.4. <span class="todo TODO">TODO</span> NCCU ILS extract processes</a></li>
</ul>
</li>
<li><a href="#orgbc0f938">1.2. <span class="todo INPROGRESS">INPROGRESS</span> Initial definition of Argot format</a>
<ul>
<li><a href="#orgc070c36">1.2.1. <span class="done DONE">DONE</span> Create Argot template showing structure of Argot record and available elements</a></li>
<li><a href="#org6abcf72">1.2.2. <span class="todo INPROGRESS">INPROGRESS</span> Add examples of records in Argot</a></li>
<li><a href="#org7a4ca58">1.2.3. <span class="todo TODO">TODO</span> Add instructions/examples to Argot template</a></li>
<li><a href="#org9161a9c">1.2.4. <span class="todo TODO">TODO</span> Create data mapping: Endeca data element -&gt; Argot element</a></li>
<li><a href="#orgfb27ce7">1.2.5. <span class="todo WAIT">WAIT</span> Create data mapping: MARC bib -&gt; Argot element</a></li>
</ul>
</li>
<li><a href="#org7c33f21">1.3. <span class="todo INPROGRESS">INPROGRESS</span> Develop initial working transformation process for MARC to Argot</a>
<ul>
<li><a href="#orga0c4f27">1.3.1. <span class="todo WAIT">WAIT</span> UNC MARC to Argot transformation</a></li>
<li><a href="#org8a3ebe2">1.3.2. <span class="todo TODO">TODO</span> Duke MARC to Argot transformation</a></li>
<li><a href="#orgf8e234f">1.3.3. <span class="todo TODO">TODO</span> NCSU MARC to Argot transformation</a></li>
<li><a href="#org3842fbb">1.3.4. <span class="todo TODO">TODO</span> NCCU MARC to Argot transformation</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>
\#+OPTIONS pri:t todo:t ^:nil num:nil


<a id="org932c886"></a>

# Get initial set of MARC bib (and attached item, holdings, order record) data from institutional ILSs into Solr to support for initial Argon development

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:31]</span></span>


<a id="org9650cb1"></a>

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


<a id="org40e30a9"></a>

### UNC ILS extract processes

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 15:38]</span></span>

Code and example data lives at: <https://github.com/trln/extract_marcxml_for_argot_unc>

1.  DONE Extract Sierra bib data to MARC-XML

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

2.  DONE Include data from attached, unsuppressed item records

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

3.  INPROGRESS Include data from attached, unsuppressed holdings records

    -   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:03]</span></span>

4.  TODO Include data from attached, unsuppressed order records


<a id="org47ee97c"></a>

### Duke ILS extract processes


<a id="org33600a5"></a>

### NCSU ILS extract processes


<a id="org8be3c44"></a>

### NCCU ILS extract processes


<a id="orgbc0f938"></a>

## Initial definition of Argot format

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:27]</span></span>

-   Argot is under intense development and will be throughout much of the development phase of this project, so more formal documentation of the Argot model outside the code is not currently a priority
-   Initial version of Argot is directly based on the properties and dimensions currently defined in Endeca
-   Template is ready for data team members to begin using as an initial data transformation model, and it is available for collective improvement/modification on Github


<a id="orgc070c36"></a>

### Create Argot template showing structure of Argot record and available elements

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>

-   Blank Argot template with full record structure and all available fields is at: [the proto-argot template](https://github.com/trln/proto-argot/blob/master/template.json)


<a id="org6abcf72"></a>

### Add examples of records in Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:12]</span></span>
-   [Example of bib record transformed to Argon](https://github.com/trln/proto-argot/blob/master/argot_out.json)
-   More examples are needed


<a id="org7a4ca58"></a>

### Add instructions/examples to Argot template


<a id="org9161a9c"></a>

### Create data mapping: Endeca data element -> Argot element


<a id="orgfb27ce7"></a>

### Create data mapping: MARC bib -> Argot element

-   State "WAIT"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:09] </span></span>   
    Whether this should be done in a centralized way, or left completely to each institution, depends upon decision from Steering Committee or Advisory Team.


<a id="org7c33f21"></a>

## Develop initial working transformation process for MARC to Argot

-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:28]</span></span>
-   We have a working start at this process: [MARC to Argot transformer](https://github.com/trln/marc-to-argot) - has general transformation instructions and institution-specific configs
    -   Details of MARC transformations currently embedded [in the code](https://github.com/trln/marc-to-argot)
    -   Initial design based on UNC data and assumption that we would, as much as possible, like to:
        -   a) have one set of instructions for the transformations/mappings we can all do the same way; and
        -   b) use institution-specific config files to handle locally-specific processing or overrides/exceptions to shared processing instructions


<a id="orga0c4f27"></a>

### UNC MARC to Argot transformation

-   State "WAIT"       from "INPROGRESS" <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:35] </span></span>   
    Adding logic to transform data from attached holdings and order records depends upon extract process producing that data.
-   Currently it can transform  bib and attached item data
-   Work on [MARC to Argot transformer](https://github.com/trln/marc-to-argot) has been based on UNC data so far <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun]</span></span>
-   State "INPROGRESS" from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2017-01-22 Sun 16:30]</span></span>


<a id="org8a3ebe2"></a>

### Duke MARC to Argot transformation


<a id="orgf8e234f"></a>

### NCSU MARC to Argot transformation


<a id="org3842fbb"></a>

### NCCU MARC to Argot transformation

