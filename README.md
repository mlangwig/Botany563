---
title: "Botany563 README"
output:
  html_document: rmdformats::downcute
  toc: yes
  toc_float: yes
  pdf_document: default
---

Link to Claudia's helpful guide: [mindful-programming](https://github.com/crsl4/mindful-programming/blob/master/lecture.md)

# Dealing with git conflicts
```
nano best-books.md 

git add .

git commit -m "maggie's book"

git push

git remote add upstream https://github.com/crsl4/phylo-class-social
```

This will produce errors:
```
git pull upstream master
```

To fix it, change the file however you want it to look using nano. Then repeat:

```
nano best-books.md 

git add .

git commit -m "maggie's book"

git push
```
THEN, go to github website and request pull from your own account

Can use this to go back to before you made a change if you haven't done git add:
```
git checkout --
```

# Basics of Git
Look at git config
```
git config -v
```

See what git channels you are connected to:
```
git remote -v
```

If upstream channel is not the one you expect (in our case /crsl4/phylo-class-social), use this to change:
```
git remote add upstream https://github.com/crsl4/phylo-class-social
```



