#### Hotspot List Function            ###
#### Gates Dupont, GLD44@cornell.edu  ###
#### Created: December 17th, 2017     ###
#### Version 1.0.121717               ###
#########################################

library("XML") # For htmlParse()
library(httr) # For GET()
library(rvest) # For html_text()

eBirdHotspotSpecies = function(hotspot){
  url = paste('http://ebird.org/ebird/hotspot/',hotspot,"?yr=all&m=&rank=mrec&hs_sortBy=taxon_order&hs_o=desc", sep = '') # Concatenating url
  doc = htmlParse(rawToChar(GET(url)$content)) # Scraping text from url
  string = as(doc, "character") # Converting scraped text to character string
  taxa = read_html(url) %>% # Selecting all species names from scraped text
    html_nodes('td.species-name') %>%
    html_text
  listall = taxa
  locSpeciesWoSp = listall[!grepl(' sp.', listall)] # Remove spuhs
  locSpeciesWoSlsh = locSpeciesWoSp[!grepl("[/]", locSpeciesWoSp)] # Remove slashes
  listwohyb = locSpeciesWoSlsh[!grepl("hybrid", locSpeciesWoSlsh)] # Remove hybrids
  listwodom = listwohyb[!grepl("Domestic", listwohyb)] # Remove domestic
  listwopar = listwodom[!grepl(")", listwodom)] # Removing any others using parantheses
  locSpecies = as.character(listwopar) # Converting to characted list
  return(locSpecies)
}
