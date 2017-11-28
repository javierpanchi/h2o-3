setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")

test.gbm <- function() {
  x <- h2o.importFile("/Users/wendycwong/temp/reproducibility_issue.csv")

  # Train Model
  gbm_v1 <- TrainGBM(x, "gbm_v6_n2.hex")
  browser()
  h2o.download_pojo(gbm_v1, getwd())
}

TrainGBM <- function(data, model_id){
  
  h2o.gbm(x=2:365, y='response', training_frame = data,
          distribution = "bernoulli", ntrees = 50, seed = 9876543210, max_depth = 4, min_rows = 7,
          model_id= model_id
  )
  
}

doTest("GBM reproducibility test", test.gbm)
