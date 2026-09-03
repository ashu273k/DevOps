# Git Homework Evidence

## Task 1: `git commit -a -m` versus `git commit -m`

### Tracked-file change

```sh
git commit -a -m "Demonstrate git commit -a -m"
```

Output:

```text
[main 14c362c] Demonstrate git commit -a -m
 1 file changed, 1 insertion(+)
```

The change to the already tracked `git-homework/file1.txt` was included automatically.

### New-file change

```sh
git commit -m "Attempt to commit new file without staging"
```

Output:

```text
nothing added to commit but untracked files present
exit code: 1
```

The new file was not included because `git commit -m` commits only staged changes. After staging it, the command succeeded:

```sh
git add git-homework/commit-m-demo.txt
git commit -m "Demonstrate git commit -m"
```

Output:

```text
[main 25c2682] Demonstrate git commit -m
 1 file changed, 1 insertion(+)
 create mode 100644 git-homework/commit-m-demo.txt
```

Summary: `git commit -a -m` stages and commits modifications and deletions to tracked files. It does not include untracked files. `git commit -m` commits the changes already in the index, so new files must be staged first.

## Task 2: Cherry-pick

The existing `main` history included these commits, followed by two new Task 1 commits:

```text
25c2682 (main) Demonstrate git commit -m
14c362c Demonstrate git commit -a -m
7489931 Feature commit 3
bc5774b Main commit 3
d7e716a Main commit 2
a45c9d4 Main commit 1
```

Created a branch and made two commits:

```sh
git switch -c git-homework-cherry-pick
git commit -a -m "Add first cherry-pick branch change"
git add git-homework/cherry-pick-result.txt
git commit -m "Add file for cherry-pick"
git log --oneline --decorate -4
```

Output:

```text
6e2a00e (HEAD -> git-homework-cherry-pick) Add file for cherry-pick
1f6c916 Add first cherry-pick branch change
25c2682 (main) Demonstrate git commit -m
14c362c Demonstrate git commit -a -m
```

Selected commit `6e2a00e` and cherry-picked it into `main`:

```sh
git switch main
git cherry-pick 6e2a00e
test -f git-homework/cherry-pick-result.txt
```

Output:

```text
[main 56e4738] Add file for cherry-pick
 1 file changed, 1 insertion(+)
 create mode 100644 git-homework/cherry-pick-result.txt
```

Verification on `main`:

```sh
git log --oneline --decorate -1
cat git-homework/cherry-pick-result.txt
```

Output:

```text
56e4738 (HEAD -> main) Add file for cherry-pick
This file was created on git-homework-cherry-pick and cherry-picked into main.
```

The selected change is available on `main`; branch commit `1f6c916` remains only on `git-homework-cherry-pick`.