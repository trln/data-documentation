# Location issues/considerations

## "Location" means multiple things
When we talk about "location" in the catalog, we're referring to a few separate things: 

1. The library branch, building, or major section that gets users to the general right area to start looking for an item on the shelves (or the correct service desk)
 - Argot fields: item_location_library, holdings_location_library
 - not indexed
 - displayed next to item or holdings level data 
2. The specific shelving location in which to begin hunting for the call number (example: Highway Safety Research Center Library Main Stacks vs. Highway Safety Research Center Library Oversize vs. Highway Safety Research Center Library New Books) 
 - Argot fields: item_location_shelf, holdings_location_shelf
 - not indexed
 - displayed next to item or holdings level data 
 - location code is stored and mapped to location label for display
3. The facet value used to limit search results (or an advanced search) to items in a particular place 
  - Argot fields: bib_locations_hierarchical
  - Facet limits to bib records, not item/holdings data
    - *_location_library and *_location_shelf are single values attached to each item and holdings record
    - this field is multi-valued because copies/volumes of a resource described by bib record may be found in different places
  - Endeca catalog location facet supports polyhierarchy and sub-locations -- The "Make it work like 'Search TRLN'" criteria in [TD-121](https://trlnmain.atlassian.net/browse/TD-121) implies we want the same going forward
  

## One idea for data mapping/transformation
I modeled this with the top-level elements of the existing hierarchy, all of UNC's data, and a bit of Duke's to extend the example. 

- *_location_shelf extracted is from incoming data and stored as code
- use [location_shelf_code_to_display.json](https://github.com/trln/data-documentation/blob/master/argot/maps/location_shelf_code_to_display.json) to get display labels
- use [location_shelf_to_location_library.json](https://github.com/trln/data-documentation/blob/master/argot/maps/location_shelf_to_location_library.json) to look up what *_location_library code/valueeach *_location_shelf code maps into
- store appropriate *_location_library code/value in each item/holdings record data in Argot
- use [location_library_hierarchy_and_display.json](https://github.com/trln/data-documentation/blob/master/argot/maps/location_library_hierarchy_and_display.json) to: 
  - look up label to display for the *_location_library code/value in the item/holdings record display
  - populate bib_locations_hierarchical field, which will drive the Location facet

### Example

#### Polyhierarchy
UNC bib record has attached item record with location code nohbb. 

This code is translated to "Health Sciences Library History Collection Reference" in the item record display. (location_shelf_code_to_display.json)

This code maps to the item_location_library value: "UNC:Health Sciences Library". (location_shelf_to_location_library.json)

location_library_hierarchy_and_display.json contains the following entry for this *_location_library value:

``` json
    "UNC:Health Sciences Library" : {
        "in record display" : "",
        "parents" : {
            "UNC Chapel Hill" : "Health Sciences Library",
	    "Health Sciences Libraries" : "UNC Health Sciences Library"
        }
    },	
```

This specifies: 
 - Nothing/blank should be displayed for the item_location_library value in the record.
   - This is because our item_location_shelf code already translates to "Health Sciences Library History Collection Reference". We don't need to show "Health Sciences Library --- Health Sciences Library History Collection Reference"
 - The bib_locations_hierarchical field values for this record should include: 
   - UNC Chapel Hill > Health Sciences Library
   - Health Sciences Libraries > UNC Health Sciences Library
   
The "parents" hash contains pairs where key = the item_location_library value of the next higher facet level, and the value = the form in which to display the sub-facet value under that parent.


#### Sublocations
Duke bib record has attached item record with location code MARCH.

This code is translated to "Archives" in the item record display. (location_shelf_code_to_display.json)

This code maps to the item_location_library value: "Duke:MedArchives". (location_shelf_to_location_library.json)

location_library_hierarchy_and_display.json contains the following entry for this *_location_library value:

``` json
"Duke:MedArchives" : {
  "in record display" : "Medical Center Library",
  "parents" : {
    "Duke:MCL" : "Archives"
  }
},	
```

This specifies: 
 - "Medical Center Library" should be displayed for the item_location_library value in the record.
   - This resulting display is "Medical Center Library --- Archives"
 - The bib_locations_hierarchical field values for this record should include: 
   - Duke > Medical Center > Archives
   - Health Sciences Libraries > Duke Medical Center > Archives
   
Top-level members of the location hierarchy do not have an "#{INST}:" prefix. 

If a item_location_library value's parent's key contains a "#{INST}:" prefix, the parent is not itself a top-level facet value, so we need to iterate up until we reach a top-level value to learn what hte entire bib_locations_hierarchical value should be

## Considerations/issues

### 1
This can probably be modeled more elegantly, but the basic idea was informed by the way hierarchies of terms controlled vocabularies are modeled (note the broader terms only, derive hierarchy from that)

### 2
Anticipated objection to the overall approach: "this is all on each institution" and should not be handled/considered centrally

Responses to that: 
- the only part of this that isn't already handled centrally is the mapping handled by location_shelf_to_location_library.json
- hosting/using that mapping centrally is in no way onerous for anyone
- before project management strategy changed, the Steering Committee agreed that, in general, data transformation and documentation should be handled centrally/consistency/transparently. 
- unless there is a very compelling reason not to use a centrally mapped/modeled solution such as this, it will save institution figuring out how to populate all this stuff on their own -- this can be done in the central MARC-to-Argot config and minimize institution-specific work.

### 3
Existing issues I tried to solve with this approach: 
- Simplify the whole process of configuring location-related stuff. This will require updating some relatively simple JSON. In Endeca, setting up a new sublocation would involve: 
  - editing local and TRLN XML mapping files
  - edit TRLN pipeline configuration in Oracle Developer Studio and waiting for a new baseline index rebuild
  - editing extract/transformation/MARC adapter logic to change what "library" values are associated with the given location codes
  - re-index affected records (this will still be necessary)
  
- Make it more agnostic about how a given library organizes/names its location codes. 




