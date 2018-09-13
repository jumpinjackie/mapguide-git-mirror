The "prepared" git repositories go here. These repositories are expendable and can be cleaned up with `bfg` and `git filter-branch`

For MapGuide, this is actually required as it contains an erroneous commit of a file that exceeds GitHub's non-LFS size limits.

The repos here are what will be pushed to github. On subsequent updates, the "prepared" repos here are rebuilt and `--force` pushed up to their respective origins.
