# Syndetics matchpoint

The field(s) on which we attempt to get a match between our data and two different Syndetics data sets: 

- Syndetics Indexed Content Enhancement (ICE) data that gets merged into our bib records in the actual index and is thus searchable 
  - Data is received from Syndetics and matching occurs using our resources at indexing time. The main concern here is processing time, and that's not too worrisome.
- Syndetics display-time supplementary content via API -- book cover images, summaries, 1st chapter previews, tables of contents, etc.
  - There may be API terms of use that constrain what we can do here.
  - We may be able to leverage the approach that NCSU has, I believe, used locally, which involves a large dataset from Syndetics giving all matchpoints and the supplementary content available for each. This can be used to pre-identify a fruitful match point, if available, for each record. This would prevent throwing multiple queries at the API for every record. 
  
## Suggested match strategy
This is what would be ideal, if we can do it with reasonable processing times and without running afoul of Syndetics. 

- For items with ISBNs referring to that item (or different format version of same item, since content, contributors, associated images, etc. should be the same across formats)
  - start with ISBN_this_item Argot field and move to ISBN_other_format Argot field if necessary
  - start with first ISBN value in field
  - if no match, attempt next ISBN value in field until match is found
  - this will improve things a lot, especially for ebooks where publishers share supplementary content with Syndetics for the **print** ISBNs, but not the e-ISBNs for the same titles. 
  - we could see some increase in mismatched data
    - this is because the MARC format doesn't give a clear way of differentiating between (A) "the ISBN for this item in a different format" and (B) "an ISBN that was erroneously published for or recorded in some copies of this item." 
    - these are both recorded in 020$z
    - however instances of (A) are extremely common, while (B) is quite rare. 
    - I suspect the benefit of more good matches in our catalog will far outweigh possible problems introduced, and there's no efficient way of determining this beforehand
- For items with UPCs
  - same approach as with ISBNs
  - same potential issue as with ISBNs
- For records for **video and music content only** which contain OCLC numbers
  - same approach as above, but use OCLC_number and OCLC_number_merged Argot fields
  - this recommendation is based on: 
	- Info in [Syndetics documentation](https://developers.exlibrisgroup.com/resources/voyager/code_contributions/SyndeticsStarterDocument.pdf) (pg. 2) stating that OCLC number matching only works for video and music content
    - An assessment project we did at UNC where we verified that none of the ebooks in included collections got any matches via OCLC number matchpoint

- If the above are doable, we do not need to define ISBN_Syndetics or UPC_Syndetics Argot fields.
- If we can leverage Syndetics data on availability of supplemental load-time content by ISBN, UPC, and OCLC# to identify what ID(s) will return content, perhaps we do want to have a Syndetics_matchpoint field in Argot that is used in generating API calls. (But there are some further complications with this approach...) 
	
## Notes
 - In the aforementioned UNC assessment project, we figured out that a Syndetics API URL that lists multiple ISBN parameters works, though that URL format isn't given in their documentation examples.
 - Our Endeca skins (at least UNC's) have apparently been using the Syndetics XML API. There is a newer product Syndetics is referring to as "Syndetics Plus" that it sounds like is supposed to replace the XML API. 

## To-do
- Ben: can TRLN contact Syndetics and find out if we need to switch to Syndetics Plus and if there are new costs associated with that
- Ben (maybe): do I recall that the ICE product is no longer available to new customers from Syndetics? If so, should be be concerned about the availability of this service going forward? If there is a replacement for this service, should we look into it so we are not building in support for a service heading toward obsolescence? 
- Kristina: verify details of the Syndetics database thing NCSU has been doing. (Or maybe Emily L. knows the details on this---whether it can be leveraged to avoid doing tons of fruitless API calls)


  


