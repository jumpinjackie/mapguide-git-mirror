Git Mirroring System for MapGuide (and related SVN repositories)
================================================================

A series of scripts to create read-only git mirrors of MapGuide/FDO/CS-Map/Fusion

Requirements
============

 * Ubuntu 18.04
 * git
 * git-svn
 * git-lfs
 * default-jre + bfg (put `bfg.jar` into this clone)
 * ruby + svn2git (install via `gem`)

First time setup
================

After cloning this repo and meeting all the above requirements, run the various `init-` scripts to create the initial "pristine" git conversion of their respective SVN repositories.

After the initial conversion (this will take a while), run the various `cleanup-` scripts to create a "prepared" version of each respective git repositories. This uses `bfg` and `git-filter-branch` to:

 * Delete large blobs or move them to git LFS (as is the case for CS-Map dictionary files)
 * Tidy up svn commit messages (translating trac ticket numbers to URLs as trac ticket numbers have dual meaning in GitHub, for both issues and pull requests)
 
After the cleanup is done, push the prepared clones to their origins (NOTE: The cleanup script assumes this author's GitHub repos as the origin to push to, modify as necessary for your own mirrors):

```
git push -u origin --all --force
git push -u origin --tags --force
```
 
Updating mirrors with recent SVN changes
========================================

Run the various `update-pristine-` script to pull in latest changes from the original SVN repositories (this runs `svn2git --rebase` under the hood for the respective pristine git clones)

Then run the `cleanup-` scripts again to rebuild a new "prepared" copy of the pristine repo.

Afterwards, force push the "prepared" repo to their origins:

```
git push -u origin --all --force
git push -u origin --tags --force
```

Overview of Process
===================

We use the svn2git tool to initially create "pristine" conversions of:

 * CS-Map
 * FDO
 * MapGuide
 * Fusion

As it stands these repos are mostly importable to GitHub as-is:

 * Except for MapGuide, which contains files that exceed GitHub's file size limitations
 * CS-Map will import, but a few of its dictionary files will trigger file size warnings

So the next logical step would then be to use a tool like `bfg` to clean out such big files.

And while we're at it we might as well clean up our commit history too. Trac ticket numbers 
(eg. #1234) have dual meaning in GitHub (referring to both issues and pull requests), so they
should be translated to something non-conflicting (eg. https://trac.osgeo.org/mapguide/ticket/1234)

But to do such actions will render the our "pristine" git conversions un-updateable to future
upstream svn commits. `svn2git --rebase` will utterly fail on such git repositories.

Based on these observations, it appears to only way to get the best of both worlds is to maintain 
2 copies of each conversion:

 1. The original pristine conversion
 2. The conversion that has been `bfg`-ed and `git filter-branch`-ed

After establishing the initial pristine conversion, the process of pushing it to github would be:

 1. Create a physical copy of the pristine conversion
 2. Run against this copy, the battery of `bfg` and `git filter-branch` calls to do whatever tidying and cleanup that is required
 3. Add the github remote origin
 4. Push all branches and tags

If we want to take in new commits from the SVN repository, we would do the following:

 1. `svn2git --rebase` the pristine copy
 2. Delete the old prepared copy and make a new prepared copy from the updated pristine conversion
 3. Run the same set of `bfg` and `git filter-branch` calls on the new prepared copy as the initial conversion
 4. Add the github remote origin
 5. Push all branches and tags (with `--force`)
    * We would only do this for as long as the github repos are read-only mirrors
    * Would repeatedly force pushing like this have undesirable effects for those already pulling from it? If these are read-only mirrors, then that wouldn't really matter right?
