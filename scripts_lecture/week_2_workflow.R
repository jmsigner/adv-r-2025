# 🧭 1. Create a Research Compendium with `usethis`


# Install usethis if needed
# install.packages("usethis")

# Create a new project with usethis (run outside of RMarkdown) or
# from the RStudio menu:
# File -> New Project
usethis::create_project("my_project")

# Inside the new project, run:

# Create a README file for your project
# and have a look at the README.md file. Edit anything you want.
usethis::use_readme_md()

# Create a DESCRIPTION file to define your metadata
# and have a look at the DESCRIPTION file. Edit anything you want.
usethis::use_description(check_name = FALSE, roxygen = FALSE)

# Create the folders data, R, analysis, and results

# for raw and processed data (I often have a separate data-raw folder for raw data)
base::dir.create("data")

# for R scripts which contain functions and other reusable code
base::dir.create("R")

# for analysis scripts (e.g., R, RMarkdown or Quarto files)
base::dir.create("analysis")

# for results (e.g., figures, tables, etc.). Add subfolders for figures, tables, etc. if needed
base::dir.create("results")

# 💻 2. Programming in R ----


# Basic operations and control structures

## Create a vector `x` with the numbers 1 to 10 and calculate the mean
...

## Use a logical condition (if-else) to print whether the mean is large (> 5) or small (<= 5)
...


# 🔁 3. Loops ----

## Simulate 10 dice rolls with a for loop
## save the results in a vector called `rolls` and print it.
...


# 🧩 4. Functions ----

# Turn the loop above into a reusable function
roll_dice <- function(n) {
  ...
}

roll_dice(10)


# ⚡ 5. Speeding Up Code with Rcpp ----

# Install Rcpp if needed
# install.packages("Rcpp")
library(Rcpp)

# Compare a slow R version vs fast C++
slow_sum <- function(x) {
  total <- 0
  for (i in x) total <- total + i
  return(total)
}

cppFunction('double fast_sum(NumericVector x) {
  double total = 0;
  for(int i = 0; i < x.size(); ++i) {
    total += x[i];
  }
  return total;
}')

x <- runif(1e6)

# Compare the performance of the two functions with microbenchmark. The C++ function was 3x faster on my machine.
# install.packages("microbenchmark") # if needed
microbenchmark::microbenchmark(
  slow = slow_sum(x),
  fast = fast_sum(x),
  times = 10
)


# 🌱 6. Version Control with Git and GitHub ----


# Initialize a Git repository in your project folder
usethis::use_git(message = "initial commit")

# In the Git tab (next to Build) you can first stage all created files and then commit them *or* you can do it in the terminal:
# git add .
# git commit -m "First package version"

# Make the compendium a GitHub repository
# This will initialize a new GitHub repository from your compendium and will add the url to DESCRIPTION.
usethis::use_github()

# If you do this for the first time it is possible that you run into some issues because you might not have set up everything correctly, yet. But the usethis package will help you through all the steps with its error messages. One thing you definitely need for this step to work is a PAT (personal access token) for GitHub added to your .Renviron file. Check if you have one or create one with usethis::browse_github_token(). You can also check usethis::git_sitrep(). Pay attention to the GitHub report.

# How to set up a PAT:
# for details see https://happygitwithr.com/https-pat.html

## 1. Create a GitHub PAT via R with 
usethis::create_github_token() # (this will open a page in your browser)

## 2. Copy and store the token in a password manager (Bitwarden, KeePass, etc.) or in a secure place. You will not be able to see it again after you close the page.

## 3. R, register your token with git.
gitcreds::gitcreds_set() 

## 4. Check your credentials again and re-run usethis::use_github() if everything is set up correctly.
usethis::git_sitrep()

## 5. Have a look at your GitHub repository. You should see all your files there now.


