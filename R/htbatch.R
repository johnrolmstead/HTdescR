#' Title Batch search and fill of sigma values for matching or highest matching by tanimoto coefficient chemical fragments from curated library
#'
#' @param file csv with columns of specific titles and filled with fragment smiles
#' @param sigma.selection The type of sigma to be returned; valid inputs include "A", "B", "C", "D", "E", "F", "G", "H", and "U"
#' @param ...
#'
#' @returnA list containing tanimoto coefficient for the closest matching MCS, SMILES string of the MCS, and index nuber of the matched fragment from the library.
#' @export
#'
#' @examples
htbatch <- function (file, sigma.selection, ...) {

  #reading the csv file as a dataframe

  qsardataframe <- read.csv(file, stringsAsFactors = TRUE,na.strings = "", encoding = "UTF-8")


  # colnames(qsardataframe)[colnames(qsardataframe)=="ï..no"] <- "no"

  # initializing the iterator

  i = 1
  n <- nrow (qsardataframe)

  for (i in 1:n) {

    if (is.na(qsardataframe$r1.meta1.smiles[i]) & is.na(qsardataframe$r1.ortho1.smiles[i]) & is.na(qsardataframe$r1.para1.smiles[i]) == TRUE) {

      t <- htdesc (smile = qsardataframe$r1.taft.smiles[i], HT.type = "taft", sigma.selection)
      qsardataframe$r1.taft.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.taft.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.taft.value[i] <- t$value
      rm (t)


      if (is.na(qsardataframe$r1.ind.smiles[i]) == FALSE) {

        t <- htdesc (smile = qsardataframe$r1.ind.smiles[i], HT.type = "inductive", sigma.selection)
        qsardataframe$r1.ind.sub.smiles[i] <- as.character (t$sub)
        qsardataframe$r1.ind.mcs.index[i] <- t$tanimoto
        qsardataframe$r1.ind.value[i] <- t$value
        rm (t)

      }

      if (is.na(qsardataframe$r1.es.smiles[i]) == FALSE) {
        t <- htdesc (smile = qsardataframe$r1.es.smiles[i], HT.type = "es", sigma.selection)
        qsardataframe$r1.es.sub.smiles[i] <- as.character (t$sub)
        qsardataframe$r1.es.mcs.index[i] <- t$tanimoto
        qsardataframe$r1.es.value[i] <- t$value
        rm (t)

      }


    } else {

      # if the structure is aromatic, than we will set these to default values

      qsardataframe$r1.taft.smiles[i] <- "*C1=CC=CC=C1"
      qsardataframe$r1.es.smiles[i] <- "*C1=CC=CC=C1"
      qsardataframe$r1.ind.smiles[i] <- "*C1=CC=CC=C1"

      # calling htdesc helper function to fill substitute mcs values
      t <- helper (type = "taft", sigma.select = sigma.selection)
      qsardataframe$r1.taft.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r1.taft.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.taft.value[i] <- t$value
      rm (t)

      t <- helper (type = "inductive", sigma.select = sigma.selection)
      qsardataframe$r1.ind.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r1.ind.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.ind.value[i] <- t$value
      rm (t)

      t <- helper (type = "es", sigma.select = sigma.selection)
      qsardataframe$r1.es.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r1.es.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.es.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r1.meta1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r1.meta1.smiles[i], HT.type = "meta", sigma.selection)
      qsardataframe$r1.meta1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.meta1.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.meta1.value[i] <- t$value
      rm (t)
    }

    if (is.na(qsardataframe$r1.meta2.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r1.meta2.smiles[i], HT.type = "meta", sigma.selection)
      qsardataframe$r1.meta2.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.meta2.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.meta2.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r1.ortho1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r1.ortho1.smiles[i], HT.type = "ortho", sigma.selection)
      qsardataframe$r1.ortho1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.ortho1.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.ortho1.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r1.ortho2.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r1.ortho2.smiles[i], HT.type = "ortho", sigma.selection)
      qsardataframe$r1.ortho2.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.ortho2.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.ortho2.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r1.para1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r1.para1.smiles[i], HT.type = "para", sigma.selection)
      qsardataframe$r1.para1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r1.para1.mcs.index[i] <- t$tanimoto
      qsardataframe$r1.para1.value[i] <- t$value
      rm (t)

    }

    #For R2

    if (is.na(qsardataframe$r2.meta1.smiles[i]) & is.na(qsardataframe$r2.ortho1.smiles[i]) & is.na(qsardataframe$r2.para1.smiles[i]) == TRUE) {

      # calling htdesc to fill substitute mcs values

      t <- htdesc (smile = qsardataframe$r2.taft.smiles[i], HT.type = "taft", sigma.selection)
      qsardataframe$r2.taft.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.taft.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.taft.value[i] <- t$value
      rm(t)


      if (is.na(qsardataframe$r2.ind.smiles[i]) == FALSE) {

        t <- htdesc (smile = qsardataframe$r2.ind.smiles[i], HT.type = "inductive", sigma.selection)
        qsardataframe$r2.ind.sub.smiles[i] <- as.character (t$sub)
        qsardataframe$r2.ind.mcs.index[i] <- t$tanimoto
        qsardataframe$r2.ind.value[i] <- t$value
        rm (t)

      }

      if (is.na(qsardataframe$r2.es.smiles[i]) == FALSE) {
        t <- htdesc (smile = qsardataframe$r2.es.smiles[i], HT.type = "es", sigma.selection)
        qsardataframe$r2.es.sub.smiles[i] <- as.character (t$sub)
        qsardataframe$r2.es.mcs.index[i] <- t$tanimoto
        qsardataframe$r2.es.value[i] <- t$value
        rm (t)

      }


    } else {

      # if the structure is aromatic, than we will set these to default values

      qsardataframe$r2.taft.smiles[i] <- "*C1=CC=CC=C1"
      qsardataframe$r2.es.smiles[i] <- "*C1=CC=CC=C1"
      qsardataframe$r2.ind.smiles[i] <- "*C1=CC=CC=C1"

      t <- helper (type = "taft", sigma.select = sigma.selection)
      qsardataframe$r2.taft.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r2.taft.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.taft.value[i] <- t$value
      rm (t)

      t <- helper (type = "inductive", sigma.select = sigma.selection)
      qsardataframe$r2.ind.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r2.ind.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.ind.value[i] <- t$value
      rm (t)

      t <- helper (type = "es", sigma.select = sigma.selection)
      qsardataframe$r2.es.sub.smiles[i] <- as.character (t$sub.smiles)
      qsardataframe$r2.es.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.es.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r2.meta1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r2.meta1.smiles[i], HT.type = "meta", sigma.selection)
      qsardataframe$r2.meta1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.meta1.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.meta1.value[i] <- t$value
      rm (t)

    }
    if (is.na(qsardataframe$r2.meta2.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r2.meta2.smiles[i], HT.type = "meta", sigma.selection)
      qsardataframe$r2.meta2.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.meta2.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.meta2.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r2.ortho1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r2.ortho1.smiles[i], HT.type = "ortho", sigma.selection)
      qsardataframe$r2.ortho1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.ortho1.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.ortho1.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r2.ortho2.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r2.ortho2.smiles[i], HT.type = "ortho", sigma.selection)
      qsardataframe$r2.ortho2.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.ortho2.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.ortho2.value[i] <- t$value
      rm (t)

    }

    if (is.na(qsardataframe$r2.para1.smiles[i]) == FALSE) {

      t <- htdesc (smile = qsardataframe$r2.para1.smiles[i], HT.type = "para", sigma.selection)
      qsardataframe$r2.para1.sub.smiles[i] <- as.character (t$sub)
      qsardataframe$r2.para1.mcs.index[i] <- t$tanimoto
      qsardataframe$r2.para1.value[i] <- t$value
      rm (t)

    }
  }

  closeAllConnections()
  # I am not sure why this is here, but dont remove it!!
  return (qsardataframe)

  #work still left
  # Low priority
  # insert output file format as a function attribute

  # medium priority

  # use appropriate HT.type after creating the data files
  # use appropriate sigma.selection method

  # high priority

  # insert if statement for es and ind
  # replace NA with 0 for .values cells
  # you can leave NA for .mcs.index and .sub.smiles for ones where we didnt trigger getsmiles function
  # insert a summation method which adds up values for hammetts

}
