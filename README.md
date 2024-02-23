# My_Coding_Experiments

## Useful bash code snippets

**Identify sub-directory size(s) without listing size for individual file(s) in the sub-directory**
`du -sh */ -t 100M | sort -hr`

**Run 'scp' in the background**
Start scp using nohup as below
`nohup scp file_to_copy user@server:/path/to/copy/the/file > nohup.out 2>&1`
Press 'ctrl + z' which will temporarily suspend the command, enter 'bg' to push the process in the background
`bg`
This will start executing the command in backgroud

**Rename file using pattern matching**
rename '_Splenium_' '_SPL_' *.gz



## Useful R code snippets
