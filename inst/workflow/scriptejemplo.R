### scripts for trallala

#### Fecha
### autor

### Modelo de Script

###

p1 <- system.file("extdata", "accident_2013.csv.bz2", package = "testFars")
p2 <- system.file("extdata", "accident_2014.csv.bz2", package = "testFars")
p3 <- system.file("extdata", "accident_2015.csv.bz2", package = "testFars")
# with one year
accident_2013.csv.bz2 <- sample_read(p1)
#print(head(accident_2013.csv.bz2))

fars_summarize_years(2013)

# woth more than one year
fars_summarize_years(c(2013,2014,2015))

#### Por ejemplo
