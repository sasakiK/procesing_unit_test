
# Description -------------------------------------------------------------

#' @ Description:前処理に関して、モジュールごとにunittestをする(validate package)
#' @ Auther     :SASAKI KENSUKE
#' @ Date       :2018.0.10d
#' @ Note       :ref : https://cran.r-project.org/web/packages/validate/vignettes/introduction.html#validator-objects-and-confrontation-objects-are-reference-objects


# load modules ------------------------------------------------------------

library(validate)


# Define function & objects ---------------------------------------------------------

# test function
function_ex <- function(inpur){
    # load faster and rename japanese varnames
    # Args:
    #  input : (character)
    #
    # Returns:
    #  returns (data.frame)

}

# Processing --------------------------------------------------------------




# Vignette ----------------------------------------------------------------

# refs / https://cran.r-project.org/web/packages/ensurer/vignettes/ensurer.html


# ---- quick example ----

# prepare data

data(women)
summary(women)


# start checking women dataset

cf <- check_that(women, height > 0, weight > 0, height/weight > 0.5)
summary(cf)

# or use pipe

women %>% check_that(height > 0, weight > 0, height/weight > 0.5) %>% summary()

# or get information graphicaly

barplot(cf,main="Checks on the women data set")


# ---- validator objects ----

# define validator object
v <- validator(height > 0, weight > 0, height/weight > 0)
v

# confront data with rules
cf <- confront(women,v)
cf

# check result
summary(cf)


# create validator object to make BMI and check
v <- validator(
    BMI := (weight*0.45359)/(height*0.0254)^2
    , height > 0
    , weight > 0
    , BMI < 23
    , mean(BMI) > 22 & mean(BMI) < 22.5
)
v

# check result
cf <- confront(women,v)
summary(cf)


# ---- Conversion from and to data.frames ----


df <- data.frame(
    rule = c("height>0","weight>0","height/weight>0.5")
    , label = c("height positive","weight positive","ratio limit")
)
# rule           label
# 1          height>0 height positive
# 2          weight>0 weight positive
# 3 height/weight>0.5     ratio limit

v <- validator(.data=df)
v
# Object of class 'validator' with 3 elements:
#     V1 [height positive]: height > 0
# V2 [weight positive]: weight > 0
# V3 [ratio limit]    : height/weight > 0.5

# confront with

cf <- confront(women, v)
quality <- as.data.frame(cf)
measure <- as.data.frame(v)
head( merge(quality, measure) )

# merge with result
merge(summary(cf),measure)



# ---- Conftontation objects ----


# aggregates
cf <- check_that(women, height>0, weight>0,height/weight < 0.5)
aggregate(cf)

# aggregate by record
head(aggregate(cf,by='record'))

# rules with most violations sorting first:
sort(cf)

# subset confrontation objects
summary(cf[c(1,3)])


# ---- Confrontatio optoins ----

v <- validator(hite > 0, weight>0)
summary(confront(women, v))

# this gives an error
confront(women, v, raise='all')


# ---- Metadata and investigating validator objects ----

v <- validator(rat = height/weight > 0.5, htest=height>0, wtest=weight > 0)
names(v)

# also try

names(v)[1] <- "ratio"
v


# add 'foo' to the first rule:
meta(v[1],"foo") <- 1
# Add 'bar' to all rules
meta(v,"bar") <- "baz"









# Data quality indicators with the validate package -----------------------

i <- indicator(
    mh  = mean(height)
    , mw  = mean(weight)
    , BMI = (weight/2.2046)/(height*0.0254)^2 )
ind <- confront(women, i)




# save rds ----------------------------------------------------------------


