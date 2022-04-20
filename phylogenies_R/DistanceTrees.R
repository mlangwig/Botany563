###################### BOTANY 563 in class testing

# install.packages("adegenet", dependencies = TRUE)
# install.packages("phangorn", dependencies = TRUE)
# install.packages("protr")

library(ape)
library(adegenet)
library(phangorn)

################################### DISTANCE BASED METHODS ###################################

###################### Neighbor Joining Method ######################

#####################DNA example
dna <- fasta2DNAbin("http://adegenet.r-forge.r-project.org/files/usflu.fasta")
#calculate distances

#First, pairwise distances are calculated. Then, the TN93 model is used to convert the
#pairwise distance into an evolutionary distance. TN93 is the Tamura-Nei model that
#accounts for the difference between transitions and transversions and differentiates 
#the two kinds of transitions (purine to purine & pyrimidine to pyrimidine).
#TN93 is chosen for this data as an example, may need to choose another model for DNA
#sequence data in the future.
D <- dist.dna(dna, model="TN93")

#classical neighbor joining algorithm
#bionj is the improved version
tre <- nj(D)
tre <- ladderize(tre)

plot(tre, cex=.4)
title("A simple NJ tree")

##################### Protein, my data
aa_alignment <- read.phyDat("input/dsrC_PlumeViruses_Refs_renamed_mafftAuto_masked.fasta", format = "fasta",
                            type = "AA")
#calculate distance

# In my amino acid data, the LG model is used to convert the pairwise distance into an 
#evolutionary distance. LG is the Le and Gascuel model that accounts for variability 
#of evolutionary rates across sites. It was tested using a larger and more diverse 
#sequence database compared to WAG. I chose this model because it was identified
#by IQ-Tree to be the best-fit model. LG paper: http://www.atgc-montpellier.fr/download/papers/lg_2008.pdf

aa <- as.AAbin(aa_alignment) #create AAbin object
D_aa <- dist.ml(aa, model = "LG") #calculate the pairwise distance using LG model

tre_aa <- nj(D_aa)
tre_aa <- ladderize(tre_aa)

plot(tre_aa, cex=.4)
title("DsrC Neighbor Joining tree")

###################### Maximum Parsimony Method ######################

#####################DNA example
dna2 <- as.phyDat(dna)

#build a distance tree to use a starting tree for parsimony
#model raw is p distances directly, not using model of evolution
tre.ini <- nj(dist.dna(dna,model="raw")) 
parsimony(tre.ini, dna2)

tre.pars <- optim.parsimony(tre.ini, dna2)
plot(tre.pars, cex=0.4)

##################### Protein, my data

aa2 <- as.phyDat.AAbin(aa) #create AAbin object

tre.ini_aa <- nj(dist.aa(aa)) ##generate starting tree for search on tree space
parsimony(tre.ini_aa, aa2) #compute parsimony score of this tree

tre.pars_aa <- optim.parsimony(tre.ini_aa, aa2) #search for tree with optimum parsimony
plot(tre.pars_aa, cex=0.25)
title("DsrC Maximum Parsimony tree")

####Experimenting with writing tree files and trying to plot trees side by side

#write tree file in newick format
ape::write.tree(tre_aa, file = "distanceNJ_tree_dsrC_PlumeViruses.nwk")
ape::write.tree(tre.pars_aa, file = "parsimony_tree_dsrC_PlumeViruses.nwk")


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("treeio")
# BiocManager::install("ggtree")
# library("treeio")
# library("ggtree")
# 
# nwk <- system.file("parsimony_tree_test.nwk", package="treeio")
# tree <- read.tree(nwk)
# 
# ggplot(tree, aes(x, y)) + geom_tree() + theme_tree()

# cophyloplot(tre, tre.pars, assoc = NULL, space = 25, font = .01)
# dev.off()

