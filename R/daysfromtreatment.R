#' Predict weather a sample has been IFN treated or not ONLY USE IF YOUR ARE SURE THAT THESE SAMPLES HAVE BEEN TREATED WITH IFNbeta
#'
#' @param input_df A matrix or Dataframe of beta values
#' @return A named vector containing predicted days since first treatment.
#' @examples
#' restults <- DaysFromTreatment(df)
#' restults <- DaysFromTreatment(mat)


DaysFromTreatment <- function(input_df){
  #LOAD CPG REFERENCE
  data(ifn_reference_cpgs)
  # INPUT CAN BE EITHER A MATRIX OR DATAFRAME
  # OTHERWISE THROWS AN ERROR
  if (!is.data.frame(input_df) & !is.matrix(input_df)){
    stop("Please use a dataframe or a matrix as input")
  }

  all_cpgs_names = row.names(ifn_reference_cpgs)

  ##### FORMULA IS y = -0.485518 + 0.016561 * log(days_since_treatment) ####

  #data(ifn_reference_cpgs)
  # FIND IF THERE IS OVERLAP EITHER IN THE COLUMNS OR ROWS WITH CPGS FROM THE REFERENCE PANEL
  if (all(all_cpgs_names %in% row.names(input_df))){
    # IF CPGs AS ROWS
    message("Found all CpGs ID in index")
    sub_df = input_df[all_cpgs_names, ]

    # CALCULATE SCORES
    all_scores <- apply(sub_df, MARGIN = 2, FUN = get_score)
    days_since_first_treatment = exp(1) ^ ((all_scores + 0.485518) / 0.016561)



  }else if(all(all_cpgs_names %in% colnames(input_df))){
    # IF CPGs as COLUMNS
    message("Found all CpGs ID in columns")
    sub_df = t(input_df[, all_cpgs_names])

    # CALCULATE SCORES
    all_scores <- apply(sub_df, MARGIN = 2, FUN = get_score)
    days_since_first_treatment = exp(1) ^ ((all_scores + 0.485518) / 0.016561)

  }else {
    stop("Could not find **ALL** 10 CpG ids needed in either rows or columns of input.")
  }

  return(days_since_first_treatment)
}

