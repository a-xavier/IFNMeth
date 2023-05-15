#' Internal function to process beta-value columns into methylation treatment scores

get_score <- function(sample_beta_column){
  #LOAD CPG REFERENCE
  return_score <- sum(ifn_reference_cpgs$weight * sample_beta_column)
  return(return_score)
}

#' Predict weather a sample has been IFN treated or not
#'
#' @param input_df A matrix or Dataframe of beta values
#' @param threshold Threshold for methylation score (double), -0.42 as default
#' @return A dataframe with two columns,all_scores and ifn_status
#' @examples
#' restults <- isTreated(df, -0.3)
#' restults <- isTreated(mat)

isTreated <- function(input_df,
                      threshold = -0.42){
  #LOAD CPG REFERENCE
  data(ifn_reference_cpgs)
  # INPUT CAN BE EITHER A MATRIX OR DATAFRAME
  # OTHERWISE THROWS AN ERROR
  if (!is.data.frame(input_df) & !is.matrix(input_df)){
    stop("Please use a dataframe or a matrix as input")
  }

  all_cpgs_names = row.names(ifn_reference_cpgs)

  #data(ifn_reference_cpgs)
  # FIND IF THERE IS OVERLAP EITHER IN THE COLUMNS OR ROWS WITH CPGS FROM THE REFERENCE PANEL
  if (all(all_cpgs_names %in% row.names(input_df))){
    # IF CPGs AS ROWS
    message("Found all CpGs ID in index")
    sub_df = input_df[all_cpgs_names, ]

    # CALCULATE SCORES AND ASSIGN TREATMENT STATUS
    all_scores <- apply(sub_df, MARGIN = 2, FUN = get_score)
    ifn_status <- ifelse(all_scores>=threshold, TRUE, FALSE)

    # CREATE RETURN MATRIX
    final_df = cbind(all_scores, ifn_status)

  }else if(all(all_cpgs_names %in% colnames(input_df))){
    # IF CPGs as COLUMNS
    message("Found all CpGs ID in columns")
    sub_df = t(input_df[, all_cpgs_names])

    # CALCULATE SCORES AND ASSIGN TREATMENT STATUS
    all_scores <- apply(sub_df, MARGIN = 2, FUN = get_score)
    ifn_status <- ifelse(all_scores>=threshold, TRUE, FALSE)

    # CREATE RETURN MATRIX
    final_df = cbind(all_scores, ifn_status)

  }else {
    stop("Could not find **ALL** 10 CpG ids needed in either rows or columns of input.")
  }

  return(as.data.frame(final_df))
}
