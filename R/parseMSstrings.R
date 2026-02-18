# parseMSstrings.R
# utilities for parsing MS strings

#' parse_mods
#' Extract metadata from an annotated peptide sequence from Spectronaut
#' 
#' @param seqs A character vector of peptide sequences
#' @param format A character value specifying the format of our seqs (not currently implemented - function expects Spectronaut format for now)
#' 
#' @returns A protein_mods object with processed sequences
#' @export
#' @importFrom Biostrings AAStringSet
#' @importFrom dplyr tibble
#' @importFrom purrr map map_chr
#' @importFrom stringr fixed str_extract_all str_replace str_replace_all str_split
parse_mods <- function(seqs, format = 'Spectronaut')
{
  # remove '_'
  seqs <- seqs |>
    str_replace_all('_', '')
  
  
  # locate modification(s)
  mods <- str_extract_all(seqs, "\\[.*?\\]") |>
    map(~ .x |>
          str_replace(fixed("["), '') |>
          str_replace(fixed("]"), '') |>
          str_replace("\\(.*?\\)", '') |>
          trimws())
  
  
  # remove modifications from seqs
  seqs <- str_split(seqs, "\\[.*?\\]")
  
  
  # find where the mods are at
  mods_at <- map(seqs, ~ 
                   {
                     retval <- nchar(.x) |>
                       cumsum()
                     
                     retval[-length(retval)] # this is the end of the peptide, not a modification
                   })
  
  
  # return the data.frame
  retval <- tibble(sequence = map_chr(seqs, ~ paste(.x, collapse = '')) |>
                     AAStringSet() |>
                     as.list(),
                   mods = mods,
                   mods_at = mods_at)
  
  class(retval) <- c('protein_mods', class(retval))
  
  return(retval)
}
