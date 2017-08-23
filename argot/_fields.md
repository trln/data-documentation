# About argot_fields.tsv
- Defines Argot fields -- what the field means, any special reasons we need that particular field, related facets, whether it is multivalued, indexed, etc. 

## Clarifications on selected columns
- provisional
  - n : directly related to feature upcoming for development, as currently specified; implement with confidence
  - y : proposed or to be proposed to extend/enhance feature which may not yet be selected for development. Included in hopes that certain distinctions/behaviors specified will make more sense. 
  - ? : questions about how to model
- local : do we know this field will be a completely (or mostly) locally defined/mapped element?
  - y : yes, we expect that the mappings for this will be all (or mostly) institution-specific
  - n : no, the mappings from standard data format to this field should be mostly applicable to all institutions providing data in that format. __Any institution may override or customize any mapping to any field in their institution-specific MARC-to-Argot config.__

For the following four columns, I decided to focus on the behavior in Argon, rather than their specification in Solr. The devs are best situated at this point to decide how to translate Argot into Solr to achieve the desired behavior.

- multivalued? : based on best understanding of source data and purpose of field
  - y : yes
  - n : no
  - ? : unsure
- searchable in : indexes where this field should be searched when a user types in a query
- facet : facet(s) populated by data in this field
- displayed : if the value should be displayed, and if so, where/how
- label : initial suggestion for default display label
  - . : not applicable
  
- endeca equivalent : used to compare defined field set to Endeca data model
# more details on fields

## date
### cataloged_date
